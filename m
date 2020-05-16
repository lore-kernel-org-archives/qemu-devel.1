Return-Path: <SRS0=I9ML=66=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6695DC433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2020 09:04:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 268B320728
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2020 09:04:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q1dC006U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 268B320728
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43096 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZsjo-0007aH-9p
	for qemu-devel@archiver.kernel.org; Sat, 16 May 2020 05:04:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56386)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jZsj6-00078y-SO; Sat, 16 May 2020 05:03:24 -0400
Received: from mail-yb1-xb44.google.com ([2607:f8b0:4864:20::b44]:42749)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jZsj3-000742-Li; Sat, 16 May 2020 05:03:24 -0400
Received: by mail-yb1-xb44.google.com with SMTP id i16so2439876ybq.9;
 Sat, 16 May 2020 02:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=7gDfXY7+roULfpI+gdlhrS1+v3OswkESG8P3TB4WY6E=;
 b=Q1dC006URRFHJmZXQQQgLo4f1gtxp7myXOKwYyugTIh3eTs5ptScPoAeJ0pdwz24nz
 BiFAZMNGLtNJBLeZoi4r7FMl+Vb5Z0DrH16CyqLrUiIkT5Q1XPjH6AenpzGx3jn8YuFa
 j4jfv+arirhKfDmCMYRH+V5pXswEXNe3TDvCEy5N3Q8VTR7MFD1nSMJMgSa4IKaMolqX
 qPAFL+RMJF91+jBDfAeh62t339zbibEoGKb4GdqEOuq7ouJpud3dbJkSsu3yEYKmIF3t
 l6GMKM8bvFY2zT6cGOMEBAcSqm4RygXbo6oqjDuHpbcFt7OHjeh0/QkYvwARYQ7pqRa+
 RR9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=7gDfXY7+roULfpI+gdlhrS1+v3OswkESG8P3TB4WY6E=;
 b=leXABOgKGh3E8OAaRejL3az8fmneL9pDfuhBQQDO0eXQas07RIRlvKDqov6BAeAvio
 egtbxPBC9Of69rTLE2/AwNjza4eQdcrsZRvRTT+WsaQNZC69vbz+bw1CFi56LZihdD+1
 Ka6DNSOqe+eQELki2Ompt7mPRf2r67GdRYDEfNtZyxRpHpXcabgeYrwBztdSti6nRNMT
 OiNbcelUZ0euRvqqUxhS+pYIolFtDGGdGsHbLE1MGdM6GDgI0ROGy7xz++S/cFQBmFDB
 q/hEicWvgV6GflBXZ5hC1b4Mi87woLTt10nJ74cxmAyIyAtNdfTIUrMTW6UghQ6FFnLk
 BKiA==
X-Gm-Message-State: AOAM531ANzL99l90x8/DTWoZU3fi7h+wZU2/EUGpk9dGrBHfL08m6aYW
 o3/NxhMYu6gwu+dMPOt71NpSP5HwrHMGb6nlMnU=
X-Google-Smtp-Source: ABdhPJz/dvBesxt/8SqY7BNghK98mG5JGWr1TlQF9oQrFNJ7dPzFgEH7DC0nop8tMtB/1AF0661BxYGNkUlxVqm8F+0=
X-Received: by 2002:a25:bdc8:: with SMTP id g8mr11325839ybk.122.1589619799898; 
 Sat, 16 May 2020 02:03:19 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1588878756.git.alistair.francis@wdc.com>
 <44d0486b0fd156a756af544866dd7d19609b1aa6.1588878756.git.alistair.francis@wdc.com>
 <01168f32-c21c-b9fd-cb9c-06511e28bd20@redhat.com>
 <CAKmqyKMwdBmZ8kdi0xp0kJ1sPrWSGYZ304ZY8G+4xK9yYQ3VKg@mail.gmail.com>
 <CAEUhbmWWdDQfj8XBkWzDXkNdvcvEic8K23NuCpNyQdfxM4TxOg@mail.gmail.com>
 <CAKmqyKMOTnc9YX9adMyrQ5NnFZY5EZgyYYA_+23_ryWOtV92pQ@mail.gmail.com>
