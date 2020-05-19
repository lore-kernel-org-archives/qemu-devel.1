Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C395C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 18:14:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F29F20674
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 18:14:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cd/U7bfn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F29F20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33438 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jb6ke-0002k0-Bg
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 14:14:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40768)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jb6jX-0001tH-0E; Tue, 19 May 2020 14:12:55 -0400
Received: from mail-il1-x144.google.com ([2607:f8b0:4864:20::144]:43041)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jb6jV-0006Yc-Tq; Tue, 19 May 2020 14:12:54 -0400
Received: by mail-il1-x144.google.com with SMTP id l20so293367ilj.10;
 Tue, 19 May 2020 11:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=kFBrO/aduvO08L5IUBv7D6z+S+KxKKSmqO9l2X1uVg0=;
 b=Cd/U7bfne+pGeSwQFEMUXxwD/rE2yKRzCLm6D3JoER1dpMpCROQIlBF5ZrCSkj4JUf
 +84XLNdhkmn4dHJXca/n76y6k1jRzWMmdveMcOLpHEF/vPUtchhLCwu7IitbcLDjxaXM
 AEhdfc+yOBIC1hOnLhcsT1gxBuNgBdI6rTEHTGmCEtoMsgYkwnJtPlVQsmdknurai9w4
 AvNsv9Aht86CJyNXA32mnWVRIMcHyLAbNHbAKbiDBMx3PPFs1PCY5pQASk76A0747gE6
 W1x2LfwpRajdci3WQPF2ID/sJiTTXUU4y+yD/OAyiiVJs07poSrSep1f2b68rlPPN5LY
 xu2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=kFBrO/aduvO08L5IUBv7D6z+S+KxKKSmqO9l2X1uVg0=;
 b=FDHOKdl5mbbTgFCd9TUdJ38cP5DAUkl9JuCr1WyvtyqYSjKOAN4NAAOsNC4TIkEzPG
 jFt/0TTzVHeulH9VfIMuS7zmFA9CJz+l9FXPYGKvyqdLVbhLARdxanPyXqLLYeMguRBT
 c+ydRJgTKmvHhwARPuGYmhAqZpa1u87bcNQE/7CgACTGs3zWR6iwvuqsPCJ6VNnjlmv4
 2dW9onpIO24FyhflN61t2hB3hhLG4d04CtDEGyAn+zgLD25k9l0yhwMNKLqDDE+yTwAn
 vIDMrSSxo/jMB8kqIp6/rw5Pi/sJHlRXSLEjme2Hif55+bv+MuaJE3hndeU9R0F22ytW
 WT1A==
X-Gm-Message-State: AOAM533fWV2GH7jG5NoKV1G2ILkdT/RUFZi3gI3/pzKER7/t3bFnEDn9
 WEHa1xbgPsYCQg3QLQdzWETAtp85v9c5i1jcT+c=
X-Google-Smtp-Source: ABdhPJzfrzPNp9h8Or495buceQ9D4QfFZcdkFMTC1Ym9L3GdHOEYO89cJJ4vcQAGEv1WILqMV2fEfJs/Dg5IlQ17TYk=
X-Received: by 2002:a92:48d1:: with SMTP id j78mr250749ilg.131.1589911972040; 
 Tue, 19 May 2020 11:12:52 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1588878756.git.alistair.francis@wdc.com>
 <44d0486b0fd156a756af544866dd7d19609b1aa6.1588878756.git.alistair.francis@wdc.com>
 <01168f32-c21c-b9fd-cb9c-06511e28bd20@redhat.com>
 <CAKmqyKMwdBmZ8kdi0xp0kJ1sPrWSGYZ304ZY8G+4xK9yYQ3VKg@mail.gmail.com>
 <CAEUhbmWWdDQfj8XBkWzDXkNdvcvEic8K23NuCpNyQdfxM4TxOg@mail.gmail.com>
 <CAKmqyKMOTnc9YX9adMyrQ5NnFZY5EZgyYYA_+23_ryWOtV92pQ@mail.gmail.com>
 <CAEUhbmVu2=zCs8yOzH_wRMmtXDCA_b8pPFO4jQjnbh1iZvjUuQ@mail.gmail.com>
