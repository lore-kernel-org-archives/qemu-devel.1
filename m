Return-Path: <SRS0=fVwN=XJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83B4AC4CECA
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Sep 2019 20:33:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5819320692
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Sep 2019 20:33:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5819320692
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52178 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9EjD-0005ZN-An
	for qemu-devel@archiver.kernel.org; Sat, 14 Sep 2019 16:33:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37585)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmer@dabbelt.com>) id 1i9Egu-00049T-3F
 for qemu-devel@nongnu.org; Sat, 14 Sep 2019 16:30:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1i9Egt-0007ap-29
 for qemu-devel@nongnu.org; Sat, 14 Sep 2019 16:30:43 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36199)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1i9Egs-0007aS-To
 for qemu-devel@nongnu.org; Sat, 14 Sep 2019 16:30:43 -0400
Received: by mail-pg1-f196.google.com with SMTP id m29so800534pgc.3
 for <qemu-devel@nongnu.org>; Sat, 14 Sep 2019 13:30:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
 :mime-version:content-transfer-encoding;
 bh=b/9+bahG3N9D/2k7ndZAoMR9759cz5ClkCwbT90cmbI=;
 b=C9y6jQV7HTUk1T6XA3l+8A70yYdG04SpHiu88arensyMJXaYdw8lAOyyr3H+EXc73i
 U/1rJCE3C978fB417zvr8mytswhAqioJPcMgEzlCPJeUytIl9cBIwPaySeL8c3qS2Is0
 WDWQ0dYczkCW4b9IdBDTijhK4kF6wjJ5CQuhzxcwzRsYHxGicGrzbgd0ZYi2rx0Qizdl
 WOfcmgkhprjF59/GRAtQy9bfUup89vFrNUWOjFlZKuJe5ofcSYs1Db/Ww7MjvXtcKru4
 XEKTeFBuH3Z1QWkglRNOvfS0PeTJbpOWoPY9ELT5jbG7sx4IKg1sNx23I4mCGsCFQnPp
 HaBA==
X-Gm-Message-State: APjAAAV3UBdBfWSVbnuOnZ5S5SFJxBd3+RAl++vMK07urVF4hfIKzvjp
 vtEGk2RUW9TA35Ow65JBj8jmpPjAEMKnCa6+
X-Google-Smtp-Source: APXvYqwRXDcc5HCgHV3Ovrp4zkAwxXK0qCm5fyA4Z+kpiKtsWRTQIS2lv2wGuvZuhiXEoboaOb9zDg==
X-Received: by 2002:a65:63c4:: with SMTP id n4mr32741816pgv.44.1568493041441; 
 Sat, 14 Sep 2019 13:30:41 -0700 (PDT)
Received: from localhost (amx-tls3.starhub.net.sg. [203.116.164.13])
 by smtp.gmail.com with ESMTPSA id n66sm52784343pfn.90.2019.09.14.13.30.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Sep 2019 13:30:40 -0700 (PDT)
Date: Sat, 14 Sep 2019 13:30:40 -0700 (PDT)
X-Google-Original-Date: Sat, 14 Sep 2019 13:24:23 PDT (-0700)
In-Reply-To: <964f729f0c7010cac733b88545f0356a668c9bed.1566603412.git.alistair.francis@wdc.com>
From: Palmer Dabbelt <palmer@sifive.com>
To: Alistair Francis <Alistair.Francis@wdc.com>
Message-ID: <mhng-cd966099-fb3f-436b-83d9-55d96bac5fb4@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.215.196
Subject: Re: [Qemu-devel] [PATCH v1 13/28] target/ricsv: Flush the TLB on
 virtulisation mode changes
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

On Fri, 23 Aug 2019 16:38:23 PDT (-0700), Alistair Francis wrote:
> To ensure our TLB isn't out-of-date we flush it on all virt mode
> changes. Unlike priv mode this isn't saved in the mmu_idx as all
> guests share V=1. The easiest option is just to flush on all changes.
>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  target/riscv/cpu_helper.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index afb3e8579e..8e8b156fc0 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -203,6 +203,11 @@ void riscv_cpu_set_virt_enabled(CPURISCVState *env, bool enable)
>          return;
>      }
>
> +    /* Flush the TLB on all virt mode changes. */
> +    if (((env->virt & VIRT_MODE_MASK) >> VIRT_MODE_SHIFT) != enable) {
> +        tlb_flush(env_cpu(env));
> +    }
> +
>      env->virt &= ~VIRT_MODE_MASK;
>      env->virt |= enable << VIRT_MODE_SHIFT;
>  }

Reviewed-by: Palmer Dabbelt <palmer@sifive.com>

