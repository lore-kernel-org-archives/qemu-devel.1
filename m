Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B4B0C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 22:27:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB85D206F4
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 22:27:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LEJ0/jjU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB85D206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jj9CD-0004k6-64
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 18:27:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43222)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jj982-0007oF-RN; Wed, 10 Jun 2020 18:23:26 -0400
Received: from mail-il1-x142.google.com ([2607:f8b0:4864:20::142]:34071)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jj981-0002cG-PG; Wed, 10 Jun 2020 18:23:26 -0400
Received: by mail-il1-x142.google.com with SMTP id x18so3618130ilp.1;
 Wed, 10 Jun 2020 15:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=FAoEUpMzwK+O29DOALfk6N49qoz4MjXXkxUmnMcACMs=;
 b=LEJ0/jjUxRhqOZ2TtcAXOagAHVn6luY5L1U+6DIOvL2DxaGBWOyIvJCQnF0MNsZS+6
 SU1aLyhd979H90zGCqOzV+Xix/TqE47AVDA/VSyBbzALsAfoC+LvIJDciDL1kbpXbjBF
 IpuGUNncfHqxxgwqeJf/l6jH1+FDfNbP8/xiTrCoCcU0vkZl3x5bVAcMOr62I/07M+Hw
 UxkpD6DmlywiEyWrWf9wA84yjulqVMRT4o5w0FEzNVM9PdoNRS2trfYegwFTF/xSMr9+
 4q53nxmgXX5pe6Uo2VC3w4lg0NSgUpJz3l2pUho6DZiPpZKc+v10U+9Lo6fD7iRS+bA1
 DoyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=FAoEUpMzwK+O29DOALfk6N49qoz4MjXXkxUmnMcACMs=;
 b=mcnUCHGT7Qdt3sHKETO6oEkHW6I3gicP42cb/E/r+d0B2jR592IIEZMkISvH7dnd4n
 u8ArRiNLDYQCQtKh7DPyLrgo8ePCePBcaruI3fYkVhF9Gwhu0SUl8BYfI3T6HPlZ4RTH
 53N4ulj3N0SgRgFN7rH8LgAqgJKMxcApC8IfVPHwKu4Er1FwYPEKTnW4yHooE9Q8AGqa
 xrINsLp0AkKm6zoN9TUfOVbHsjAjL18EQDeAdB794L8YOZqy3eF4t9zZGmDboCWDkCce
 ssqjrzG8zGGxrdPtAJloXSTyROhrOuwFN9FgfE1tIrF1blWTRvQPvgPAsQIsQ4ySbmrb
 t7jg==
X-Gm-Message-State: AOAM531QQPCHqa52Zm39JOqFOc2Ia5u16ApOY4h/OqjW6Devfb+kWSjz
 hvOwCe3w2xh+OK2ZuP6xYeJmEfmzSMYyTbr2dR/msWMH
X-Google-Smtp-Source: ABdhPJyloAIpxYBK6+aqa4w+VTNtD9apc04UaDtZi77TtF0KbnZBuY8ApqyjJ7lggBUNpq5ILYGXjHnBTzMw2qnh1DU=
X-Received: by 2002:a92:aa07:: with SMTP id j7mr5223048ili.40.1591827792258;
 Wed, 10 Jun 2020 15:23:12 -0700 (PDT)
MIME-Version: 1.0
References: <925bdcd2b3536014306a8800975fb63592fd051a.1589489213.git.alistair.francis@wdc.com>
 <mhng-8a09dc11-68b8-4e28-9b50-3fc5a52837e6@palmerdabbelt-glaptop1>
 <CAKmqyKM7G+b0cZ2a0MGtqRCKc5WbCcAkTfzYfF+gbvYDyOMidA@mail.gmail.com>
 <CAKmqyKP_Z=8gYqviEAveCd18OL0YXHW8k3k652KvTbJ9zbXPog@mail.gmail.com>
In-Reply-To: <CAKmqyKP_Z=8gYqviEAveCd18OL0YXHW8k3k652KvTbJ9zbXPog@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 10 Jun 2020 15:13:49 -0700
Message-ID: <CAKmqyKPOSdgnWfCR40jXC6qQjeeEr8rfzQaez+Ce92CZstz_aw@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] sifive_e: Support the revB machine
To: Palmer Dabbelt <palmer@dabbelt.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::142;
 envelope-from=alistair23@gmail.com; helo=mail-il1-x142.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 Alistair Francis <Alistair.Francis@wdc.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, May 28, 2020 at 11:13 AM Alistair Francis <alistair23@gmail.com> wrote:
