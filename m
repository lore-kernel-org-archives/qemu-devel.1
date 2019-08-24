Return-Path: <SRS0=NWXH=WU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E99CFC3A5A2
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Aug 2019 00:18:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B68B421726
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Aug 2019 00:18:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fd1P8Nds"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B68B421726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35480 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1JlN-000319-UE
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 20:18:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54033)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1i1JkZ-0002LN-JB
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 20:17:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1i1JkY-0002vH-AY
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 20:17:47 -0400
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:43574)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1i1JkY-0002ux-1U; Fri, 23 Aug 2019 20:17:46 -0400
Received: by mail-lj1-x242.google.com with SMTP id h15so10328534ljg.10;
 Fri, 23 Aug 2019 17:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=vVXuHFjsVWI0iY1Cbauv6PMjL/r8pTrmVpNN70hUSzQ=;
 b=fd1P8Ndsl8apJj1t2G6HBxkoiyWxZKh6Y/AyUqejdZMWQ2iPYMMlZEoUME/a8qgy20
 3+Cf9Q7V1hil4JI6wxuhoAAd8J48Th8X2NzsDR5qW9D/F3IsESVUNcXs8Xw11eB8xbIl
 qYnnUuspRed6fX/1h43dk/3fANQogEnkOcNWKCaS6RHgU5ZAlI3Y50gL03PBW+qdnL3l
 At/GkXxbuDQmKWD5+4oTI1G2umnKoq8cq/4UsbMMyw71Vw4xwawJbRTeKk0uql5eYO9c
 NbdzrtWs+jECarQQE5ZF5gyRQNZzNCplDrk0+bUPl3J4KzXLfuRlBBQI008ZBKK6rtvM
 Ieew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=vVXuHFjsVWI0iY1Cbauv6PMjL/r8pTrmVpNN70hUSzQ=;
 b=Z6qmSRQIFUwHNlQPkc4wX+ZLx41XNclm1TL92oclxL552Hwk4urZoh6RdmyJcA3zwg
 f1MC3/AC2VnK1AV7A23u73ZKZgr9oW91emY4QDgvZzB3QsUgUDN/1aGvSTvMhpLhWTqY
 X0jOfGREaUgOnbC5SDlXt7XotEkWPjBSVxyPFM7N429n+Dkww4SC6C+uoYEVRq6SUy1L
 n3E41BcMuAg2Wd90rwyI2DeNNSppQLeipDQvjfPvx3cFeNkD8NrZ0w1aGkA9xQzlrJTx
 cHYBpPJJyUCayTNA8tiWoex31Hlsv9eeHQ1gxyHiTcd6wia5MfF+9L2M0vmVVqUoXV1C
 ctCg==
X-Gm-Message-State: APjAAAXu5GAbKHJBgPvAmU1k9pzV1I3wTtqrXd7mERIDOgldDRoDG2+I
 Y08js8+idDM5lMSIxmvP7cr+r3p7BXoZGjhRKzM=
X-Google-Smtp-Source: APXvYqwC4b8X5eFwLP7KqWS++IZu1ub0d49bbX1MrdI5mksKkDuJEcgplQx81Z2Ap47yDYsk0RbDABilz/vhUsmCj40=
X-Received: by 2002:a05:651c:109:: with SMTP id
 a9mr4459636ljb.33.1566605864258; 
 Fri, 23 Aug 2019 17:17:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190821162831.27811-1-georg.kotheimer@kernkonzept.com>
In-Reply-To: <20190821162831.27811-1-georg.kotheimer@kernkonzept.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 23 Aug 2019 17:13:37 -0700
Message-ID: <CAKmqyKMFyjQnNqr3AdHCxx5NJsEr2Tbh0GfLQa9L++h56MHSew@mail.gmail.com>
To: Georg Kotheimer <georg.kotheimer@kernkonzept.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::242
Subject: Re: [Qemu-devel] [PATCH v3] RISC-V: Select FPU gdb xml file based
 on the supported extensions
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
 Palmer Dabbelt <palmer@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Aug 21, 2019 at 9:36 AM Georg Kotheimer
