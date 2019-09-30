Return-Path: <SRS0=LaQQ=XZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2590C32792
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 18:06:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A836224D2
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 18:06:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y1vFB6Ws"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A836224D2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55906 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iF03p-00059v-Ea
	for qemu-devel@archiver.kernel.org; Mon, 30 Sep 2019 14:06:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55623)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1iF02v-0004ft-DU
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 14:05:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1iF02u-0005fk-7p
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 14:05:17 -0400
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142]:36341)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1iF02t-0005eq-W6; Mon, 30 Sep 2019 14:05:16 -0400
Received: by mail-lf1-x142.google.com with SMTP id x80so7773013lff.3;
 Mon, 30 Sep 2019 11:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=qbAWtxRsy/NMXfNeZQkP2QtBTIR7MRb2SHAvDdiJmtk=;
 b=Y1vFB6WsnMtQLjjNHBIPx+1BwTxrOgggLmZNDfN9tR4k2enYi6d9Kx2aq0ZkOGrnil
 LKSFF04HSxlohhDhSOCDsL5+UhwL86HtPDq/LBnN2m2bY0OmPiU1L8uHecuGpIDcn4uK
 A4gITZ8xz1j90/Q1uWFAyhdKrSwQDczhBhgXp6UnVWTXAIp+WXiTsBI4+9OOnH5U9hIi
 7Wo9EEnnd2Jal8xhPeL1W3xClZujxOGTkZFbbTVZQMl9JGwRjvofpUV6qLII9h+JeNMV
 XREMb3HssE5DGb8zad2aFvBOTmxk4a9AsL0U8vi21sF3awaoCMU5XmCVzv0y74WRVOwi
 akvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qbAWtxRsy/NMXfNeZQkP2QtBTIR7MRb2SHAvDdiJmtk=;
 b=aboeRGHr9oyDqBSb8C5cmdiF9OEA9UTBAB3GreItrIiSEJPFeY4wDOcpYogf4Bgmlj
 3AlZmyBd4/v6sMzscTKoiSZt5zUb7H4HHmHAm8r0uXkPmVX7tUEtYr/lzWzZsrm++mEe
 t4PSHsOziUSPylMat0CcETMVm54ykTkYC5EaI6xjJZUM+/kj00PhTO6oIkf/+jkJC04a
 NknIs6Iq9LE+PWsydGomeDsMLtcvENz5ogmlEWfTBNt5zGH/ygIECN4DTAubwlDM9m6T
 fN7NIdO6SsQMTAAg4kyW9+pDDodfXguhGNzDRzBN7Jm8UTQgn8f5PNWnGlJEvmLHLccx
 XD+w==
X-Gm-Message-State: APjAAAWozHyaB+8ssf+ZE6QjW9Iueg0cMmj8oNu+cbJEB2BlPSbZUFqH
 j6e+uU3h8PirjOavJx4b2Xm12MATsmemSXl6N2c=
X-Google-Smtp-Source: APXvYqz7ID+a97wUQ4Jyo7Xat5JoXYNb9m4AgmjlMLiU72asVMT3iSGnIISLcZPsNrLHh1xssug+Gx8VNadUSTOS4dw=
X-Received: by 2002:a19:4912:: with SMTP id w18mr11814539lfa.93.1569866714364; 
 Mon, 30 Sep 2019 11:05:14 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1569545046.git.alistair.francis@wdc.com>
 <a24af06cea57073f4a75381755ab05e825679445.1569545046.git.alistair.francis@wdc.com>
 <CAEUhbmVvsujN-EG3hdpaAbf-OF-NvvQnX4k5KWS_MscPHhKg-A@mail.gmail.com>
