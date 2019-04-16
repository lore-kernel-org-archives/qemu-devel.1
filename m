Return-Path: <SRS0=xvb4=SS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68A2EC282DA
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 17:57:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4131B2075B
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 17:57:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4131B2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40420 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGSKL-0005F2-5i
	for qemu-devel@archiver.kernel.org; Tue, 16 Apr 2019 13:57:01 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42856)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hGSJN-0004kF-QJ
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 13:56:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hGSJK-0005jS-OQ
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 13:56:01 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:32947)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hGSJH-0005UB-HY
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 13:55:57 -0400
Received: by mail-wm1-f65.google.com with SMTP id z6so2868618wmi.0
	for <qemu-devel@nongnu.org>; Tue, 16 Apr 2019 10:55:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=N7vJfiZxeg/FUQjpiota7F685VfcwfBGepfztdU2+4Y=;
	b=q3S8ylAgdNgFm4MQryyRdSCgcBOqbAuSzsiEcVRewpBUeprfeQkSizFJq2/PHFUaO+
	ASWyRnY55ig44OgJJ0ZT+zGMz9dX273Rv0ZP5utoIm93+EOlfqTotVPHEMnFdAgr0nwt
	bxkanFtT9o5FcxlviYDsuhxzsaA4Rtuun0A9joI2UTZetqsp7C0lx2HweiWeSxzljya1
	hxCqfLSA+dJ2fOw/3MncXPnVWHteWUmwoUio0s2aEbIM9vblWFFITWn2/I+Xf3m4vOg/
	Xn/wc3YWxk0DJ21SXsxB/Pr1ettCTGnkF60Pr0Ri223LOyqv0K7dPE2cD6pRB2EZuMvT
	9iFA==
X-Gm-Message-State: APjAAAWBI4twfAqDHI+puzsAebFQjHH04zKQrbnF2WLg/NNcXYbOV5au
	rOzCpaaZtPtyxruIV1XndB4zNg==
X-Google-Smtp-Source: APXvYqyRGyvxIH7QXfX98Uh/ZjhaP5jndIp9IKrP4RLvwMc4S/+IreHwzVL5w0W118a9YojpzpvxEw==
X-Received: by 2002:a7b:c14c:: with SMTP id z12mr26795935wmi.138.1555437336049;
	Tue, 16 Apr 2019 10:55:36 -0700 (PDT)
Received: from [192.168.1.33] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193]) by smtp.gmail.com with ESMTPSA id
	v190sm188491wme.18.2019.04.16.10.55.35
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Tue, 16 Apr 2019 10:55:35 -0700 (PDT)
To: Eric Blake <eblake@redhat.com>,
	Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20190416083150.19649-1-richard.henderson@linaro.org>
	<20190416083150.19649-3-richard.henderson@linaro.org>
	<6860567d-8678-783e-e001-1dd53785c84a@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <df82da11-f32e-f07c-15fe-0fb9b5f3540a@redhat.com>
Date: Tue, 16 Apr 2019 19:55:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <6860567d-8678-783e-e001-1dd53785c84a@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.65
Subject: Re: [Qemu-devel] [PATCH 2/2] tcg: Restart after TB code generation
 overflow
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190416175529.IlXn-0r5dB6KnHFJu-bu44wxjDLcmTs5odSNZIlPCW8@z>

On 4/16/19 7:47 PM, Eric Blake wrote:
> On 4/16/19 3:31 AM, Richard Henderson wrote:
>> If a TB generates too much code, try again with fewer insns.
>>
>> Fixes: https://bugs.launchpad.net/bugs/1824853
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>  accel/tcg/translate-all.c | 39 +++++++++++++++++++++++++++++++++------
>>  tcg/tcg.c                 |  4 ++++
>>  2 files changed, 37 insertions(+), 6 deletions(-)
>>
> 
>> +             * Try again with half as many insns as we attempted this time.
>> +             * If a single insn overflows, there's a bug somewhere...
>> +             */
>> +            max_insns = tb->icount;
>> +qemu_log("TB overflow: pc=%lx insns=%d\n", (unsigned long)pc, max_insns);
> 
> Leftover debugging? Or should it be kept but properly indented?

Oops. I'd rather keep it between #ifdef CONFIG_DEBUG_TCG/#endif.

