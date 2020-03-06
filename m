Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A4DCC10F25
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 19:52:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28C9720656
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 19:52:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qniVqyqb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28C9720656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41688 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jAJ1U-00040D-BG
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 14:52:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44369)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1jAJ0g-0003UB-UO
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 14:51:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1jAJ0f-0003gL-OT
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 14:51:50 -0500
Received: from mail-vk1-xa42.google.com ([2607:f8b0:4864:20::a42]:39039)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1jAJ0f-0003f3-IV; Fri, 06 Mar 2020 14:51:49 -0500
Received: by mail-vk1-xa42.google.com with SMTP id t129so940808vkg.6;
 Fri, 06 Mar 2020 11:51:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=jtvBEhmbkno0g0p63SO8wukXuC60CI3AMLSaeMMvhTw=;
 b=qniVqyqbqQXLum2Ow8fSpKWv3OCgV1pUpNfmW1n9kUPoMfN+iMW1tx3QJz/Q1VnZaw
 S8BeDWoDa4h5x/XkvzKe60JSAeImFRx/rIRxMKbEMmBOiaYaqiWArBEt9SYUZXrsj6Gl
 jN2/OUUjLMkUWKSWoWEBZhGVxrcr3TkUdCO9M6cNxjFFf724AwM/P43rFZ9o/HkRgkCD
 B5P4DPo2AeIRLkSHL9t5SFB/9bSq0TOAGmUnud00zmulzd0zAGQhpTDK9dRnj1F+y/+h
 emt+K6FpUyPut9gC0lV9LD1ZdaDMYsYWu/cW1KA1zKHrDh6gXRA3YkQFCvoB8YKScXEH
 AGuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=jtvBEhmbkno0g0p63SO8wukXuC60CI3AMLSaeMMvhTw=;
 b=WPepJ2i/UMI5LWDOELEnT0G2vAsQgMZ7g/kTlGp4haDi0x3WfZzHfDKsbTigmkRmee
 3U5QCocdgMUzx9pPxriasDGYZbj4CrAshIgdwn4xxj2jt15jRm7SaL12BFBIiKfjdLOY
 MVuBUR2G8MLxSKMs/zXnPgaSw9lFBBwqxvsVGFm/Fgehfk9LVaWyvGIK7A3A9H1rB5Cu
 aEyGv9iZ8nH5SF5nmEwBnNali737ZJIzN7zw8SdAwIrO8fA+YC6IkW4Ituggse+S3Frx
 NbB0CNLQVKwuE2O3ncQJE/x920ejqH6WsrkejocU3ONmK7ZvwwRVtGcWhj1hydMtkN5k
 caDw==
X-Gm-Message-State: ANhLgQ3dpA4MQfYbZFH75Htg7xK2dWx45i1Jh9c+e32LFLZ6RpBQmwdY
 TjFdrr0BqceKB3ju5NEUBb2rmTQm+GuwEeuZdI4=
X-Google-Smtp-Source: ADFU+vvWqwScidltFbrxAW4rZinVUrKRubTyb/BS/fOwuOU0p5HekGM4mpQrEgdIhF8GlDVgjVKBlOQ8mx2n6fh5u4o=
X-Received: by 2002:a1f:9d16:: with SMTP id g22mr2670145vke.22.1583524308549; 
 Fri, 06 Mar 2020 11:51:48 -0800 (PST)
MIME-Version: 1.0
References: <cover.1583285287.git.alistair.francis@wdc.com>
 <e91f9fccc49a42482d964f380b2ae085de5bfab2.1583285287.git.alistair.francis@wdc.com>
 <CAEUhbmWFPVOZ6Sxjd+VUENqyPxCe89QYKWP-nKSkH3Co-=FYbg@mail.gmail.com>
 <CAKmqyKNrG4Uh_WKwEfiX=HpFoFiforzjKxnY+dZmBQBdKfZceg@mail.gmail.com>
 <CAEUhbmXTzjukKbaXqS+ivxtxbu+tcVFDCg1hcSw5roQjJhx9og@mail.gmail.com>
 <CAKmqyKMLcKKGbA3gJGDMgw77vWNdsU_GhkqC+m9OsN5tBFv0OQ@mail.gmail.com>
 <CAEUhbmX8ytjiH6JWdvZLveSaN6PS7zHF9wRcDM_yxCA48wn6tQ@mail.gmail.com>
