Return-Path: <SRS0=hY9S=T7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF2C8C04AB6
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 17:49:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79CD126D5E
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 17:49:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="flDRSxmu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79CD126D5E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47125 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWlej-0005al-Ro
	for qemu-devel@archiver.kernel.org; Fri, 31 May 2019 13:49:29 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55591)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hWldm-0005Jp-MT
	for qemu-devel@nongnu.org; Fri, 31 May 2019 13:48:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hWldl-0004y0-K4
	for qemu-devel@nongnu.org; Fri, 31 May 2019 13:48:30 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:35056)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hWldl-0004x6-9F
	for qemu-devel@nongnu.org; Fri, 31 May 2019 13:48:29 -0400
Received: by mail-oi1-x241.google.com with SMTP id y6so4736465oix.2
	for <qemu-devel@nongnu.org>; Fri, 31 May 2019 10:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=CDc/JVw+52I/alb2lQU/Zyy98nAkyaGg8+py/RsfLpk=;
	b=flDRSxmupn6aUIMM8cymKmQs6BiSXRHQ1Pt7Vb+xDFKliMtL9Xv5s6FnY/YrpxZ+aZ
	3cBZCv3tVr0EGT09X4RCJ1Ew133NyPdklaRUiDnAanz5f0C731QQ/N8AtGfq58SAZ+po
	hnrMb4HDvLmqi4kQf2Z97xdDHc7aBx2LNXYuBqeMRAhNrIXeCpSFKv/99lrBIsaKKA+E
	0lXS0TZQzntGTRBA6rcUnQ3Y+dITTJpnJ9vEYsifCdDQcmj6Ale6ijNQvbusGO1mNkOf
	7OGwmGM6CEzlVvraxoIGRKvAoaZ2UwZ62UjEacUVZcNqWFBEVCOriwPFQWs/IxmtXFli
	Sl1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=CDc/JVw+52I/alb2lQU/Zyy98nAkyaGg8+py/RsfLpk=;
	b=MV3d4HGVxGtrSP/nWYRXCXeGuGFpvkx3/PBQBwZrgAFwUIG9cG7FWRlzJAKOizLMZ/
	VN0msNc+hVpcI/WUdISo3Mw8/63w3R9DEcGlbIaoeTGMQVJbB/umxFCCdHQxc3L1DMM3
	8D/3LO+GJHxWyHb/NIUC25jfFJpx+4eQdDICOTVKnsXnloqRsYhG4WIVScefpsCjOoF+
	pb/j7/ByzPZ3f7c/nFeq9J1ORmEEeXRTPQ6w2Xme9LBrn+cvUCe7aMLeYoNl8xhGrmIV
	3772hZOWTy0zt09848qmnMTtpAw8rCbRP5FlVeXrnj6oDFKI6Rdj3DCRAtcEEwpEPS9c
	DIDQ==
X-Gm-Message-State: APjAAAXEZifuLzJ+YbkrIiOQQrceYz9W3MdObLn0ydxuoAVIxYBu3Zu6
	diFNjTurTsQ13IS0p5O35ZQu/Q==
X-Google-Smtp-Source: APXvYqwMYQpedxHp9Hm2G5BwhfvpsXSdb+7oD4a7yUhcKkpFjxjbbzXoTlHOhcMnqszCUoN7GLZKVQ==
X-Received: by 2002:aca:5209:: with SMTP id g9mr16271oib.35.1559324908120;
	Fri, 31 May 2019 10:48:28 -0700 (PDT)
Received: from [172.24.12.210] (168.189-204-159.bestelclientes.com.mx.
	[189.204.159.168]) by smtp.gmail.com with ESMTPSA id
	l31sm2267626otc.30.2019.05.31.10.48.26
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 31 May 2019 10:48:27 -0700 (PDT)
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190531104432.29379-1-david@redhat.com>
	<20190531104432.29379-18-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <3b28ed7b-cbde-c7a3-c072-df8eeb55a288@linaro.org>
Date: Fri, 31 May 2019 12:48:24 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190531104432.29379-18-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::241
Subject: Re: [Qemu-devel] [PATCH v1 17/23] s390x/tcg: Implement VECTOR FP
 PERFORM SIGN OPERATION
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
Cc: Christian Borntraeger <borntraeger@de.ibm.com>,
	Denys Vlasenko <dvlasenk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/31/19 5:44 AM, David Hildenbrand wrote:
> +static DisasJumpType op_vfpso(DisasContext *s, DisasOps *o)
> +{
> +    const uint8_t fpf = get_field(s->fields, m3);
> +    const uint8_t m4 = get_field(s->fields, m4);
> +    const uint8_t m5 = get_field(s->fields, m5);
> +    const bool se = extract32(m4, 3, 1);
> +    TCGv_i64 tmp;
> +    int i;
> +
> +    if (fpf != FPF_LONG || extract32(m4, 0, 3) || m5 > 2) {
> +        gen_program_exception(s, PGM_SPECIFICATION);
> +        return DISAS_NORETURN;
> +    }
> +
> +    tmp = tcg_temp_new_i64();
> +    for (i = 0; i < 2; i++) {
> +        read_vec_element_i64(tmp, get_field(s->fields, v2), i, ES_64);
> +
> +        switch (m5) {
> +        case 0:
> +            /* sign bit is inverted (complement) */
> +            tcg_gen_xori_i64(tmp, tmp, 1ull << 63);
> +            break;
> +        case 1:
> +            /* sign bit is set to one (negative) */
> +            tcg_gen_ori_i64(tmp, tmp, 1ull << 63);
> +            break;
> +        case 2:
> +            /* sign bit is set to zero (positive) */
> +            tcg_gen_andi_i64(tmp, tmp, (1ull << 63) - 1);
> +            break;
> +        }
> +
> +        write_vec_element_i64(tmp, get_field(s->fields, v1), i, ES_64);
> +        if (se) {
> +            break;
> +        }
> +    }
> +    tcg_temp_free_i64(tmp);
> +    return DISAS_NEXT;
> +}

Better to use tcg_gen_gvec_{and,xor,or}i to do all of the elements at once.
Won't work for FPF_EXTENDED, but much better for FPF_SINGLE, once they're
supported.


r~

