Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5468C3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 22:30:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D00A206C2
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 22:30:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cbZSg6Nk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D00A206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35794 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBRAt-0004MZ-UP
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 18:14:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57662)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1iBR8s-00070n-0c
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 18:12:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1iBR8q-0006UO-Lk
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 18:12:41 -0400
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:43903)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1iBR8q-0006UA-Aw; Fri, 20 Sep 2019 18:12:40 -0400
Received: by mail-lj1-x243.google.com with SMTP id n14so3436518ljj.10;
 Fri, 20 Sep 2019 15:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ZfAWoHJgDaLpaFvT81RSKFrNh8Gv/h5ToHqyeRHEvqY=;
 b=cbZSg6NkoDARs6aifAIYRhl+UVpZwhN9H+rhRXY+vkLvlbXn2c6L+1khErmNgyr4lY
 mm4UGi+6txTYC8Szw1NARwJ7T2vYPzbr5HBYogVINJAxiTXiLUwrwnYYUwUODmokvuCb
 SA9wG5jz6KeSddFs7OsJqVuVN7ewmGgaiEW1s8nFuPpD4bLSmFeuAL+96oKSABwsc6FJ
 Q2ukpOxFjCQJoHJ5/JjaCP9PyveY0LtIenns+VhvnSvy4wvF9bwneAKHZoNM8PweweTJ
 m2GVqIhD18MLFFkORHiYaEdA3V3yp3dFd71Zbl5RAKxecrX9o/2v1Edo35lS1mA9ITsR
 WbsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ZfAWoHJgDaLpaFvT81RSKFrNh8Gv/h5ToHqyeRHEvqY=;
 b=P0dyeO+rQp4BmkRDk3gGsGEOyacDGUKCKqr5CM7wQlM2qhRn8kmoP46LwR/ajIsPq3
 /neADCV2yg7LyJaHGCei8I3zPrvLciUPLPXWCi3l5ziyHWD24cyicKLzq88NiE4g1+KB
 PWzPGfYsAI160yPqi5/n8CU5zU2Fb5qEeutTmjdvweqEep3g0Y2Wyv9l4uGmA/d3x+HP
 11+iOToEF9jCM5Sh7AMDvtPs3EjX7Z8zsZovThZKPVxGfslERbZebJZ4ReV7KhVVFgYb
 9CK3cFWViPVmoxAcjZslsn6sz2vshrCTwZ1YM6C6Kl/RJOskSuQuubEFoDLZ3tRJF8Lk
 a6PQ==
X-Gm-Message-State: APjAAAWwnPaQgNIstUHRoaB6Ve/X8j0wBWkZHrNkTQf2dZS2p7n3EEoy
 HHN+YtOCskWWgT2JLFSYzV2xL+VpKkhV8Fawjrc=
X-Google-Smtp-Source: APXvYqwPtdaUQrcNtB58wfxwzsFABCcD1cXh6SR/Y8Vemm/1COHP+NZVcUmq6U11E3p017JGN2Gzfvi/HSVUv1pCE0k=
X-Received: by 2002:a2e:9081:: with SMTP id l1mr10451657ljg.33.1569017552379; 
 Fri, 20 Sep 2019 15:12:32 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1568931866.git.alistair.francis@wdc.com>
 <d3357e0b87cce025418f6383ce971246ded547bd.1568931866.git.alistair.francis@wdc.com>
 <CAEUhbmV7Ao6L25HM+8AJLP8unn=HhvdRc1Kt+tUQgRB4S4zsBQ@mail.gmail.com>
In-Reply-To: <CAEUhbmV7Ao6L25HM+8AJLP8unn=HhvdRc1Kt+tUQgRB4S4zsBQ@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 20 Sep 2019 15:07:56 -0700
Message-ID: <CAKmqyKO=PahfKej1Ch6=x3zcxN8R26Gkd9dsjScMSHPxitp=rA@mail.gmail.com>
Subject: Re: [PATCH v1 4/6] riscv/sifive_u: Add the start-in-flash property
To: Bin Meng <bmeng.cn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::243
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

On Thu, Sep 19, 2019 at 10:15 PM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> On Fri, Sep 20, 2019 at 6:32 AM Alistair Francis
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
> > index c3949fb316..b7cd3631cd 100644
> > --- a/hw/riscv/sifive_u.c
> > +++ b/hw/riscv/sifive_u.c
> > @@ -373,6 +373,10 @@ static void riscv_sifive_u_init(MachineState *machine)
> >                                         /* dtb: */
> >      };
> >
> > +    if (s->start_in_flash) {
> > +        reset_vec[6] = memmap[SIFIVE_U_FLASH0].base; /* start: .dword FLASH0_BASE */
> > +    }
> > +
> >      /* copy in the reset vector in little_endian byte order */
> >      for (i = 0; i < sizeof(reset_vec) >> 2; i++) {
> >          reset_vec[i] = cpu_to_le32(reset_vec[i]);
> > @@ -544,8 +548,31 @@ static void riscv_sifive_u_soc_realize(DeviceState *dev, Error **errp)
> >          memmap[SIFIVE_U_GEM_MGMT].base, memmap[SIFIVE_U_GEM_MGMT].size);
> >  }
> >
> > +static bool virt_get_start_in_flash(Object *obj, Error **errp)
> > +{
> > +    SiFiveUState *s = RISCV_U_MACHINE(obj);
> > +
> > +    return s->start_in_flash;
> > +}
> > +
> > +static void virt_set_start_in_flash(Object *obj, bool value, Error **errp)
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
> >
> >  }
> >
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
> >  enum {
>
> This patch chose a different way from the one used in patch "[v1,6/6]
> riscv/virt: Jump to pflash if specified":
>
> - this patch uses reset_vec[6] while patch [6/6] defines a variable start_addr
> - this patch adds a "start-in-flash" property to the machine, while
> patch [6/6] tests against drive IF_PFLASH

Yes, we do it differently for the sifive_u board as the sifive_u board
doesn't use pflash so there is no way to know if the user has loaded
anything into the SPI memory.

>
> We should be consistent and I would prefer to use the patch [6/6] way.
> On Unleashed an SPI flash is mounted so we cannot add a PFlash to
> sifive_u machine like what was done on virt machine, so we should test
> IF_MTD instead. Thoughts?

How would we test that?

Right now I am loading the binary in SPI with the -device loader
option. The machine can't really know what is/isn't loaded there.

It's not ideal, but I don't see a nicer way.

Alistair

>
> Regards,
> Bin

