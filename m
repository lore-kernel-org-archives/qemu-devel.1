Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E8B8C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 19:53:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDD2B20727
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 19:53:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y13T5NW2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDD2B20727
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40564 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZgOS-0007KR-Q4
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 15:53:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33482)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jZgNB-0005vp-KY; Fri, 15 May 2020 15:51:58 -0400
Received: from mail-io1-xd42.google.com ([2607:f8b0:4864:20::d42]:43103)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jZgN9-0006jV-AE; Fri, 15 May 2020 15:51:57 -0400
Received: by mail-io1-xd42.google.com with SMTP id h10so3993471iob.10;
 Fri, 15 May 2020 12:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=MNmWg2t7KThVT+pKhitNSuNJd3D9L1f+N1L6AiQvDPI=;
 b=Y13T5NW2U88CMWQwWA1KoR0AM6kANNjm9SwtABV4+aEXnXa5d7GsU1wWEIsTsES/P5
 MYMEOGL20w8g9GnboEQi6OjJyR/XonnmF3E12+z+ptvN2u+itOQRVwuTd6ftcJ0dVFKn
 AT4Wj1CUrGus/rZrVSRLmLX25YWKsYPpLb+3LQ1XXQWyp0qwmUnN82y2B4a9TbEDfPht
 +p6nKbfmi3OUVDkGNXYyjMDO5bFy5FOQfneNgGUTXW9AYEc8v21Que72iH+YZlw6OR4N
 PibInbqWhP0XnA2MC5UV8LnYRTdf54RRWcWJMFI/8XIKLSCmFyz1WEEEJMat9OsD+AhW
 3vKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=MNmWg2t7KThVT+pKhitNSuNJd3D9L1f+N1L6AiQvDPI=;
 b=IqfWhBH3euYEvolChWUtAAmL/RbFvq5N/UehF1NfFddAT2jclFjDWbvX8aCYpo6ciJ
 Yji/aP2pFKMYmJfF/ohYcxb98ZbGKaiY9SHxhrjUsyEFeekDjkDa+ofK3v3XqPj/u6ox
 lN05FsddjwKZpLjHVZbDqaP7bHRpzmhUyN14+Skwt4HKuYsj05ZDU3ESteGgQfDOilBs
 WbDA0hufexd0fDgk7HIJZEDk6dskZpdczCCgy4haxdOtwxGTT1M0ELLJayWnSY0t4rAc
 UPP73LtyWG8tgdEZSncQk3gTzxV7YSBu6ZpeLF0WtwSOy8EC1tEodqeF8/OKhF1llk6N
 3ySw==
X-Gm-Message-State: AOAM531LaOXvlOECDmoJpIKgQaiyjEVQfzozjty/gaHHL5KGn4DGsvpL
 KTbXLL5AcXEimf+yDn47w60YrdNlacU9Q+vHQCw=
X-Google-Smtp-Source: ABdhPJxwhYJvIlkb+94asoeaAkykxLDniZq8oefc7EEAr9e0Or6ynYqz3i5GPnFuCH6rTKR62gz++JmqIb/4fByQTiw=
X-Received: by 2002:a6b:bf83:: with SMTP id p125mr4491555iof.118.1589572313830; 
 Fri, 15 May 2020 12:51:53 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1588878756.git.alistair.francis@wdc.com>
 <44d0486b0fd156a756af544866dd7d19609b1aa6.1588878756.git.alistair.francis@wdc.com>
 <01168f32-c21c-b9fd-cb9c-06511e28bd20@redhat.com>
 <CAKmqyKMwdBmZ8kdi0xp0kJ1sPrWSGYZ304ZY8G+4xK9yYQ3VKg@mail.gmail.com>
 <CAEUhbmWWdDQfj8XBkWzDXkNdvcvEic8K23NuCpNyQdfxM4TxOg@mail.gmail.com>
