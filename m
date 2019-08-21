Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 171B3C3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 23:06:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D743D22CF7
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 23:06:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QvHGZtdk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D743D22CF7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36900 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0ZgS-00043E-3y
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 19:06:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46637)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i0ZfV-0003T5-Nh
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 19:05:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i0ZfU-0004vr-M2
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 19:05:29 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:34963)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i0ZfU-0004u8-EM
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 19:05:28 -0400
Received: by mail-pg1-x542.google.com with SMTP id n4so2250678pgv.2
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 16:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=6Img8ptMSpA6aVi7uo5HvVz2LGrrGdvHjYos8WvDk00=;
 b=QvHGZtdkpqb1yufdGJb86D4um1YWCzl7AMDxNNm12w+hlhPM3dfTudrjGMsx5U4BFr
 CYKddlV7NbHasU2ZtCGWhWuRdiMOC0lE3tZ5nVvmpAKnlzQ8uK1wedZ3hZha5lYN/Pqr
 sQJobve3F2zdHorSR6OZqsGdjgAC5fZloubEMKHW5yr3PL1Mqd+y7hUNFLwQyZkVdSNO
 H7VTEF136fIj/bxEgc9ikKovpb5sGQn4dMg1BassBPOEXJY6Wd7XMR9dx312yULwjZZ/
 M/ErYPLyOk/n+b+nsmDMXQFC0C7a5+/kUK7b3FfOnT0S/XV1XezWuQrkrGJt6zb5ymcJ
 ML3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=6Img8ptMSpA6aVi7uo5HvVz2LGrrGdvHjYos8WvDk00=;
 b=kKuIxaH/C16apD94ZpZNxkSeL7ZUjUpYSYsS5/2XRBdaB1DF/g/TL6sI0tDDUYZegE
 oGPWzSNvJyGe1VnGAvngTmvAC4SL42ZrfH2+kwzhPPK1UKHCxKX3lDTSIsYDbhdAw2eN
 4++KtdRbCcaFktRkQun//TvswrGSL7bbXPUNYPfoImEnh8gDsrIUqu+MgSQhP7xXv+HA
 euqnRJjJePCKoJRTEYVC1E3LgEUD/g4ynPxVYYHCnaTWnLxIuBPeO4jrIEz8I/40Ee3x
 pBQ1liuy+HDeiYP7cX+grgVt+Bz8INpu+/qQj/QyEm5A6tlOpe7MARXgVS4AJRnmqTou
 /fuw==
X-Gm-Message-State: APjAAAU1eNYr8KG3npcoOmZLF5qKpVX+knxWEjmdACw5TfOqmlx9Xd1v
 kRDIWGLqkPdDFOyrEd1Xl+BS5Q==
X-Google-Smtp-Source: APXvYqzO7E/VPPi5VD4qqu5WI3qoF3xoUPwA3kwB8vl+wLb4/QMNJr/BdDfnEpvkc27jBmGg/da7Zg==
X-Received: by 2002:a17:90a:4485:: with SMTP id
 t5mr2323092pjg.65.1566428727121; 
 Wed, 21 Aug 2019 16:05:27 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id p10sm26543483pff.132.2019.08.21.16.05.25
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 21 Aug 2019 16:05:26 -0700 (PDT)
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, qemu-devel@nongnu.org
References: <20190821122315.18015-1-kbastian@mail.uni-paderborn.de>
 <20190821122315.18015-5-kbastian@mail.uni-paderborn.de>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <fa01ce65-2bf5-1877-bb57-f1baa821ddaa@linaro.org>
Date: Wed, 21 Aug 2019 16:05:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190821122315.18015-5-kbastian@mail.uni-paderborn.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
Subject: Re: [Qemu-devel] [PATCH v2 4/5] target/tricore: Implement a qemu
 excptions helper
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
Cc: david.brenken@efs-auto.de
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/21/19 5:23 AM, Bastian Koppelmann wrote:
> @@ -3928,7 +3937,7 @@ static void decode_sr_system(DisasContext *ctx)
>          ctx->base.is_jmp = DISAS_NORETURN;
>          break;
>      case OPC2_16_SR_DEBUG:
> -        /* raise EXCP_DEBUG */
> +        generate_qemu_excp(ctx, EXCP_DEBUG);
>          break;
>      case OPC2_16_SR_FRET:
>          gen_fret(ctx);
> @@ -8354,7 +8363,7 @@ static void decode_sys_interrupts(DisasContext *ctx)
>  
>      switch (op2) {
>      case OPC2_32_SYS_DEBUG:
> -        /* raise EXCP_DEBUG */
> +        generate_qemu_excp(ctx, EXCP_DEBUG);
>          break;
>      case OPC2_32_SYS_DISABLE:
>          tcg_gen_andi_tl(cpu_ICR, cpu_ICR, ~MASK_ICR_IE_1_3);

This is not correct -- EXCP_DEBUG is an internal qemu exception.

The manual I have only describes the ISA and does not describe what a "Debug
Event" would be.  I note that you're missing the DBGSR.DE check.  I also note
that whatever a "Debug Event" is, RFM appears to be the return from it.  So one
can deduce some things about what it should be.


r~

