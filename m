Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FD5BC33CB1
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 12:09:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62DA92073A
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 12:09:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rbBd5qM3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62DA92073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56170 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isQRl-0007an-K0
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 07:09:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39545)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1isQR2-00078i-O1
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 07:09:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1isQR1-0003Zj-AP
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 07:09:08 -0500
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:41407)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1isQR1-0003XO-0K; Fri, 17 Jan 2020 07:09:07 -0500
Received: by mail-lj1-x242.google.com with SMTP id h23so26228406ljc.8;
 Fri, 17 Jan 2020 04:09:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=d5VKE+G4ouQXs1X4IYyRBMyUcbawyRF/tVv23S/eQBU=;
 b=rbBd5qM3NTouYB4O/AZyuk0G6xkSyTxDs5Xl5Pr5QOWkboozNAA7b09sDntYGZGZT0
 DJs4XKC3GHdQboMKoqlYNgDmzXgyIWdYjNmMQfNYunLRh6fCYeRPX8oZJ13KLnQT69ph
 cDIbru6I2Y77oZCjTKE71MqRVXd6/nVPSHpnDFjey8jXP+cn+kafYNMLPj4v4C4xX2KM
 8Z9HKIIuv9NwNCjxPZL2djibxW6rzmUfZPsSFAZwudga0mmk0F9dt6XamVwM2oqtYS6I
 uv5cIWcTxSZbl3VJ+2oH7w4tmyA+xY1enU1jlS8EzIGO8LD9C5W+81MhkyI8+3fVICC/
 MB4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=d5VKE+G4ouQXs1X4IYyRBMyUcbawyRF/tVv23S/eQBU=;
 b=G53Ia0R9/OJcJWVYeCR5peSPG+F3lgufXCn9QFQpM6ZBjiEupjn9zqwKtJ7Gp+UKPM
 ++0FEDYIPrF7JgyX7MEgY1+5Nz7uigdQrDkWIC+mNeUh9wBEFYxmqX8nVhFZN6nbx2r2
 hIWQ/kM60NaMwIJk8yQao6ljgzXXDZ8RexgHSuClC8VvWsj2RDVXyq0ofSiz70sPv+Lj
 TwNzOKUqciOa6i+3UkENLsSTFraRR0oM5WSwBATljLfkDvt9yaRqzd+It3yoOnYtel/W
 2RnYfaHAAJieJ5l1qKnxlH2TCW2h2p8Hhkpa5gxYsauXi9RwMcxkKIsc+qKReaBblvND
 O2Fg==
X-Gm-Message-State: APjAAAX58MMnJ2BtYULNH7wTR+kSi/yRR+svjPUwejduIlkeIWI3McG4
 5OK8FLthFeWnFt7HU5GnlHgfQGYn5PZlNd4I6DE=
X-Google-Smtp-Source: APXvYqyY4Tx6Je1B7yZyu8PRabhvxtQbv7VVJc0DEmHPKM5cohRNkH+RJufrdO93H5p35mcsGmPjdZ8/3vuUcoeKTfU=
X-Received: by 2002:a2e:8946:: with SMTP id b6mr5364709ljk.1.1579262945077;
 Fri, 17 Jan 2020 04:09:05 -0800 (PST)
MIME-Version: 1.0
References: <20190821162831.27811-1-georg.kotheimer@kernkonzept.com>
 <87zhez4ied.fsf@linaro.org>
