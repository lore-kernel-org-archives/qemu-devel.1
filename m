Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E4E2C04AB5
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 18:35:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 293B420872
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 18:35:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VIiEFrKM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 293B420872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36656 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYxEP-0004mS-2l
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 14:35:21 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58328)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hYxDW-0004L0-4y
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 14:34:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hYxDV-0003Sp-71
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 14:34:26 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:34577)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hYxDU-0003KL-UB
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 14:34:25 -0400
Received: by mail-ot1-x341.google.com with SMTP id z24so2939032oto.1
	for <qemu-devel@nongnu.org>; Thu, 06 Jun 2019 11:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=RlCYGH+221kIeiTRbc/5GBCNLC+DFHEoe//7Gf2/98w=;
	b=VIiEFrKMsviaSBA+PC2ycGHJLG1ksnEf+FYoxzla012OXRAmRWCBlLfpXcHdfpmswp
	Q3uAXWxsB7vhpKq352jDcO00A1WlLyKaka/cPnlAot4+g0lI+FUEvnIcjqq/ac3kUqm8
	lskWQP+uu4eOsisInRiSdeJW8/BW3CBI9U/3Cxaq0IMLIhPOkIgaZysfdOu3ZA+2TWVK
	uJEAINVUfhYVxTGplkHOBBFAWjq5ltD1eyHFBKNWFSIrgir+ydPKqTu780z3D/TCvEBF
	uPEwCSMAHgNQTnKJatiKRSi2jYGwkA3/Z5lzIh3cRfeW6uPSeMA2O/WhxePLrNyTjKO/
	ZCwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=RlCYGH+221kIeiTRbc/5GBCNLC+DFHEoe//7Gf2/98w=;
	b=KIiQJPpHMKqvkPSbQGmxqW8QWPKECVcmxKBG65I/odg9QmM/cj3jvrf8UDob1GtNI0
	a81RSUR1uowKnG659+U3SS50dT36cGUZ3oSrmB/TaRglP2tyF0X0KcrCsK3uTGOS8OG7
	YjNioe1/gRwtofunG5s2YRBPqW+0Uj14XU/8l6qjtm0Ffuo//qOUpcJ1Jya+UAGOFOzu
	zhugTlb/o6NPsrR4qAhq7ATjUhKHq+ixX17VG42zRs4T122GoSi0bk302mDKLr/PddlV
	fwUtFUfLa/opQik05xus/HLYmESpvka8g3EHifuOvdsB0TEI3Sb3cnBB8GHHX7D9VE2/
	O5wA==
X-Gm-Message-State: APjAAAXDufUdxDN7VK19wwDvtKUfV+NTYmMLvUe3Uuva469SgWcBAR2S
	5ZIV7heiVvId/ULAmSpO24ayCQ==
X-Google-Smtp-Source: APXvYqzR7nykvAaWcyjyaYyQ8Zsrl7DCr6ZKDA4x6dnK7rVoNyQ563J2qyennh8GIzWVoWCnGCnPGQ==
X-Received: by 2002:a9d:7d16:: with SMTP id v22mr11417123otn.124.1559846061266;
	Thu, 06 Jun 2019 11:34:21 -0700 (PDT)
Received: from [192.168.3.43] (200-56-192-86-cable.cybercable.net.mx.
	[200.56.192.86])
	by smtp.gmail.com with ESMTPSA id o3sm822774otl.76.2019.06.06.11.34.20
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 06 Jun 2019 11:34:20 -0700 (PDT)
To: Stefan Brankovic <stefan.brankovic@rt-rk.com>, qemu-devel@nongnu.org
References: <1559816130-17113-1-git-send-email-stefan.brankovic@rt-rk.com>
	<1559816130-17113-7-git-send-email-stefan.brankovic@rt-rk.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <18871125-cb2c-57e7-864d-c5c7a8846093@linaro.org>
Date: Thu, 6 Jun 2019 13:34:17 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1559816130-17113-7-git-send-email-stefan.brankovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::341
Subject: Re: [Qemu-devel] [PATCH 6/8] target/ppc: Optimize emulation of
 vclzw instruction
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
> +    for (i = 0; i < 2; i++) {
> +        if (i == 0) {
> +            /* Get high doubleword element of vB in avr. */
> +            get_avr64(avr, VB, true);
> +        } else {
> +            /* Get low doubleword element of vB in avr. */
> +            get_avr64(avr, VB, false);
> +        }

Better as simply get_avr64(avr, VB, i);

> +        /*
> +         * Perform count for every word element using tcg_gen_clzi_i64.
> +         * Since it counts leading zeros on 64 bit lenght, we have to move
> +         * ith word element to highest 32 bits of tmp, or it with mask(so we get
> +         * all ones in lowest 32 bits), then perform tcg_gen_clzi_i64 and move
> +         * it's result in appropriate word element of result.
> +         */
> +        tcg_gen_shli_i64(tmp, avr, 32);
> +        tcg_gen_or_i64(tmp, tmp, mask);
> +        tcg_gen_clzi_i64(result, tmp, 64);
> +
> +        tcg_gen_or_i64(tmp, avr, mask);
> +        tcg_gen_clzi_i64(tmp, tmp, 64);

s/64/32.

> +        tcg_gen_deposit_i64(result, result, tmp, 32, 32);

That said, it's probably better to treat this as 4 words, not 2 doublewords.

	for (i = 0; i < 4; i++) {
	    tcg_gen_ld_i32(tmp, cpu_env, avr_full_offset(VB) + i * 4);
	    tcg_gen_clzi_i32(tmp, tmp, 32);
	    tcg_gen_st_i32(tmp, cpu_env, avr_full_offset(VT) + i * 4);
	}


r~

