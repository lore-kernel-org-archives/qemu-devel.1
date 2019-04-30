Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75910C43219
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 17:22:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E4142147A
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 17:22:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J0gR3Jvy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E4142147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50604 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLWST-0000gt-B6
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 13:22:21 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39137)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLW2P-00048d-MF
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 12:55:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLVvH-0005vd-0N
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 12:48:03 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:32982)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hLVvG-0005vN-Pu
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 12:48:02 -0400
Received: by mail-pf1-x441.google.com with SMTP id z28so2039567pfk.0
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 09:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=ivHTq9NA90NnFAcOynI4tVCb04fi9J23LjYxLsWBKd0=;
	b=J0gR3JvyomIjUIxQTxW0WWaB7qRAesDpSY3QHoUtc5E9aAVgjoBwmpP6l8ou445OWM
	vYSXZ/gk9rwsCYpb63jne3GWAhir2MBfB7ULdFR5GqnHs7yZMf6e034EfOlg2nPG3Vcb
	OdVxxOuDLV4nIih0zaElVZj/p/IOnLqwgTkIjiMwywpgTcUCvHxQWdDKluOeUBLVAbVS
	pzqDrS7qFUcZaTL2DQL0s9wSBWD1ZoRf9/wVj2jMCwfCmnxZHEMyKFGCtgzt33rsA8tj
	sozA5AomRVhRHMk4D5UovqiZXS19YHL49djSDzLV88+GoEsdHpZeHZ0AVFRHv7SD8ujq
	cNdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=ivHTq9NA90NnFAcOynI4tVCb04fi9J23LjYxLsWBKd0=;
	b=WPrm8TNgrshPk4iZSJ/don+I9KvD//AlHnRZGLGoUAFLvu85MZhqEWXOc3LqsLJJUN
	T8xEYBfql7ffainYj17SjREAp8jjRrIJpJv9oRrhl9gBnmsf9XKMaV5hRNZnbz7/e+kO
	d7Py6VzJRFDZTVrBxDVc3yhmGetmLVC8jL8au8uuxLjavPpB+MqFK3KRHBSlqFoZhSTG
	a3rWigDdY9km7CCtJuVZYvvKI6BnKqxeA23nYZKhCrZR4LiPEzGIiJHhTcpY7gOnHAW8
	fvxf6nOASzbP+/2QrpbTGFgKV1VerRi1FpCvX9uQa8nQEltZw0dEaSwv61Otdo+XxUGs
	8nIA==
X-Gm-Message-State: APjAAAUYXS9BZ8t+U9AVE+artQzT9IdMW2FHrqQ3DTSnLPe9x19iKNzq
	Zjbun543YKtgKA+Dy+5T1TbASA==
X-Google-Smtp-Source: APXvYqyTXMcUddLg0NJAPd8uhCOQWD8qbR49C81m9tmSVpyRi0kSLrlxftEMcEUsuYJv65XIma3GPA==
X-Received: by 2002:a65:5cc8:: with SMTP id b8mr65087799pgt.36.1556642881645; 
	Tue, 30 Apr 2019 09:48:01 -0700 (PDT)
Received: from [192.168.1.11] (97-113-18-231.tukw.qwest.net. [97.113.18.231])
	by smtp.gmail.com with ESMTPSA id
	h4sm49930152pfo.119.2019.04.30.09.47.58
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 30 Apr 2019 09:48:00 -0700 (PDT)
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
	qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, rth@twiddle.net,
	gkurz@kaod.org
References: <20190428143845.11810-1-mark.cave-ayland@ilande.co.uk>
	<20190428143845.11810-9-mark.cave-ayland@ilande.co.uk>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <4c8b7939-cd48-fd3f-8f3d-3f6fd18b6be2@linaro.org>
Date: Tue, 30 Apr 2019 09:47:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190428143845.11810-9-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::441
Subject: Re: [Qemu-devel] [PATCH 08/14] target/ppc: introduce
 GEN_VSX_HELPER_R3 macro to fpu_helper.c
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
Message-ID: <20190430164751.ubALqTpIRpwiayP55UkQp4SMEmCuUoFtKaRMriyf-ZU@z>

On 4/28/19 7:38 AM, Mark Cave-Ayland wrote:
> +#define GEN_VSX_HELPER_R3(name, op1, op2, inval, type)                        \
> +static void gen_##name(DisasContext *ctx)                                     \
> +{                                                                             \
> +    TCGv_i32 opc;                                                             \
> +    TCGv_ptr xt, xa, xb;                                                      \
> +    if (unlikely(!ctx->vsx_enabled)) {                                        \
> +        gen_exception(ctx, POWERPC_EXCP_VSXU);                                \
> +        return;                                                               \
> +    }                                                                         \
> +    opc = tcg_const_i32(ctx->opcode);                                         \
> +    xt = gen_vsr_ptr(rD(ctx->opcode) + 32);                                   \
> +    xa = gen_vsr_ptr(rA(ctx->opcode) + 32);                                   \
> +    xb = gen_vsr_ptr(rB(ctx->opcode) + 32);                                   \
> +    gen_helper_##name(cpu_env, opc, xt, xa, xb);                              \

Is opc still used here?  Otherwise,

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

