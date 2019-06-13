Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC883C31E45
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 21:54:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8176921473
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 21:54:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rHWQEELo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8176921473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45972 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbXgE-0001nm-Q6
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 17:54:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51753)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hbXMo-0000SA-Sj
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 17:34:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hbXMm-0003Gl-0R
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 17:34:42 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:33252)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hbXMl-0003F8-K0
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 17:34:39 -0400
Received: by mail-pf1-x443.google.com with SMTP id x15so77933pfq.0
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2019 14:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=p0z7URaZqQCsfktbXRSIL0pThBgVJ1cAPpGi+1vxVDE=;
 b=rHWQEELoHAUZ4Tl2RIVroKspc3W5nkysrcIEKoO+Rn3q3wlwGfs33s3Dvzx4tAgtPD
 YUKGtMr5gJWbOTRJSpeZq4ONKWPMp2c1E0rscM0+qpQCEBO6H1BT8bb8tc0JOCFVahTv
 PMgz0SILzVnfR7yQt9iRoYjAwWmn+f+1CqIPUHyS5Upuq1Ft7J9kIPpXslZLvbtTw2HC
 ycBTR4IYAgN/CQIgVnxL6u8i65AulQxaBc5gJDPPOIfK3roBYcT0AgYfcZ2lLsfqcO50
 HGKmYbYEHfvgnk9H8STGPq4txx/45UC0GhL5S5hfgoj3ONsnVpkUZaAWCDs8Gui+0St4
 3jWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=p0z7URaZqQCsfktbXRSIL0pThBgVJ1cAPpGi+1vxVDE=;
 b=WFDUOnrX0FipTtz18xinIixoLa0qHW2KX1YS5UIBHBRZw/zWWYO3z9uuQglv2/vRET
 Q8RcLgyUK/9Lu+BNUZX/HGdd7eMyItts9Le2+eu0aBbrYSGVOvJmYFzBc8+fKkuIZCA6
 SqvOMetqja0y1BJCgM9EdpUOhw2Obsv7U+cOjRiKyk9MBIGuYzjR1hIP2lVRlIlVaEsr
 I3po6A3GjPBX3poG2R0bu5cZoJbugx2YT1o2hv20JIT0GAuMIUkGEmBOZ93ceA3aOP1O
 KGoiGgdFnC4ayaG44Gw208mkGOL3MOinY7gP8mwK1E0VeaVV668uzdRtNzsth/sviO8e
 zR+g==
X-Gm-Message-State: APjAAAUQxU8uhHFPN5S/kZpiEZl9QH7H4A/hwxJ2nZB6jHPsg40GQMNq
 b2A3wvNY+rr23Ui55HbFxEeHWRmZkHw=
X-Google-Smtp-Source: APXvYqwlNn7B5L+cXpRiHCxbhCfEd3y8XmOo4nQnGMgoBav6g/FBiva9Ie2VNVewjfGphXFWCNFN2g==
X-Received: by 2002:a17:90a:dd45:: with SMTP id
 u5mr7328659pjv.109.1560461677806; 
 Thu, 13 Jun 2019 14:34:37 -0700 (PDT)
Received: from [10.10.150.239] ([149.199.65.200])
 by smtp.gmail.com with ESMTPSA id y12sm699112pgi.10.2019.06.13.14.34.36
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 13 Jun 2019 14:34:37 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20190613163917.28589-1-peter.maydell@linaro.org>
 <20190613163917.28589-12-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <bdcc8e54-7eea-9100-9c7b-b114fb159b1f@linaro.org>
Date: Thu, 13 Jun 2019 14:34:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190613163917.28589-12-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
Subject: Re: [Qemu-devel] [PATCH 11/12] target/arm: Stop using deprecated
 functions in NEON_2RM_VCVT_F32_F16
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/13/19 9:39 AM, Peter Maydell wrote:
> Remove some old constructns from NEON_2RM_VCVT_F16_F32 code:
>  * don't use CPU_F0s
>  * don't use tcg_gen_st_f32
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/translate.c | 26 +++++++++++---------------
>  1 file changed, 11 insertions(+), 15 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


