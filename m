Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 196D5C04AB5
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 18:21:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D27572083D
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 18:21:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tNiEgyVK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D27572083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36485 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYx0k-00040m-4N
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 14:21:14 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54801)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hYwzM-0002wG-CG
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 14:19:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hYwzL-0007j3-0b
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 14:19:48 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:43752)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hYwzK-0007hl-P0
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 14:19:46 -0400
Received: by mail-oi1-x244.google.com with SMTP id w79so2269682oif.10
	for <qemu-devel@nongnu.org>; Thu, 06 Jun 2019 11:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=yGN9qrzNneJv3/WSYmR17UAWi8U6U8S1GHaGhFkX+qA=;
	b=tNiEgyVKcyVR5YhsLOuIjCmqxl6ggbJw4Fw25p0k20U4/skQmos8kHArBZClktd/P5
	VwuT167tad0axf1sFGQCiY8GYEV6uTorXiNDZ5O11tPVX5FsCH21al188fCUGzo4Ort1
	oEdvXKeviwCQWUDurMRCWESpgccfhlnzePjEHt7Z6d9Y4Hwzt9BtiW1G8LwJX8aGzJwm
	G5+DDGZRBoCWwUa1adp8LRYD63hYPmqmuyE44JahN2ccDAms4Bd+anAKnbkEL17vz18b
	JHUeNGhjKltKm14YDOs1po+in/OiUUwF8p00FZn6Bi4PvSVX0aXZpcb3gNAtMNe3hnN2
	B/Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=yGN9qrzNneJv3/WSYmR17UAWi8U6U8S1GHaGhFkX+qA=;
	b=QS1x5rYeqNrSYq72713LquHvsYR7P2fbsBmucYJjfoQPet1qNM+dh7G9h8ciu9XnNT
	+9fW3qDghJNHMVHCMpSB/r3sUjQtRa78y1MwCwx95N52YSy6qOX48XgJ88ESSA1nwbhl
	609rzfWN556vl1xmQqngSUhzH1ERO442G0a4cdBs9gVHoY17zBAOJa2gzSdVz5SDoKS3
	SKfwFNNiPRVRiD7Em4Q0ScrijSGXB4rALhkD4nwRquOFiz0i25rtKDOZiMvVN9U35ZXy
	FH4rp/KDBK2PwxyKmkCqQEXRpx+dBrvLogQGkuIA4AXr9+sbpF+3GUL4XVBiat9bw7ju
	X4Tw==
X-Gm-Message-State: APjAAAVJNJoYwj2IQPz6xqM8r8NnpN6jqOUq1X43ghvSZP+RsGAFzntw
	4ocdoj/GCEiENeXOO94a9W8anKaXexAbfw==
X-Google-Smtp-Source: APXvYqx95hM9rFKT5/CvL3NnMNHPtxkoUA/2pMHpZ36O3sv494aynujqpwwomTu7xzNsooYV9YyHYQ==
X-Received: by 2002:aca:b546:: with SMTP id e67mr979137oif.127.1559845185559; 
	Thu, 06 Jun 2019 11:19:45 -0700 (PDT)
Received: from [192.168.3.43] (200-56-192-86-cable.cybercable.net.mx.
	[200.56.192.86]) by smtp.gmail.com with ESMTPSA id
	m129sm961638oif.13.2019.06.06.11.19.43
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 06 Jun 2019 11:19:44 -0700 (PDT)
To: Stefan Brankovic <stefan.brankovic@rt-rk.com>, qemu-devel@nongnu.org
References: <1559816130-17113-1-git-send-email-stefan.brankovic@rt-rk.com>
	<1559816130-17113-5-git-send-email-stefan.brankovic@rt-rk.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <fac722ec-ea35-80c5-5820-2ff9d1296620@linaro.org>