In-Reply-To: <87zhez4ied.fsf@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 17 Jan 2020 22:08:37 +1000
Message-ID: <CAKmqyKNOQBomr66+2pUj8Kugo-yPXf4Sc6wD0afW-aZFCDQo3w@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v3] RISC-V: Select FPU gdb xml file based on
 the supported extensions
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::242
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
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Palmer Dabbelt <palmer@sifive.com>, "open list:RISC-V" <qemu-riscv@nongnu.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Georg Kotheimer <georg.kotheimer@kernkonzept.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jan 7, 2020 at 10:21 PM Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
>
>
> Georg Kotheimer <georg.kotheimer@kernkonzept.com> writes:
>
> > The size of the FPU registers depends solely on the floating point
> > extensions supported by the target architecture.
> > However, in the previous implementation the floating point register
> > size was derived from whether the target architecture is 32-bit or
> > 64-bit.
> >
> > To allow RVF without RVD, changes to riscv_gdb_get_fpu() and
> > riscv_gdb_set_fpu() were necessary.
> >
> > Signed-off-by: Georg Kotheimer <georg.kotheimer@kernkonzept.com>
> > ---
> >  configure              |  4 ++--
> >  target/riscv/gdbstub.c | 45 ++++++++++++++++++++++++------------------
> >  2 files changed, 28 insertions(+), 21 deletions(-)
> >
> > diff --git a/configure b/configure
> > index 714e7fb6a1..44ee953022 100755
> > --- a/configure
> > +++ b/configure
> > @@ -7596,14 +7596,14 @@ case "$target_name" in
> >      TARGET_BASE_ARCH=3Driscv
> >      TARGET_ABI_DIR=3Driscv
> >      mttcg=3Dyes
> > -    gdb_xml_files=3D"riscv-32bit-cpu.xml riscv-32bit-fpu.xml riscv-32b=
it-csr.xml"
> > +    gdb_xml_files=3D"riscv-32bit-cpu.xml riscv-32bit-fpu.xml riscv-64b=
it-fpu.xml riscv-32bit-csr.xml"
> >      target_compiler=3D$cross_cc_riscv32
> >    ;;
> >    riscv64)
> >      TARGET_BASE_ARCH=3Driscv
> >      TARGET_ABI_DIR=3Driscv
> >      mttcg=3Dyes
> > -    gdb_xml_files=3D"riscv-64bit-cpu.xml riscv-64bit-fpu.xml riscv-64b=
it-csr.xml"
> > +    gdb_xml_files=3D"riscv-64bit-cpu.xml riscv-32bit-fpu.xml riscv-64b=
it-fpu.xml riscv-64bit-csr.xml"
> >      target_compiler=3D$cross_cc_riscv64
> >    ;;
> >    sh4|sh4eb)
> > diff --git a/target/riscv/gdbstub.c b/target/riscv/gdbstub.c
> > index 27be93279b..89b2543c9d 100644
> > --- a/target/riscv/gdbstub.c
> > +++ b/target/riscv/gdbstub.c
> > @@ -303,19 +303,22 @@ int riscv_cpu_gdb_write_register(CPUState *cs, ui=
nt8_t *mem_buf, int n)
> >  static int riscv_gdb_get_fpu(CPURISCVState *env, uint8_t *mem_buf, int=
 n)
