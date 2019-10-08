Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BF52C4360C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 20:39:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0284D21835
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 20:39:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PBMHKspl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0284D21835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37088 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHwGR-0001NQ-6Y
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 16:39:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41155)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1iHwFZ-0000pg-IB
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 16:38:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1iHwFX-0000fX-Mz
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 16:38:29 -0400
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141]:45679)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1iHwFX-0000eB-De; Tue, 08 Oct 2019 16:38:27 -0400
Received: by mail-lf1-x141.google.com with SMTP id r134so12978089lff.12;
 Tue, 08 Oct 2019 13:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=XCPjj57kQgQLJcPcvoqbLBI71lfQjENYLDR7lzwPQVM=;
 b=PBMHKsplcYsVLC+ZLjSuqIduxzRUp92gBw6p7zXj87dCJe+k66D2HwwxhK6QdgPO4v
 DD7yyMMuRyklPAjyQngEWodVjACtqwebQ+UYhsdTRQvCOdGhI5HQPD/kkh2JKn8/+WC4
 KFGI0k/4cmwdTXHXaWQufMNeE27FOG5D8Sb8DlE7OB126KT7t87rx54j2caCx5Jdl7Rf
 JIQCDqdvLB6lNaU3Dg31RT3FFxiKxtIzqQ9PAQbGjIOsygiBRoaceogge74MjoTBbLVL
 acb1eS3lxqVyILrWpYZJHjlBspXX9rk/2gb3RwlGTq2eZmRIhy/1K1WzsTzVRrq7BYO1
 mBGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=XCPjj57kQgQLJcPcvoqbLBI71lfQjENYLDR7lzwPQVM=;
 b=IrI66cuovhQuDiYYcVXFcKwpudcIFC6eS3Pd2eQZjZE7T3UHN4ULjJ+ezK0CSf0vQf
 SthW9NYI2kz+4YJFpjDK9rZ9BnSdq+/PpDYD/h5//tJU2CeZ+jGMcp/F1+FxX+Da0SUi
 R82wl7lfNz6mFlR1fGARbxEbXhHCqn7XQHYqDqdkUNrQnc6J9jr4z7a6lJwPY7UyBDzx
 Zp4sb+T+6AqMuEfHJKm1/lLBvTSHn8JHTGf5BO0LqqkIHbLZlizHkQpke2faOxezy0Bk
 5XzcHVSaQAFYmsGUnpfnSBNx4BeIfFr70FzZ+TtMjJ2/IJC/hmUL4+On0IrCLO2YhGOv
 WU8g==
X-Gm-Message-State: APjAAAVyLDQ2wkAOdeNXQ2HvOAui9MWfadBVG+aQYDbXSoXguoQ2PksL
 rETKL1EAv+NeUtSztPDTPRJCJcIwlyy3Dc2VYG0=
X-Google-Smtp-Source: APXvYqx5XBJQKq44cAbltXdfUE+pDOK7ljgZwV+CKlWPtOeMhiXglmVudQt3hnMvc79p3w0AIoaSetKQTmdRhZgEXWg=
X-Received: by 2002:a19:4912:: with SMTP id w18mr21093275lfa.93.1570567105492; 
 Tue, 08 Oct 2019 13:38:25 -0700 (PDT)
MIME-Version: 1.0
References: <CAKmqyKPMOAq3oeU-_MQHBAbzTv__iKr=uR8WkCfGbH8yk4afFg@mail.gmail.com>
 <mhng-1d294790-a5b7-4fa7-8b5e-9adf550c5d1a@palmer-si-x1e>