In-Reply-To: <CAEUhbmVvsujN-EG3hdpaAbf-OF-NvvQnX4k5KWS_MscPHhKg-A@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 30 Sep 2019 11:04:45 -0700
Message-ID: <CAKmqyKPMOAq3oeU-_MQHBAbzTv__iKr=uR8WkCfGbH8yk4afFg@mail.gmail.com>
Subject: Re: [PATCH v2 4/7] riscv/sifive_u: Add the start-in-flash property
To: Bin Meng <bmeng.cn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::142
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
 Palmer Dabbelt <palmer@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Sep 27, 2019 at 12:57 AM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> On Fri, Sep 27, 2019 at 8:55 AM Alistair Francis
> <alistair.francis@wdc.com> wrote:
> >
> > Add a property that when set to true QEMU will jump from the ROM code to
> > the start of flash memory instead of DRAM which is the default
> > behaviour.
> >
> > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > ---
> >  hw/riscv/sifive_u.c         | 27 +++++++++++++++++++++++++++
> >  include/hw/riscv/sifive_u.h |  2 ++
> >  2 files changed, 29 insertions(+)
> >
> > diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
> > index f5741e9a38..33b55d0d5b 100644
> > --- a/hw/riscv/sifive_u.c
> > +++ b/hw/riscv/sifive_u.c
> > @@ -373,6 +373,10 @@ static void riscv_sifive_u_init(MachineState *machine)
> >                                         /* dtb: */
> >      };
> >
> > +    if (s->start_in_flash) {
> > +        reset_vec[6] = memmap[SIFIVE_U_FLASH0].base; /* start: .dword FLASH0_BASE */
> > +    }
>
> Please change to use the way that patch "[v2,7/7] riscv/virt: Jump to
> pflash if specified" does for consistency, ie:
>
>     if (s->start_in_flash) {
>         start_addr = memmap[SIFIVE_U_FLASH0].base; /* start: .dword
> FLASH0_BASE */
>     }
>
> > +
> >      /* copy in the reset vector in little_endian byte order */
> >      for (i = 0; i < sizeof(reset_vec) >> 2; i++) {
> >          reset_vec[i] = cpu_to_le32(reset_vec[i]);
> > @@ -432,8 +436,31 @@ static void riscv_sifive_u_soc_init(Object *obj)
> >                            TYPE_CADENCE_GEM);
> >  }
> >
> > +static bool virt_get_start_in_flash(Object *obj, Error **errp)
>
> sifive_u_get_start_in_flash()
>
> > +{
> > +    SiFiveUState *s = RISCV_U_MACHINE(obj);
> > +
> > +    return s->start_in_flash;
> > +}
> > +
> > +static void virt_set_start_in_flash(Object *obj, bool value, Error **errp)
>
> sifive_u_set_start_in_flash()

Yep, I have fixed all of these.

Alistair

>
> > +{
> > +    SiFiveUState *s = RISCV_U_MACHINE(obj);
> > +
> > +    s->start_in_flash = value;
> > +}
> > +
> >  static void riscv_sifive_u_machine_instance_init(Object *obj)
> >  {
> > +    SiFiveUState *s = RISCV_U_MACHINE(obj);
> > +
> > +    s->start_in_flash = false;
> > +    object_property_add_bool(obj, "start-in-flash", virt_get_start_in_flash,
> > +                             virt_set_start_in_flash, NULL);
> > +    object_property_set_description(obj, "start-in-flash",
> > +                                    "Set on to tell QEMU's ROM to jump to " \
> > +                                    "flash. Otherwise QEMU will jump to DRAM",
> > +                                    NULL);
> >  }
> >
> >  static void riscv_sifive_u_soc_realize(DeviceState *dev, Error **errp)
> > diff --git a/include/hw/riscv/sifive_u.h b/include/hw/riscv/sifive_u.h
> > index a921079fbe..2656b43c58 100644
> > --- a/include/hw/riscv/sifive_u.h
> > +++ b/include/hw/riscv/sifive_u.h
> > @@ -57,6 +57,8 @@ typedef struct SiFiveUState {
> >
> >      void *fdt;
> >      int fdt_size;
> > +
> > +    bool start_in_flash;
> >  } SiFiveUState;
> >
>
> Regards,
> Bin

