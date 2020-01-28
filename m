Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B083C2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 23:36:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6451E2173E
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 23:36:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PhpCO83H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6451E2173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38858 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwaPd-0005qD-JA
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 18:36:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34305)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1iwaOa-00051Q-Dw
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 18:35:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1iwaOZ-0006Y4-6M
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 18:35:48 -0500
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142]:41457)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1iwaOY-0006P1-ST; Tue, 28 Jan 2020 18:35:47 -0500
Received: by mail-lf1-x142.google.com with SMTP id m30so10450194lfp.8;
 Tue, 28 Jan 2020 15:35:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=1i7hsIzmCffF09mnyOMdgtFSyGxp4xB2YWtQQN6vT/4=;
 b=PhpCO83HDiwUlvnWb2RXxAsl0cfEpRFNMvUC2dmgUTknfjQ1bcpcsf9CZs8ZDbeldF
 xJjxvKj0DFXyTI8QXH21aoCMXpcogYAr4tOC6Y4rORPucH7sNgUtdfarvSAdapkzxkVk
 4EoXQhg5MDqbjH+VV6Zx9aNcEvYRprci6F+R6UU0bnDFzaOOCIRmwVKykDtpurOzGUbm
 Cfz8IGVi68Ih5QB0hRjFnVMzHgC96IAgQuqGdEqik23rhq3EJ04zRET46sUMBJ0B7sjK
 pejcQ+bjeY26wcBqXXSiMMjevJGiBgkh04c4WhaC4D7H8rJgKxZ6RIm8ykARG0X58sFc
 pvLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=1i7hsIzmCffF09mnyOMdgtFSyGxp4xB2YWtQQN6vT/4=;
 b=kOdLrWJgrr2HKZZ63lcZuxNse7mScedmph3kiwbyJi+AcvY7ql2+hkN4HWApzMMYZn
 JN+b5Yew1H4OWjXrKjjPJOcld8tSEFeHqHB1wdU6xiTShKCzS1ye81v1wX6eevFubkT2
 D9h0l/u7OiTcakswc6Z9v2knEa71WqZcFOy32KBpwk4x9Bu8FP8aUG/n5uwH2h74VnLq
 OWFAYn1fuBkbFjA28Uhq2HT33mlUusHBDtVUU6w25GeOCB5VntOO2NQmKDYT63N6kWx+
 9Gq3D39a9vYd5Xps0UfpHOiYF7YhZD9YFYHehAHOmprBXvM30IBi3lxgUSecIHB0cv3P
 f0fg==
X-Gm-Message-State: APjAAAXaMiqVq26GCRND+dcMIicwnGXW/5JL+Dm6zU184E0I53lv87Bh
 v9aePqbXDhVyT+Aoym9KCLksKjDnJoRWqnW/pAc=
X-Google-Smtp-Source: APXvYqzAo6sOD+nSPatMT25Gujkb0/6PUi/rdhv9WVDK4jY8q+CpGi5LT/iOiBfPsodESHOt8FPiufOIt2ZND8/MFrY=
X-Received: by 2002:ac2:5310:: with SMTP id c16mr3803854lfh.102.1580254544081; 
 Tue, 28 Jan 2020 15:35:44 -0800 (PST)
MIME-Version: 1.0
References: <20200128233216.515171-1-keithp@keithp.com>
In-Reply-To: <20200128233216.515171-1-keithp@keithp.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 28 Jan 2020 15:35:17 -0800
Message-ID: <CAKmqyKMN=3P7V=m+3na6zh_711gw2qDkosWxjgLG_DbUGm9sYQ@mail.gmail.com>
Subject: Re: [PATCH] riscv: Separate FPU register size from core register size
 in gdbstub [v2]
To: Keith Packard <keithp@keithp.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::142
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jan 28, 2020 at 3:33 PM Keith Packard via <qemu-devel@nongnu.org> wrote:
>
> The size of the FPU registers is dictated by the 'f' and 'd' features,
> not the core processor register size. Processors with the 'd' feature
> have 64-bit FPU registers. Processors without the 'd' feature but with
> the 'f' feature have 32-bit FPU registers.
>
> Signed-off-by: Keith Packard <keithp@keithp.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

