Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 376EDC433E6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 10:24:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0E96206FA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 10:24:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="onrRFhEE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0E96206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40108 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD3Sm-0004Wp-1Y
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 06:24:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52232)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kD3S8-00045s-13
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 06:23:48 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:52430)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kD3S6-0007hi-Dj
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 06:23:47 -0400
Received: by mail-wm1-x342.google.com with SMTP id q9so609393wmj.2
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2020 03:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=SOD3NreGo1V885+N/yx+58IbyIp4/uSuO02wnwe4frc=;
 b=onrRFhEEPr5GF5ZLZRqRt6nu0gaR8tlitxHBhLcguezlkfTEAsw5hPxYfAp30Zg4vp
 Wixbb+m2nPW+fNAtN7B/Ki6Xqzn7ScBl2Zu2GgEbE8W9NdGlpuCgasaHEZkYFfNu9J53
 7nmjO0J8RHGVuTwp6+44y2mf5rOI1lF0w6Hqrhn0QsDpM1uuFxsuqIBcD9k5+X2C46sa
 h1c3foSO+lLSEQVLspCO3ueSehrnShN9rfepm28Y//PXUk5TAOjvtShna/6qPRPr+unx
 sxph9w2GHMbUEmOxI6wxVYpXYOz75aIiD1vWnk78v8jTGhvEyqDxobo3h61m6WxZXZCx
 PkFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=SOD3NreGo1V885+N/yx+58IbyIp4/uSuO02wnwe4frc=;
 b=OXfBxLoINu1OdbDjFZTMYFhesPvHvo5sjJbDr/lbjlp1UJCWKbny1lQKyax7W+QZAx
 UPfjKl1LgKaysGj7SDHPK8GnpSsIBcW1UFjn9s5vZkNghd6ON8YstW1pGeTyRKLJioJw
 TVrfp08XQisPvv96ucNDjW4Qd21YNybooT471VkgJpJTP0TcxwUSsLwcI3N1LelZZEst
 uSmBB3cNvTNWqDxIycRHvq082KSQKAddpC3WoJV90O9RBCc4HgPyMvBXxL4eywNA5JuD
 aOO8aUoHYy3mHpxeWnK4p0djIMc+1Qf/ZhVJhRNt6+VOYBysBeD7qd6LQo7QtlNCHtPl
 jdpA==
X-Gm-Message-State: AOAM531vcsP1qZaQ/m+zD76PADCIeAmVl0tKZdbP3ebCyC4XUDkERI7p
 RzeU/QROHx9NiOerCnhtnj75ZQ==
X-Google-Smtp-Source: ABdhPJyx4rhuK8QaFTDkqav9Wm6WNcgCM7ZR1X0OB9hv1nzhxLCyqKSVA6gQu9v69Bl5cPbHvBKzIQ==
X-Received: by 2002:a1c:6187:: with SMTP id v129mr1056822wmb.35.1598955825207; 
 Tue, 01 Sep 2020 03:23:45 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id n8sm1624721wra.32.2020.09.01.03.23.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2020 03:23:43 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id A65D41FF7E;
 Tue,  1 Sep 2020 11:23:42 +0100 (BST)
References: <20200901072201.7133-1-cfontana@suse.de>
 <20200901072201.7133-3-cfontana@suse.de>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Claudio Fontana <cfontana@suse.de>
Subject: Re: [PATCH v6 02/16] icount: rename functions to be consistent with
 the module name
In-reply-to: <20200901072201.7133-3-cfontana@suse.de>
Date: Tue, 01 Sep 2020 11:23:42 +0100
Message-ID: <87o8mp6bip.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x342.google.com
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

> Signed-off-by: Claudio Fontana <cfontana@suse.de>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e

