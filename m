Return-Path: <SRS0=J7/p=6I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1659C54FD0
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 19:49:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 971DE20736
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 19:49:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vcPD7yXa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 971DE20736
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51110 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jS4KS-0006vI-PG
	for qemu-devel@archiver.kernel.org; Fri, 24 Apr 2020 15:49:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59184)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1jS4Jm-0006HF-AJ
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 15:48:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1jS4Jl-0006H3-Ic
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 15:48:58 -0400
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41]:37968)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jS4Jl-00063Z-4c; Fri, 24 Apr 2020 15:48:57 -0400
Received: by mail-io1-xd41.google.com with SMTP id f19so11674161iog.5;
 Fri, 24 Apr 2020 12:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=8oWQyn3T8uEIiBympa2dHQYjh07eo0K68oyO4QJfaVM=;
 b=vcPD7yXaEPztQX2DZvG8c6S2YSdzTAOfrTdJroe9EfLav2kHFhE/SCcSiJmR6aR7m2
 9G76usSbsvg8QK3+BLp2D6QJJCekXKRLIY0ScIVrOVImFw8VLQfXTMoeR+1cIs87aVgC
 +mZqvGKirDr3R2gaKZ5zkr0v61mQi6Eubx3rNGyI6dAHbtr5HNl3Sy3O2hDQMNRtiqZk
 sGhztI/1scxPdx3lywFZz6gqp39yqlvp9SRrxpRIHoUlaQjzvkjGnWpiJkOnLrdnliQ/
 dPrCVvHivm1AFPPLGZ+mMA/KpMBzh/Gveld5FiqwghJPPYz69j8ShStZnpYeh1pcP3gW
 Oz+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=8oWQyn3T8uEIiBympa2dHQYjh07eo0K68oyO4QJfaVM=;
 b=g3RoV6XVuIvHj7tsKXKd8oKjTKbwi3FSwaGnl1QI50u8d9SnmqPv+4GNWX860Y5BZe
 K6bCAasF9yvdBkl1bblxkHuu+rmxk4EZ2wr25kjC2jU6zEL2KEuv97ESzjesl2UxdvCc
 cy4h+zfxJtUZOl5+fvDTsQoa00KyS8ns70U84SQvBhl60J7X2M9Mnb6QaR1HKIlcsMD4
 DqgvhdnTCco7WCK1egXTClOvtl1ScnLbpOlLN2AgN2lWJh5amvvIgkKmf71CE96FzGEo
 UckUhQSXYNE6szuud6ojt75N4JdmRJzOM7UEHL+yzda6jwwQFfBHWnZUboYQpbfEapGS
 frYA==
X-Gm-Message-State: AGi0PuZw1XpO9lbnBZFfTgTOuWSQtf5XzK02qQxUPVP6Wz+UQ4ZbpdMr
 7eTNGZRdw0aaAcT+wxbFNlZuita3Iel6JWJYqow=
X-Google-Smtp-Source: APiQypKjY0OtyR7z55PcjV3bDv3PGzO/jJNIvt8HiYR+rptil40T2kEllT9huF0+BXVmE0T1JD2v6ihiXK9fQV4Pr+Q=
X-Received: by 2002:a6b:bf83:: with SMTP id
 p125mr10212817iof.118.1587757735627; 
 Fri, 24 Apr 2020 12:48:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200313193429.8035-1-coreyw7@fb.com>
 <20200313193429.8035-2-coreyw7@fb.com>
 <CAKmqyKNGLOE_UKWVuJzrBDRkRXj74XfOace+K5ab4-5HTWg_KA@mail.gmail.com>
 <MW3PR15MB4041DC49872DE4C92E982FE993D00@MW3PR15MB4041.namprd15.prod.outlook.com>
