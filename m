Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6198EC76195
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 15:04:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DF2B20693
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 15:04:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BgTTYZxp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DF2B20693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49906 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnP0A-0008Ay-8R
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 11:04:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53077)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hnOzw-0007mC-IN
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 11:04:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hnOzv-00071V-ID
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 11:04:08 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:45725)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hnOzv-00070K-A5
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 11:04:07 -0400
Received: by mail-pg1-x543.google.com with SMTP id o13so9566438pgp.12
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2019 08:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Vami3kb1fVj6KrU0Qjqblj6q7FXkXTv9IfpO2z270F4=;
 b=BgTTYZxpRPBFR7vekZvvZIcz7mY7CXRH1EbWS2HzrjqWVDjpgHDyN2OTaycbzCAfjS
 IK7c1IIZatcFusJMyPwukY513fiGd8EickMKojnJXK/v/jY9/GIb1UweRJKXN55jERgi
 0wkIN5F/nr17weisy2nBDyKoIpU0c5a0f/rQRKMWRnR0mTAwuVMpVJ3d3yj7OANt78Gk
 G3m48e2szdOl7lsAccxxSm8lepElNrLbApkRfG6Wd10GKlS4SitEUjpgxoNA1U+tMafH
 R0P4rbAGMki4kg8cRwiFGG/I/fpgmcZ+wRdpcV8/lvLxyPF9qu4I0kn9CfHaXFLJ41RN
 ZnCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Vami3kb1fVj6KrU0Qjqblj6q7FXkXTv9IfpO2z270F4=;
 b=Ms816lRdy1Zm2tXfn6xiBK3NlRI/A9hoEeXE5vlKf1s3uj04Q14FSibIkU+X2DjFL/
 GS3CejwK3XObX+WAm8KgE6U7AXRaQ+ra7RskImzNarHxM7vL4u2J4Ai/tnUqJUU7V9PQ
 v3AJdhrwK6oPPsKPWBfRMvtk0DO8v0f+u/SB8jzQPRvtycZRNbKWbkZvFZok7Ucnzhwa
 CRnEnpsKnIMJ1CHqXUwPbH2Q77GSZS4QiDvnK0rNI3QELw592IJsRJ9q13GE9QUHIsH7
 J5HmXKe6MU4aIgbbLR/hZDrrGFBTagY7rXfnhj3Tn9Qu0dpEDNcSyICmH4B3ck9kIu0i
 UaAQ==
X-Gm-Message-State: APjAAAVWvgSXa/GDjdUchkCAChzU+/FU76Wr1RSU2kv0USbvq2wIFDo7
 FUkyb0sE+2kZfptn4S0o4S73mg==
X-Google-Smtp-Source: APXvYqzUeZURg1boD9c+DQZcHZttDBq6g8gJDOeIYkenFLo7+G504UTR4Gy0iB1KEKhQ1X0kKaat8w==
X-Received: by 2002:a17:90a:1a45:: with SMTP id
 5mr37966710pjl.43.1563289446056; 
 Tue, 16 Jul 2019 08:04:06 -0700 (PDT)
Received: from [192.168.1.11] (97-113-176-6.tukw.qwest.net. [97.113.176.6])
 by smtp.gmail.com with ESMTPSA id v10sm20921045pfe.163.2019.07.16.08.04.04
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 16 Jul 2019 08:04:05 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>
References: <20181102171638.24069-1-peter.maydell@linaro.org>
 <20181102171638.24069-9-peter.maydell@linaro.org>
 <3e3d2018-3993-f651-8e94-5bea612bd776@redhat.com>
 <CAFEAcA_FtoHOUv_cPgfO7GrZ8Ug9cKCvmY2z75i9DaAQ8Qx+gQ@mail.gmail.com>
 <2745eb9d-c2a2-30a8-c1d0-b8cb3ee43705@linaro.org>
 <CAFEAcA-EqXU3vM63bK4+Yo1j07fZpD_=gapB_5_ygrJFk2-Rsw@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <c15bcb9c-170a-380e-0ec5-4681b641e130@linaro.org>
Date: Tue, 16 Jul 2019 08:04:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-EqXU3vM63bK4+Yo1j07fZpD_=gapB_5_ygrJFk2-Rsw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::543
Subject: Re: [Qemu-devel] [PULL 08/10] target/arm: Conditionalize some
 asserts on aarch32 support
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Laszlo Ersek <lersek@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/16/19 2:18 PM, Peter Maydell wrote:
> On Tue, 16 Jul 2019 at 15:02, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> On 7/16/19 12:03 PM, Peter Maydell wrote:
>>> The intention of the assertion really is to catch QEMU bugs
>>> where we got the ID register values wrong in our emulated
>>> CPUs. Perhaps we should relax all these assertions to only
>>> testing if we're using TCG, not KVM ?
>>
>> Perhaps.  In some instances if ID register values are wrong we would then not
>> migrate properly, but none of the checks we're currently doing of this sort
>> would catch those particular cases.
> 
> In those cases we should probably print a warning and install
> a migration-blocker, rather than asserting...

Ok, but I'm saying we don't assert for those either, at the moment.


r~