In-Reply-To: <CAEUhbmWWdDQfj8XBkWzDXkNdvcvEic8K23NuCpNyQdfxM4TxOg@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 15 May 2020 12:43:04 -0700
Message-ID: <CAKmqyKMOTnc9YX9adMyrQ5NnFZY5EZgyYYA_+23_ryWOtV92pQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/9] target/riscv: Don't overwrite the reset vector
To: Bin Meng <bmeng.cn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::d42;
 envelope-from=alistair23@gmail.com; helo=mail-io1-xd42.google.com
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

On Thu, May 14, 2020 at 9:54 PM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> On Fri, May 15, 2020 at 5:51 AM Alistair Francis <alistair23@gmail.com> w=
rote:
> >
> > On Thu, May 14, 2020 at 10:54 AM Philippe Mathieu-Daud=C3=A9
> > <philmd@redhat.com> wrote:
> > >
> > > On 5/7/20 9:13 PM, Alistair Francis wrote:
> > > > If the reset vector is set in the init function don't set it again =
in
> > > > realise.
> > >
> > > typo "realize".
> >
> > It's not a typo, just correct English :)
> >
> > I have changed it.
> >
> > >
> > > >
> > > > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > > > ---
> > > >   target/riscv/cpu.c | 20 +++++++++++---------
> > > >   1 file changed, 11 insertions(+), 9 deletions(-)
> > > >
> > > > diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> > > > index 059d71f2c7..8f837edf8d 100644
> > > > --- a/target/riscv/cpu.c
> > > > +++ b/target/riscv/cpu.c
> > > > @@ -111,6 +111,14 @@ static void set_feature(CPURISCVState *env, in=
t feature)
> > > >       env->features |=3D (1ULL << feature);
> > > >   }
> > > >
> > > > +static int get_resetvec(CPURISCVState *env)
> > > > +{
> > > > +#ifndef CONFIG_USER_ONLY
> > > > +    return env->resetvec;
> > > > +#endif
> > > > +    return 0;
> > >
> > > Don't you get an error about double return? Maybe use #else?
> >
> > Apparently not, I have changed it though.
> >
> > Alistair
> >
> > >
> > > > +}
> > > > +
> > > >   static void set_resetvec(CPURISCVState *env, int resetvec)
> > > >   {
> > > >   #ifndef CONFIG_USER_ONLY
> > > > @@ -123,7 +131,6 @@ static void riscv_any_cpu_init(Object *obj)
> > > >       CPURISCVState *env =3D &RISCV_CPU(obj)->env;
> > > >       set_misa(env, RVXLEN | RVI | RVM | RVA | RVF | RVD | RVC | RV=
U);
> > > >       set_priv_version(env, PRIV_VERSION_1_11_0);
> > > > -    set_resetvec(env, DEFAULT_RSTVEC);
> > > >   }
> > > >
> > > >   #if defined(TARGET_RISCV32)
> > > > @@ -140,7 +147,6 @@ static void rv32gcsu_priv1_09_1_cpu_init(Object=
 *obj)
> > > >       CPURISCVState *env =3D &RISCV_CPU(obj)->env;
> > > >       set_misa(env, RV32 | RVI | RVM | RVA | RVF | RVD | RVC | RVS =
| RVU);
> > > >       set_priv_version(env, PRIV_VERSION_1_09_1);
> > > > -    set_resetvec(env, DEFAULT_RSTVEC);
> > > >       set_feature(env, RISCV_FEATURE_MMU);
> > > >       set_feature(env, RISCV_FEATURE_PMP);
> > > >   }
> > > > @@ -150,7 +156,6 @@ static void rv32gcsu_priv1_10_0_cpu_init(Object=
 *obj)
