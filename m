Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D014C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 04:55:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32D31206F1
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 04:55:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sQUf3pKU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32D31206F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55892 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZSNI-0000md-Bk
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 00:55:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44294)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jZSMi-0008Tw-Jz; Fri, 15 May 2020 00:54:32 -0400
Received: from mail-yb1-xb44.google.com ([2607:f8b0:4864:20::b44]:44370)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jZSMf-0003uT-S7; Fri, 15 May 2020 00:54:32 -0400
Received: by mail-yb1-xb44.google.com with SMTP id o8so468580ybc.11;
 Thu, 14 May 2020 21:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=SD7o7U8HqfVKgwLHVAmgbyTHSbcH1rfyg+2OL0gKPBA=;
 b=sQUf3pKUotkzVJ+JQeNNazmLENU4LSdEHCK8yNfL/fk5vVz/RmB06+X38yvmW9Fsx4
 zAIe30XYx0zTlFhOQiNHfYNArLqrn+vO9UFf6JXzPvDynifl+lFNtX0DbiTuHn4v5sUp
 dHhnIINc0XfVkEXRfIHe+VoCBdeFAfcbHvExMD87awOt1rmCIvvbWsTMpDKFO0kQv6+F
 +TxIQmeWLlqYmN/HjqPzeNSvAPZoiLzCRhqvT/XHD3ZSDBf32+dl7NBVuSxLrjghLGIF
 EhS/KLpAcjxAspJfTwB0sr24KFNeA7bx4CxRT3KiK5kaWax3LC1YS2Uqmy4BzTdQRJ9A
 yUNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=SD7o7U8HqfVKgwLHVAmgbyTHSbcH1rfyg+2OL0gKPBA=;
 b=lkVhpzbsy00jdI2JIJ+ZmVZBf3CKL2Tjxia7qj8trijTH+7c958G5RX2TpLSNS12Ro
 uye9HpVCUYzLcw4uRpN+lF/zKCJrCRaMQx3QLjwZzLnJE11T6CNxx4DXT4gjVnFPAGnB
 2gTZOCdJmz7Klx+34r/B0mgb0tYofAeR2111Cn6BC1sF3CQnZX+QAPK2IQXPvVOQImFA
 n6an2eRQMVP7m6+osEYoBPkCWeSN+yPG3hV7aImy0ZR5BGf3OprXQgGI8Dq1w07yVK6c
 LlwutsehGiEafiC29UPIaON3ZE7OirpkYIVneC7UCL+sBK4gsl4vVzX/TVLTM+f8WB76
 38aw==
X-Gm-Message-State: AOAM5315kTXZ4mf4rYisfuPcIR4bfGtoRM209qdoAQi51WL2DkKhT41Z
 OWWIFeWa45TY0YcLR38b1J69Q5XDo/B8oHPK4bQ=
X-Google-Smtp-Source: ABdhPJy4FrMTgUZOgVi22K48SVlfsJCdMVN1l4UcEO0YVyAkxR9LU4zUgyoByXgd643sRevx6lg+o+pHpGWQxzynsR4=
X-Received: by 2002:a25:c68e:: with SMTP id k136mr589428ybf.517.1589518467329; 
 Thu, 14 May 2020 21:54:27 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1588878756.git.alistair.francis@wdc.com>
 <44d0486b0fd156a756af544866dd7d19609b1aa6.1588878756.git.alistair.francis@wdc.com>
 <01168f32-c21c-b9fd-cb9c-06511e28bd20@redhat.com>
 <CAKmqyKMwdBmZ8kdi0xp0kJ1sPrWSGYZ304ZY8G+4xK9yYQ3VKg@mail.gmail.com>