Date: Thu, 6 Jun 2019 13:19:40 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1559816130-17113-5-git-send-email-stefan.brankovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::244
Subject: Re: [Qemu-devel] [PATCH 4/8] target/ppc: Optimize emulation of
 vgbbd instruction
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
Cc: david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/6/19 5:15 AM, Stefan Brankovic wrote:
> Optimize altivec instruction vgbbd (Vector Gather Bits by Bytes by Doubleword)
> All ith bits (i in range 1 to 8) of each byte of doubleword element in
> source register are concatenated and placed into ith byte of appropriate
> doubleword element in destination register.
> 
> Following solution is done for every doubleword element of source register
> (placed in shifted variable):
> We gather bits in 2x8 iterations.
> In first iteration bit 1 of byte 1, bit 2 of byte 2,... bit 8 of byte 8 are
> in their final spots so we just and avr with mask. For every next iteration,
> we have to shift right both shifted(7 places) and mask(8 places), so we get
> bit 1 of byte 2, bit 2 of byte 3.. bit 7 of byte 8 in right places so we and
> shifted with new value of mask... After first 8 iteration(first for loop) we
> have all first bits in their final place all second bits but second bit from
> eight byte in their place,... only 1 eight bit from eight byte is in it's
> place), so we and result1 with mask1 to save those bits that are at right
> place and save them in result1. In second loop we do all operations
> symetrical, so we get other half of bits on their final spots, and save
> result in result2. Or of result1 and result2 is placed in appropriate
> doubleword element of vD. We repeat this 2 times.
> 
> Signed-off-by: Stefan Brankovic <stefan.brankovic@rt-rk.com>
> ---
>  target/ppc/translate/vmx-impl.inc.c | 99 ++++++++++++++++++++++++++++++++++++-
>  1 file changed, 98 insertions(+), 1 deletion(-)
> 
> diff --git a/target/ppc/translate/vmx-impl.inc.c b/target/ppc/translate/vmx-impl.inc.c
> index 87f69dc..010f337 100644
> --- a/target/ppc/translate/vmx-impl.inc.c
> +++ b/target/ppc/translate/vmx-impl.inc.c
> @@ -780,6 +780,103 @@ static void trans_vsr(DisasContext *ctx)
>      tcg_temp_free_i64(tmp);
>  }
>  
> +/*
> + * vgbbd VRT,VRB - Vector Gather Bits by Bytes by Doubleword
> + *
> + * All ith bits (i in range 1 to 8) of each byte of doubleword element in source
> + * register are concatenated and placed into ith byte of appropriate doubleword
> + * element in destination register.
> + *
> + * Following solution is done for every doubleword element of source register
> + * (placed in shifted variable):
> + * We gather bits in 2x8 iterations.
> + * In first iteration bit 1 of byte 1, bit 2 of byte 2,... bit 8 of byte 8 are
> + * in their final spots so we just and avr with mask. For every next iteration,
> + * we have to shift right both shifted(7 places) and mask(8 places), so we get
> + * bit 1 of byte 2, bit 2 of byte 3.. bit 7 of byte 8 in right places so we and
> + * shifted with new value of mask... After first 8 iteration(first for loop) we
> + * have all first bits in their final place all second bits but second bit from
> + * eight byte in their place,... only 1 eight bit from eight byte is in it's
> + * place), so we and result1 with mask1 to save those bits that are at right
> + * place and save them in result1. In second loop we do all operations
> + * symetrical, so we get other half of bits on their final spots, and save
> + * result in result2. Or of result1 and result2 is placed in appropriate
> + * doubleword element of vD. We repeat this 2 times.
> + */
> +static void trans_vgbbd(DisasContext *ctx)
> +{
> +    int VT = rD(ctx->opcode);
> +    int VB = rB(ctx->opcode);
> +    TCGv_i64 tmp = tcg_temp_new_i64();
> +    TCGv_i64 avr = tcg_temp_new_i64();
> +    TCGv_i64 shifted = tcg_temp_new_i64();
> +    TCGv_i64 result1 = tcg_temp_new_i64();
> +    TCGv_i64 result2 = tcg_temp_new_i64();
> +    uint64_t mask = 0x8040201008040201ULL;
> +    uint64_t mask1 = 0x80c0e0f0f8fcfeffULL;
> +    uint64_t mask2 = 0x7f3f1f0f07030100ULL;
> +    int i;
> +
> +    get_avr64(avr, VB, true);
> +    tcg_gen_movi_i64(result1, 0x0ULL);
> +    tcg_gen_mov_i64(shifted, avr);
> +    for (i = 0; i < 8; i++) {
> +        tcg_gen_andi_i64(tmp, shifted, mask);
> +        tcg_gen_or_i64(result1, result1, tmp);
> +
> +        tcg_gen_shri_i64(shifted, shifted, 7);
> +        mask = mask >> 8;
> +    }
> +    tcg_gen_andi_i64(result1, result1, mask1);

This masking appears to be redundant with the masking within the loop.

> +
> +    mask = 0x8040201008040201ULL;
> +    tcg_gen_movi_i64(result2, 0x0ULL);
> +    for (i = 0; i < 8; i++) {
> +        tcg_gen_andi_i64(tmp, avr, mask);
> +        tcg_gen_or_i64(result2, result2, tmp);
> +
> +        tcg_gen_shli_i64(avr, avr, 7);
> +        mask = mask << 8;
> +    }
> +    tcg_gen_andi_i64(result2, result2, mask2);

Similarly.

Also, the first iteration of the second loop is redundant with the first
iteration of the first loop.

I will also note that these are large constants, not easily constructable.
Therefore it would be best to avoid needing to construct them twice.  You can
do this by processing the two doublewords simultaneously.  e.g.

	TCGv_i64 avr[2], out[2], tmp, tcg_mask;

	identity_mask = 0x8040201008040201ull;
	tcg_gen_movi_i64(tcg_mask, identity_mask);
	for (j = 0; j < 2; j++) {
	    get_avr(avr[j], VB, j);
	    tcg_gen_and_i64(out[j], avr[j], tcg_mask);
	}
	for (i = 1; i < 8; i++) {
	    tcg_gen_movi_i64(tcg_mask, identity_mask >> (i * 8);
	    for (j = 0; j < 2; j++) {
	        tcg_gen_shri_i64(tmp, avr[j], i * 7);
	        tcg_gen_and_i64(tmp, tmp, tcg_mask);
	        tcg_gen_or_i64(out[j], out[j], tmp);
	    }
	}
	for (i = 1; i < 8; i++) {
	    tcg_gen_movi_i64(tcg_mask, identity_mask << (i * 8));
	    for (j = 0; j < 2; j++) {
	        tcg_gen_shli_i64(tmp, avr[j], i * 7);
	        tcg_gen_and_i64(tmp, tmp, tcg_mask);
	        tcg_gen_or_i64(out[j], out[j], tmp);
	    }
	}
	for (j = 0; j < 2; j++) {
	    set_avr(VT, out[j], j);
	}

This should produce the same results with fewer operations.


r~

