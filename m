Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF52AC433E6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 11:09:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B213020BED
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 11:09:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="emNn2buQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B213020BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50616 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD4AR-0001M5-OU
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 07:09:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35262)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kD49T-0008Ve-TE
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 07:08:35 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:40057)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kD49S-0005Ei-Aw
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 07:08:35 -0400
Received: by mail-wm1-x341.google.com with SMTP id v4so730422wmj.5
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2020 04:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=58oByHRQENKiTCsgJ5OOlEzdGn1qtJ2SPqsRrI/y+oY=;
 b=emNn2buQicn9i8m/CixQE9Np2A6sfyYmDPMgIoQ1d/ze1yo64U9m/XjTGhkbXb1/Cb
 HdeAIwSvLPzCEtHMmr9nxPKGWLZqP6thRjciC5kfdB2v4IVe97t0/cBNbHcITUDotgUC
 upI2XNs+BxOxkTqpJlAGiOT8F/mH+h4x0jWACvVm72+k4veo6tGAJUtR5lgPmalCBvZG
 syJJJ/5mdz/brUd8yhv4u9Wyp1CuJ0pv2PCdAYfdPrdjJTUuBwmhip5+N7gRi6hCpB+A
 Xvijn8GsnUGSS8nmDfn4SsEqQn3lCOJizoispGvI7N4eyYmsKSIjAkIYpB82+kTaqRd1
 aQdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=58oByHRQENKiTCsgJ5OOlEzdGn1qtJ2SPqsRrI/y+oY=;
 b=ADEoeZvtZz+Aftdf75wvMiLVYuJ+CEWuKLyLEdMLdgaBzqL44afCV0qRtSGhmt4a7O
 lwYzIBYBKk8GFiYNKRhke9v7OXZR7+tuqNoBqKcn6PocCzD7p1Ju2nVYPUbxSu/ErXea
 e3ygBZzxaPIH6EVhG+2KUvck6t1VY14ZGk7BUwSE9BpgtdzMKFgsieu8bn1XON/LjRp+
 C9zzfCmDhfXXIZ+ZtpS8M9xJx8Kcl32YkJcXVTF4ygwwckOyKZc9RUCPgJBUS5CsttZY
 FZRef1NRNb+U9/fo3uMnoqM6uAgrGFim9rIlf+sA2Z4FTwzkreIqiX8V20D30p7eueBz
 +qXQ==
X-Gm-Message-State: AOAM533NiIsA0sWg9w8M+l6zML7rYfNq4HxOXaaUx9z/nC4SoKQ/wf6b
 b2uYcBnUNzPQY98ln7AkndgRUQ==
X-Google-Smtp-Source: ABdhPJxj77mwabRWI0vbtu9iiTC/uq7D61jeYBV5i5teOqYfIM6YTP8jcsAguJYoMDe06YnVsBP2Pw==
X-Received: by 2002:a1c:ed15:: with SMTP id l21mr1208183wmh.37.1598958512762; 
 Tue, 01 Sep 2020 04:08:32 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id n21sm1367631wmi.21.2020.09.01.04.08.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2020 04:08:31 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id D9FF21FF7E;
 Tue,  1 Sep 2020 12:08:30 +0100 (BST)
References: <20200901072201.7133-1-cfontana@suse.de>
 <20200901072201.7133-11-cfontana@suse.de>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Claudio Fontana <cfontana@suse.de>
Subject: Re: [PATCH v6 10/16] cpus: cleanup now unneeded includes
In-reply-to: <20200901072201.7133-11-cfontana@suse.de>
Date: Tue, 01 Sep 2020 12:08:30 +0100
Message-ID: <87eenl69g1.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x341.google.com
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
 Marcelo Tosatti <mtosatti@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Roman Bolshakov <r.bolshakov@yadro.com>,
 Colin Xu <colin.xu@intel.com>, Wenchao Wang <wenchao.wang@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Sunil Muthuswamy <sunilmut@microsoft.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Claudio Fontana <cfontana@suse.de> writes:

> Signed-off-by: Claudio Fontana <cfontana@suse.de>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e

