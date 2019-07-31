Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01739C32751
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 19:51:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0A74206B8
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 19:51:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B55vCmMo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0A74206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44050 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsud2-0007Ao-Vm
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 15:51:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48859)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hsucM-0006k0-1X
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 15:50:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hsucK-0006gs-HC
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 15:50:33 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:40188)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hsucK-0006fg-5J
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 15:50:32 -0400
Received: by mail-pf1-x444.google.com with SMTP id p184so32444452pfp.7
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2019 12:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=24a14m2MyWcMaEitorwyCKqCcBd2O7avmsKoYnSSNTE=;
 b=B55vCmMoWNZsSUPq6qTEDDEPDcXQtEkPBLZDEZoGX1/qKhvqd3gfnq1tvZxYexQLte
 X5Yk9EJvXNYtBLetqsL9Zw1jWh+tWtDR2vNilIUgh6d8ucJxwTfhqXlWuZXiWit/m+OH
 /ywSe90yDSmOVICkF+psLsmLnKuia0sAo1J5Yb7UNpQX3LiAi7KnVEGL2D0+zU+QP+ly
 Mx4U7Recw/VGDT9QfDrycbkcYBcFE8QHFiTa8MbSwRDaWa3RYwtF9797pgP0+u6FVWJQ
 1mu7pc9y3WZ9zDwCHD98EQ0TiR7Y3lOPbg7r0XSleDKxuxbW7btvx8A6Fk/nckQaj3Mq
 XRNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=24a14m2MyWcMaEitorwyCKqCcBd2O7avmsKoYnSSNTE=;
 b=rB3+IwjZmx3HhVkyX4RGz9SjRUVBIKH6PREzTR1/vE9bAj+WpY3bVh+j9xjdUH3po8
 SZQvTAXYzTYgHfvK1hwQ+JaPiVbjmtBqOYWvBV/Ba0jP17XzjTMkOGv08inKVq+0dkJV
 /hzzCZtoJCAw8s7E8uI5juIFVYhQDGx0J4N0W3B98g2WV1eFKM+VwRsy7pA5JdKXZ8wq
 JoWmgPaE7J6XKD1RQjDGTEfe5VplauIKDyvLiapTBZR3RZDux1weUH7BWNgPBQjnLfPZ
 Curn1hhW1HL2TrXQ6Co0uADbilHTU8nAUer3mbttNMXIxxxIVRngygh0utDiiFhI/QSh
 gwoQ==
X-Gm-Message-State: APjAAAVgMekvBFULgztuYP4++yF+dPc6NYTA/1CyIF7dPXGgKcZhYqnq
 jI7msR2soKSKgi9qC+tBPfoOHg==
X-Google-Smtp-Source: APXvYqwxJo2VVQx1YsewxXRbqLEP1UiVEJCvhXpmVDiI1vLNp21TGIG88KDyTjePh23HibLtIIUbeQ==
X-Received: by 2002:a17:90a:71ca:: with SMTP id
 m10mr4644816pjs.27.1564602630820; 
 Wed, 31 Jul 2019 12:50:30 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id q1sm81117788pfg.84.2019.07.31.12.50.29
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 31 Jul 2019 12:50:29 -0700 (PDT)
To: Jan Bobek <jan.bobek@gmail.com>, qemu-devel@nongnu.org
References: <20190731175702.4916-1-jan.bobek@gmail.com>
 <20190731175702.4916-23-jan.bobek@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <1691a32a-e0a2-931b-2d17-4dae8dde7c7e@linaro.org>
Date: Wed, 31 Jul 2019 12:50:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190731175702.4916-23-jan.bobek@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
Subject: Re: [Qemu-devel] [RFC PATCH v1 22/22] target/i386: reimplement
 (V)P(EQ, CMP)(B, W, D)
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/31/19 10:57 AM, Jan Bobek wrote:
> +static inline void gen_gvec_cmpeq(unsigned vece, uint32_t dofs,
> +                                  uint32_t aofs, uint32_t bofs,
> +                                  uint32_t oprsz, uint32_t maxsz)
> +{
> +    tcg_gen_gvec_cmp(TCG_COND_EQ, vece, dofs, aofs, bofs, oprsz, maxsz);
> +}
...
> +static inline void gen_gvec_cmpgt(unsigned vece, uint32_t dofs,
> +                                  uint32_t aofs, uint32_t bofs,
> +                                  uint32_t oprsz, uint32_t maxsz)
> +{
> +    tcg_gen_gvec_cmp(TCG_COND_GT, vece, dofs, aofs, bofs, oprsz, maxsz);
> +}

Drop the inlines.

> +#define gen_pcmpgt_mm(env, s, modrm, vece)   gen_gvec_ld_modrm_mm  ((env), (s), (modrm), (vece), gen_gvec_cmpgt, 0112)
> +#define gen_pcmpgt_xmm(env, s, modrm, vece)  gen_gvec_ld_modrm_xmm ((env), (s), (modrm), (vece), gen_gvec_cmpgt, 0112)
> +#define gen_vpcmpgt_xmm(env, s, modrm, vece) gen_gvec_ld_modrm_vxmm((env), (s), (modrm), (vece), gen_gvec_cmpgt, 0123)
> +#define gen_vpcmpgt_ymm(env, s, modrm, vece) gen_gvec_ld_modrm_vymm((env), (s), (modrm), (vece), gen_gvec_cmpgt, 0123)
...
> +    case 0x64 | M_0F:                  gen_pcmpgt_mm(env, s, modrm, MO_8); return;
> +    case 0x64 | M_0F | P_66:           gen_pcmpgt_xmm(env, s, modrm, MO_8); return;
> +    case 0x64 | M_0F | P_66 | VEX_128: gen_vpcmpgt_xmm(env, s, modrm, MO_8); return;
> +    case 0x64 | M_0F | P_66 | VEX_256: gen_vpcmpgt_ymm(env, s, modrm, MO_8); return;

Looks like my comments vs PAND apply to all of the subsequent patches as well.
 But everything else looks good.


r~