In-Reply-To: <mhng-1d294790-a5b7-4fa7-8b5e-9adf550c5d1a@palmer-si-x1e>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 8 Oct 2019 13:33:26 -0700
Message-ID: <CAKmqyKPnA=GzRVT=AVPcs0-MghBOrnms4_xx=oE0O4UkrG4r7A@mail.gmail.com>
Subject: Re: [PATCH v2 4/7] riscv/sifive_u: Add the start-in-flash property
To: Palmer Dabbelt <palmer@sifive.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>, Bin Meng <bmeng.cn@gmail.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Oct 8, 2019 at 1:12 PM Palmer Dabbelt <palmer@sifive.com> wrote:
>
> On Mon, 30 Sep 2019 11:04:45 PDT (-0700), alistair23@gmail.com wrote:
> > On Fri, Sep 27, 2019 at 12:57 AM Bin Meng <bmeng.cn@gmail.com> wrote:
> >>
> >> On Fri, Sep 27, 2019 at 8:55 AM Alistair Francis
> >> <alistair.francis@wdc.com> wrote:
> >> >
> >> > Add a property that when set to true QEMU will jump from the ROM code to
> >> > the start of flash memory instead of DRAM which is the default
> >> > behaviour.
> >> >
> >> > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> >> > ---
> >> >  hw/riscv/sifive_u.c         | 27 +++++++++++++++++++++++++++
> >> >  include/hw/riscv/sifive_u.h |  2 ++
> >> >  2 files changed, 29 insertions(+)
> >> >
> >> > diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
> >> > index f5741e9a38..33b55d0d5b 100644
> >> > --- a/hw/riscv/sifive_u.c
> >> > +++ b/hw/riscv/sifive_u.c
> >> > @@ -373,6 +373,10 @@ static void riscv_sifive_u_init(MachineState *machine)
> >> >                                         /* dtb: */
> >> >      };
> >> >
> >> > +    if (s->start_in_flash) {
> >> > +        reset_vec[6] = memmap[SIFIVE_U_FLASH0].base; /* start: .dword FLASH0_BASE */
> >> > +    }
> >>
> >> Please change to use the way that patch "[v2,7/7] riscv/virt: Jump to
> >> pflash if specified" does for consistency, ie:
> >>
> >>     if (s->start_in_flash) {
> >>         start_addr = memmap[SIFIVE_U_FLASH0].base; /* start: .dword
> >> FLASH0_BASE */
> >>     }
> >>
> >> > +
> >> >      /* copy in the reset vector in little_endian byte order */
> >> >      for (i = 0; i < sizeof(reset_vec) >> 2; i++) {
> >> >          reset_vec[i] = cpu_to_le32(reset_vec[i]);
> >> > @@ -432,8 +436,31 @@ static void riscv_sifive_u_soc_init(Object *obj)
> >> >                            TYPE_CADENCE_GEM);
> >> >  }
> >> >
> >> > +static bool virt_get_start_in_flash(Object *obj, Error **errp)
> >>
> >> sifive_u_get_start_in_flash()
> >>
> >> > +{
> >> > +    SiFiveUState *s = RISCV_U_MACHINE(obj);
> >> > +
> >> > +    return s->start_in_flash;
> >> > +}
> >> > +
> >> > +static void virt_set_start_in_flash(Object *obj, bool value, Error **errp)
> >>
> >> sifive_u_set_start_in_flash()
> >
> > Yep, I have fixed all of these.
>
> Did I miss the v3?

Nope, I'll send it today.

Alistair

>
> >
> > Alistair
> >
> >>
> >> > +{
> >> > +    SiFiveUState *s = RISCV_U_MACHINE(obj);
> >> > +
> >> > +    s->start_in_flash = value;
> >> > +}
> >> > +
> >> >  static void riscv_sifive_u_machine_instance_init(Object *obj)
> >> >  {
> >> > +    SiFiveUState *s = RISCV_U_MACHINE(obj);
> >> > +
> >> > +    s->start_in_flash = false;
> >> > +    object_property_add_bool(obj, "start-in-flash", virt_get_start_in_flash,
> >> > +                             virt_set_start_in_flash, NULL);
> >> > +    object_property_set_description(obj, "start-in-flash",
> >> > +                                    "Set on to tell QEMU's ROM to jump to " \
> >> > +                                    "flash. Otherwise QEMU will jump to DRAM",
> >> > +                                    NULL);
> >> >  }
> >> >
> >> >  static void riscv_sifive_u_soc_realize(DeviceState *dev, Error **errp)
> >> > diff --git a/include/hw/riscv/sifive_u.h b/include/hw/riscv/sifive_u.h
> >> > index a921079fbe..2656b43c58 100644
> >> > --- a/include/hw/riscv/sifive_u.h
> >> > +++ b/include/hw/riscv/sifive_u.h
> >> > @@ -57,6 +57,8 @@ typedef struct SiFiveUState {
> >> >
> >> >      void *fdt;
> >> >      int fdt_size;
> >> > +
> >> > +    bool start_in_flash;
> >> >  } SiFiveUState;
> >> >
> >>
> >> Regards,
> >> Bin

