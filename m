Return-Path: <SRS0=PARU=US=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B367CC31E49
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 10:51:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D1A3206E0
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 10:51:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D1A3206E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36802 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdYC6-0005Nh-SV
	for qemu-devel@archiver.kernel.org; Wed, 19 Jun 2019 06:51:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60878)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <palmer@dabbelt.com>) id 1hdYA5-00044t-TL
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 06:49:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1hdYA3-0003B2-7C
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 06:49:53 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41370)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1hdYA1-00033Q-0b
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 06:49:50 -0400
Received: by mail-pl1-f194.google.com with SMTP id m7so3464241pls.8
 for <qemu-devel@nongnu.org>; Wed, 19 Jun 2019 03:49:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
 :mime-version:content-transfer-encoding;
 bh=cO+uD4tBxnTjM9TJE7p2YYiyVobc6x86e1frLVztAEw=;
 b=StWU6GK/7S8SxcnSl50XaFIQn/TABybmW2keyxPX/hahUPFI6WUZ0j66HYVXAFKVZe
 7YZsTRcCGa1qaMVXQ4VUcnRKeD01RTK5kNOB0wOIiz3c0VLKBTNnGEQ6FGxDQUlB/H79
 FBJ7V1d3TWVxwP/ExBSbz+No+Cccc8msvRZ24OlobqKYp1nF2kMnQzYX4NrKq/iPtHWw
 T21jAUmwS4KDqGNOhIvyPECm9ChmBo0uyR1scpcJykDplDhYZwMvF4BxxD15cMtJ1DNQ
 GIwXngQXW0BmKrtXk25eUyVZNXMfpYU/a8KOWbwstmTEmpBI3C40kG8EdJ538ku9GdLe
 U57A==
X-Gm-Message-State: APjAAAVqgilgFGtl5RJPHiVoiJnip/PhIOkg053SH5ThjQtaIkmdba3G
 u1k7YSqDEnZTY5YoeYEKmaSdCA==
X-Google-Smtp-Source: APXvYqxBVJ3OwPKMzyVrpF4E+z2snQn5sGC5CMn8g80rMe/hYYJrLUP5b5L6/xTh0XsGOx7HT7gZaw==
X-Received: by 2002:a17:902:f301:: with SMTP id
 gb1mr62608977plb.292.1560941381295; 
 Wed, 19 Jun 2019 03:49:41 -0700 (PDT)
Received: from localhost (amx-tls3.starhub.net.sg. [203.116.164.13])
 by smtp.gmail.com with ESMTPSA id p1sm19836410pff.74.2019.06.19.03.49.40
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 19 Jun 2019 03:49:40 -0700 (PDT)
Date: Wed, 19 Jun 2019 03:49:40 -0700 (PDT)
X-Google-Original-Date: Wed, 19 Jun 2019 03:48:46 PDT (-0700)
In-Reply-To: <98e88256-7a88-b505-9bde-0836cf21c654@linaro.org>
From: Palmer Dabbelt <palmer@sifive.com>
To: richard.henderson@linaro.org
Message-ID: <mhng-a709557f-be85-4a1e-9f95-d708e95c540e@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.214.194
Subject: Re: [Qemu-devel] [PATCH v3 33/50] target/riscv: fetch code with
 translator_ld
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
Cc: qemu-riscv@nongnu.org, sagark@eecs.berkeley.edu,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, qemu-devel@nongnu.org,
 cota@braap.org, Alistair Francis <Alistair.Francis@wdc.com>,
 alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 17 Jun 2019 15:38:45 PDT (-0700), richard.henderson@linaro.org wrote:
> On 6/14/19 10:11 AM, Alex Bennée wrote:
>> +++ b/target/riscv/translate.c
>> @@ -793,7 +793,7 @@ static void riscv_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
>>      DisasContext *ctx = container_of(dcbase, DisasContext, base);
>>      CPURISCVState *env = cpu->env_ptr;
>>
>> -    ctx->opcode = cpu_ldl_code(env, ctx->base.pc_next);
>> +    ctx->opcode = translator_ldl(env, ctx->base.pc_next);
>
> I'll note for the riscv folks that this is an existing bug, reading too much in
> the case of an RVC instruction.  This could well matter for the last 2-byte
> instruction at the end of a page.
>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Thanks for pointing this out.  I'm checking the ISA semantics with Andrew to
make sure I've got it right, as there's some implicit wording in the document
that doesn't quite do what I'd expect it to.