> > > >       CPURISCVState *env =3D &RISCV_CPU(obj)->env;
> > > >       set_misa(env, RV32 | RVI | RVM | RVA | RVF | RVD | RVC | RVS =
| RVU);
> > > >       set_priv_version(env, PRIV_VERSION_1_10_0);
> > > > -    set_resetvec(env, DEFAULT_RSTVEC);
> > > >       set_feature(env, RISCV_FEATURE_MMU);
> > > >       set_feature(env, RISCV_FEATURE_PMP);
> > > >   }
> > > > @@ -160,7 +165,6 @@ static void rv32imacu_nommu_cpu_init(Object *ob=
j)
> > > >       CPURISCVState *env =3D &RISCV_CPU(obj)->env;
> > > >       set_misa(env, RV32 | RVI | RVM | RVA | RVC | RVU);
> > > >       set_priv_version(env, PRIV_VERSION_1_10_0);
> > > > -    set_resetvec(env, DEFAULT_RSTVEC);
> > > >       set_feature(env, RISCV_FEATURE_PMP);
> > > >   }
> > > >
> > > > @@ -169,7 +173,6 @@ static void rv32imafcu_nommu_cpu_init(Object *o=
bj)
> > > >       CPURISCVState *env =3D &RISCV_CPU(obj)->env;
> > > >       set_misa(env, RV32 | RVI | RVM | RVA | RVF | RVC | RVU);
> > > >       set_priv_version(env, PRIV_VERSION_1_10_0);
> > > > -    set_resetvec(env, DEFAULT_RSTVEC);
> > > >       set_feature(env, RISCV_FEATURE_PMP);
> > > >   }
> > > >
> > > > @@ -187,7 +190,6 @@ static void rv64gcsu_priv1_09_1_cpu_init(Object=
 *obj)
> > > >       CPURISCVState *env =3D &RISCV_CPU(obj)->env;
> > > >       set_misa(env, RV64 | RVI | RVM | RVA | RVF | RVD | RVC | RVS =
| RVU);
> > > >       set_priv_version(env, PRIV_VERSION_1_09_1);
> > > > -    set_resetvec(env, DEFAULT_RSTVEC);
> > > >       set_feature(env, RISCV_FEATURE_MMU);
> > > >       set_feature(env, RISCV_FEATURE_PMP);
> > > >   }
> > > > @@ -197,7 +199,6 @@ static void rv64gcsu_priv1_10_0_cpu_init(Object=
 *obj)
> > > >       CPURISCVState *env =3D &RISCV_CPU(obj)->env;
> > > >       set_misa(env, RV64 | RVI | RVM | RVA | RVF | RVD | RVC | RVS =
| RVU);
> > > >       set_priv_version(env, PRIV_VERSION_1_10_0);
> > > > -    set_resetvec(env, DEFAULT_RSTVEC);
> > > >       set_feature(env, RISCV_FEATURE_MMU);
> > > >       set_feature(env, RISCV_FEATURE_PMP);
> > > >   }
> > > > @@ -207,7 +208,6 @@ static void rv64imacu_nommu_cpu_init(Object *ob=
j)
> > > >       CPURISCVState *env =3D &RISCV_CPU(obj)->env;
> > > >       set_misa(env, RV64 | RVI | RVM | RVA | RVC | RVU);
> > > >       set_priv_version(env, PRIV_VERSION_1_10_0);
> > > > -    set_resetvec(env, DEFAULT_RSTVEC);
> > > >       set_feature(env, RISCV_FEATURE_PMP);
> > > >   }
> > > >
> > > > @@ -399,7 +399,9 @@ static void riscv_cpu_realize(DeviceState *dev,=
 Error **errp)
> > > >       }
> > > >
> > > >       set_priv_version(env, priv_version);
> > > > -    set_resetvec(env, DEFAULT_RSTVEC);
> > > > +    if (!get_resetvec(env)) {
>
> What if we have a RISC-V CPU whose reset vector is at address 0?

That won't work then. I think if that happens we could swap to a
negative number.

Alistair

>
> > > > +        set_resetvec(env, DEFAULT_RSTVEC);
> > > > +    }
> > > >
> > > >       if (cpu->cfg.mmu) {
> > > >           set_feature(env, RISCV_FEATURE_MMU);
> > > >
>
> Regards,
> Bin

