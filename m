Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 567A1C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 01:48:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11F9520888
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 01:48:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mEsXYwOF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11F9520888
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34010 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdlBE-0003W7-74
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 21:48:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50108)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jdlAX-00032U-HK; Tue, 26 May 2020 21:47:45 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:34916)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jdlAV-0005Fa-Ds; Tue, 26 May 2020 21:47:45 -0400
Received: by mail-wr1-x42b.google.com with SMTP id x14so17036194wrp.2;
 Tue, 26 May 2020 18:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=TKlz/BtpjBBJCc2GWiqC2sRona9rprI7DtqZkIecDsc=;
 b=mEsXYwOFbaobPnu7oA8iDqfKkF5yjeP1sIgvU6uyglPHmeLP2ydPLBqvdaXHvjweZ2
 wdxn5IB+Zgt2v2WbMX540B86iBWgTi8iMysqjf3PdL28qcY+K9kW+EOb1Z2Z6kZUlP0c
 PN33stFlg3CqQjtv5PDLvIIUYYMyTbyRE4Rb7gF2OnrdPmLI4Q/ipp3HEcBoFBNMX+lU
 QdEQqcEEFPmrJBUGiOsQP2JiTcOnv1+Edx7OQjfUfsnnSRuvtGR72FMfOhTXtQswDLrU
 H9bDix5JDHwnsaRGpI5XxYqH0r21OroHnJLpWNydyRZwXo30ZH3sziIs95HhKqTq5rxu
 hFHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=TKlz/BtpjBBJCc2GWiqC2sRona9rprI7DtqZkIecDsc=;
 b=RgJyU7HCfVRC0buaK00Jn4n37O3qlojY7Mf4tH9ZIcXrLILf+AUcllV8mqyCkcrDy1
 2qlfvfdxOP2EzA7+uTAkR1vocilTyueprIqNRb1jhFa9uQGvIE0JiUbpAFfh869aEibq
 YglolAihJ9YiUb7TsoG+CiSLvb7hqPmgo2rkKZfw0CTgDOynqUmoYyZkEIcU95UvFcFu
 g88vLmncxr/nmdJCHHRhdGZmrASQUl43j+mEYNjk0OQTg6u1H2Ezw0DXURBg30VIPezT
 1iqfErjp7S5E86BEa+9ADxqtiQei6FVi1DoyPg0aQ8xCRAMMWThvECYi05Y/sKtuKHfj
 A/RA==
X-Gm-Message-State: AOAM5319P/mK/Nim0GZY3E0Wf2X7UFX7JFOKPzRj8rdGWjVjJcjWGj1V
 RofWQ2NsdGT5mKezZW06cXugTmfFnPbd3rQLAzM=
X-Google-Smtp-Source: ABdhPJx7cChi4S0lZl5Od/1XiI6vNdtk3poyYqzXZXOMahAKYAE1h44j6Uz+oRVQVB+OxLtxECNWtLGk7XafUusIaNs=
X-Received: by 2002:adf:dc50:: with SMTP id m16mr22553626wrj.329.1590544061373; 
 Tue, 26 May 2020 18:47:41 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1590533156.git.alistair.francis@wdc.com>
 <50009ff3005847a5958327d5a31ebc70f52e7a4c.1590533156.git.alistair.francis@wdc.com>
 <CAHiYmc5fRmCZ+3i-SExYwWo=j+rQUvtG_WBexrQKhwb=BVpnKg@mail.gmail.com>
 <CAKmqyKM0kQ2HjOiqoUdmHcTwaHgV3DsV8XD2FgdZkB1_dpzZnw@mail.gmail.com>
In-Reply-To: <CAKmqyKM0kQ2HjOiqoUdmHcTwaHgV3DsV8XD2FgdZkB1_dpzZnw@mail.gmail.com>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Wed, 27 May 2020 03:47:28 +0200
Message-ID: <CAHiYmc5=skiWwCa+7=V8ETO75aKtBv=ADrinbHU6SFZmuMNysA@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] target/riscv: Drop support for ISA spec version
 1.09.1
To: Alistair Francis <alistair23@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wr1-x42b.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
 QEMU Developers <qemu-devel@nongnu.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

