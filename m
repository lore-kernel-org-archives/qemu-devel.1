Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28A1AC38A2A
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 19:22:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6EAA24954
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 19:22:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="roKiZiCW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6EAA24954
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47924 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWm6V-0001zW-T1
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 15:22:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56698)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jWm4N-0006ET-30; Thu, 07 May 2020 15:20:31 -0400
Received: from mail-il1-x143.google.com ([2607:f8b0:4864:20::143]:45016)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jWm4K-0004z1-9b; Thu, 07 May 2020 15:20:30 -0400
Received: by mail-il1-x143.google.com with SMTP id s10so3819607iln.11;
 Thu, 07 May 2020 12:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=poLe65lfobKRzFqxViCKV+k3Hrmzs7JAwV7sj7g+0Ak=;
 b=roKiZiCWqq5KpFpxYO+MEDtke94g0UIXqFrd3ND3+xgrCBW1dDFMiRdSRAP2dJc8Bc
 Q53FzLew61m56wnPraxs6a6tKOAOOJtstqSttARP+XkQYMHQ0Fu87qZe1w//YBxLz6BR
 6PzBpVoJ9lC60VjRGp+Ilo5TYSNG92To+BTZnYhJvq96cIJoZkmPmV0/Qe5F75qSyX7t
 jrtuSDj1GIVU371wXIzMxv8/OGAk/UBWMBfcx581liQV8VhZaVmi58kmEL1h9aMbksgW
 YxwBAFBDTGy2QJRXzqg8wcTl1WFaNqBZu/kzK77+cKnCkL6dPCPykMKPVylX3oXSkML2
 ++KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=poLe65lfobKRzFqxViCKV+k3Hrmzs7JAwV7sj7g+0Ak=;
 b=Hk6F5zt5um5viEHZ+ngYLnZaA8hRxKQkstWEQKr0FuGEfku2JLvUlQ+Z1Bisffs0WG
 cPN6/DTruyZw1ZyjBYo2141RTeKf+WKT8pXB0VajlfPcY1d9Fc2+QOn0I6g0b5+Gh5a2
 p/528r2ZQNrtwID/lyiy/YLVOExzSErAWWLi/eM5UJV75W2bwvQ3fZUTK2pCNCRso7Nk
 DZlGGG0IKZ95i7zBN7t6egofpyWQA/khtLX4QPVCjAitSUUhN6BZdAweBQUUrWrJ+ihZ
 Wjs/zpKu4OGBSj/WDPWr8cWeVkjinPVvtwUCIqdLsTyzlMmaiuknKNbNgeBAbf79tKxn
 YVJA==
X-Gm-Message-State: AGi0PuYje+7bp0W/WyiXe3q0tpzEBGD8IgfRChfMpzQGJNYa9taUBlnp
 Ovk3X7Hv5fvZOotZ5Clx5YwxF7xK65EqE7xjuGs=
X-Google-Smtp-Source: APiQypLDh3u8voRI+zan6wQnd8HiPbkoDupYTTSTS+3frR4B5NUJokl7v09cu1Xjw3gvQww6kFutXy2Wk8ikupMr0Os=
X-Received: by 2002:a92:d0c6:: with SMTP id y6mr17425566ila.227.1588879226367; 
 Thu, 07 May 2020 12:20:26 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1588727508.git.alistair.francis@wdc.com>
 <31e61b6cd45bbfa91ce924cdb19ca9844f0907b9.1588727508.git.alistair.francis@wdc.com>
 <59587535-3780-fc3a-3c28-869c495cf739@redhat.com>