>
> On Thu, May 21, 2020 at 8:57 AM Alistair Francis <alistair23@gmail.com> wrote:
> >
> > On Wed, May 20, 2020 at 4:08 PM Palmer Dabbelt <palmer@dabbelt.com> wrote:
> > >
> > > On Thu, 14 May 2020 13:47:10 PDT (-0700), Alistair Francis wrote:
> > > > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > > > ---
> > > >  hw/riscv/sifive_e.c         | 35 +++++++++++++++++++++++++++++++----
> > > >  include/hw/riscv/sifive_e.h |  1 +
> > > >  2 files changed, 32 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
> > > > index 472a98970b..cb7818341b 100644
> > > > --- a/hw/riscv/sifive_e.c
> > > > +++ b/hw/riscv/sifive_e.c
> > > > @@ -98,10 +98,14 @@ static void riscv_sifive_e_init(MachineState *machine)
> > > >          memmap[SIFIVE_E_DTIM].base, main_mem);
> > > >
> > > >      /* Mask ROM reset vector */
> > > > -    uint32_t reset_vec[2] = {
> > > > -        0x204002b7,        /* 0x1000: lui     t0,0x20400 */
> > > > -        0x00028067,        /* 0x1004: jr      t0 */
> > > > -    };
> > > > +    uint32_t reset_vec[2];
> > > > +
> > > > +    if (s->revb) {
> > > > +        reset_vec[0] = 0x200102b7;        /* 0x1000: lui     t0,0x20010 */
> > > > +    } else {
> > > > +        reset_vec[0] = 0x204002b7;        /* 0x1000: lui     t0,0x20400 */
> > > > +    }
> > > > +    reset_vec[1] = 0x00028067;        /* 0x1004: jr      t0 */
> > > >
> > > >      /* copy in the reset vector in little_endian byte order */
> > > >      for (i = 0; i < sizeof(reset_vec) >> 2; i++) {
> > > > @@ -115,8 +119,31 @@ static void riscv_sifive_e_init(MachineState *machine)
> > > >      }
> > > >  }
> > > >
> > > > +static bool sifive_e_machine_get_revb(Object *obj, Error **errp)
> > > > +{
> > > > +    SiFiveEState *s = RISCV_E_MACHINE(obj);
> > > > +
> > > > +    return s->revb;
> > > > +}
> > > > +
> > > > +static void sifive_e_machine_set_revb(Object *obj, bool value, Error **errp)
> > > > +{
> > > > +    SiFiveEState *s = RISCV_E_MACHINE(obj);
> > > > +
> > > > +    s->revb = value;
> > > > +}
> > > > +
> > > >  static void sifive_e_machine_instance_init(Object *obj)
> > > >  {
> > > > +    SiFiveEState *s = RISCV_E_MACHINE(obj);
> > > > +
> > > > +    s->revb = false;
> > > > +    object_property_add_bool(obj, "revb", sifive_e_machine_get_revb,
> > > > +                             sifive_e_machine_set_revb, NULL);
> > > > +    object_property_set_description(obj, "revb",
> > > > +                                    "Set on to tell QEMU that it should model "
> > > > +                                    "the revB HiFive1 board",
> > > > +                                    NULL);
> > > >  }
> > > >
> > > >  static void sifive_e_machine_class_init(ObjectClass *oc, void *data)
> > > > diff --git a/include/hw/riscv/sifive_e.h b/include/hw/riscv/sifive_e.h
> > > > index 414992119e..0d3cd07fcc 100644
> > > > --- a/include/hw/riscv/sifive_e.h
> > > > +++ b/include/hw/riscv/sifive_e.h
> > > > @@ -45,6 +45,7 @@ typedef struct SiFiveEState {
> > > >
> > > >      /*< public >*/
> > > >      SiFiveESoCState soc;
> > > > +    bool revb;
> > > >  } SiFiveEState;
> > > >
> > > >  #define TYPE_RISCV_E_MACHINE MACHINE_TYPE_NAME("sifive_e")
> > >
> > > IIRC there are way more differences between the un-suffixed FE310 and the Rev
> > > B, specifically the interrupt map is all different.
> >
> > The three IRQs that QEMU uses for the SiFive E (UART0, UART1 and GPIO)
> > all seem to be the same.
>
> Ping!

Ping^2

Applying to RISC-V tree.

Alistair

>
> >
> > Alistair

