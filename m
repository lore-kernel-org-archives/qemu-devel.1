Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34D9DC433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 11:09:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E988D20BED
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 11:09:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e4u/Z838"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E988D20BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48874 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD4A6-0000co-0A
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 07:09:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35188)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kD49E-0008HE-8q
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 07:08:20 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:36115)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kD49C-0005Cm-II
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 07:08:19 -0400
Received: by mail-wr1-x444.google.com with SMTP id z1so1048399wrt.3
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2020 04:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=6eXSA8JpRFaMMal7/OXnrPe9PiTP+hfXg5e6r5FPGhs=;
 b=e4u/Z838HhzDkXUJNSFYiUlI7bVmWyjvelpnAN7jNdbdRoToX4QVgNGAgeKZ/szYN/
 3qSoGKkjcreixQ5HV0PN/aUxqheh8T9IxPPy8efpSdKRwQY6WLRe7r5i7ekbD/BP+PdB
 GjGId5FEIVXg3Z/G3o15iR4g3sO+da57wOJkgX8hF4cN0UQb9ooEuj5gsMXUDMonKdsD
 VvR0XAFIsMsNR2eRN31INMe0H0tPIEnnbVs1qKM9nev3S5JLnBFiWNaXo0tTr0FYVGun
 vKb0xMVW6U8k4lHIdj+G9RBZv6SrqDAE8rgqFY1wN3K4GEKwOfC+x58Ulks4s/KUV4Bk
 1Vvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=6eXSA8JpRFaMMal7/OXnrPe9PiTP+hfXg5e6r5FPGhs=;
 b=JlCBQsZ6ij7i8bRTqrDrLS4yQXiIa5gNziUoJIEzKYOmPvTY0MiCnDaZ9GiuCH22QC
 32bXC6iXOuETVq5wcJ/9MoPws26F1ppvjSfeudy0bwvYZoyip/qEG9Bgc9USS5puG4Ig
 zJaKTZdd6DDYJI7mHmIizhkxaaKVM+Awu3MY8nY+ZC7gI7PbITYVeZErFMUb+iazZXlc
 27Z+/LPFXybrXqxVjYm50D/y6aUNEyZRXd8ynziD5tSGBRBJ2R3KogyAR3+Lcr4NaCV1
 qoW5k4d3GB0Gfj0CQGqW+LKO+QWKW4WaqMIuiC9gOfWyKA/oW3ms/vcN0nFSg+ocnpK7
 PhKA==
X-Gm-Message-State: AOAM533Z4jWsWL2lfxG5I3RWrZdJLBd4JjRTRQYn4f5rJIB+MQpNyiCH
 uq+l2RkIGwnCCAnlc5kucA+KVA==
X-Google-Smtp-Source: ABdhPJwP+jmQC4ZG4qZcoP6PmfAPFBuIAUq8yIe7L4VuPZKN5TI0Ofv16rmSsM3WmjlGcNRvRrs4aA==
X-Received: by 2002:adf:e94a:: with SMTP id m10mr1404983wrn.249.1598958497129; 
 Tue, 01 Sep 2020 04:08:17 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id m3sm974239wmb.26.2020.09.01.04.08.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2020 04:08:16 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id EBF8F1FF7E;
 Tue,  1 Sep 2020 12:08:14 +0100 (BST)
References: <20200901072201.7133-1-cfontana@suse.de>
 <20200901072201.7133-5-cfontana@suse.de>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Claudio Fontana <cfontana@suse.de>
Subject: Re: [PATCH v6 04/16] cpus: extract out TCG-specific code to accel/tcg
In-reply-to: <20200901072201.7133-5-cfontana@suse.de>
Date: Tue, 01 Sep 2020 12:08:14 +0100
Message-ID: <87h7sh69gh.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Alberto Garcia <berto@igalia.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Pavel Dovgalyuk <dovgaluk@ispras.ru>, haxm-team@intel.com,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Roman Bolshakov <r.bolshakov@yadro.com>,
 Colin Xu <colin.xu@intel.com>, Wenchao Wang <wenchao.wang@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Sunil Muthuswamy <sunilmut@microsoft.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Claudio Fontana <cfontana@suse.de> writes:

> TCG is the first accelerator to register a "CpusAccel" interface
> on initialization, providing functions for starting a vcpu,
> kicking a vcpu, sychronizing state and getting virtual clock
> and ticks.
>
> Signed-off-by: Claudio Fontana <cfontana@suse.de>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> [added const]
> Signed-off-by: Claudio Fontana <cfontana@suse.de>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e