In-Reply-To: <CAEUhbmVu2=zCs8yOzH_wRMmtXDCA_b8pPFO4jQjnbh1iZvjUuQ@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 19 May 2020 11:03:59 -0700
Message-ID: <CAKmqyKMMiQES-60C8y4QSfeQk8Gg-8ixOTw=PrRVWrWQPxVufw@mail.gmail.com>
Subject: Re: [PATCH v2 2/9] target/riscv: Don't overwrite the reset vector
To: Bin Meng <bmeng.cn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::144;
 envelope-from=alistair23@gmail.com; helo=mail-il1-x144.google.com
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
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, May 16, 2020 at 2:03 AM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> On Sat, May 16, 2020 at 3:51 AM Alistair Francis <alistair23@gmail.com> w=
rote:
> >
> > On Thu, May 14, 2020 at 9:54 PM Bin Meng <bmeng.cn@gmail.com> wrote:
> > >
> > > On Fri, May 15, 2020 at 5:51 AM Alistair Francis <alistair23@gmail.co=
m> wrote:
> > > >
> > > > On Thu, May 14, 2020 at 10:54 AM Philippe Mathieu-Daud=C3=A9
> > > > <philmd@redhat.com> wrote:
> > > > >
> > > > > On 5/7/20 9:13 PM, Alistair Francis wrote:
> > > > > > If the reset vector is set in the init function don't set it ag=
ain in
> > > > > > realise.
> > > > >
> > > > > typo "realize".
> > > >
> > > > It's not a typo, just correct English :)
> > > >
> > > > I have changed it.
> > > >
> > > > >
> > > > > >
> > > > > > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > > > > > ---
> > > > > >   target/riscv/cpu.c | 20 +++++++++++---------
> > > > > >   1 file changed, 11 insertions(+), 9 deletions(-)
> > > > > >
> > > > > > diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> > > > > > index 059d71f2c7..8f837edf8d 100644
> > > > > > --- a/target/riscv/cpu.c
> > > > > > +++ b/target/riscv/cpu.c
> > > > > > @@ -111,6 +111,14 @@ static void set_feature(CPURISCVState *env=
, int feature)
> > > > > >       env->features |=3D (1ULL << feature);
> > > > > >   }
> > > > > >
> > > > > > +static int get_resetvec(CPURISCVState *env)
> > > > > > +{
> > > > > > +#ifndef CONFIG_USER_ONLY
> > > > > > +    return env->resetvec;
> > > > > > +#endif
> > > > > > +    return 0;
> > > > >
> > > > > Don't you get an error about double return? Maybe use #else?
> > > >
> > > > Apparently not, I have changed it though.
> > > >
> > > > Alistair
> > > >
> > > > >
> > > > > > +}
> > > > > > +
> > > > > >   static void set_resetvec(CPURISCVState *env, int resetvec)
> > > > > >   {
> > > > > >   #ifndef CONFIG_USER_ONLY
> > > > > > @@ -123,7 +131,6 @@ static void riscv_any_cpu_init(Object *obj)
> > > > > >       CPURISCVState *env =3D &RISCV_CPU(obj)->env;
> > > > > >       set_misa(env, RVXLEN | RVI | RVM | RVA | RVF | RVD | RVC =
| RVU);
> > > > > >       set_priv_version(env, PRIV_VERSION_1_11_0);
> > > > > > -    set_resetvec(env, DEFAULT_RSTVEC);
> > > > > >   }
> > > > > >
> > > > > >   #if defined(TARGET_RISCV32)
> > > > > > @@ -140,7 +147,6 @@ static void rv32gcsu_priv1_09_1_cpu_init(Ob=
ject *obj)
> > > > > >       CPURISCVState *env =3D &RISCV_CPU(obj)->env;
> > > > > >       set_misa(env, RV32 | RVI | RVM | RVA | RVF | RVD | RVC | =
RVS | RVU);
> > > > > >       set_priv_version(env, PRIV_VERSION_1_09_1);
> > > > > > -    set_resetvec(env, DEFAULT_RSTVEC);
> > > > > >       set_feature(env, RISCV_FEATURE_MMU);
> > > > > >       set_feature(env, RISCV_FEATURE_PMP);
> > > > > >   }
> > > > > > @@ -150,7 +156,6 @@ static void rv32gcsu_priv1_10_0_cpu_init(Ob=
ject *obj)
> > > > > >       CPURISCVState *env =3D &RISCV_CPU(obj)->env;
> > > > > >       set_misa(env, RV32 | RVI | RVM | RVA | RVF | RVD | RVC | =
RVS | RVU);
> > > > > >       set_priv_version(env, PRIV_VERSION_1_10_0);
> > > > > > -    set_resetvec(env, DEFAULT_RSTVEC);
> > > > > >       set_feature(env, RISCV_FEATURE_MMU);
> > > > > >       set_feature(env, RISCV_FEATURE_PMP);
> > > > > >   }
> > > > > > @@ -160,7 +165,6 @@ static void rv32imacu_nommu_cpu_init(Object=
 *obj)
