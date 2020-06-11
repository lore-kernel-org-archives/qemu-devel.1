Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D287FC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 16:15:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C641206DC
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 16:15:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sdl794V9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C641206DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49668 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjPrS-0008Ly-PX
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 12:15:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48242)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jjPkE-0003GS-My; Thu, 11 Jun 2020 12:07:58 -0400
Received: from mail-il1-x143.google.com ([2607:f8b0:4864:20::143]:43766)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jjPkA-0001pz-Ui; Thu, 11 Jun 2020 12:07:58 -0400
Received: by mail-il1-x143.google.com with SMTP id g3so5896076ilq.10;
 Thu, 11 Jun 2020 09:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=gBTuH6EAM+lMB7EkTRADdYlxqy3PAbX4mi45MI5BDx0=;
 b=Sdl794V9TvEMfBo3FVMuhWTTpCT9Vx5TEfFFiiMkDuQeqxqxY/mUfzRUb6MgJFuAya
 LZS4BuDUeGRgQZ2Lt4M1BwxiscthVH1bLPxcFPSr1r1c0zVPjZfMwMdW129SQaNGR+gB
 ljsdDgFNKVLCrr7/erERQRhz1aLuUrHkW4EanjFV6NCuTVOCDh2UmT9C9yvdcOJDczqM
 hldqiO3kU1/b/iIFa3okLWr0DNu6pE3LjVxCrXC2ltHgKIKOlxo7mx4H4+SnXaS6uzoW
 NLpa4DVtU8LuRcU6+W/Q11wWSatgI/cFG5oD5O50mqBsYESOmO1KosTEne7Rag8gnqew
 5qKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=gBTuH6EAM+lMB7EkTRADdYlxqy3PAbX4mi45MI5BDx0=;
 b=OvYgCX4dPFihnV6eXSeJhIA6AJ5K7/Dhcf+cLQMSrj083SQixpeV0AksUr390H0PGk
 UUoXXHz3du/iY9ad6ayT1YnGW3VYsnVjaZ2kvqqsqmscwO4etbBDModg0kqsqh3ysSVa
 X4unzd7DE2r7agNDb4NjHV6GHZCqLCuZDxFJgDwBqwMBjtDE5yxcIDnoKv5Zfq7ysxKw
 +KYne2XqilndLIat26xxSQb/JgqT/RhSTPHTFtERuJOs10L/XF3n6FCmm0EE9y1e1HnG
 Dshh5wUDW5uSVEmq0v+3YomOCwZ7/Z98RfVwvLlinzKp0voxafLXPYl/w6fMyTNoG53R
 BvMg==
X-Gm-Message-State: AOAM533HlHudqS6kgFYi0nGujM9boQkX9pGNlnfBqI2TGABjLVZzQwvk
 ttHvQgedVKSI8A7U1Z7y5MBghGI0/pNn2TzSoF8=
X-Google-Smtp-Source: ABdhPJzVeDsw3cENC5kLricOgl6womJYp9UtBQ6Q50o9V/ab8DgZihmOneJlnR1zrXkst4JqZC10kpuTgqg4lqnactQ=
X-Received: by 2002:a05:6e02:4d:: with SMTP id
 i13mr9148147ilr.227.1591891661383; 
 Thu, 11 Jun 2020 09:07:41 -0700 (PDT)
MIME-Version: 1.0
References: <1591837729-27486-1-git-send-email-bmeng.cn@gmail.com>
In-Reply-To: <1591837729-27486-1-git-send-email-bmeng.cn@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 11 Jun 2020 08:58:17 -0700
Message-ID: <CAKmqyKNdxrwKgaC+Bdff=sBCQc5VcrWHZ=haO1O3Es2io2FnGA@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] riscv: Generalize CPU init routine for the base CPU
To: Bin Meng <bmeng.cn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::143;
 envelope-from=alistair23@gmail.com; helo=mail-il1-x143.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Bin Meng <bin.meng@windriver.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmerdabbelt@google.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jun 10, 2020 at 6:09 PM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> From: Bin Meng <bin.meng@windriver.com>
>
> There is no need to have two functions that have exactly the same
> codes for 32-bit and 64-bit base CPUs.
>
> Signed-off-by: Bin Meng <bin.meng@windriver.com>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Applied to riscv-to-apply branch.

Alistair

> ---
>
> (no changes since v1)
>
>  target/riscv/cpu.c | 18 +++++-------------
>  1 file changed, 5 insertions(+), 13 deletions(-)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 3a6d202..81cdea8 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -126,9 +126,7 @@ static void riscv_any_cpu_init(Object *obj)
>      set_resetvec(env, DEFAULT_RSTVEC);
>  }
>
> -#if defined(TARGET_RISCV32)
> -
> -static void riscv_base32_cpu_init(Object *obj)
> +static void riscv_base_cpu_init(Object *obj)
>  {
>      CPURISCVState *env = &RISCV_CPU(obj)->env;
>      /* We set this in the realise function */
> @@ -136,6 +134,8 @@ static void riscv_base32_cpu_init(Object *obj)
>      set_resetvec(env, DEFAULT_RSTVEC);
>  }
>
> +#if defined(TARGET_RISCV32)
> +
>  static void rv32gcsu_priv1_10_0_cpu_init(Object *obj)
>  {
>      CPURISCVState *env = &RISCV_CPU(obj)->env;
> @@ -173,14 +173,6 @@ static void rv32imafcu_nommu_cpu_init(Object *obj)
>
>  #elif defined(TARGET_RISCV64)
>
> -static void riscv_base64_cpu_init(Object *obj)
> -{
> -    CPURISCVState *env = &RISCV_CPU(obj)->env;
> -    /* We set this in the realise function */
> -    set_misa(env, 0);
> -    set_resetvec(env, DEFAULT_RSTVEC);
> -}
> -
>  static void rv64gcsu_priv1_10_0_cpu_init(Object *obj)
>  {
>      CPURISCVState *env = &RISCV_CPU(obj)->env;
> @@ -603,13 +595,13 @@ static const TypeInfo riscv_cpu_type_infos[] = {
>      },
>      DEFINE_CPU(TYPE_RISCV_CPU_ANY,              riscv_any_cpu_init),
>  #if defined(TARGET_RISCV32)
> -    DEFINE_CPU(TYPE_RISCV_CPU_BASE32,           riscv_base32_cpu_init),
> +    DEFINE_CPU(TYPE_RISCV_CPU_BASE32,           riscv_base_cpu_init),
>      DEFINE_CPU(TYPE_RISCV_CPU_IBEX,             rv32imcu_nommu_cpu_init),
>      DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_E31,       rv32imacu_nommu_cpu_init),
>      DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_E34,       rv32imafcu_nommu_cpu_init),
>      DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_U34,       rv32gcsu_priv1_10_0_cpu_init),
>  #elif defined(TARGET_RISCV64)
> -    DEFINE_CPU(TYPE_RISCV_CPU_BASE64,           riscv_base64_cpu_init),
> +    DEFINE_CPU(TYPE_RISCV_CPU_BASE64,           riscv_base_cpu_init),
>      DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_E51,       rv64imacu_nommu_cpu_init),
>      DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_U54,       rv64gcsu_priv1_10_0_cpu_init),
>  #endif
> --
> 2.7.4
>
>