>
> ---
>
> v2:
>     Fix checkpatch formatting complaints.
> ---
>  configure              |  4 ++--
>  target/riscv/gdbstub.c | 20 +++++++++++---------
>  2 files changed, 13 insertions(+), 11 deletions(-)
>
> diff --git a/configure b/configure
> index a72a5def57..c21bff8d10 100755
> --- a/configure
> +++ b/configure
> @@ -7709,13 +7709,13 @@ case "$target_name" in
>      TARGET_BASE_ARCH=riscv
>      TARGET_ABI_DIR=riscv
>      mttcg=yes
> -    gdb_xml_files="riscv-32bit-cpu.xml riscv-32bit-fpu.xml riscv-32bit-csr.xml riscv-32bit-virtual.xml"
> +    gdb_xml_files="riscv-32bit-cpu.xml riscv-32bit-fpu.xml riscv-64bit-fpu.xml riscv-32bit-csr.xml riscv-32bit-virtual.xml"
>    ;;
>    riscv64)
>      TARGET_BASE_ARCH=riscv
>      TARGET_ABI_DIR=riscv
>      mttcg=yes
> -    gdb_xml_files="riscv-64bit-cpu.xml riscv-64bit-fpu.xml riscv-64bit-csr.xml riscv-64bit-virtual.xml"
> +    gdb_xml_files="riscv-64bit-cpu.xml riscv-32bit-fpu.xml riscv-64bit-fpu.xml riscv-64bit-csr.xml riscv-64bit-virtual.xml"
>    ;;
>    sh4|sh4eb)
>      TARGET_ARCH=sh4
> diff --git a/target/riscv/gdbstub.c b/target/riscv/gdbstub.c
> index 1a7947e019..1a72f7be9c 100644
> --- a/target/riscv/gdbstub.c
> +++ b/target/riscv/gdbstub.c
> @@ -303,7 +303,12 @@ int riscv_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
>  static int riscv_gdb_get_fpu(CPURISCVState *env, uint8_t *mem_buf, int n)
>  {
>      if (n < 32) {
> -        return gdb_get_reg64(mem_buf, env->fpr[n]);
> +        if (env->misa & RVD) {
> +            return gdb_get_reg64(mem_buf, env->fpr[n]);
> +        }
> +        if (env->misa & RVF) {
> +            return gdb_get_reg32(mem_buf, env->fpr[n]);
> +        }
>      /* there is hole between ft11 and fflags in fpu.xml */
>      } else if (n < 36 && n > 32) {
>          target_ulong val = 0;
> @@ -403,23 +408,20 @@ void riscv_cpu_register_gdb_regs_for_features(CPUState *cs)
>  {
>      RISCVCPU *cpu = RISCV_CPU(cs);
>      CPURISCVState *env = &cpu->env;
> -#if defined(TARGET_RISCV32)
> -    if (env->misa & RVF) {
> +    if (env->misa & RVD) {
> +        gdb_register_coprocessor(cs, riscv_gdb_get_fpu, riscv_gdb_set_fpu,
> +                                 36, "riscv-64bit-fpu.xml", 0);
> +    } else if (env->misa & RVF) {
>          gdb_register_coprocessor(cs, riscv_gdb_get_fpu, riscv_gdb_set_fpu,
>                                   36, "riscv-32bit-fpu.xml", 0);
>      }
> -
> +#if defined(TARGET_RISCV32)
>      gdb_register_coprocessor(cs, riscv_gdb_get_csr, riscv_gdb_set_csr,
>                               240, "riscv-32bit-csr.xml", 0);
>
>      gdb_register_coprocessor(cs, riscv_gdb_get_virtual, riscv_gdb_set_virtual,
>                               1, "riscv-32bit-virtual.xml", 0);
>  #elif defined(TARGET_RISCV64)
> -    if (env->misa & RVF) {
> -        gdb_register_coprocessor(cs, riscv_gdb_get_fpu, riscv_gdb_set_fpu,
> -                                 36, "riscv-64bit-fpu.xml", 0);
> -    }
> -
>      gdb_register_coprocessor(cs, riscv_gdb_get_csr, riscv_gdb_set_csr,
>                               240, "riscv-64bit-csr.xml", 0);
>
> --
> 2.25.0
>
>