> > > > > >       CPURISCVState *env =3D &RISCV_CPU(obj)->env;
> > > > > >       set_misa(env, RV32 | RVI | RVM | RVA | RVC | RVU);
> > > > > >       set_priv_version(env, PRIV_VERSION_1_10_0);
> > > > > > -    set_resetvec(env, DEFAULT_RSTVEC);
> > > > > >       set_feature(env, RISCV_FEATURE_PMP);
> > > > > >   }
> > > > > >
> > > > > > @@ -169,7 +173,6 @@ static void rv32imafcu_nommu_cpu_init(Objec=
t *obj)
> > > > > >       CPURISCVState *env =3D &RISCV_CPU(obj)->env;
> > > > > >       set_misa(env, RV32 | RVI | RVM | RVA | RVF | RVC | RVU);
> > > > > >       set_priv_version(env, PRIV_VERSION_1_10_0);
> > > > > > -    set_resetvec(env, DEFAULT_RSTVEC);
> > > > > >       set_feature(env, RISCV_FEATURE_PMP);
> > > > > >   }
> > > > > >
> > > > > > @@ -187,7 +190,6 @@ static void rv64gcsu_priv1_09_1_cpu_init(Ob=
ject *obj)
> > > > > >       CPURISCVState *env =3D &RISCV_CPU(obj)->env;
> > > > > >       set_misa(env, RV64 | RVI | RVM | RVA | RVF | RVD | RVC | =
RVS | RVU);
> > > > > >       set_priv_version(env, PRIV_VERSION_1_09_1);
> > > > > > -    set_resetvec(env, DEFAULT_RSTVEC);
> > > > > >       set_feature(env, RISCV_FEATURE_MMU);
> > > > > >       set_feature(env, RISCV_FEATURE_PMP);
> > > > > >   }
> > > > > > @@ -197,7 +199,6 @@ static void rv64gcsu_priv1_10_0_cpu_init(Ob=
ject *obj)
> > > > > >       CPURISCVState *env =3D &RISCV_CPU(obj)->env;
> > > > > >       set_misa(env, RV64 | RVI | RVM | RVA | RVF | RVD | RVC | =
RVS | RVU);
> > > > > >       set_priv_version(env, PRIV_VERSION_1_10_0);
> > > > > > -    set_resetvec(env, DEFAULT_RSTVEC);
> > > > > >       set_feature(env, RISCV_FEATURE_MMU);
> > > > > >       set_feature(env, RISCV_FEATURE_PMP);
> > > > > >   }
> > > > > > @@ -207,7 +208,6 @@ static void rv64imacu_nommu_cpu_init(Object=
 *obj)
> > > > > >       CPURISCVState *env =3D &RISCV_CPU(obj)->env;
> > > > > >       set_misa(env, RV64 | RVI | RVM | RVA | RVC | RVU);
> > > > > >       set_priv_version(env, PRIV_VERSION_1_10_0);
> > > > > > -    set_resetvec(env, DEFAULT_RSTVEC);
> > > > > >       set_feature(env, RISCV_FEATURE_PMP);
> > > > > >   }
> > > > > >
> > > > > > @@ -399,7 +399,9 @@ static void riscv_cpu_realize(DeviceState *=
dev, Error **errp)
> > > > > >       }
> > > > > >
> > > > > >       set_priv_version(env, priv_version);
> > > > > > -    set_resetvec(env, DEFAULT_RSTVEC);
> > > > > > +    if (!get_resetvec(env)) {
> > >
> > > What if we have a RISC-V CPU whose reset vector is at address 0?
> >
> > That won't work then. I think if that happens we could swap to a
> > negative number.
> >
>
> env->resetvec is declared as target_ulong so negative number does not wor=
k here.
>
> How about just remove set_resetvec() in riscv_cpu_realize()? Or
> introduce a new config parameter for the reset vector, and only
> override it if the config parameter is given, like other properties?

We need to set the default reset veector though. I can just set all of
the values in the init function instead.

Alistair

>
> Regards,
> Bin