In-Reply-To: <59587535-3780-fc3a-3c28-869c495cf739@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 7 May 2020 12:11:41 -0700
Message-ID: <CAKmqyKOUGhYQuaLsHKxBnLZGsO6BhSxtQ9MWh8ovxW61VuOe9A@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] target/riscv: Drop support for ISA spec version
 1.09.1
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, May 6, 2020 at 5:11 AM Philippe Mathieu-Daud=C3=A9 <philmd@redhat.c=
om> wrote:
>
> Hi Alistair,
>
> On 5/6/20 3:12 AM, Alistair Francis wrote:
> > The RISC-V ISA spec version 1.09.1 has been deprecated in QEMU since
> > 4.1. It's not commonly used so let's remove support for it.
> >
> > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > ---
> >   target/riscv/cpu.c                            | 30 -------
> >   target/riscv/cpu.h                            |  8 --
> >   target/riscv/csr.c                            | 82 ++++--------------=
-
> >   .../riscv/insn_trans/trans_privileged.inc.c   |  6 --
> >   tests/qtest/machine-none-test.c               |  4 +-
> >   5 files changed, 19 insertions(+), 111 deletions(-)
> >
> > diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> > index 059d71f2c7..eeb91f8513 100644
> > --- a/target/riscv/cpu.c
> > +++ b/target/riscv/cpu.c
> > @@ -135,16 +135,6 @@ static void riscv_base32_cpu_init(Object *obj)
> >       set_misa(env, 0);
> >   }
> >
> > -static void rv32gcsu_priv1_09_1_cpu_init(Object *obj)
> > -{
> > -    CPURISCVState *env =3D &RISCV_CPU(obj)->env;
> > -    set_misa(env, RV32 | RVI | RVM | RVA | RVF | RVD | RVC | RVS | RVU=
);
> > -    set_priv_version(env, PRIV_VERSION_1_09_1);
> > -    set_resetvec(env, DEFAULT_RSTVEC);
> > -    set_feature(env, RISCV_FEATURE_MMU);
> > -    set_feature(env, RISCV_FEATURE_PMP);
> > -}
> > -
> >   static void rv32gcsu_priv1_10_0_cpu_init(Object *obj)
> >   {
> >       CPURISCVState *env =3D &RISCV_CPU(obj)->env;
> > @@ -182,16 +172,6 @@ static void riscv_base64_cpu_init(Object *obj)
> >       set_misa(env, 0);
> >   }
> >
> > -static void rv64gcsu_priv1_09_1_cpu_init(Object *obj)
> > -{
> > -    CPURISCVState *env =3D &RISCV_CPU(obj)->env;
> > -    set_misa(env, RV64 | RVI | RVM | RVA | RVF | RVD | RVC | RVS | RVU=
);
> > -    set_priv_version(env, PRIV_VERSION_1_09_1);
> > -    set_resetvec(env, DEFAULT_RSTVEC);
> > -    set_feature(env, RISCV_FEATURE_MMU);
> > -    set_feature(env, RISCV_FEATURE_PMP);
> > -}
> > -
> >   static void rv64gcsu_priv1_10_0_cpu_init(Object *obj)
> >   {
> >       CPURISCVState *env =3D &RISCV_CPU(obj)->env;
> > @@ -388,8 +368,6 @@ static void riscv_cpu_realize(DeviceState *dev, Err=
or **errp)
> >               priv_version =3D PRIV_VERSION_1_11_0;
> >           } else if (!g_strcmp0(cpu->cfg.priv_spec, "v1.10.0")) {
> >               priv_version =3D PRIV_VERSION_1_10_0;
> > -        } else if (!g_strcmp0(cpu->cfg.priv_spec, "v1.9.1")) {
> > -            priv_version =3D PRIV_VERSION_1_09_1;
> >           } else {
> >               error_setg(errp,
> >                          "Unsupported privilege spec version '%s'",
> > @@ -621,18 +599,10 @@ static const TypeInfo riscv_cpu_type_infos[] =3D =
{
> >       DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_E31,       rv32imacu_nommu_cpu_i=
nit),
> >       DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_E34,       rv32imafcu_nommu_cpu_=
init),
> >       DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_U34,       rv32gcsu_priv1_10_0_c=
pu_init),
> > -    /* Depreacted */
> > -    DEFINE_CPU(TYPE_RISCV_CPU_RV32IMACU_NOMMU,  rv32imacu_nommu_cpu_in=
it),
> > -    DEFINE_CPU(TYPE_RISCV_CPU_RV32GCSU_V1_09_1, rv32gcsu_priv1_09_1_cp=
u_init),
> > -    DEFINE_CPU(TYPE_RISCV_CPU_RV32GCSU_V1_10_0, rv32gcsu_priv1_10_0_cp=
u_init)
>
> Shouldn't you let TYPE_RISCV_CPU_RV32GCSU_V1_10_0 until you remove v1.10.=
0?
>
> Or remove TYPE_RISCV_CPU_RV32GCSU_V1_10_0 &
> TYPE_RISCV_CPU_RV64GCSU_V1_10_0 in another patch after this one
> (restricted to 1.09.1).