> >  {
> >      if (n < 32) {
> > -        return gdb_get_reg64(mem_buf, env->fpr[n]);
> > +        if (env->misa & RVD) {
> > +            return gdb_get_reg64(mem_buf, env->fpr[n]);
> > +        }
> > +        return gdb_get_reg32(mem_buf, env->fpr[n]);
> >      /* there is hole between ft11 and fflags in fpu.xml */
> >      } else if (n < 36 && n > 32) {
> >          target_ulong val =3D 0;
> >          int result;
> >          /*
> > -         * CSR_FFLAGS is at index 8 in csr_register, and gdb says it i=
s FP
> > -         * register 33, so we recalculate the map index.
> > +         * CSR_FFLAGS is at index 1 in the csr space, and gdb says it =
is FP
> > +         * register 33, so we recalculate the csr index.
> >           * This also works for CSR_FRM and CSR_FCSR.
> >           */
> > -        result =3D riscv_csrrw_debug(env, n - 33 +  8, &val, 0, 0);
> > +        result =3D riscv_csrrw_debug(env, n - 33 + CSR_FFLAGS, &val, 0=
, 0);
> >          if (result =3D=3D 0) {
> > -            return gdb_get_regl(mem_buf, val);
> > +            return gdb_get_reg32(mem_buf, val);
> >          }
> >      }
> >      return 0;
> > @@ -324,20 +327,25 @@ static int riscv_gdb_get_fpu(CPURISCVState *env, =
uint8_t *mem_buf, int n)
> >  static int riscv_gdb_set_fpu(CPURISCVState *env, uint8_t *mem_buf, int=
 n)
> >  {
> >      if (n < 32) {
> > -        env->fpr[n] =3D ldq_p(mem_buf); /* always 64-bit */
> > -        return sizeof(uint64_t);
> > +        if (env->misa & RVD) {
> > +            env->fpr[n] =3D ldq_p(mem_buf);
> > +            return sizeof(uint64_t);
> > +        } else {
> > +            env->fpr[n] =3D ldl_p(mem_buf);
> > +            return sizeof(uint32_t);
> > +        }
>
> What endianess can RISC-V support? Unless specifically stated by the
> architecture values should be returned in tgarget endian format.

It can support both.

What needs to be changed?

Alistair

>
> >      /* there is hole between ft11 and fflags in fpu.xml */
> >      } else if (n < 36 && n > 32) {
> > -        target_ulong val =3D ldtul_p(mem_buf);
> > +        target_ulong val =3D ldl_p(mem_buf);
> >          int result;
> >          /*
> > -         * CSR_FFLAGS is at index 8 in csr_register, and gdb says it i=
s FP
> > -         * register 33, so we recalculate the map index.
> > +         * CSR_FFLAGS is at index 1 in the csr space, and gdb says it =
is FP
> > +         * register 33, so we recalculate the csr index.
> >           * This also works for CSR_FRM and CSR_FCSR.
> >           */
> > -        result =3D riscv_csrrw_debug(env, n - 33 + 8, NULL, val, -1);
> > +        result =3D riscv_csrrw_debug(env, n - 33 + CSR_FFLAGS, NULL, v=
al, -1);
> >          if (result =3D=3D 0) {
> > -            return sizeof(target_ulong);
> > +            return sizeof(uint32_t);
> >          }
> >      }
> >      return 0;
> > @@ -375,20 +383,19 @@ void riscv_cpu_register_gdb_regs_for_features(CPU=
State *cs)
> >  {
> >      RISCVCPU *cpu =3D RISCV_CPU(cs);
> >      CPURISCVState *env =3D &cpu->env;
> > -#if defined(TARGET_RISCV32)
> > -    if (env->misa & RVF) {
> > +
> > +    if (env->misa & RVD) {
> > +        gdb_register_coprocessor(cs, riscv_gdb_get_fpu, riscv_gdb_set_=
fpu,
> > +                                 36, "riscv-64bit-fpu.xml", 0);
> > +    } else if (env->misa & RVF) {
> >          gdb_register_coprocessor(cs, riscv_gdb_get_fpu, riscv_gdb_set_=
fpu,
> >                                   36, "riscv-32bit-fpu.xml", 0);
> >      }
> >
> > +#if defined(TARGET_RISCV32)
> >      gdb_register_coprocessor(cs, riscv_gdb_get_csr, riscv_gdb_set_csr,
> >                               4096, "riscv-32bit-csr.xml", 0);
> >  #elif defined(TARGET_RISCV64)
> > -    if (env->misa & RVF) {
> > -        gdb_register_coprocessor(cs, riscv_gdb_get_fpu, riscv_gdb_set_=
fpu,
> > -                                 36, "riscv-64bit-fpu.xml", 0);
> > -    }
> > -
> >      gdb_register_coprocessor(cs, riscv_gdb_get_csr, riscv_gdb_set_csr,
> >                               4096, "riscv-64bit-csr.xml", 0);
> >  #endif
>
>
> --
> Alex Benn=C3=A9e
>