=D1=81=D1=80=D0=B5, 27. =D0=BC=D0=B0=D1=98 2020. =D1=83 02:33 Alistair Fran=
cis <alistair23@gmail.com> =D1=98=D0=B5
=D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>
> On Tue, May 26, 2020 at 4:55 PM Aleksandar Markovic
> <aleksandar.qemu.devel@gmail.com> wrote:
> >
> > =D1=81=D1=80=D0=B5, 27. =D0=BC=D0=B0=D1=98 2020. =D1=83 00:56 Alistair =
Francis <alistair.francis@wdc.com>
> > =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
> > >
> > > The RISC-V ISA spec version 1.09.1 has been deprecated in QEMU since
> > > 4.1. It's not commonly used so let's remove support for it.
> > >
> >
> > Hmmm, a very odd commit message. Do you suggest that there could be
> > the case that spec version 1.09.1 has been deprecated, but, let's say,
> > it remained commonly in use, and in that case, supposedly, it wouldn't
> > be removed (even though it was annonced as deprecated), or, even
> > "undeprecated"? I am not saying anything is wrong, but just looks like
>
> The commit message was just confirming why it was deprecated in the
> first place. AFAIK no one is using the 1.09.1 version of the spec.
>
> In saying that I think that it could be "undeprecated". I don't use
> the 1.09.1 and no one I know uses it, but if after deprecating it in
> QEMU a large group of users voiced interest in it, I think we would
> still keep it around. That would depend on the burden and teh level of
> interest. So I think things could be "undeprecated" or at least the
> deprecation timeline could be extended if required or requested.
>
> Alistair
>

Fair enough.