In-Reply-To: <CAEUhbmX8ytjiH6JWdvZLveSaN6PS7zHF9wRcDM_yxCA48wn6tQ@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 6 Mar 2020 11:51:21 -0800
Message-ID: <CAKmqyKM=+xA28qo=1vXWNYf2JNDKKWmr4t6+4UxVUk+BGVt3tw@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] riscv/sifive_u: Add a serial property to the
 sifive_u SoC
To: Bin Meng <bmeng.cn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::a42
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
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Mar 5, 2020 at 4:09 PM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> Hi Alistair,
>
> On Fri, Mar 6, 2020 at 12:53 AM Alistair Francis <alistair23@gmail.com> wrote:
> >
> > On Thu, Mar 5, 2020 at 1:31 AM Bin Meng <bmeng.cn@gmail.com> wrote:
> > >
> > > Hi Alistair,
> > >
> > > On Thu, Mar 5, 2020 at 7:13 AM Alistair Francis <alistair23@gmail.com> wrote:
> > > >
> > > > On Wed, Mar 4, 2020 at 6:47 AM Bin Meng <bmeng.cn@gmail.com> wrote:
> > > > >
> > > > > Hi Alistair,
> > > > >
> > > > > On Wed, Mar 4, 2020 at 9:37 AM Alistair Francis
> > > > > <alistair.francis@wdc.com> wrote:
> > > > > >
> > > > > > At present the board serial number is hard-coded to 1, and passed
> > > > > > to OTP model during initialization. Firmware (FSBL, U-Boot) uses
> > > > > > the serial number to generate a unique MAC address for the on-chip
> > > > > > ethernet controller. When multiple QEMU 'sifive_u' instances are
> > > > > > created and connected to the same subnet, they all have the same
> > > > > > MAC address hence it creates a unusable network.
> > > > > >
> > > > > > A new "serial" property is introduced to the sifive_u SoC to specify
> > > > > > the board serial number. When not given, the default serial number
> > > > > > 1 is used.
> > > > > >
> > > > > > Suggested-by: Bin Meng <bmeng.cn@gmail.com>
> > > > > > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > > > > > ---
> > > > > >  hw/riscv/sifive_u.c         | 8 +++++++-
> > > > > >  include/hw/riscv/sifive_u.h | 2 ++
> > > > > >  2 files changed, 9 insertions(+), 1 deletion(-)
> > > > > >
> > > > > > diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
> > > > > > index 9a0145b5b4..e52f9d0bd4 100644
> > > > > > --- a/hw/riscv/sifive_u.c
> > > > > > +++ b/hw/riscv/sifive_u.c
> > > > > > @@ -488,7 +488,7 @@ static void riscv_sifive_u_soc_init(Object *obj)
> > > > > >                            TYPE_SIFIVE_U_PRCI);
> > > > > >      sysbus_init_child_obj(obj, "otp", &s->otp, sizeof(s->otp),
> > > > > >                            TYPE_SIFIVE_U_OTP);
> > > > > > -    qdev_prop_set_uint32(DEVICE(&s->otp), "serial", OTP_SERIAL);
> > > > > > +    qdev_prop_set_uint32(DEVICE(&s->otp), "serial", s->serial);
> > > > > >      sysbus_init_child_obj(obj, "gem", &s->gem, sizeof(s->gem),
> > > > > >                            TYPE_CADENCE_GEM);
> > > > > >  }
> > > > > > @@ -607,10 +607,16 @@ static void riscv_sifive_u_soc_realize(DeviceState *dev, Error **errp)
> > > > > >          memmap[SIFIVE_U_GEM_MGMT].base, memmap[SIFIVE_U_GEM_MGMT].size);
> > > > > >  }
> > > > > >
> > > > > > +static Property riscv_sifive_u_soc_props[] = {
> > > > > > +    DEFINE_PROP_UINT32("serial", SiFiveUSoCState, serial, OTP_SERIAL),
> > > > > > +    DEFINE_PROP_END_OF_LIST()
> > > > >
> > > > > I am not sure how adding another level of property in the SoC could
> > > > > solve the 'make check' error.
> > > >
> > > > The problem is that you were adding a machine property and then you
> > > > had the SoC reach up to the machine object to get the serial value.
> > > > This isn't correct and is why the tests fail.
> > > >
> > >
> > > So looks the failure was due to a check in the test codes only? As I
> > > did not see QEMU crashed during my normal usage.
> >
> > No, the bug was in the actual implementation. You were just lucky that
> > you didn't see any issues as in your case you could access the machine
> > state. The make check probably added the SoC individually and hence
> > caught the bug.
>
> That sounds like the difference that caused the crash in the test.
> Thanks for helping this!

No worries!

Alistair

>
> Regards,
> Bin

