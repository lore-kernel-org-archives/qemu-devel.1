Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBB8CECE58E
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 18:13:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FC9D217D9
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 18:13:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vv6vKvjo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FC9D217D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55226 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iK4q3-0005tK-PU
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 14:12:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54642)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1iK4iq-0001mF-Tx
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 14:05:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1iK4io-0002RK-KM
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 14:05:32 -0400
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:46005)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1iK4io-0002QX-B4; Mon, 14 Oct 2019 14:05:30 -0400
Received: by mail-lj1-x241.google.com with SMTP id q64so17516944ljb.12;
 Mon, 14 Oct 2019 11:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=jMvhxdWzNtdIXTeuZyyU9CkWelT0B+uy8QsZVEjSeOg=;
 b=Vv6vKvjomKgXj7xXSdOAD8IL9nth69qRE0YWYCZ7Nrt6ZgEsLLm9gz3XT/5COVTpYp
 NnXKcZuC4763dw9mZvPPKh+2kFmKwvDJCVcDsSTTzmt7TpxuTzOSbqp2TCOPrFJBKyCY
 MvXUByaxiqfLIq208uLwavLlm9gKd99ZapniOnz7B1nOnrd1XNlhRFZBM7u154ArKT0G
 Jad8OTYhXRrtW+/gDF06olZ+xlEvMweQ8xUEKahwtuxCwb2yCg5HHoUbJEgO2Gi96qaV
 RGTJqnwWADpcAk8EMmr3b2yPjWU/iC2HmkfbVY9mEtyBVxj2EfJXNr0BVpWD28Kj38b2
 sgxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=jMvhxdWzNtdIXTeuZyyU9CkWelT0B+uy8QsZVEjSeOg=;
 b=FwG0BtQHIfuRItgghYi/RymuGKfYXnk5H6VMtGA44GTgSWTI50XDJRKT7nctIkafAl
 nIlck3AoTFYOtRHME+MsTNoqoSFSCxNC38Rmml6HQh95IiJlC1m6F75doUs9EmJv5qvW
 TdvTCFbDTO618tb7v5Erc9u+E00jwa/ok7yz+D4/k5f6veUMbgF6I7VUyUUDwJgNB/8U
 vWY9naD3r1tl0rYRLa3tmKbNbwZS5YWAA4fyKFvGzL8ey3hLEUYdTxlKgQawuf3ibjZ9
 cazvS1ad/ZjM5eV7NKB8e/9IjIZ2lgvKyVm50K96SaAfdewzOu2bkKBqfNNC3vzU4FhC
 ShEw==
X-Gm-Message-State: APjAAAVtUuZjx6iR0qnCch0zzDTPsluFsx7YOhqwryOrZIQZ6SV4feRI
 Zi5IlXAsP0RsKWjZHJy2KLww5PACyGPTisjWgzc=
X-Google-Smtp-Source: APXvYqyIoDeTn3P2wfE+yvHWILp6fNb4uvucDQ4uGMiL5W9qfO+mOQ58T/S8g4CvMnVtoAL/x1uGDAoBolapmJjwRyI=
X-Received: by 2002:a2e:b010:: with SMTP id y16mr7530523ljk.147.1571076327873; 
 Mon, 14 Oct 2019 11:05:27 -0700 (PDT)
MIME-Version: 1.0
References: <20191014154529.287048-1-jonathan@fintelia.io>
 <20191014154529.287048-3-jonathan@fintelia.io>
In-Reply-To: <20191014154529.287048-3-jonathan@fintelia.io>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 14 Oct 2019 11:00:22 -0700
Message-ID: <CAKmqyKOGWMDDm1-VRcQZJB3La3=2tcDw3oHpWjJBCirMrcGX8g@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] target/riscv: Expose "priv" register for GDB for
 reads
To: Jonathan Behrens <jonathan@fintelia.io>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::241
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
 Palmer Dabbelt <palmer@sifive.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Oct 14, 2019 at 8:50 AM Jonathan Behrens <jonathan@fintelia.io> wrote:
