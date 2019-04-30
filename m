Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BFDEC43219
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 16:31:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0563020644
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 16:31:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QPMppVRE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0563020644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49884 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLVf9-0005Qs-3c
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 12:31:23 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34329)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLVdl-0004Rn-1R
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 12:29:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLVdj-0004pU-T7
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 12:29:56 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:45851)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hLVdj-0004ns-3K
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 12:29:55 -0400
Received: by mail-pl1-x643.google.com with SMTP id o5so6960355pls.12
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 09:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=oYED+v33kjn9GdtNu/ZK9YP9lcL0eScTlu+mmd/zEQo=;
	b=QPMppVREIjvnojldJHH0GDYaWoYlJxLp1hbRxaqukPwqFMyQlfUWyzw/0cG85mS3ZB
	nM7Bn+8NN0pVMXW0dACXJyb3WposJLga5b8Z/CpRoURRWHgIi+NXijZEFqWscL9lDiaq
	SEiZwOtM2IJH7QlDw5kIYlpGdKeZmEeuH7aAj9xwSqwDQbcKNd/WxFSaRpkodsn29Ywx
	sBRvstqtxR89/NKGOKYF3bULjtno/5ycvHzyNGoBXWbeIiEhf6t3oD2YGuq0Nws5YOAE
	klb1y5vlSzNJCStDESai/F6Tvw+xXlHUNEd/qLFJNOeXPxRP4rtJUR5cK53ZFx0ltfyn
	ZKFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=oYED+v33kjn9GdtNu/ZK9YP9lcL0eScTlu+mmd/zEQo=;
	b=a2Jf+2Q9U1bFcR/KC6O2zZOQlVoU5KJ6ONSGdWvSkHOGvNnVM4+MS8yfM7hNx3HM/F
	Cb3awBh/k60QhbpsrEmkTfRMwXECgnWz/hgSGgpvhGq9a1DcTFL4eOfcTAXBCVCuUDh6
	V2Z0ErjxvcB0VjZqSi0WDTxxPUy9qbDF6OaROcTVKLE30CaT0oj066nUc+RR10jebl/Z
	LIIAGwiRtbAiiyX0oII4w1RkCo3YyGLQK5Cjs+Zkd4kB+Y1oFIMee5v3SahkiAY6JfT4
	LDbMGTUAcOM9zeDXMT4dk5QEv2o+OLuyNmlRwO54lFENPCdHFYpo0mauwq1Kfz0rEZjl
	nLNg==
X-Gm-Message-State: APjAAAVMPZLpyYO9Po40BQRYxJr4UC/2U1ZAxPS5LEHRna+5k/t5VXJr
	78PcMlxP4ZiC0jbQUeHV2voB9Q==
X-Google-Smtp-Source: APXvYqw2+LkY/IUxfNYOh80sT9+yCkpWB0CEyRi1Z2GMmf+WdfBH5TFkV4Oz4JXOht7dzFXeoomn0g==
X-Received: by 2002:a17:902:b715:: with SMTP id
	d21mr71078356pls.103.1556641793161; 
	Tue, 30 Apr 2019 09:29:53 -0700 (PDT)
Received: from [192.168.1.11] (97-113-18-231.tukw.qwest.net. [97.113.18.231])
	by smtp.gmail.com with ESMTPSA id
	o15sm14844481pgb.85.2019.04.30.09.29.52
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 30 Apr 2019 09:29:52 -0700 (PDT)
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
	qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, rth@twiddle.net,
	gkurz@kaod.org
References: <20190428143845.11810-1-mark.cave-ayland@ilande.co.uk>
	<20190428143845.11810-3-mark.cave-ayland@ilande.co.uk>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <55204805-9275-2bc4-2c38-51dc87aa836d@linaro.org>
Date: Tue, 30 Apr 2019 09:29:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190428143845.11810-3-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::643
Subject: Re: [Qemu-devel] [PATCH 02/14] target/ppc: remove getVSR()/putVSR()
 from mem_helper.c
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
Message-ID: <20190430162948.XOD27MP59KyzBygl9GdT6rvoZNiNS_I75fSznEFNHhk@z>

On 4/28/19 7:38 AM, Mark Cave-Ayland wrote:
>  #define VSX_LXVL(name, lj)                                              \
>  void helper_##name(CPUPPCState *env, target_ulong addr,                 \
> -                   target_ulong xt_num, target_ulong rb)                \
> +                   target_ulong xt, target_ulong rb)                    \
>  {                                                                       \
> +    ppc_vsr_t *r = &env->vsr[xt];                                       \
> +    int nb = GET_NB(env->gpr[rb]);                                      \
>      int i;                                                              \
> -    ppc_vsr_t xt;                                                       \
> -    uint64_t nb = GET_NB(rb);                                           \
>                                                                          \
> -    xt.s128 = int128_zero();                                            \
> +    r->s128 = int128_zero();                                            \
>      if (nb) {                                                           \
>          nb = (nb >= 16) ? 16 : nb;                                      \
>          if (msr_le && !lj) {                                            \
>              for (i = 16; i > 16 - nb; i--) {                            \
> -                xt.VsrB(i - 1) = cpu_ldub_data_ra(env, addr, GETPC());  \
> +                r->VsrB(i - 1) = cpu_ldub_data_ra(env, addr, GETPC());  \
>                  addr = addr_add(env, addr, 1);                          \
>              }                                                           \
>          } else {                                                        \
>              for (i = 0; i < nb; i++) {                                  \
> -                xt.VsrB(i) = cpu_ldub_data_ra(env, addr, GETPC());      \
> +                r->VsrB(i) = cpu_ldub_data_ra(env, addr, GETPC());      \
>                  addr = addr_add(env, addr, 1);                          \
>              }                                                           \
>          }                                                               \
>      }                                                                   \
> -    putVSR(xt_num, &xt, env);                                           \
>  }

Similarly, this modifies env->vsr[xt] before all exceptions are recognized.

> @@ -304,12 +304,14 @@ static void gen_##name(DisasContext *ctx)                       \
>          }                                                       \
>      }                                                           \
>      EA = tcg_temp_new();                                        \
> -    xt = tcg_const_tl(xT(ctx->opcode));                         \
>      gen_set_access_type(ctx, ACCESS_INT);                       \
>      gen_addr_register(ctx, EA);                                 \
> -    gen_helper_##name(cpu_env, EA, xt, cpu_gpr[rB(ctx->opcode)]); \
> +    xt = tcg_const_tl(xT(ctx->opcode));                         \
> +    rb = tcg_const_tl(rB(ctx->opcode));                         \
> +    gen_helper_##name(cpu_env, EA, xt, rb);                     \
>      tcg_temp_free(EA);                                          \
>      tcg_temp_free(xt);                                          \
> +    tcg_temp_free(rb);                                          \
>  }

Why are you adjusting the function to pass the rB register number rather than
the contents of rB?  That seems the wrong way around...


r~