In-Reply-To: <MW3PR15MB4041DC49872DE4C92E982FE993D00@MW3PR15MB4041.namprd15.prod.outlook.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 24 Apr 2020 12:40:22 -0700
Message-ID: <CAKmqyKPvt7ae7T0VLnriwk4HYxiCTsuDp2yTHPQ5p16oQtL6Hw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] riscv: sifive_e: Support changing CPU type
To: Corey Wharton <coreyw7@fb.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d41;
 envelope-from=alistair23@gmail.com; helo=mail-io1-xd41.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::d41
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
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Bin Meng <bmeng.cn@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Apr 24, 2020 at 12:12 PM Corey Wharton <coreyw7@fb.com> wrote:
>
>
>
> > -----Original Message-----
> > From: Alistair Francis <alistair23@gmail.com>
> > Sent: Friday, April 24, 2020 9:04 AM
> > To: Corey Wharton <coreyw7@fb.com>
> > Cc: qemu-devel@nongnu.org Developers <qemu-devel@nongnu.org>; open
> > list:RISC-V <qemu-riscv@nongnu.org>; Sagar Karandikar
> > <sagark@eecs.berkeley.edu>; Bastian Koppelmann <kbastian@mail.uni-
> > paderborn.de>; Alistair Francis <alistair.francis@wdc.com>; Palmer Dabbelt
> > <palmer@dabbelt.com>; Bin Meng <bmeng.cn@gmail.com>
> > Subject: Re: [PATCH v2 1/2] riscv: sifive_e: Support changing CPU type
> >
> > On Fri, Mar 13, 2020 at 12:35 PM Corey Wharton <coreyw7@fb.com> wrote:
> > >
> > > Allows the CPU to be changed from the default via the -cpu command
> > > line option.
> > >
> > > Signed-off-by: Corey Wharton <coreyw7@fb.com>
> > > Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
> > > Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> >
> > Thanks for the patch.
> >
> > Unfortunately this fails `make check`.
> >
> > The problem is that the machine has the `default_cpu_type` set but then you
> > set "cpu-type" from the SoC.
> >
> > This diff fixes the make check failure for me:
> >
> > diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c index
> > 1fd08f325c..b53109521e 100644
> > --- a/hw/riscv/sifive_e.c
> > +++ b/hw/riscv/sifive_e.c
> > @@ -123,8 +123,6 @@ static void riscv_sifive_e_soc_init(Object *obj)
> >      object_initialize_child(obj, "cpus", &s->cpus,
> >                              sizeof(s->cpus), TYPE_RISCV_HART_ARRAY,
> >                              &error_abort, NULL);
> > -    object_property_set_str(OBJECT(&s->cpus), ms->cpu_type, "cpu-type",
> > -                            &error_abort);
> >      object_property_set_int(OBJECT(&s->cpus), ms->smp.cpus, "num-harts",
> >                              &error_abort);
> >      sysbus_init_child_obj(obj, "riscv.sifive.e.gpio0", @@ -141,6 +139,8 @@
> > static void riscv_sifive_e_soc_realize(DeviceState
> > *dev, Error **errp)
> >      SiFiveESoCState *s = RISCV_E_SOC(dev);
> >      MemoryRegion *sys_mem = get_system_memory();
> >
> > +    object_property_set_str(OBJECT(&s->cpus), ms->cpu_type, "cpu-type",
> > +                            &error_abort);
> >      object_property_set_bool(OBJECT(&s->cpus), true, "realized",
> >                              &error_abort);
> >
> >
> > I'm happy to just squash that into the patch. Let me know if you don't want
> > me to do that and I'll drop these patches and let you re-send them.
> >
> > Alistair
> >
>
> Thanks for fixing this issue. I tested your patch and it seems to work as
> Intended and  I'm fine with you squashing it into the patch.

Great!

I'll send this patch as part of the PR after 5.0 then.

I also realised that my justification was wrong. It's not because of
the machine/SoC split, but because of the order between init/realise.

Alistair

>
> Corey
>
> > > ---
> > >  hw/riscv/sifive_e.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c index
> > > a254cad489..b0a611adb9 100644
> > > --- a/hw/riscv/sifive_e.c
> > > +++ b/hw/riscv/sifive_e.c
> > > @@ -123,7 +123,7 @@ static void riscv_sifive_e_soc_init(Object *obj)
> > >      object_initialize_child(obj, "cpus", &s->cpus,
> > >                              sizeof(s->cpus), TYPE_RISCV_HART_ARRAY,
> > >                              &error_abort, NULL);
> > > -    object_property_set_str(OBJECT(&s->cpus), SIFIVE_E_CPU, "cpu-type",
> > > +    object_property_set_str(OBJECT(&s->cpus), ms->cpu_type,
> > > + "cpu-type",
> > >                              &error_abort);
> > >      object_property_set_int(OBJECT(&s->cpus), ms->smp.cpus, "num-
> > harts",
> > >                              &error_abort); @@ -220,6 +220,7 @@ static
> > > void riscv_sifive_e_machine_init(MachineClass *mc)
> > >      mc->desc = "RISC-V Board compatible with SiFive E SDK";
> > >      mc->init = riscv_sifive_e_init;
> > >      mc->max_cpus = 1;
> > > +    mc->default_cpu_type = SIFIVE_E_CPU;
> > >  }
> > >
> > >  DEFINE_MACHINE("sifive_e", riscv_sifive_e_machine_init)
> > > --
> > > 2.21.1
> > >
> > >