In-Reply-To: <CAKmqyKMwdBmZ8kdi0xp0kJ1sPrWSGYZ304ZY8G+4xK9yYQ3VKg@mail.gmail.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Fri, 15 May 2020 12:54:14 +0800
Message-ID: <CAEUhbmWWdDQfj8XBkWzDXkNdvcvEic8K23NuCpNyQdfxM4TxOg@mail.gmail.com>
Subject: Re: [PATCH v2 2/9] target/riscv: Don't overwrite the reset vector
To: Alistair Francis <alistair23@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b44;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yb1-xb44.google.com
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
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, May 15, 2020 at 5:51 AM Alistair Francis <alistair23@gmail.com> wro=
te:
>
> On Thu, May 14, 2020 at 10:54 AM Philippe Mathieu-Daud=C3=A9
> <philmd@redhat.com> wrote:
> >
> > On 5/7/20 9:13 PM, Alistair Francis wrote:
> > > If the reset vector is set in the init function don't set it again in
> > > realise.
> >
> > typo "realize".
>
> It's not a typo, just correct English :)
>
> I have changed it.
>
> >
> > >
> > > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > > ---
> > >   target/riscv/cpu.c | 20 +++++++++++---------
> > >   1 file changed, 11 insertions(+), 9 deletions(-)
> > >
> > > diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> > > index 059d71f2c7..8f837edf8d 100644
> > > --- a/target/riscv/cpu.c
> > > +++ b/target/riscv/cpu.c
> > > @@ -111,6 +111,14 @@ static void set_feature(CPURISCVState *env, int =
feature)
> > >       env->features |=3D (1ULL << feature);
> > >   }
> > >
> > > +static int get_resetvec(CPURISCVState *env)
> > > +{
> > > +#ifndef CONFIG_USER_ONLY
> > > +    return env->resetvec;
> > > +#endif
> > > +    return 0;
> >
> > Don't you get an error about double return? Maybe use #else?
>
> Apparently not, I have changed it though.
>
> Alistair
>
> >
> > > +}
> > > +
> > >   static void set_resetvec(CPURISCVState *env, int resetvec)
> > >   {
> > >   #ifndef CONFIG_USER_ONLY
> > > @@ -123,7 +131,6 @@ static void riscv_any_cpu_init(Object *obj)
> > >       CPURISCVState *env =3D &RISCV_CPU(obj)->env;
> > >       set_misa(env, RVXLEN | RVI | RVM | RVA | RVF | RVD | RVC | RVU)=
;
> > >       set_priv_version(env, PRIV_VERSION_1_11_0);
> > > -    set_resetvec(env, DEFAULT_RSTVEC);
> > >   }
> > >
> > >   #if defined(TARGET_RISCV32)
> > > @@ -140,7 +147,6 @@ static void rv32gcsu_priv1_09_1_cpu_init(Object *=
obj)
> > >       CPURISCVState *env =3D &RISCV_CPU(obj)->env;
> > >       set_misa(env, RV32 | RVI | RVM | RVA | RVF | RVD | RVC | RVS | =
RVU);
> > >       set_priv_version(env, PRIV_VERSION_1_09_1);
> > > -    set_resetvec(env, DEFAULT_RSTVEC);
> > >       set_feature(env, RISCV_FEATURE_MMU);
> > >       set_feature(env, RISCV_FEATURE_PMP);
> > >   }
> > > @@ -150,7 +156,6 @@ static void rv32gcsu_priv1_10_0_cpu_init(Object *=
obj)
> > >       CPURISCVState *env =3D &RISCV_CPU(obj)->env;
> > >       set_misa(env, RV32 | RVI | RVM | RVA | RVF | RVD | RVC | RVS | =
RVU);
> > >       set_priv_version(env, PRIV_VERSION_1_10_0);
> > > -    set_resetvec(env, DEFAULT_RSTVEC);
> > >       set_feature(env, RISCV_FEATURE_MMU);
> > >       set_feature(env, RISCV_FEATURE_PMP);
> > >   }
> > > @@ -160,7 +165,6 @@ static void rv32imacu_nommu_cpu_init(Object *obj)
> > >       CPURISCVState *env =3D &RISCV_CPU(obj)->env;
> > >       set_misa(env, RV32 | RVI | RVM | RVA | RVC | RVU);
> > >       set_priv_version(env, PRIV_VERSION_1_10_0);
> > > -    set_resetvec(env, DEFAULT_RSTVEC);
> > >       set_feature(env, RISCV_FEATURE_PMP);
> > >   }
> > >
> > > @@ -169,7 +173,6 @@ static void rv32imafcu_nommu_cpu_init(Object *obj=
)
> > >       CPURISCVState *env =3D &RISCV_CPU(obj)->env;
> > >       set_misa(env, RV32 | RVI | RVM | RVA | RVF | RVC | RVU);
> > >       set_priv_version(env, PRIV_VERSION_1_10_0);
> > > -    set_resetvec(env, DEFAULT_RSTVEC);
> > >       set_feature(env, RISCV_FEATURE_PMP);
> > >   }
> > >
> > > @@ -187,7 +190,6 @@ static void rv64gcsu_priv1_09_1_cpu_init(Object *=
obj)
> > >       CPURISCVState *env =3D &RISCV_CPU(obj)->env;
> > >       set_misa(env, RV64 | RVI | RVM | RVA | RVF | RVD | RVC | RVS | =
RVU);
> > >       set_priv_version(env, PRIV_VERSION_1_09_1);
> > > -    set_resetvec(env, DEFAULT_RSTVEC);
> > >       set_feature(env, RISCV_FEATURE_MMU);
> > >       set_feature(env, RISCV_FEATURE_PMP);
> > >   }
> > > @@ -197,7 +199,6 @@ static void rv64gcsu_priv1_10_0_cpu_init(Object *=
obj)
> > >       CPURISCVState *env =3D &RISCV_CPU(obj)->env;
> > >       set_misa(env, RV64 | RVI | RVM | RVA | RVF | RVD | RVC | RVS | =
RVU);
> > >       set_priv_version(env, PRIV_VERSION_1_10_0);
> > > -    set_resetvec(env, DEFAULT_RSTVEC);
> > >       set_feature(env, RISCV_FEATURE_MMU);
> > >       set_feature(env, RISCV_FEATURE_PMP);
> > >   }
> > > @@ -207,7 +208,6 @@ static void rv64imacu_nommu_cpu_init(Object *obj)
> > >       CPURISCVState *env =3D &RISCV_CPU(obj)->env;
> > >       set_misa(env, RV64 | RVI | RVM | RVA | RVC | RVU);
> > >       set_priv_version(env, PRIV_VERSION_1_10_0);
> > > -    set_resetvec(env, DEFAULT_RSTVEC);
> > >       set_feature(env, RISCV_FEATURE_PMP);
> > >   }
> > >
> > > @@ -399,7 +399,9 @@ static void riscv_cpu_realize(DeviceState *dev, E=
rror **errp)
> > >       }
> > >
> > >       set_priv_version(env, priv_version);
> > > -    set_resetvec(env, DEFAULT_RSTVEC);
> > > +    if (!get_resetvec(env)) {

What if we have a RISC-V CPU whose reset vector is at address 0?

> > > +        set_resetvec(env, DEFAULT_RSTVEC);
> > > +    }
> > >
> > >       if (cpu->cfg.mmu) {
> > >           set_feature(env, RISCV_FEATURE_MMU);
> > >

Regards,
Bin