In-Reply-To: <CAKmqyKMOTnc9YX9adMyrQ5NnFZY5EZgyYYA_+23_ryWOtV92pQ@mail.gmail.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Sat, 16 May 2020 17:03:06 +0800
Message-ID: <CAEUhbmVu2=zCs8yOzH_wRMmtXDCA_b8pPFO4jQjnbh1iZvjUuQ@mail.gmail.com>
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

On Sat, May 16, 2020 at 3:51 AM Alistair Francis <alistair23@gmail.com> wro=
te:
>
> On Thu, May 14, 2020 at 9:54 PM Bin Meng <bmeng.cn@gmail.com> wrote:
> >
> > On Fri, May 15, 2020 at 5:51 AM Alistair Francis <alistair23@gmail.com>=
 wrote:
> > >
> > > On Thu, May 14, 2020 at 10:54 AM Philippe Mathieu-Daud=C3=A9
> > > <philmd@redhat.com> wrote:
> > > >
> > > > On 5/7/20 9:13 PM, Alistair Francis wrote:
> > > > > If the reset vector is set in the init function don't set it agai=
n in
> > > > > realise.
> > > >
> > > > typo "realize".
> > >
> > > It's not a typo, just correct English :)
> > >
> > > I have changed it.
> > >
> > > >
> > > > >
> > > > > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > > > > ---
> > > > >   target/riscv/cpu.c | 20 +++++++++++---------
> > > > >   1 file changed, 11 insertions(+), 9 deletions(-)
> > > > >
> > > > > diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> > > > > index 059d71f2c7..8f837edf8d 100644
> > > > > --- a/target/riscv/cpu.c
> > > > > +++ b/target/riscv/cpu.c
> > > > > @@ -111,6 +111,14 @@ static void set_feature(CPURISCVState *env, =
int feature)
> > > > >       env->features |=3D (1ULL << feature);
> > > > >   }
> > > > >
> > > > > +static int get_resetvec(CPURISCVState *env)
> > > > > +{
> > > > > +#ifndef CONFIG_USER_ONLY
> > > > > +    return env->resetvec;
> > > > > +#endif
> > > > > +    return 0;
> > > >
> > > > Don't you get an error about double return? Maybe use #else?
> > >
> > > Apparently not, I have changed it though.
> > >
> > > Alistair
> > >
> > > >
> > > > > +}
> > > > > +
> > > > >   static void set_resetvec(CPURISCVState *env, int resetvec)
> > > > >   {
> > > > >   #ifndef CONFIG_USER_ONLY
> > > > > @@ -123,7 +131,6 @@ static void riscv_any_cpu_init(Object *obj)
> > > > >       CPURISCVState *env =3D &RISCV_CPU(obj)->env;
> > > > >       set_misa(env, RVXLEN | RVI | RVM | RVA | RVF | RVD | RVC | =
RVU);
> > > > >       set_priv_version(env, PRIV_VERSION_1_11_0);
> > > > > -    set_resetvec(env, DEFAULT_RSTVEC);
> > > > >   }
> > > > >
> > > > >   #if defined(TARGET_RISCV32)
> > > > > @@ -140,7 +147,6 @@ static void rv32gcsu_priv1_09_1_cpu_init(Obje=
ct *obj)
> > > > >       CPURISCVState *env =3D &RISCV_CPU(obj)->env;
> > > > >       set_misa(env, RV32 | RVI | RVM | RVA | RVF | RVD | RVC | RV=
S | RVU);
> > > > >       set_priv_version(env, PRIV_VERSION_1_09_1);
> > > > > -    set_resetvec(env, DEFAULT_RSTVEC);
> > > > >       set_feature(env, RISCV_FEATURE_MMU);
> > > > >       set_feature(env, RISCV_FEATURE_PMP);
> > > > >   }
> > > > > @@ -150,7 +156,6 @@ static void rv32gcsu_priv1_10_0_cpu_init(Obje=
ct *obj)
> > > > >       CPURISCVState *env =3D &RISCV_CPU(obj)->env;
> > > > >       set_misa(env, RV32 | RVI | RVM | RVA | RVF | RVD | RVC | RV=
S | RVU);
> > > > >       set_priv_version(env, PRIV_VERSION_1_10_0);
> > > > > -    set_resetvec(env, DEFAULT_RSTVEC);
> > > > >       set_feature(env, RISCV_FEATURE_MMU);
> > > > >       set_feature(env, RISCV_FEATURE_PMP);
> > > > >   }
> > > > > @@ -160,7 +165,6 @@ static void rv32imacu_nommu_cpu_init(Object *=
obj)
> > > > >       CPURISCVState *env =3D &RISCV_CPU(obj)->env;
> > > > >       set_misa(env, RV32 | RVI | RVM | RVA | RVC | RVU);
> > > > >       set_priv_version(env, PRIV_VERSION_1_10_0);
> > > > > -    set_resetvec(env, DEFAULT_RSTVEC);
> > > > >       set_feature(env, RISCV_FEATURE_PMP);
> > > > >   }
> > > > >
> > > > > @@ -169,7 +173,6 @@ static void rv32imafcu_nommu_cpu_init(Object =
*obj)
> > > > >       CPURISCVState *env =3D &RISCV_CPU(obj)->env;
> > > > >       set_misa(env, RV32 | RVI | RVM | RVA | RVF | RVC | RVU);
> > > > >       set_priv_version(env, PRIV_VERSION_1_10_0);
> > > > > -    set_resetvec(env, DEFAULT_RSTVEC);
> > > > >       set_feature(env, RISCV_FEATURE_PMP);
> > > > >   }
> > > > >
> > > > > @@ -187,7 +190,6 @@ static void rv64gcsu_priv1_09_1_cpu_init(Obje=
ct *obj)
> > > > >       CPURISCVState *env =3D &RISCV_CPU(obj)->env;
> > > > >       set_misa(env, RV64 | RVI | RVM | RVA | RVF | RVD | RVC | RV=
S | RVU);
> > > > >       set_priv_version(env, PRIV_VERSION_1_09_1);
> > > > > -    set_resetvec(env, DEFAULT_RSTVEC);
> > > > >       set_feature(env, RISCV_FEATURE_MMU);
> > > > >       set_feature(env, RISCV_FEATURE_PMP);
> > > > >   }
> > > > > @@ -197,7 +199,6 @@ static void rv64gcsu_priv1_10_0_cpu_init(Obje=
ct *obj)
> > > > >       CPURISCVState *env =3D &RISCV_CPU(obj)->env;
> > > > >       set_misa(env, RV64 | RVI | RVM | RVA | RVF | RVD | RVC | RV=
S | RVU);
> > > > >       set_priv_version(env, PRIV_VERSION_1_10_0);
> > > > > -    set_resetvec(env, DEFAULT_RSTVEC);
> > > > >       set_feature(env, RISCV_FEATURE_MMU);
> > > > >       set_feature(env, RISCV_FEATURE_PMP);
> > > > >   }
> > > > > @@ -207,7 +208,6 @@ static void rv64imacu_nommu_cpu_init(Object *=
obj)
> > > > >       CPURISCVState *env =3D &RISCV_CPU(obj)->env;
> > > > >       set_misa(env, RV64 | RVI | RVM | RVA | RVC | RVU);
> > > > >       set_priv_version(env, PRIV_VERSION_1_10_0);
> > > > > -    set_resetvec(env, DEFAULT_RSTVEC);
> > > > >       set_feature(env, RISCV_FEATURE_PMP);
> > > > >   }
> > > > >
> > > > > @@ -399,7 +399,9 @@ static void riscv_cpu_realize(DeviceState *de=
v, Error **errp)
> > > > >       }
> > > > >
> > > > >       set_priv_version(env, priv_version);
> > > > > -    set_resetvec(env, DEFAULT_RSTVEC);
> > > > > +    if (!get_resetvec(env)) {
> >
> > What if we have a RISC-V CPU whose reset vector is at address 0?
>
> That won't work then. I think if that happens we could swap to a
> negative number.
>

env->resetvec is declared as target_ulong so negative number does not work =
here.

How about just remove set_resetvec() in riscv_cpu_realize()? Or
introduce a new config parameter for the reset vector, and only
override it if the config parameter is given, like other properties?

Regards,
Bin

