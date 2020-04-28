Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6009EC83000
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 08:55:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E231206B9
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 08:55:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I3wN164U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E231206B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTM1A-00069D-0e
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 04:55:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51578)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zltjiangshi@gmail.com>) id 1jTLsj-0004wJ-W3
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 04:47:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <zltjiangshi@gmail.com>) id 1jTLrm-0002Ek-Ca
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 04:46:21 -0400
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141]:45985)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zltjiangshi@gmail.com>)
 id 1jTLZZ-0002DB-IW
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 04:26:33 -0400
Received: by mail-lf1-x141.google.com with SMTP id f8so16176052lfe.12
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2020 01:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=/pxSPH3uzHb6jb5WZ5jbgxdZGc5cFMsWzvcqeAua4jA=;
 b=I3wN164UGKYFtOjGkFs4OQQyrF17c826wLfQofQDG62Dnf8PY4LfgeN3+L2nHByz4a
 LXsbFNn6THJbGcbKz3ReFrTWu1SI3u+sa/svoqzc5bh6nMgdaLr/mRy0jtsB1sUnqnLs
 iO7pv3PueGvCsmUpAWbZho/Tyr+1K8DXU0VtIRQtvzkN/RtNkCwTkraCuanY6ipdZGtp
 ukz+UlPULYtTfbj9jdh9clsP6adb7dENRvRwxCO8VLQouKSPSN/a+kpzZ954SD4XrvAb
 xjaefIqEw8x2DQPy3MwJdykKXCRgAlDY/BKtdkBFRMZAKgbYT3vzjtYYWtlEvTeNzEsl
 tZ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=/pxSPH3uzHb6jb5WZ5jbgxdZGc5cFMsWzvcqeAua4jA=;
 b=O6Lm3VNYlb6iCPn/SqBhdIPPXa1jPjvnlNPrk/a2RmASolrqLjTX91N7MmK08s+MzY
 YZkgiIL+y3ya2LfqE75M2EXHK6/uvM3xgabjLolnp79hXwS3KfhLfQ/M/nGY5H2s1XEw
 VmxBikokjm/9pua9nLUSmIj9CLFCy5go7ZIFUA1A3TBfmviExkFiYRt/w4dhKawzbdbZ
 mBpqIk4vj/kvCSmJfVxf6EqX5VXhqKqNic7AM1xU+uGodLeOEr+VcOOzEyGMyxhRofXx
 il+9j8d2U8E9K0iBjRZa/TAZynAlGgr+rTqOOz+UU+6F5sCYPFeHP0xqX1X4yXBuE9qU
 +f+A==
X-Gm-Message-State: AGi0PuZQmXJ/tefUrmM5y4L7QFPjZ/bX22KCakw0kVEY1NcGxmGylcqh
 G13ARr+l9/PHgDupFyVVKknx8Z7DMFsjvw1QuWE=
X-Google-Smtp-Source: APiQypJalbv40M7p2g3OzASYHJvPPMdZYk9bWuE+27giz1/B7T/hX4PWAf87wUSdknVPxKKEtsmhat36aewbtEaioc4=
X-Received: by 2002:a19:dcc:: with SMTP id 195mr18393552lfn.193.1588062391180; 
 Tue, 28 Apr 2020 01:26:31 -0700 (PDT)
MIME-Version: 1.0
References: <1587979995-17717-1-git-send-email-chenhc@lemote.com>
 <1587979995-17717-4-git-send-email-chenhc@lemote.com>
 <c1a3aec6-dc45-3484-3a70-c06449bee609@amsat.org>
In-Reply-To: <c1a3aec6-dc45-3484-3a70-c06449bee609@amsat.org>
From: chen huacai <zltjiangshi@gmail.com>
Date: Tue, 28 Apr 2020 16:34:00 +0800
Message-ID: <CABDp7Vq-YX0LWU3iM=oygpcKzoS8cmXG6mvTQ5Gm_PbQsQMAgw@mail.gmail.com>
Subject: Re: [PATCH for-5.1 4/7] target/mips: Add Loongson-3 CPU definition
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::141;
 envelope-from=zltjiangshi@gmail.com; helo=mail-lf1-x141.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::141
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
Cc: Huacai Chen <chenhuacai@gmail.com>, Huacai Chen <chenhc@lemote.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 qemu-level <qemu-devel@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi, Philippe,