Fixed in v2, I have split this patch into 2.

Alistair

>
> >   #elif defined(TARGET_RISCV64)
> >       DEFINE_CPU(TYPE_RISCV_CPU_BASE64,           riscv_base64_cpu_init=
),
> >       DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_E51,       rv64imacu_nommu_cpu_i=
nit),
> >       DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_U54,       rv64gcsu_priv1_10_0_c=
pu_init),
> > -    /* Deprecated */
> > -    DEFINE_CPU(TYPE_RISCV_CPU_RV64IMACU_NOMMU,  rv64imacu_nommu_cpu_in=
it),
> > -    DEFINE_CPU(TYPE_RISCV_CPU_RV64GCSU_V1_09_1, rv64gcsu_priv1_09_1_cp=
u_init),
> > -    DEFINE_CPU(TYPE_RISCV_CPU_RV64GCSU_V1_10_0, rv64gcsu_priv1_10_0_cp=
u_init)
>
> Ditto.
>
> >   #endif
> >   };
> >
> > diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> > index d0e7f5b9c5..c022539012 100644
> > --- a/target/riscv/cpu.h
> > +++ b/target/riscv/cpu.h
> > @@ -40,13 +40,6 @@
> >   #define TYPE_RISCV_CPU_SIFIVE_E51       RISCV_CPU_TYPE_NAME("sifive-e=
51")
> >   #define TYPE_RISCV_CPU_SIFIVE_U34       RISCV_CPU_TYPE_NAME("sifive-u=
34")
> >   #define TYPE_RISCV_CPU_SIFIVE_U54       RISCV_CPU_TYPE_NAME("sifive-u=
54")
> > -/* Deprecated */
> > -#define TYPE_RISCV_CPU_RV32IMACU_NOMMU  RISCV_CPU_TYPE_NAME("rv32imacu=
-nommu")
> > -#define TYPE_RISCV_CPU_RV32GCSU_V1_09_1 RISCV_CPU_TYPE_NAME("rv32gcsu-=
v1.9.1")
> > -#define TYPE_RISCV_CPU_RV32GCSU_V1_10_0 RISCV_CPU_TYPE_NAME("rv32gcsu-=
v1.10.0")
>
> Ditto.
>
> > -#define TYPE_RISCV_CPU_RV64IMACU_NOMMU  RISCV_CPU_TYPE_NAME("rv64imacu=
-nommu")
> > -#define TYPE_RISCV_CPU_RV64GCSU_V1_09_1 RISCV_CPU_TYPE_NAME("rv64gcsu-=
v1.9.1")
> > -#define TYPE_RISCV_CPU_RV64GCSU_V1_10_0 RISCV_CPU_TYPE_NAME("rv64gcsu-=
v1.10.0")
>
> Ditto.
>
> >
> >   #define RV32 ((target_ulong)1 << (TARGET_LONG_BITS - 2))
> >   #define RV64 ((target_ulong)2 << (TARGET_LONG_BITS - 2))
> > @@ -80,7 +73,6 @@ enum {
> >       RISCV_FEATURE_MISA
> >   };
> >
> > -#define PRIV_VERSION_1_09_1 0x00010901
> >   #define PRIV_VERSION_1_10_0 0x00011000
> >   #define PRIV_VERSION_1_11_0 0x00011100
> >
> > diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> > index 11d184cd16..df3498b24f 100644
> > --- a/target/riscv/csr.c
> > +++ b/target/riscv/csr.c
> > @@ -58,31 +58,11 @@ static int ctr(CPURISCVState *env, int csrno)
> >   #if !defined(CONFIG_USER_ONLY)
> >       CPUState *cs =3D env_cpu(env);
> >       RISCVCPU *cpu =3D RISCV_CPU(cs);
> > -    uint32_t ctr_en =3D ~0u;
> >
> >       if (!cpu->cfg.ext_counters) {
> >           /* The Counters extensions is not enabled */
> >           return -1;
> >       }
> > -
> > -    /*
> > -     * The counters are always enabled at run time on newer priv specs=
, as the
> > -     * CSR has changed from controlling that the counters can be read =
to
> > -     * controlling that the counters increment.
> > -     */
> > -    if (env->priv_ver > PRIV_VERSION_1_09_1) {
> > -        return 0;
> > -    }
> > -
> > -    if (env->priv < PRV_M) {
> > -        ctr_en &=3D env->mcounteren;
> > -    }
> > -    if (env->priv < PRV_S) {
> > -        ctr_en &=3D env->scounteren;
> > -    }
> > -    if (!(ctr_en & (1u << (csrno & 31)))) {
> > -        return -1;
> > -    }
> >   #endif
> >       return 0;
> >   }
> > @@ -358,34 +338,21 @@ static int write_mstatus(CPURISCVState *env, int =
csrno, target_ulong val)
> >       int dirty;
> >
> >       /* flush tlb on mstatus fields that affect VM */
> > -    if (env->priv_ver <=3D PRIV_VERSION_1_09_1) {
> > -        if ((val ^ mstatus) & (MSTATUS_MXR | MSTATUS_MPP |
> > -                MSTATUS_MPRV | MSTATUS_SUM | MSTATUS_VM)) {
> > -            tlb_flush(env_cpu(env));
> > -        }
> > -        mask =3D MSTATUS_SIE | MSTATUS_SPIE | MSTATUS_MIE | MSTATUS_MP=
IE |
> > -            MSTATUS_SPP | MSTATUS_FS | MSTATUS_MPRV | MSTATUS_SUM |
> > -            MSTATUS_MPP | MSTATUS_MXR |
> > -            (validate_vm(env, get_field(val, MSTATUS_VM)) ?
> > -                MSTATUS_VM : 0);
> > +    if ((val ^ mstatus) & (MSTATUS_MXR | MSTATUS_MPP | MSTATUS_MPV |
> > +            MSTATUS_MPRV | MSTATUS_SUM)) {
> > +        tlb_flush(env_cpu(env));
> >       }
> > -    if (env->priv_ver >=3D PRIV_VERSION_1_10_0) {
> > -        if ((val ^ mstatus) & (MSTATUS_MXR | MSTATUS_MPP | MSTATUS_MPV=
 |
> > -                MSTATUS_MPRV | MSTATUS_SUM)) {
> > -            tlb_flush(env_cpu(env));
> > -        }
> > -        mask =3D MSTATUS_SIE | MSTATUS_SPIE | MSTATUS_MIE | MSTATUS_MP=
IE |
> > -            MSTATUS_SPP | MSTATUS_FS | MSTATUS_MPRV | MSTATUS_SUM |
> > -            MSTATUS_MPP | MSTATUS_MXR | MSTATUS_TVM | MSTATUS_TSR |
> > -            MSTATUS_TW;
> > +    mask =3D MSTATUS_SIE | MSTATUS_SPIE | MSTATUS_MIE | MSTATUS_MPIE |
> > +        MSTATUS_SPP | MSTATUS_FS | MSTATUS_MPRV | MSTATUS_SUM |
> > +        MSTATUS_MPP | MSTATUS_MXR | MSTATUS_TVM | MSTATUS_TSR |
> > +        MSTATUS_TW;
> >   #if defined(TARGET_RISCV64)
> > -            /*
> > -             * RV32: MPV and MTL are not in mstatus. The current plan =
is to
> > -             * add them to mstatush. For now, we just don't support it=
.
> > -             */
> > -            mask |=3D MSTATUS_MTL | MSTATUS_MPV;
> > +        /*
> > +         * RV32: MPV and MTL are not in mstatus. The current plan is t=
o
> > +         * add them to mstatush. For now, we just don't support it.
> > +         */
> > +        mask |=3D MSTATUS_MTL | MSTATUS_MPV;
> >   #endif
> > -    }
> >
> >       mstatus =3D (mstatus & ~mask) | (val & mask);
> >
> > @@ -553,8 +520,7 @@ static int write_mcounteren(CPURISCVState *env, int=
 csrno, target_ulong val)
> >   /* This regiser is replaced with CSR_MCOUNTINHIBIT in 1.11.0 */
> >   static int read_mscounteren(CPURISCVState *env, int csrno, target_ulo=
ng *val)
> >   {
> > -    if (env->priv_ver > PRIV_VERSION_1_09_1
> > -        && env->priv_ver < PRIV_VERSION_1_11_0) {
> > +    if (env->priv_ver < PRIV_VERSION_1_11_0) {
> >           return -1;
> >       }
> >       *val =3D env->mcounteren;
> > @@ -564,8 +530,7 @@ static int read_mscounteren(CPURISCVState *env, int=
 csrno, target_ulong *val)
> >   /* This regiser is replaced with CSR_MCOUNTINHIBIT in 1.11.0 */
> >   static int write_mscounteren(CPURISCVState *env, int csrno, target_ul=
ong val)
> >   {
> > -    if (env->priv_ver > PRIV_VERSION_1_09_1
> > -        && env->priv_ver < PRIV_VERSION_1_11_0) {
> > +    if (env->priv_ver < PRIV_VERSION_1_11_0) {
> >           return -1;
> >       }
> >       env->mcounteren =3D val;
> > @@ -574,20 +539,13 @@ static int write_mscounteren(CPURISCVState *env, =
int csrno, target_ulong val)
> >
> >   static int read_mucounteren(CPURISCVState *env, int csrno, target_ulo=
ng *val)
> >   {
> > -    if (env->priv_ver > PRIV_VERSION_1_09_1) {
> > -        return -1;
> > -    }
> > -    *val =3D env->scounteren;
> > +    return -1;
> >       return 0;
> >   }
> >
> >   static int write_mucounteren(CPURISCVState *env, int csrno, target_ul=
ong val)
> >   {
> > -    if (env->priv_ver > PRIV_VERSION_1_09_1) {
> > -        return -1;
> > -    }
> > -    env->scounteren =3D val;
> > -    return 0;
> > +    return -1;
> >   }
> >
> >   /* Machine Trap Handling */
> > @@ -829,13 +787,7 @@ static int write_satp(CPURISCVState *env, int csrn=
o, target_ulong val)
> >       if (!riscv_feature(env, RISCV_FEATURE_MMU)) {
> >           return 0;
> >       }
> > -    if (env->priv_ver <=3D PRIV_VERSION_1_09_1 && (val ^ env->sptbr)) =
{
> > -        tlb_flush(env_cpu(env));
> > -        env->sptbr =3D val & (((target_ulong)
> > -            1 << (TARGET_PHYS_ADDR_SPACE_BITS - PGSHIFT)) - 1);
> > -    }
> > -    if (env->priv_ver >=3D PRIV_VERSION_1_10_0 &&
> > -        validate_vm(env, get_field(val, SATP_MODE)) &&
> > +    if (validate_vm(env, get_field(val, SATP_MODE)) &&
> >           ((val ^ env->satp) & (SATP_MODE | SATP_ASID | SATP_PPN)))
> >       {
> >           if (env->priv =3D=3D PRV_S && get_field(env->mstatus, MSTATUS=
_TVM)) {
> > diff --git a/target/riscv/insn_trans/trans_privileged.inc.c b/target/ri=
scv/insn_trans/trans_privileged.inc.c
> > index 76c2fad71c..1af9fa7df8 100644
> > --- a/target/riscv/insn_trans/trans_privileged.inc.c
> > +++ b/target/riscv/insn_trans/trans_privileged.inc.c
> > @@ -95,12 +95,6 @@ static bool trans_sfence_vma(DisasContext *ctx, arg_=
sfence_vma *a)
> >
> >   static bool trans_sfence_vm(DisasContext *ctx, arg_sfence_vm *a)
> >   {
> > -#ifndef CONFIG_USER_ONLY
> > -    if (ctx->priv_ver <=3D PRIV_VERSION_1_09_1) {
> > -        gen_helper_tlb_flush(cpu_env);
> > -        return true;
> > -    }
> > -#endif
> >       return false;
> >   }
> >
> > diff --git a/tests/qtest/machine-none-test.c b/tests/qtest/machine-none=
-test.c
> > index 8bb54a6360..b52311ec2e 100644
> > --- a/tests/qtest/machine-none-test.c
> > +++ b/tests/qtest/machine-none-test.c
> > @@ -54,8 +54,8 @@ static struct arch2cpu cpus_map[] =3D {
> >       { "xtensa", "dc233c" },
> >       { "xtensaeb", "fsf" },
> >       { "hppa", "hppa" },
> > -    { "riscv64", "rv64gcsu-v1.10.0" },
> > -    { "riscv32", "rv32gcsu-v1.9.1" },
> > +    { "riscv64", "sifive-u54" },
> > +    { "riscv32", "sifive-u34" },
> >       { "rx", "rx62n" },
> >   };
> >
> >
>