<georg.kotheimer@kernkonzept.com> wrote:
>
> The size of the FPU registers depends solely on the floating point
> extensions supported by the target architecture.
> However, in the previous implementation the floating point register
> size was derived from whether the target architecture is 32-bit or
> 64-bit.
>
> To allow RVF without RVD, changes to riscv_gdb_get_fpu() and
> riscv_gdb_set_fpu() were necessary.
>
> Signed-off-by: Georg Kotheimer <georg.kotheimer@kernkonzept.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  configure              |  4 ++--
>  target/riscv/gdbstub.c | 45 ++++++++++++++++++++++++------------------
>  2 files changed, 28 insertions(+), 21 deletions(-)
>
> diff --git a/configure b/configure
> index 714e7fb6a1..44ee953022 100755
> --- a/configure
> +++ b/configure
> @@ -7596,14 +7596,14 @@ case "$target_name" in
>      TARGET_BASE_ARCH=riscv
>      TARGET_ABI_DIR=riscv
>      mttcg=yes
> -    gdb_xml_files="riscv-32bit-cpu.xml riscv-32bit-fpu.xml riscv-32bit-csr.xml"
> +    gdb_xml_files="riscv-32bit-cpu.xml riscv-32bit-fpu.xml riscv-64bit-fpu.xml riscv-32bit-csr.xml"
>      target_compiler=$cross_cc_riscv32
>    ;;
>    riscv64)
>      TARGET_BASE_ARCH=riscv
>      TARGET_ABI_DIR=riscv
>      mttcg=yes
> -    gdb_xml_files="riscv-64bit-cpu.xml riscv-64bit-fpu.xml riscv-64bit-csr.xml"
> +    gdb_xml_files="riscv-64bit-cpu.xml riscv-32bit-fpu.xml riscv-64bit-fpu.xml riscv-64bit-csr.xml"
>      target_compiler=$cross_cc_riscv64
>    ;;
>    sh4|sh4eb)
> diff --git a/target/riscv/gdbstub.c b/target/riscv/gdbstub.c
> index 27be93279b..89b2543c9d 100644
> --- a/target/riscv/gdbstub.c
> +++ b/target/riscv/gdbstub.c
> @@ -303,19 +303,22 @@ int riscv_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
>  static int riscv_gdb_get_fpu(CPURISCVState *env, uint8_t *mem_buf, int n)
>  {
>      if (n < 32) {
> -        return gdb_get_reg64(mem_buf, env->fpr[n]);
> +        if (env->misa & RVD) {
> +            return gdb_get_reg64(mem_buf, env->fpr[n]);
> +        }
> +        return gdb_get_reg32(mem_buf, env->fpr[n]);
>      /* there is hole between ft11 and fflags in fpu.xml */
>      } else if (n < 36 && n > 32) {
>          target_ulong val = 0;
>          int result;
>          /*
> -         * CSR_FFLAGS is at index 8 in csr_register, and gdb says it is FP
> -         * register 33, so we recalculate the map index.
> +         * CSR_FFLAGS is at index 1 in the csr space, and gdb says it is FP
> +         * register 33, so we recalculate the csr index.
>           * This also works for CSR_FRM and CSR_FCSR.
>           */
> -        result = riscv_csrrw_debug(env, n - 33 +  8, &val, 0, 0);
> +        result = riscv_csrrw_debug(env, n - 33 + CSR_FFLAGS, &val, 0, 0);
>          if (result == 0) {
> -            return gdb_get_regl(mem_buf, val);
> +            return gdb_get_reg32(mem_buf, val);
>          }
>      }
>      return 0;
> @@ -324,20 +327,25 @@ static int riscv_gdb_get_fpu(CPURISCVState *env, uint8_t *mem_buf, int n)
>  static int riscv_gdb_set_fpu(CPURISCVState *env, uint8_t *mem_buf, int n)
>  {
>      if (n < 32) {
> -        env->fpr[n] = ldq_p(mem_buf); /* always 64-bit */
> -        return sizeof(uint64_t);
> +        if (env->misa & RVD) {
> +            env->fpr[n] = ldq_p(mem_buf);
> +            return sizeof(uint64_t);
> +        } else {
> +            env->fpr[n] = ldl_p(mem_buf);
> +            return sizeof(uint32_t);
> +        }
>      /* there is hole between ft11 and fflags in fpu.xml */
>      } else if (n < 36 && n > 32) {
> -        target_ulong val = ldtul_p(mem_buf);
> +        target_ulong val = ldl_p(mem_buf);
>          int result;
>          /*
> -         * CSR_FFLAGS is at index 8 in csr_register, and gdb says it is FP
> -         * register 33, so we recalculate the map index.
> +         * CSR_FFLAGS is at index 1 in the csr space, and gdb says it is FP
> +         * register 33, so we recalculate the csr index.
>           * This also works for CSR_FRM and CSR_FCSR.
>           */
> -        result = riscv_csrrw_debug(env, n - 33 + 8, NULL, val, -1);
> +        result = riscv_csrrw_debug(env, n - 33 + CSR_FFLAGS, NULL, val, -1);
>          if (result == 0) {
> -            return sizeof(target_ulong);
> +            return sizeof(uint32_t);
>          }
>      }
>      return 0;
> @@ -375,20 +383,19 @@ void riscv_cpu_register_gdb_regs_for_features(CPUState *cs)
>  {
>      RISCVCPU *cpu = RISCV_CPU(cs);
>      CPURISCVState *env = &cpu->env;
> -#if defined(TARGET_RISCV32)
> -    if (env->misa & RVF) {
> +
> +    if (env->misa & RVD) {
> +        gdb_register_coprocessor(cs, riscv_gdb_get_fpu, riscv_gdb_set_fpu,
> +                                 36, "riscv-64bit-fpu.xml", 0);
> +    } else if (env->misa & RVF) {
>          gdb_register_coprocessor(cs, riscv_gdb_get_fpu, riscv_gdb_set_fpu,
>                                   36, "riscv-32bit-fpu.xml", 0);
>      }
>
> +#if defined(TARGET_RISCV32)
>      gdb_register_coprocessor(cs, riscv_gdb_get_csr, riscv_gdb_set_csr,
>                               4096, "riscv-32bit-csr.xml", 0);
>  #elif defined(TARGET_RISCV64)
> -    if (env->misa & RVF) {
> -        gdb_register_coprocessor(cs, riscv_gdb_get_fpu, riscv_gdb_set_fpu,
> -                                 36, "riscv-64bit-fpu.xml", 0);
> -    }
> -
>      gdb_register_coprocessor(cs, riscv_gdb_get_csr, riscv_gdb_set_csr,
>                               4096, "riscv-64bit-csr.xml", 0);
>  #endif
> --
> 2.20.1
>
>