On Tue, Apr 28, 2020 at 2:34 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
>
> Hi Huacai,
>
> On 4/27/20 11:33 AM, Huacai Chen wrote:
> > Loongson-3 CPU family include Loongson-3A R1/R2/R3/R4 and Loongson-3B
> > R1/R2. Loongson-3A R4 is the newest and its ISA is almost the superset
> > of all others. To reduce complexity, we just define a "Loongson-3A" CPU
> > which is corresponding to Loongson-3A R4. Loongson-3A has CONFIG6 and
> > CONFIG7, so add their bit-fields as well.
>
> Is there a public datasheet for R4? (If possible in English).
I'm sorry that we only have Chinese datasheet in www.loongson.cn.

>
> >
> > Signed-off-by: Huacai Chen <chenhc@lemote.com>
> > Co-developed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> > ---
> >  target/mips/cpu.h                | 28 ++++++++++++++++++++++
> >  target/mips/internal.h           |  2 ++
> >  target/mips/mips-defs.h          |  7 ++++--
> >  target/mips/translate.c          |  2 ++
> >  target/mips/translate_init.inc.c | 51 ++++++++++++++++++++++++++++++++=
++++++++
> >  5 files changed, 88 insertions(+), 2 deletions(-)
> >
> > diff --git a/target/mips/cpu.h b/target/mips/cpu.h
> > index 94d01ea..0b3c987 100644
> > --- a/target/mips/cpu.h
> > +++ b/target/mips/cpu.h
> > @@ -940,7 +940,35 @@ struct CPUMIPSState {
> >  #define CP0C5_UFR          2
> >  #define CP0C5_NFExists     0
> >      int32_t CP0_Config6;
> > +    int32_t CP0_Config6_rw_bitmask;
> > +#define CP0C6_BPPASS          31
> > +#define CP0C6_KPOS            24
> > +#define CP0C6_KE              23
> > +#define CP0C6_VTLBONLY        22
> > +#define CP0C6_LASX            21
> > +#define CP0C6_SSEN            20
> > +#define CP0C6_DISDRTIME       19
> > +#define CP0C6_PIXNUEN         18
> > +#define CP0C6_SCRAND          17
> > +#define CP0C6_LLEXCEN         16
> > +#define CP0C6_DISVC           15
> > +#define CP0C6_VCLRU           14
> > +#define CP0C6_DCLRU           13
> > +#define CP0C6_PIXUEN          12
> > +#define CP0C6_DISBLKLYEN      11
> > +#define CP0C6_UMEMUALEN       10
> > +#define CP0C6_SFBEN           8
> > +#define CP0C6_FLTINT          7
> > +#define CP0C6_VLTINT          6
> > +#define CP0C6_DISBTB          5
> > +#define CP0C6_STPREFCTL       2
> > +#define CP0C6_INSTPREF        1
> > +#define CP0C6_DATAPREF        0
> >      int32_t CP0_Config7;
> > +    int64_t CP0_Config7_rw_bitmask;
> > +#define CP0C7_NAPCGEN       2
> > +#define CP0C7_UNIMUEN       1
> > +#define CP0C7_VFPUCGEN      0
> >      uint64_t CP0_LLAddr;
> >      uint64_t CP0_MAAR[MIPS_MAAR_MAX];
> >      int32_t CP0_MAARI;
> > diff --git a/target/mips/internal.h b/target/mips/internal.h
> > index 1bf274b..7853cb1 100644
> > --- a/target/mips/internal.h
> > +++ b/target/mips/internal.h
> > @@ -36,7 +36,9 @@ struct mips_def_t {
> >      int32_t CP0_Config5;
> >      int32_t CP0_Config5_rw_bitmask;
> >      int32_t CP0_Config6;
> > +    int32_t CP0_Config6_rw_bitmask;
> >      int32_t CP0_Config7;
> > +    int32_t CP0_Config7_rw_bitmask;
> >      target_ulong CP0_LLAddr_rw_bitmask;
> >      int CP0_LLAddr_shift;
> >      int32_t SYNCI_Step;
> > diff --git a/target/mips/mips-defs.h b/target/mips/mips-defs.h
> > index a831bb4..c2c96db 100644
> > --- a/target/mips/mips-defs.h
> > +++ b/target/mips/mips-defs.h
> > @@ -51,8 +51,9 @@
> >   */
> >  #define INSN_LOONGSON2E   0x0001000000000000ULL
> >  #define INSN_LOONGSON2F   0x0002000000000000ULL
> > -#define INSN_VR54XX       0x0004000000000000ULL
> > -#define INSN_R5900        0x0008000000000000ULL
> > +#define INSN_LOONGSON3A   0x0004000000000000ULL
> > +#define INSN_VR54XX       0x0008000000000000ULL
> > +#define INSN_R5900        0x0010000000000000ULL
> >  /*
> >   *   bits 56-63: vendor-specific ASEs
> >   */
> > @@ -94,6 +95,8 @@
> >  /* Wave Computing: "nanoMIPS" */
> >  #define CPU_NANOMIPS32  (CPU_MIPS32R6 | ISA_NANOMIPS32)
> >
> > +#define CPU_LOONGSON3A  (CPU_MIPS64R2 | INSN_LOONGSON3A)
> > +
> >  /*
> >   * Strictly follow the architecture standard:
> >   * - Disallow "special" instruction handling for PMON/SPIM.
> > diff --git a/target/mips/translate.c b/target/mips/translate.c
> > index 25b595a..2caf4cb 100644
> > --- a/target/mips/translate.c
> > +++ b/target/mips/translate.c
> > @@ -31206,7 +31206,9 @@ void cpu_state_reset(CPUMIPSState *env)
> >      env->CP0_Config5 =3D env->cpu_model->CP0_Config5;
> >      env->CP0_Config5_rw_bitmask =3D env->cpu_model->CP0_Config5_rw_bit=
mask;
> >      env->CP0_Config6 =3D env->cpu_model->CP0_Config6;
> > +    env->CP0_Config6_rw_bitmask =3D env->cpu_model->CP0_Config6_rw_bit=
mask;
> >      env->CP0_Config7 =3D env->cpu_model->CP0_Config7;
> > +    env->CP0_Config7_rw_bitmask =3D env->cpu_model->CP0_Config7_rw_bit=
mask;
> >      env->CP0_LLAddr_rw_bitmask =3D env->cpu_model->CP0_LLAddr_rw_bitma=
sk
> >                                   << env->cpu_model->CP0_LLAddr_shift;
> >      env->CP0_LLAddr_shift =3D env->cpu_model->CP0_LLAddr_shift;
> > diff --git a/target/mips/translate_init.inc.c b/target/mips/translate_i=
nit.inc.c
> > index 6d145a9..a32412d 100644
> > --- a/target/mips/translate_init.inc.c
> > +++ b/target/mips/translate_init.inc.c
> > @@ -802,6 +802,57 @@ const mips_def_t mips_defs[] =3D
> >          .mmu_type =3D MMU_TYPE_R4000,
> >      },
> >      {
> > +        .name =3D "Loongson-3A",
> > +        .CP0_PRid =3D 0x14C000,
> > +        /* 64KB I-cache and d-cache. 4 way with 32 bit cache line size=
.  */
> > +        .CP0_Config0 =3D MIPS_CONFIG0 | (0x1 << CP0C0_AR) | (0x2 << CP=
0C0_AT) |
> > +                       (MMU_TYPE_R4000 << CP0C0_MT),
> > +        .CP0_Config1 =3D MIPS_CONFIG1 | (1 << CP0C1_FP) | (63 << CP0C1=
_MMU) |
> > +                       (2 << CP0C1_IS) | (4 << CP0C1_IL) | (3 << CP0C1=
_IA) |
> > +                       (2 << CP0C1_DS) | (4 << CP0C1_DL) | (3 << CP0C1=
_DA) |
> > +                       (1 << CP0C1_PC) | (1 << CP0C1_WR) | (1 << CP0C1=
_EP),
> > +        .CP0_Config2 =3D MIPS_CONFIG2,
> > +        .CP0_Config3 =3D MIPS_CONFIG3 | (1U << CP0C3_M) | (1 << CP0C3_=
MSAP) |
> > +                       (1 << CP0C3_BP) | (1 << CP0C3_BI) | (1 << CP0C3=
_ULRI) |
> > +                       (1 << CP0C3_RXI) | (1 << CP0C3_LPA) | (1 << CP0=
C3_VInt),
> > +        .CP0_Config4 =3D MIPS_CONFIG4 | (1U << CP0C4_M) | (2 << CP0C4_=
IE) |
> > +                       (1 << CP0C4_AE) | (0x1c << CP0C4_KScrExist),
> > +        .CP0_Config4_rw_bitmask =3D 0,
> > +        .CP0_Config5 =3D MIPS_CONFIG5 | (1 << CP0C5_NFExists) | (1 << =
18),
> > +        .CP0_Config5_rw_bitmask =3D (1 << CP0C5_K) | (1 << CP0C5_CV) |
> > +                                  (1 << CP0C5_MSAEn) | (1 << CP0C5_UFE=
) |
> > +                                  (1 << CP0C5_FRE) | (1 << CP0C5_SBRI)=
,
> > +        .CP0_Config6 =3D (1 << CP0C6_VCLRU) | (1 << CP0C6_DCLRU) | (1 =
<< CP0C6_SFBEN) |
> > +                       (1 << CP0C6_FLTINT) | (1 << CP0C6_INSTPREF) | (=
1 << CP0C6_DATAPREF),
> > +        .CP0_Config6_rw_bitmask =3D (1 << CP0C6_BPPASS) | (0x3f << CP0=
C6_KPOS) |
> > +                                  (1 << CP0C6_KE) | (1 << CP0C6_VTLBON=
LY) | (1 << CP0C6_LASX) |
> > +                                  (1 << CP0C6_SSEN) | (1 << CP0C6_DISD=
RTIME) |
> > +                                  (1 << CP0C6_PIXNUEN) | (1 << CP0C6_S=
CRAND) |
> > +                                  (1 << CP0C6_LLEXCEN) | (1 << CP0C6_D=
ISVC) |
> > +                                  (1 << CP0C6_VCLRU) | (1 << CP0C6_DCL=
RU) |
> > +                                  (1 << CP0C6_PIXUEN) | (1 << CP0C6_DI=
SBLKLYEN) |
> > +                                  (1 << CP0C6_UMEMUALEN) | (1 << CP0C6=
_SFBEN) |
> > +                                  (1 << CP0C6_FLTINT) | (1 << CP0C6_VL=
TINT) |
> > +                                  (1 << CP0C6_DISBTB) | (3 << CP0C6_ST=
PREFCTL) |
> > +                                  (1 << CP0C6_INSTPREF) | (1 << CP0C6_=
DATAPREF),
> > +        .CP0_Config7 =3D 0,
> > +        .CP0_Config7_rw_bitmask =3D (1 << CP0C7_NAPCGEN) | (1 << CP0C7=
_UNIMUEN) | \
> > +                                  (1 << CP0C7_VFPUCGEN),
> > +        .CP0_LLAddr_rw_bitmask =3D 1,
> > +        .SYNCI_Step =3D 16,
> > +        .CCRes =3D 2,
> > +        .CP0_Status_rw_bitmask =3D 0x7DDBFFFF,
> > +        .CP0_PageGrain_rw_bitmask =3D (1U << CP0PG_RIE) | (1 << CP0PG_=
XIE) |
> > +                    (1 << CP0PG_ELPA) | (1 << CP0PG_IEC),
> > +        .CP1_fcr0 =3D (0x5 << FCR0_PRID) | (0x1 << FCR0_REV) | (0x1 <<=
 FCR0_F64),
> > +        .CP1_fcr31 =3D 0,
> > +        .CP1_fcr31_rw_bitmask =3D 0xFF83FFFF,
> > +        .SEGBITS =3D 48,
> > +        .PABITS =3D 48,
> > +        .insn_flags =3D CPU_LOONGSON3A,
> > +        .mmu_type =3D MMU_TYPE_R4000,
> > +    },
> > +    {
> >          /* A generic CPU providing MIPS64 DSP R2 ASE features.
> >             FIXME: Eventually this should be replaced by a real CPU mod=
el. */
> >          .name =3D "mips64dspr2",
> >



--=20
Huacai Chen

