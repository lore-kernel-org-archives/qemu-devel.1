Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82C6CC49ED7
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 15:09:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 537F22089F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 15:09:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 537F22089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7hlf-0006dg-Ck
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 11:09:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54801)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmer@dabbelt.com>) id 1i7hRC-0000M9-5M
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 10:48:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1i7hRB-0006PA-0Z
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 10:48:09 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33794)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1i7hRA-0006Ok-Rw
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 10:48:08 -0400
Received: by mail-wr1-f66.google.com with SMTP id a11so11093836wrx.1
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2019 07:48:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
 :mime-version:content-transfer-encoding;
 bh=2V9FK9K2t1PGHm8vRzp0SynOI3GiSjvt1CUWvjkDi+w=;
 b=t0mmVLEp7c3dHxAdAoYi+LliW59G/rjiP7GkkR17Nq0SKaObNlT+xJ/U2r9beYvtgc
 SqdGelbui2zCFtz2Ylp5jt9shsRiHDjLhaGCxONZ7vrc22U2rdaJSeKXHVzQAR2IJuoe
 UgGzbqGf5EQjDKNClIYMfZJiBX0DvFq8vHw039R/cG+PQkERf76u4/6XBQVGw1KE0rjT
 6sSEzOCCOEhBI3n1ncrP39ehiKQjQVZ2AYASk9PWG1SMHldQWhkY2Usz1ldZyHo80Cmh
 29N4wQFvxgqcrej7/1lGW6MWJeqsOn+xbwXsUhhwezpH6rjW9wfVYU4SDPySwIQVMCdI
 ji7Q==
X-Gm-Message-State: APjAAAUN9Z5GjBQV65ZjCUEWJz4m9pYeStB6hG7HbzZcCm4HPXpExwMB
 aeDcyyruSYbsqdbu8eaEpe628cAsnGL/6w==
X-Google-Smtp-Source: APXvYqz5JBu/oMgO5Kj5C1A5/crLiTqrqJFjGGogbNk7IfMk8kScCpt3XAAVeUyq9koCvT19p55xbA==
X-Received: by 2002:adf:db47:: with SMTP id f7mr26273520wrj.1.1568126887533;
 Tue, 10 Sep 2019 07:48:07 -0700 (PDT)
Received: from localhost ([148.69.85.38])
 by smtp.gmail.com with ESMTPSA id b144sm3646416wmb.3.2019.09.10.07.48.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2019 07:48:07 -0700 (PDT)
Date: Tue, 10 Sep 2019 07:48:07 -0700 (PDT)
X-Google-Original-Date: Tue, 10 Sep 2019 07:43:50 PDT (-0700)
In-Reply-To: <413539f43f6b9c120efd4c882ce7341ef3530b81.1566603412.git.alistair.francis@wdc.com>
From: Palmer Dabbelt <palmer@sifive.com>
To: Alistair Francis <Alistair.Francis@wdc.com>
Message-ID: <mhng-16fd87b6-4cf3-45ec-bcc5-12bd4463aa06@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.66
Subject: Re: [Qemu-devel] [PATCH v1 06/28] target/riscv: Print priv and virt
 in disas log
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
Cc: qemu-riscv@nongnu.org, Anup Patel <Anup.Patel@wdc.com>,
 qemu-devel@nongnu.org, Atish Patra <Atish.Patra@wdc.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 23 Aug 2019 16:38:05 PDT (-0700), Alistair Francis wrote:
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  target/riscv/translate.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/target/riscv/translate.c b/target/riscv/translate.c
> index adeddb85f6..8ac72c6470 100644
> --- a/target/riscv/translate.c
> +++ b/target/riscv/translate.c
> @@ -810,7 +810,15 @@ static void riscv_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
>
>  static void riscv_tr_disas_log(const DisasContextBase *dcbase, CPUState *cpu)
>  {
> +#ifndef CONFIG_USER_ONLY
> +    RISCVCPU *rvcpu = RISCV_CPU(cpu);
> +    CPURISCVState *env = &rvcpu->env;
> +#endif
> +
>      qemu_log("IN: %s\n", lookup_symbol(dcbase->pc_first));
> +#ifndef CONFIG_USER_ONLY
> +    qemu_log("Priv: "TARGET_FMT_ld"; Virt: "TARGET_FMT_ld"\n", env->priv, env->virt);
> +#endif
>      log_target_disas(cpu, dcbase->pc_first, dcbase->tb->size);
>  }

Reviewed-by: Palmer Dabbelt <palmer@sifive.com>