> > an uncommon explanation for removing after deprecating, like a novel
> > approach to the deprecation process.
> >
> > Best Regards,
> > Aleksandar
> >
> >
> >
> > > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > > ---
> > >  target/riscv/cpu.h                            |   1 -
> > >  target/riscv/cpu.c                            |   2 -
> > >  target/riscv/cpu_helper.c                     |  82 +++++-------
> > >  target/riscv/csr.c                            | 118 +++-------------=
--
> > >  .../riscv/insn_trans/trans_privileged.inc.c   |  18 +--
> > >  target/riscv/monitor.c                        |   5 -
> > >  target/riscv/op_helper.c                      |  17 +--
> > >  7 files changed, 56 insertions(+), 187 deletions(-)
> > >
> > > diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> > > index 76b98d7a33..c022539012 100644
> > > --- a/target/riscv/cpu.h
> > > +++ b/target/riscv/cpu.h
> > > @@ -73,7 +73,6 @@ enum {
> > >      RISCV_FEATURE_MISA
> > >  };
> > >
> > > -#define PRIV_VERSION_1_09_1 0x00010901
> > >  #define PRIV_VERSION_1_10_0 0x00011000
> > >  #define PRIV_VERSION_1_11_0 0x00011100
> > >
> > > diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> > > index 112f2e3a2f..eeb91f8513 100644
> > > --- a/target/riscv/cpu.c
> > > +++ b/target/riscv/cpu.c
> > > @@ -368,8 +368,6 @@ static void riscv_cpu_realize(DeviceState *dev, E=
rror **errp)
> > >              priv_version =3D PRIV_VERSION_1_11_0;
> > >          } else if (!g_strcmp0(cpu->cfg.priv_spec, "v1.10.0")) {
> > >              priv_version =3D PRIV_VERSION_1_10_0;
> > > -        } else if (!g_strcmp0(cpu->cfg.priv_spec, "v1.9.1")) {
> > > -            priv_version =3D PRIV_VERSION_1_09_1;
> > >          } else {
> > >              error_setg(errp,
> > >                         "Unsupported privilege spec version '%s'",
> > > diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> > > index bc80aa87cf..62fe1ecc8f 100644
> > > --- a/target/riscv/cpu_helper.c
> > > +++ b/target/riscv/cpu_helper.c
> > > @@ -364,57 +364,36 @@ static int get_physical_address(CPURISCVState *=
env, hwaddr *physical,
> > >          mxr =3D get_field(env->vsstatus, MSTATUS_MXR);
> > >      }
> > >
> > > -    if (env->priv_ver >=3D PRIV_VERSION_1_10_0) {
> > > -        if (first_stage =3D=3D true) {
> > > -            if (use_background) {
> > > -                base =3D (hwaddr)get_field(env->vsatp, SATP_PPN) << =
PGSHIFT;
> > > -                vm =3D get_field(env->vsatp, SATP_MODE);
> > > -            } else {
> > > -                base =3D (hwaddr)get_field(env->satp, SATP_PPN) << P=
GSHIFT;
> > > -                vm =3D get_field(env->satp, SATP_MODE);
> > > -            }
> > > -            widened =3D 0;
> > > +    if (first_stage =3D=3D true) {
> > > +        if (use_background) {
> > > +            base =3D (hwaddr)get_field(env->vsatp, SATP_PPN) << PGSH=
IFT;
> > > +            vm =3D get_field(env->vsatp, SATP_MODE);
> > >          } else {
> > > -            base =3D (hwaddr)get_field(env->hgatp, HGATP_PPN) << PGS=
HIFT;
> > > -            vm =3D get_field(env->hgatp, HGATP_MODE);
> > > -            widened =3D 2;
> > > -        }
> > > -        sum =3D get_field(env->mstatus, MSTATUS_SUM);
> > > -        switch (vm) {
> > > -        case VM_1_10_SV32:
> > > -          levels =3D 2; ptidxbits =3D 10; ptesize =3D 4; break;
> > > -        case VM_1_10_SV39:
> > > -          levels =3D 3; ptidxbits =3D 9; ptesize =3D 8; break;
> > > -        case VM_1_10_SV48:
> > > -          levels =3D 4; ptidxbits =3D 9; ptesize =3D 8; break;
> > > -        case VM_1_10_SV57:
> > > -          levels =3D 5; ptidxbits =3D 9; ptesize =3D 8; break;
> > > -        case VM_1_10_MBARE:
> > > -            *physical =3D addr;
> > > -            *prot =3D PAGE_READ | PAGE_WRITE | PAGE_EXEC;
> > > -            return TRANSLATE_SUCCESS;
> > > -        default:
> > > -          g_assert_not_reached();
> > > +            base =3D (hwaddr)get_field(env->satp, SATP_PPN) << PGSHI=
FT;
> > > +            vm =3D get_field(env->satp, SATP_MODE);
> > >          }
> > > -    } else {
> > >          widened =3D 0;
> > > -        base =3D (hwaddr)(env->sptbr) << PGSHIFT;
> > > -        sum =3D !get_field(env->mstatus, MSTATUS_PUM);
> > > -        vm =3D get_field(env->mstatus, MSTATUS_VM);
> > > -        switch (vm) {
> > > -        case VM_1_09_SV32:
> > > -          levels =3D 2; ptidxbits =3D 10; ptesize =3D 4; break;
> > > -        case VM_1_09_SV39:
> > > -          levels =3D 3; ptidxbits =3D 9; ptesize =3D 8; break;
> > > -        case VM_1_09_SV48:
> > > -          levels =3D 4; ptidxbits =3D 9; ptesize =3D 8; break;
> > > -        case VM_1_09_MBARE:
> > > -            *physical =3D addr;
> > > -            *prot =3D PAGE_READ | PAGE_WRITE | PAGE_EXEC;
> > > -            return TRANSLATE_SUCCESS;
> > > -        default:
> > > -          g_assert_not_reached();
> > > -        }
> > > +    } else {
> > > +        base =3D (hwaddr)get_field(env->hgatp, HGATP_PPN) << PGSHIFT=
;
> > > +        vm =3D get_field(env->hgatp, HGATP_MODE);
> > > +        widened =3D 2;
> > > +    }
> > > +    sum =3D get_field(env->mstatus, MSTATUS_SUM);
> > > +    switch (vm) {
> > > +    case VM_1_10_SV32:
> > > +      levels =3D 2; ptidxbits =3D 10; ptesize =3D 4; break;
> > > +    case VM_1_10_SV39:
> > > +      levels =3D 3; ptidxbits =3D 9; ptesize =3D 8; break;
> > > +    case VM_1_10_SV48:
> > > +      levels =3D 4; ptidxbits =3D 9; ptesize =3D 8; break;
> > > +    case VM_1_10_SV57:
> > > +      levels =3D 5; ptidxbits =3D 9; ptesize =3D 8; break;
> > > +    case VM_1_10_MBARE:
> > > +        *physical =3D addr;
> > > +        *prot =3D PAGE_READ | PAGE_WRITE | PAGE_EXEC;
> > > +        return TRANSLATE_SUCCESS;
> > > +    default:
> > > +      g_assert_not_reached();
> > >      }
> > >
> > >      CPUState *cs =3D env_cpu(env);
> > > @@ -588,7 +567,6 @@ static void raise_mmu_exception(CPURISCVState *en=
v, target_ulong address,
> > >      int page_fault_exceptions;
> > >      if (first_stage) {
> > >          page_fault_exceptions =3D
> > > -            (env->priv_ver >=3D PRIV_VERSION_1_10_0) &&
> > >              get_field(env->satp, SATP_MODE) !=3D VM_1_10_MBARE &&
> > >              !pmp_violation;
> > >      } else {
> > > @@ -941,8 +919,7 @@ void riscv_cpu_do_interrupt(CPUState *cs)
> > >          }
> > >
> > >          s =3D env->mstatus;
> > > -        s =3D set_field(s, MSTATUS_SPIE, env->priv_ver >=3D PRIV_VER=
SION_1_10_0 ?
> > > -            get_field(s, MSTATUS_SIE) : get_field(s, MSTATUS_UIE << =
env->priv));
> > > +        s =3D set_field(s, MSTATUS_SPIE, get_field(s, MSTATUS_SIE));
> > >          s =3D set_field(s, MSTATUS_SPP, env->priv);
> > >          s =3D set_field(s, MSTATUS_SIE, 0);
> > >          env->mstatus =3D s;
> > > @@ -979,8 +956,7 @@ void riscv_cpu_do_interrupt(CPUState *cs)
> > >          }
> > >
> > >          s =3D env->mstatus;
> > > -        s =3D set_field(s, MSTATUS_MPIE, env->priv_ver >=3D PRIV_VER=
SION_1_10_0 ?
> > > -            get_field(s, MSTATUS_MIE) : get_field(s, MSTATUS_UIE << =
env->priv));
> > > +        s =3D set_field(s, MSTATUS_MPIE, get_field(s, MSTATUS_MIE));
> > >          s =3D set_field(s, MSTATUS_MPP, env->priv);
> > >          s =3D set_field(s, MSTATUS_MIE, 0);
> > >          env->mstatus =3D s;
> > > diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> > > index 11d184cd16..ad42beb7df 100644
> > > --- a/target/riscv/csr.c
> > > +++ b/target/riscv/csr.c
> > > @@ -58,31 +58,11 @@ static int ctr(CPURISCVState *env, int csrno)
> > >  #if !defined(CONFIG_USER_ONLY)
> > >      CPUState *cs =3D env_cpu(env);
> > >      RISCVCPU *cpu =3D RISCV_CPU(cs);
> > > -    uint32_t ctr_en =3D ~0u;
> > >
> > >      if (!cpu->cfg.ext_counters) {
> > >          /* The Counters extensions is not enabled */
> > >          return -1;
> > >      }
> > > -
> > > -    /*
> > > -     * The counters are always enabled at run time on newer priv spe=
cs, as the
> > > -     * CSR has changed from controlling that the counters can be rea=
d to
> > > -     * controlling that the counters increment.
> > > -     */
> > > -    if (env->priv_ver > PRIV_VERSION_1_09_1) {
> > > -        return 0;
> > > -    }
> > > -
> > > -    if (env->priv < PRV_M) {
> > > -        ctr_en &=3D env->mcounteren;
> > > -    }
> > > -    if (env->priv < PRV_S) {
> > > -        ctr_en &=3D env->scounteren;
> > > -    }
> > > -    if (!(ctr_en & (1u << (csrno & 31)))) {
> > > -        return -1;
> > > -    }
> > >  #endif
> > >      return 0;
> > >  }
> > > @@ -293,9 +273,6 @@ static const target_ulong delegable_excps =3D
> > >      (1ULL << (RISCV_EXCP_INST_GUEST_PAGE_FAULT)) |
> > >      (1ULL << (RISCV_EXCP_LOAD_GUEST_ACCESS_FAULT)) |
> > >      (1ULL << (RISCV_EXCP_STORE_GUEST_AMO_ACCESS_FAULT));
> > > -static const target_ulong sstatus_v1_9_mask =3D SSTATUS_SIE | SSTATU=
S_SPIE |
> > > -    SSTATUS_UIE | SSTATUS_UPIE | SSTATUS_SPP | SSTATUS_FS | SSTATUS_=
XS |
> > > -    SSTATUS_SUM | SSTATUS_SD;
> > >  static const target_ulong sstatus_v1_10_mask =3D SSTATUS_SIE | SSTAT=
US_SPIE |
> > >      SSTATUS_UIE | SSTATUS_UPIE | SSTATUS_SPP | SSTATUS_FS | SSTATUS_=
XS |
> > >      SSTATUS_SUM | SSTATUS_MXR | SSTATUS_SD;
> > > @@ -304,20 +281,11 @@ static const target_ulong hip_writable_mask =3D=
 MIP_VSSIP | MIP_VSTIP | MIP_VSEIP;
> > >  static const target_ulong vsip_writable_mask =3D MIP_VSSIP;
> > >
> > >  #if defined(TARGET_RISCV32)
> > > -static const char valid_vm_1_09[16] =3D {
> > > -    [VM_1_09_MBARE] =3D 1,
> > > -    [VM_1_09_SV32] =3D 1,
> > > -};
> > >  static const char valid_vm_1_10[16] =3D {
> > >      [VM_1_10_MBARE] =3D 1,
> > >      [VM_1_10_SV32] =3D 1
> > >  };
> > >  #elif defined(TARGET_RISCV64)
> > > -static const char valid_vm_1_09[16] =3D {
> > > -    [VM_1_09_MBARE] =3D 1,
> > > -    [VM_1_09_SV39] =3D 1,
> > > -    [VM_1_09_SV48] =3D 1,
> > > -};
> > >  static const char valid_vm_1_10[16] =3D {
> > >      [VM_1_10_MBARE] =3D 1,
> > >      [VM_1_10_SV39] =3D 1,
> > > @@ -347,8 +315,7 @@ static int read_mstatus(CPURISCVState *env, int c=
srno, target_ulong *val)
> > >
> > >  static int validate_vm(CPURISCVState *env, target_ulong vm)
> > >  {
> > > -    return (env->priv_ver >=3D PRIV_VERSION_1_10_0) ?
> > > -        valid_vm_1_10[vm & 0xf] : valid_vm_1_09[vm & 0xf];
> > > +    return valid_vm_1_10[vm & 0xf];
> > >  }
> > >
> > >  static int write_mstatus(CPURISCVState *env, int csrno, target_ulong=
 val)
> > > @@ -358,34 +325,21 @@ static int write_mstatus(CPURISCVState *env, in=
t csrno, target_ulong val)
> > >      int dirty;
> > >
> > >      /* flush tlb on mstatus fields that affect VM */
> > > -    if (env->priv_ver <=3D PRIV_VERSION_1_09_1) {
> > > -        if ((val ^ mstatus) & (MSTATUS_MXR | MSTATUS_MPP |
> > > -                MSTATUS_MPRV | MSTATUS_SUM | MSTATUS_VM)) {
> > > -            tlb_flush(env_cpu(env));
> > > -        }
> > > -        mask =3D MSTATUS_SIE | MSTATUS_SPIE | MSTATUS_MIE | MSTATUS_=
MPIE |
> > > -            MSTATUS_SPP | MSTATUS_FS | MSTATUS_MPRV | MSTATUS_SUM |
> > > -            MSTATUS_MPP | MSTATUS_MXR |
> > > -            (validate_vm(env, get_field(val, MSTATUS_VM)) ?
> > > -                MSTATUS_VM : 0);
> > > +    if ((val ^ mstatus) & (MSTATUS_MXR | MSTATUS_MPP | MSTATUS_MPV |
> > > +            MSTATUS_MPRV | MSTATUS_SUM)) {
> > > +        tlb_flush(env_cpu(env));
> > >      }
> > > -    if (env->priv_ver >=3D PRIV_VERSION_1_10_0) {
> > > -        if ((val ^ mstatus) & (MSTATUS_MXR | MSTATUS_MPP | MSTATUS_M=
PV |
> > > -                MSTATUS_MPRV | MSTATUS_SUM)) {
> > > -            tlb_flush(env_cpu(env));
> > > -        }
> > > -        mask =3D MSTATUS_SIE | MSTATUS_SPIE | MSTATUS_MIE | MSTATUS_=
MPIE |
> > > -            MSTATUS_SPP | MSTATUS_FS | MSTATUS_MPRV | MSTATUS_SUM |
> > > -            MSTATUS_MPP | MSTATUS_MXR | MSTATUS_TVM | MSTATUS_TSR |
> > > -            MSTATUS_TW;
> > > +    mask =3D MSTATUS_SIE | MSTATUS_SPIE | MSTATUS_MIE | MSTATUS_MPIE=
 |
> > > +        MSTATUS_SPP | MSTATUS_FS | MSTATUS_MPRV | MSTATUS_SUM |
> > > +        MSTATUS_MPP | MSTATUS_MXR | MSTATUS_TVM | MSTATUS_TSR |
> > > +        MSTATUS_TW;
> > >  #if defined(TARGET_RISCV64)
> > > -            /*
> > > -             * RV32: MPV and MTL are not in mstatus. The current pla=
n is to
> > > -             * add them to mstatush. For now, we just don't support =
it.
> > > -             */
> > > -            mask |=3D MSTATUS_MTL | MSTATUS_MPV;
> > > +    /*
> > > +     * RV32: MPV and MTL are not in mstatus. The current plan is to
> > > +     * add them to mstatush. For now, we just don't support it.
> > > +     */
> > > +    mask |=3D MSTATUS_MTL | MSTATUS_MPV;
> > >  #endif
> > > -    }
> > >
> > >      mstatus =3D (mstatus & ~mask) | (val & mask);
> > >
> > > @@ -534,18 +488,12 @@ static int write_mtvec(CPURISCVState *env, int =
csrno, target_ulong val)
> > >
> > >  static int read_mcounteren(CPURISCVState *env, int csrno, target_ulo=
ng *val)
> > >  {
> > > -    if (env->priv_ver < PRIV_VERSION_1_10_0) {
> > > -        return -1;
> > > -    }
> > >      *val =3D env->mcounteren;
> > >      return 0;
> > >  }
> > >
> > >  static int write_mcounteren(CPURISCVState *env, int csrno, target_ul=
ong val)
> > >  {
> > > -    if (env->priv_ver < PRIV_VERSION_1_10_0) {
> > > -        return -1;
> > > -    }
> > >      env->mcounteren =3D val;
> > >      return 0;
> > >  }
> > > @@ -553,8 +501,7 @@ static int write_mcounteren(CPURISCVState *env, i=
nt csrno, target_ulong val)
> > >  /* This regiser is replaced with CSR_MCOUNTINHIBIT in 1.11.0 */
> > >  static int read_mscounteren(CPURISCVState *env, int csrno, target_ul=
ong *val)
> > >  {
> > > -    if (env->priv_ver > PRIV_VERSION_1_09_1
> > > -        && env->priv_ver < PRIV_VERSION_1_11_0) {
> > > +    if (env->priv_ver < PRIV_VERSION_1_11_0) {
> > >          return -1;
> > >      }
> > >      *val =3D env->mcounteren;
> > > @@ -564,32 +511,13 @@ static int read_mscounteren(CPURISCVState *env,=
 int csrno, target_ulong *val)
> > >  /* This regiser is replaced with CSR_MCOUNTINHIBIT in 1.11.0 */
> > >  static int write_mscounteren(CPURISCVState *env, int csrno, target_u=
long val)
> > >  {
> > > -    if (env->priv_ver > PRIV_VERSION_1_09_1
> > > -        && env->priv_ver < PRIV_VERSION_1_11_0) {
> > > +    if (env->priv_ver < PRIV_VERSION_1_11_0) {
> > >          return -1;
> > >      }
> > >      env->mcounteren =3D val;
> > >      return 0;
> > >  }
> > >
> > > -static int read_mucounteren(CPURISCVState *env, int csrno, target_ul=
ong *val)
> > > -{
> > > -    if (env->priv_ver > PRIV_VERSION_1_09_1) {
> > > -        return -1;
> > > -    }
> > > -    *val =3D env->scounteren;
> > > -    return 0;
> > > -}
> > > -
> > > -static int write_mucounteren(CPURISCVState *env, int csrno, target_u=
long val)
> > > -{
> > > -    if (env->priv_ver > PRIV_VERSION_1_09_1) {
> > > -        return -1;
> > > -    }
> > > -    env->scounteren =3D val;
> > > -    return 0;
> > > -}
> > > -
> > >  /* Machine Trap Handling */
> > >  static int read_mscratch(CPURISCVState *env, int csrno, target_ulong=
 *val)
> > >  {
> > > @@ -663,16 +591,14 @@ static int rmw_mip(CPURISCVState *env, int csrn=
o, target_ulong *ret_value,
> > >  /* Supervisor Trap Setup */
> > >  static int read_sstatus(CPURISCVState *env, int csrno, target_ulong =
*val)
> > >  {
> > > -    target_ulong mask =3D ((env->priv_ver >=3D PRIV_VERSION_1_10_0) =
?
> > > -                         sstatus_v1_10_mask : sstatus_v1_9_mask);
> > > +    target_ulong mask =3D (sstatus_v1_10_mask);
> > >      *val =3D env->mstatus & mask;
> > >      return 0;
> > >  }
> > >
> > >  static int write_sstatus(CPURISCVState *env, int csrno, target_ulong=
 val)
> > >  {
> > > -    target_ulong mask =3D ((env->priv_ver >=3D PRIV_VERSION_1_10_0) =
?
> > > -                         sstatus_v1_10_mask : sstatus_v1_9_mask);
> > > +    target_ulong mask =3D (sstatus_v1_10_mask);
> > >      target_ulong newval =3D (env->mstatus & ~mask) | (val & mask);
> > >      return write_mstatus(env, CSR_MSTATUS, newval);
> > >  }
> > > @@ -829,13 +755,7 @@ static int write_satp(CPURISCVState *env, int cs=
rno, target_ulong val)
> > >      if (!riscv_feature(env, RISCV_FEATURE_MMU)) {
> > >          return 0;
> > >      }
> > > -    if (env->priv_ver <=3D PRIV_VERSION_1_09_1 && (val ^ env->sptbr)=
) {
> > > -        tlb_flush(env_cpu(env));
> > > -        env->sptbr =3D val & (((target_ulong)
> > > -            1 << (TARGET_PHYS_ADDR_SPACE_BITS - PGSHIFT)) - 1);
> > > -    }
> > > -    if (env->priv_ver >=3D PRIV_VERSION_1_10_0 &&
> > > -        validate_vm(env, get_field(val, SATP_MODE)) &&
> > > +    if (validate_vm(env, get_field(val, SATP_MODE)) &&
> > >          ((val ^ env->satp) & (SATP_MODE | SATP_ASID | SATP_PPN)))
> > >      {
> > >          if (env->priv =3D=3D PRV_S && get_field(env->mstatus, MSTATU=
S_TVM)) {
> > > @@ -1313,8 +1233,6 @@ static riscv_csr_operations csr_ops[CSR_TABLE_S=
IZE] =3D {
> > >      [CSR_MSTATUSH] =3D            { any,  read_mstatush,    write_ms=
tatush    },
> > >  #endif
> > >
> > > -    /* Legacy Counter Setup (priv v1.9.1) */
> > > -    [CSR_MUCOUNTEREN] =3D         { any,  read_mucounteren, write_mu=
counteren },
> > >      [CSR_MSCOUNTEREN] =3D         { any,  read_mscounteren, write_ms=
counteren },
> > >
> > >      /* Machine Trap Handling */
> > > diff --git a/target/riscv/insn_trans/trans_privileged.inc.c b/target/=
riscv/insn_trans/trans_privileged.inc.c
> > > index 76c2fad71c..5f26e0f5ea 100644
> > > --- a/target/riscv/insn_trans/trans_privileged.inc.c
> > > +++ b/target/riscv/insn_trans/trans_privileged.inc.c
> > > @@ -85,30 +85,21 @@ static bool trans_wfi(DisasContext *ctx, arg_wfi =
*a)
> > >  static bool trans_sfence_vma(DisasContext *ctx, arg_sfence_vma *a)
> > >  {
> > >  #ifndef CONFIG_USER_ONLY
> > > -    if (ctx->priv_ver >=3D PRIV_VERSION_1_10_0) {
> > > -        gen_helper_tlb_flush(cpu_env);
> > > -        return true;
> > > -    }
> > > +    gen_helper_tlb_flush(cpu_env);
> > > +    return true;
> > >  #endif
> > >      return false;
> > >  }
> > >
> > >  static bool trans_sfence_vm(DisasContext *ctx, arg_sfence_vm *a)
> > >  {
> > > -#ifndef CONFIG_USER_ONLY
> > > -    if (ctx->priv_ver <=3D PRIV_VERSION_1_09_1) {
> > > -        gen_helper_tlb_flush(cpu_env);
> > > -        return true;
> > > -    }
> > > -#endif
> > >      return false;
> > >  }
> > >
> > >  static bool trans_hfence_gvma(DisasContext *ctx, arg_sfence_vma *a)
> > >  {
> > >  #ifndef CONFIG_USER_ONLY
> > > -    if (ctx->priv_ver >=3D PRIV_VERSION_1_10_0 &&
> > > -        has_ext(ctx, RVH)) {
> > > +    if (has_ext(ctx, RVH)) {
> > >          /* Hpervisor extensions exist */
> > >          /*
> > >           * if (env->priv =3D=3D PRV_M ||
> > > @@ -127,8 +118,7 @@ static bool trans_hfence_gvma(DisasContext *ctx, =
arg_sfence_vma *a)
> > >  static bool trans_hfence_bvma(DisasContext *ctx, arg_sfence_vma *a)
> > >  {
> > >  #ifndef CONFIG_USER_ONLY
> > > -    if (ctx->priv_ver >=3D PRIV_VERSION_1_10_0 &&
> > > -        has_ext(ctx, RVH)) {
> > > +    if (has_ext(ctx, RVH)) {
> > >          /* Hpervisor extensions exist */
> > >          /*
> > >           * if (env->priv =3D=3D PRV_M ||
> > > diff --git a/target/riscv/monitor.c b/target/riscv/monitor.c
> > > index d725a7a36e..b569f08387 100644
> > > --- a/target/riscv/monitor.c
> > > +++ b/target/riscv/monitor.c
> > > @@ -215,11 +215,6 @@ void hmp_info_mem(Monitor *mon, const QDict *qdi=
ct)
> > >          return;
> > >      }
> > >
> > > -    if (env->priv_ver < PRIV_VERSION_1_10_0) {
> > > -        monitor_printf(mon, "Privileged mode < 1.10 unsupported\n");
> > > -        return;
> > > -    }
> > > -
> > >      if (!(env->satp & SATP_MODE)) {
> > >          monitor_printf(mon, "No translation or protection\n");
> > >          return;
> > > diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
> > > index c6412f680c..b0c49efc4a 100644
> > > --- a/target/riscv/op_helper.c
> > > +++ b/target/riscv/op_helper.c
> > > @@ -84,8 +84,7 @@ target_ulong helper_sret(CPURISCVState *env, target=
_ulong cpu_pc_deb)
> > >          riscv_raise_exception(env, RISCV_EXCP_INST_ADDR_MIS, GETPC()=
);
> > >      }
> > >
> > > -    if (env->priv_ver >=3D PRIV_VERSION_1_10_0 &&
> > > -        get_field(env->mstatus, MSTATUS_TSR) && !(env->priv >=3D PRV=
_M)) {
> > > +    if (get_field(env->mstatus, MSTATUS_TSR) && !(env->priv >=3D PRV=
_M)) {
> > >          riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC())=
;
> > >      }
> > >
> > > @@ -119,10 +118,8 @@ target_ulong helper_sret(CPURISCVState *env, tar=
get_ulong cpu_pc_deb)
> > >      } else {
> > >          prev_priv =3D get_field(mstatus, MSTATUS_SPP);
> > >
> > > -        mstatus =3D set_field(mstatus,
> > > -            env->priv_ver >=3D PRIV_VERSION_1_10_0 ?
> > > -            MSTATUS_SIE : MSTATUS_UIE << prev_priv,
> > > -            get_field(mstatus, MSTATUS_SPIE));
> > > +        mstatus =3D set_field(mstatus, MSTATUS_SIE,
> > > +                            get_field(mstatus, MSTATUS_SPIE));
> > >          mstatus =3D set_field(mstatus, MSTATUS_SPIE, 1);
> > >          mstatus =3D set_field(mstatus, MSTATUS_SPP, PRV_U);
> > >          env->mstatus =3D mstatus;
> > > @@ -147,10 +144,8 @@ target_ulong helper_mret(CPURISCVState *env, tar=
get_ulong cpu_pc_deb)
> > >      target_ulong mstatus =3D env->mstatus;
> > >      target_ulong prev_priv =3D get_field(mstatus, MSTATUS_MPP);
> > >      target_ulong prev_virt =3D MSTATUS_MPV_ISSET(env);
> > > -    mstatus =3D set_field(mstatus,
> > > -        env->priv_ver >=3D PRIV_VERSION_1_10_0 ?
> > > -        MSTATUS_MIE : MSTATUS_UIE << prev_priv,
> > > -        get_field(mstatus, MSTATUS_MPIE));
> > > +    mstatus =3D set_field(mstatus, MSTATUS_MIE,
> > > +                        get_field(mstatus, MSTATUS_MPIE));
> > >      mstatus =3D set_field(mstatus, MSTATUS_MPIE, 1);
> > >      mstatus =3D set_field(mstatus, MSTATUS_MPP, PRV_U);
> > >  #ifdef TARGET_RISCV32
> > > @@ -177,7 +172,6 @@ void helper_wfi(CPURISCVState *env)
> > >      CPUState *cs =3D env_cpu(env);
> > >
> > >      if ((env->priv =3D=3D PRV_S &&
> > > -        env->priv_ver >=3D PRIV_VERSION_1_10_0 &&
> > >          get_field(env->mstatus, MSTATUS_TW)) ||
> > >          riscv_cpu_virt_enabled(env)) {
> > >          riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC())=
;
> > > @@ -193,7 +187,6 @@ void helper_tlb_flush(CPURISCVState *env)
> > >      CPUState *cs =3D env_cpu(env);
> > >      if (!(env->priv >=3D PRV_S) ||
> > >          (env->priv =3D=3D PRV_S &&
> > > -         env->priv_ver >=3D PRIV_VERSION_1_10_0 &&
> > >           get_field(env->mstatus, MSTATUS_TVM))) {
> > >          riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC())=
;
> > >      } else {
> > > --
> > > 2.26.2
> > >
> > >

