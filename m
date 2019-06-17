Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4163EC31E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 20:05:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03BDF2084B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 20:05:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t7kjDO58"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03BDF2084B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51666 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcxse-0005jC-7O
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 16:05:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59006)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hcxqR-0004Ru-N8
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 16:03:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hcxqP-0002Wg-N4
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 16:03:10 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:39662)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hcxqO-0002TS-TH
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 16:03:09 -0400
Received: by mail-pl1-x643.google.com with SMTP id b7so4573117pls.6
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2019 13:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=AeO/fc/+touGJalVrSTWrvfqCC5q9ULWPm9GmuJ83F4=;
 b=t7kjDO58dEMfjFM+wwIECtJ92U3288fSRlKfWz/du3xwYb6bpOQhn98Nf0cdLsUNu7
 eYDV9HA4v4PHThcR0EsAS6SG5LIV6Eud9Z2A0rZ2trFYH61EEAeLy0eEbePOjb9LWj89
 QPaRBmoDgGN0jV+co+jsMNfs70vlu+i0Fw/FG5IxWsyqdenw+jdRRCaS9neg55sVya64
 X73WBTxeDU/ElZr8nbCUItAD275VXWUkaGZXH1LNRfzyJwf19J6E/rZV0tDMF/zyxM9/
 A3DSTSZ1FxvnutrbG3X9dqj/xh5iEi02MM7OFxgn2EvxY0kNkROnikj2DaNGgNGPj1n4
 Qxaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=AeO/fc/+touGJalVrSTWrvfqCC5q9ULWPm9GmuJ83F4=;
 b=uQg/LX46KXWYZ8gmVt9DPoQTEzEVRIrJefGSki4tDRFiR912j9lemSjj54dLqkVi+4
 b43uIfiQPiUGrMy+UeVe4fu6GYZFFHyaDvKl6aBIZFz/oA3GPM1dAzzlcrZdWftuXLiH
 Lh2/kbRS0e/4j3H03OqmYTUWGvQUttrtMfdZuWu1xOWgWDqriBx+HYjshgcW8fRJuFLT
 HZ+rCJRdzuWVWBBOBG91XY/PZGq3DNBwRQT9KeuOhx5sTN4xVPKIBoIv/QqcsFU4+ZWd
 olOQRJQMm6bQT1Asb1ofdWUb5lxVDn136e9w2o5GXl3Rj4npTNohdeW6CSOzIlCnNICd
 nJ+Q==
X-Gm-Message-State: APjAAAVifUnyY0lken6jKJCqDvdcn8fTFYEX8Kg6PPJKHqmQDmGP9VcH
 Rq8CCXnTby+FhRyJbtb4p4vDC4NZbvg=
X-Google-Smtp-Source: APXvYqzm+e7QZVP9dFt1RMQ0yhG9HL9sdr/z6uWWCC54+h58HuvNHmCmfDrt1MJvOlhgj3cznN1DrQ==
X-Received: by 2002:a17:902:f01:: with SMTP id
 1mr108868949ply.170.1560801787216; 
 Mon, 17 Jun 2019 13:03:07 -0700 (PDT)
Received: from [192.168.1.11] (97-113-2-33.tukw.qwest.net. [97.113.2.33])
 by smtp.gmail.com with ESMTPSA id p1sm13998317pff.74.2019.06.17.13.03.06
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 17 Jun 2019 13:03:06 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20190617175317.27557-1-peter.maydell@linaro.org>
 <20190617175317.27557-6-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <639fcc95-4da2-c7ec-ba2d-4d4e96670b09@linaro.org>
Date: Mon, 17 Jun 2019 13:03:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190617175317.27557-6-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::643
Subject: Re: [Qemu-devel] [PATCH 5/6] hw/timer/armv7m_systick: Forbid
 non-privileged accesses
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

On 6/17/19 10:53 AM, Peter Maydell wrote:
> Like most of the v7M memory mapped system registers, the systick
> registers are accessible to privileged code only and user accesses
> must generate a BusFault. We implement that for registers in
> the NVIC proper already, but missed it for systick since we
> implement it as a separate device. Correct the omission.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/timer/armv7m_systick.c | 26 ++++++++++++++++++++------
>  1 file changed, 20 insertions(+), 6 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

