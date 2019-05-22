Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 231A0C282CE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 15:55:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF91620879
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 15:55:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RE/ZkAjq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF91620879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46583 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTTaa-0002Oo-4M
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 11:55:36 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48951)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hTTNN-0000VY-AA
	for qemu-devel@nongnu.org; Wed, 22 May 2019 11:41:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hTTNL-000842-Fv
	for qemu-devel@nongnu.org; Wed, 22 May 2019 11:41:57 -0400
Received: from mail-vs1-xe34.google.com ([2607:f8b0:4864:20::e34]:39105)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hTTNJ-0007mB-EQ
	for qemu-devel@nongnu.org; Wed, 22 May 2019 11:41:55 -0400
Received: by mail-vs1-xe34.google.com with SMTP id m1so1679397vsr.6
	for <qemu-devel@nongnu.org>; Wed, 22 May 2019 08:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=sRQTFPgHxy3uIYJo5ma2IAY1Aj3KCNIC0hUAp3ZFE8k=;
	b=RE/ZkAjqCR8ZpTAuVAaNlNyvprdclVepeLNu29f0/VcUkEIoFwbSfKhbVP2IfFB+Cg
	a6ciAddMMOkn0JcgNU16QK3w5SR6VjSqoQaCB+Bfj8OUgbAaRNrduEV719XphK6T+ZfL
	MI5FWFrKL0p9V0W5rnA/YsP+Kv31i68YmzFMXbp/wzP1W/IWaYLRTH+TXWMJXOTBq3GZ
	RvIiumd5PhBtj4eqweGO6E2T7WgtpR1w1iA4IBHRsQ6Q0hyVMX0VstjqzY+ZvYCnPYHP
	RCcNgjhrEN7R5hThaPs/tnZADo/GPbyzvKLaJ/C/MhRh3w6+ae00XqYXvm/r7YsNBvyY
	POXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=sRQTFPgHxy3uIYJo5ma2IAY1Aj3KCNIC0hUAp3ZFE8k=;
	b=KgqdQdgar1RZdKFZx9jEYdaxm+i3cMIX2TrcDbxDp7YjfL4yX2u2ML29+LEss1TQLa
	7fKBCt08VCe7r01mAFszqu7SrlacrlLGR01dX0VC0PLNto1PkTvLyFJGYx4Gm2qxFBIN
	udjBZ2Iv15sket02DYlILKfnRAMivRhYR9vfjbe4s1ivCVsdJoxa9K2itqa1T5gc/V9g
	LoANwUL1SQTgAGlhowT2gB23q95W0Gc/quHkLClxwQM4cv6WHaTGXyp8V8pqWaxroIdh
	lUf6ZWf/L4uVsw0BI4LLUHL+qX08in1QLPCQWW+bW/8OT/SgkuU+ftkv/dJm8UXqg2GI
	jKXA==
X-Gm-Message-State: APjAAAWxfSG87TbYqz7m5lt6alERiQPUl3xSa2gukfAV0FLilyqXJPk9
	vMQnh/QXy9rPWc5AwBXewi67Ug==
X-Google-Smtp-Source: APXvYqyBNOUfFROslZr5r/E6fulNNzVkZFTefZzKi2xILGKFmbNKWrX8eA2sIBt04Alr+NCl7zoODA==
X-Received: by 2002:a67:1485:: with SMTP id 127mr15097942vsu.77.1558539709811; 
	Wed, 22 May 2019 08:41:49 -0700 (PDT)
Received: from [192.168.43.94] (ip-173-130-247-24.orldfl.spcsdns.net.
	[173.130.247.24]) by smtp.gmail.com with ESMTPSA id
	p75sm4797453vkf.29.2019.05.22.08.41.48
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 22 May 2019 08:41:49 -0700 (PDT)
To: G 3 <programmingkidx@gmail.com>
References: <20190522000617.21945-1-programmingkidx@gmail.com>
	<b90278ec-ee66-76c6-32b5-d5aca1fb8d24@linaro.org>
	<CAKyx-3M_zMPBuS3BntUGMd21d7xX_d1KOq_Yc21MVjEp+fZbRQ@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <e48deeeb-310b-39b1-2396-48b0b81734ce@linaro.org>
Date: Wed, 22 May 2019 11:41:46 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAKyx-3M_zMPBuS3BntUGMd21d7xX_d1KOq_Yc21MVjEp+fZbRQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::e34
Subject: Re: [Qemu-devel] [PATCH] Implement Fraction Rounded bit in FPSCR
 for PowerPC
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
Cc: David Gibson <david@gibson.dropbear.id.au>,
	"qemu-ppc@nongnu.org list:PowerPC" <qemu-ppc@nongnu.org>,
	qemu-devel qemu-devel <qemu-devel@nongnu.org>,
	Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/22/19 11:25 AM, G 3 wrote:
> Thank you for the suggestion.
> 
> For the added note, did you want specific places listed? If so please let me
> know these places.
> 

They are round_to_int, and all of the legacy roundAndPack* routines.
Basically anywhere that currently sets float_flag_inexact.


r~