>
> This patch enables a debugger to read the current privilege level via a virtual
> "priv" register. When compiled with CONFIG_USER_ONLY the register is still
> visible but always reports the value zero.
>
> Signed-off-by: Jonathan Behrens <jonathan@fintelia.io>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  configure                       |  4 ++--
>  gdb-xml/riscv-32bit-virtual.xml | 11 +++++++++++
>  gdb-xml/riscv-64bit-virtual.xml | 11 +++++++++++
>  target/riscv/gdbstub.c          | 23 +++++++++++++++++++++++
>  4 files changed, 47 insertions(+), 2 deletions(-)
>  create mode 100644 gdb-xml/riscv-32bit-virtual.xml
>  create mode 100644 gdb-xml/riscv-64bit-virtual.xml
>
> diff --git a/configure b/configure
> index 30544f52e6..6118a6a045 100755
> --- a/configure
> +++ b/configure
> @@ -7520,13 +7520,13 @@ case "$target_name" in
>      TARGET_BASE_ARCH=riscv
>      TARGET_ABI_DIR=riscv
>      mttcg=yes
> -    gdb_xml_files="riscv-32bit-cpu.xml riscv-32bit-fpu.xml riscv-32bit-csr.xml"
> +    gdb_xml_files="riscv-32bit-cpu.xml riscv-32bit-fpu.xml riscv-32bit-csr.xml riscv-32bit-virtual.xml"
>    ;;
>    riscv64)
>      TARGET_BASE_ARCH=riscv
>      TARGET_ABI_DIR=riscv
>      mttcg=yes
> -    gdb_xml_files="riscv-64bit-cpu.xml riscv-64bit-fpu.xml riscv-64bit-csr.xml"
> +    gdb_xml_files="riscv-64bit-cpu.xml riscv-64bit-fpu.xml riscv-64bit-csr.xml riscv-64bit-virtual.xml"
>    ;;
>    sh4|sh4eb)
>      TARGET_ARCH=sh4
> diff --git a/gdb-xml/riscv-32bit-virtual.xml b/gdb-xml/riscv-32bit-virtual.xml
> new file mode 100644
> index 0000000000..905f1c555d
> --- /dev/null
> +++ b/gdb-xml/riscv-32bit-virtual.xml
> @@ -0,0 +1,11 @@
> +<?xml version="1.0"?>
> +<!-- Copyright (C) 2018-2019 Free Software Foundation, Inc.
> +
> +     Copying and distribution of this file, with or without modification,
> +     are permitted in any medium without royalty provided the copyright
> +     notice and this notice are preserved.  -->
> +
> +<!DOCTYPE feature SYSTEM "gdb-target.dtd">
> +<feature name="org.gnu.gdb.riscv.virtual">
> +  <reg name="priv" bitsize="32"/>
> +</feature>
> diff --git a/gdb-xml/riscv-64bit-virtual.xml b/gdb-xml/riscv-64bit-virtual.xml
> new file mode 100644
> index 0000000000..62d86c237b
> --- /dev/null
> +++ b/gdb-xml/riscv-64bit-virtual.xml
> @@ -0,0 +1,11 @@
> +<?xml version="1.0"?>
> +<!-- Copyright (C) 2018-2019 Free Software Foundation, Inc.
> +
> +     Copying and distribution of this file, with or without modification,
> +     are permitted in any medium without royalty provided the copyright
> +     notice and this notice are preserved.  -->
> +
> +<!DOCTYPE feature SYSTEM "gdb-target.dtd">
> +<feature name="org.gnu.gdb.riscv.virtual">
> +  <reg name="priv" bitsize="64"/>
> +</feature>
> diff --git a/target/riscv/gdbstub.c b/target/riscv/gdbstub.c
> index cb5bfd3d50..1f71604b78 100644
> --- a/target/riscv/gdbstub.c
> +++ b/target/riscv/gdbstub.c
> @@ -373,6 +373,23 @@ static int riscv_gdb_set_csr(CPURISCVState *env, uint8_t *mem_buf, int n)
>      return 0;
>  }
>
> +static int riscv_gdb_get_virtual(CPURISCVState *cs, uint8_t *mem_buf, int n)
> +{
> +    if (n == 0) {
> +#ifdef CONFIG_USER_ONLY
> +        return gdb_get_regl(mem_buf, 0);
> +#else
> +        return gdb_get_regl(mem_buf, cs->priv);
> +#endif
> +    }
> +    return 0;
> +}
> +
> +static int riscv_gdb_set_virtual(CPURISCVState *cs, uint8_t *mem_buf, int n)
> +{
> +    return 0;
> +}
> +
>  void riscv_cpu_register_gdb_regs_for_features(CPUState *cs)
>  {
>      RISCVCPU *cpu = RISCV_CPU(cs);
> @@ -385,6 +402,9 @@ void riscv_cpu_register_gdb_regs_for_features(CPUState *cs)
>
>      gdb_register_coprocessor(cs, riscv_gdb_get_csr, riscv_gdb_set_csr,
>                               240, "riscv-32bit-csr.xml", 0);
> +
> +    gdb_register_coprocessor(cs, riscv_gdb_get_virtual, riscv_gdb_set_virtual,
> +                             1, "riscv-32bit-virtual.xml", 0);
>  #elif defined(TARGET_RISCV64)
>      if (env->misa & RVF) {
>          gdb_register_coprocessor(cs, riscv_gdb_get_fpu, riscv_gdb_set_fpu,
> @@ -393,5 +413,8 @@ void riscv_cpu_register_gdb_regs_for_features(CPUState *cs)
>
>      gdb_register_coprocessor(cs, riscv_gdb_get_csr, riscv_gdb_set_csr,
>                               240, "riscv-64bit-csr.xml", 0);
> +
> +    gdb_register_coprocessor(cs, riscv_gdb_get_virtual, riscv_gdb_set_virtual,
> +                             1, "riscv-64bit-virtual.xml", 0);
>  #endif
>  }
> --
> 2.23.0
>

