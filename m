Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC8E7C43219
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 16:37:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A69C520652
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 16:37:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tWKDQ2UA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A69C520652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50011 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLVlN-0000oU-12
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 12:37:49 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36347)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLVkQ-0000JT-NK
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 12:36:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLVkP-00017t-T4
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 12:36:50 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:40163)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hLVkP-00017D-L0
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 12:36:49 -0400
Received: by mail-pf1-x444.google.com with SMTP id u17so3364622pfn.7
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 09:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=QYPPVja3cYoKkd5VXE32o6HiEfjZ0o1eQ1OuBPA7nf8=;
	b=tWKDQ2UATxh56S82SZZUkLQcqmmFdvtBLs5CIavLt78LidUdgiwYzkV2ZQ5ZYGhrpD
	RNr0Vh/2E/vF+qHW3Nt5DaYM4MuFSmpvhPaQgbz8sXzJMV8bc8HA3d7Jby44yTPWOq7N
	hrgIq+BeaAywIQVoYFL2keVS8xdlPdnsQi/RtD8SssQrFyO/LjX+JXZGH0pn6X922v3o
	uzFaAmHD6CyTfa1W/imVVXR2Irqd9qG3S2gQbTtesaxx6DkEvJlAPlNIwV1Bm6qPq+fi
	aK+dZo908zwVB1Mx9F5FVqU3VKdqk7Dg6/wTP2TPsTppaSfCJvjQlYlh9uyr3MjU9ME5
	DiwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=QYPPVja3cYoKkd5VXE32o6HiEfjZ0o1eQ1OuBPA7nf8=;
	b=PfZMhumvnL65DqoMsiDXTeA349OfmIiBmINeyPSaGEiAYvyp+YmDbGETkI1Af5OCcY
	BoaNRk7yODw2hfqzkPeJqrSrMV9jHF7rxbY590ly8yoCmeGETK1Zg/bT3tc9L7qFQLcb
	wBBOBuUWoA6giwpx+fZYjihbcojy4k0zT8DTal2OSx+pqEkmtmSyaXIIedAEuKfcW5y3
	oTWy0YeICujoSJi9YQ9onH289RpNdOFZT5os/ZGSwww3k0TNFExCla0ILnpNjb1Ec/vh
	mcKDZjuJQADlw038+NYet+WPmt7lElwTVWnDTKQRpz6RVoI1gUfyGD2iobW8reTRC2K/
	bJFw==
X-Gm-Message-State: APjAAAVzg0SmgBKGE1bgIxF3/UkpNs0PFfPKvCYHdm573sfPgxvpTgqI
	DpoD6vyjxKlBZGmoxeoQNpeN5A==
X-Google-Smtp-Source: APXvYqzuYm5NuOhilgk4u1bYAyZUKx5Wom7dXUFR0E9YClXHoqTlILB7qjKa6G7jsGd2a/k9u9C8PA==
X-Received: by 2002:a63:cd50:: with SMTP id a16mr48036665pgj.394.1556642208472;
	Tue, 30 Apr 2019 09:36:48 -0700 (PDT)
Received: from [192.168.1.11] (97-113-18-231.tukw.qwest.net. [97.113.18.231])
	by smtp.gmail.com with ESMTPSA id
	c127sm46752609pfc.132.2019.04.30.09.36.46
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 30 Apr 2019 09:36:47 -0700 (PDT)
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
	qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, rth@twiddle.net,
	gkurz@kaod.org
References: <20190428143845.11810-1-mark.cave-ayland@ilande.co.uk>
	<20190428143845.11810-5-mark.cave-ayland@ilande.co.uk>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <557b6776-45ab-0c00-7e1e-45fe33705d0b@linaro.org>
Date: Tue, 30 Apr 2019 09:36:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190428143845.11810-5-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::444
Subject: Re: [Qemu-devel] [PATCH 04/14] target/ppc: introduce
 GEN_VSX_HELPER_X3 macro to fpu_helper.c
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190430163642.neSZFGGD-kjV5XHNShmFRaGe-IWq4Wi2D2tMZ7QZZIg@z>

On 4/28/19 7:38 AM, Mark Cave-Ayland wrote:
> +#define GEN_VSX_HELPER_X3(name, op1, op2, inval, type)                        \
> +static void gen_##name(DisasContext *ctx)                                     \
> +{                                                                             \
> +    TCGv_i32 opc;                                                             \
> +    TCGv_ptr xt, xa, xb;                                                      \
> +    if (unlikely(!ctx->vsx_enabled)) {                                        \
> +        gen_exception(ctx, POWERPC_EXCP_VSXU);                                \
> +        return;                                                               \
> +    }                                                                         \
> +    opc = tcg_const_i32(ctx->opcode);                                         \
> +    xt = gen_vsr_ptr(xT(ctx->opcode));                                        \
> +    xa = gen_vsr_ptr(xA(ctx->opcode));                                        \
> +    xb = gen_vsr_ptr(xB(ctx->opcode));                                        \

Do you still need to pass opc?

Anyway, I guess this is still progress...
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

