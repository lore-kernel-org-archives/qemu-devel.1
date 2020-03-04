Return-Path: <SRS0=3KIA=4V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F323BC3F2CE
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 23:14:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBCAB20866
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 23:14:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MMtx3doJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBCAB20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41052 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9dDt-00033G-TK
	for qemu-devel@archiver.kernel.org; Wed, 04 Mar 2020 18:14:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44402)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1j9dDB-0002FJ-FA
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 18:13:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1j9dD9-0000fp-Vs
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 18:13:57 -0500
Received: from mail-vs1-xe41.google.com ([2607:f8b0:4864:20::e41]:46497)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1j9dD9-0000eF-NG; Wed, 04 Mar 2020 18:13:55 -0500
Received: by mail-vs1-xe41.google.com with SMTP id t12so2347109vso.13;
 Wed, 04 Mar 2020 15:13:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Z49wymSKuSD31YfxZ+o+81awIH5l65zOZVETXnpqXNI=;
 b=MMtx3doJlkxPWPKKsG5cv94ehptyMgAxb42yP4oDnFDIkBKK/IcdEjuQam6lBIaBGP
 Nw0fB6FOhbrhZQewnW2BWMuw+khi8jWEsgCVZ3BUx/DdIwPhZ9tlaqH8evEg90PeZqov
 3Iuom9t5yazNI59cwIVsqzTjbE13Y0Y/2wsFQVPCKdKOAYArrEoM+aSJu8hY6XPX20Vl
 61bYLuyVY7RUtqdF1bQ1hLbrcB2CjoUUTY7Ll7q4x9y8z3cS6UjdBoXLatLNoxclAcxj
 0M2xKa+VfJmhNghDuJVWM1GyqpmR0kQH3Fr5jYUGbZTVVv7tMda93AXRNpH3jT9uYZi3
 9ysg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Z49wymSKuSD31YfxZ+o+81awIH5l65zOZVETXnpqXNI=;
 b=mwhM/xH0zsZK1Ous+oFpocD8KNM3iY+55NtXHZU29kHtTZCNcQNSB5Go10FxSKEaNs
 qBJiw3Tac9bt+5+sQWDqYLV6RMT6Gsl8Ft0vIdLYqF+2KmCxKTXiDqR7FSyLeHDzM8rm
 9/OK+eHXu5iIU+WQ7bZ8Ax1Oo559vThE8/tWXOk0Dn2KyD5ApEDrkG747wic8b5PBIRH
 OJf3FW9oVZZPvx8Tt2yRGr3LQGJtCZkslQNA8eAX91lrO309Kz7cw9WtziDxwCSQjd1C
 Btf0IUmrDihyIwwnxyrZccrgmQhJzw+ak8qxk8+Ztxg1UPVugAF5sb9fBPbFFftNETQe
 YqXw==
X-Gm-Message-State: ANhLgQ1Qik4EdEaIlQPY4zcgFldtNabLYrQLGhVUE1OLC3M+bUeFcN84
 iqV83+gISZwbcM0UrjtEXr3AnNiuPojpaKB2B5s=
X-Google-Smtp-Source: ADFU+vuD0uFreRgPYE+4b/W4TS/ZnziE3pYjHeusfm7cyu3y+Ybq9KAlAH/IFTjv3FNglIx6ofkOWIpok1yogbb7F+Q=
X-Received: by 2002:a05:6102:205:: with SMTP id
 z5mr876648vsp.151.1583363634709; 
 Wed, 04 Mar 2020 15:13:54 -0800 (PST)
MIME-Version: 1.0
References: <cover.1583285287.git.alistair.francis@wdc.com>
 <e91f9fccc49a42482d964f380b2ae085de5bfab2.1583285287.git.alistair.francis@wdc.com>
 <CAEUhbmWFPVOZ6Sxjd+VUENqyPxCe89QYKWP-nKSkH3Co-=FYbg@mail.gmail.com>
In-Reply-To: <CAEUhbmWFPVOZ6Sxjd+VUENqyPxCe89QYKWP-nKSkH3Co-=FYbg@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 4 Mar 2020 15:06:14 -0800
Message-ID: <CAKmqyKNrG4Uh_WKwEfiX=HpFoFiforzjKxnY+dZmBQBdKfZceg@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] riscv/sifive_u: Add a serial property to the
 sifive_u SoC
To: Bin Meng <bmeng.cn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::e41
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

On Wed, Mar 4, 2020 at 6:47 AM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> Hi Alistair,
>
> On Wed, Mar 4, 2020 at 9:37 AM Alistair Francis
> <alistair.francis@wdc.com> wrote:
> >
> > At present the board serial number is hard-coded to 1, and passed
> > to OTP model during initialization. Firmware (FSBL, U-Boot) uses
> > the serial number to generate a unique MAC address for the on-chip
> > ethernet controller. When multiple QEMU 'sifive_u' instances are
> > created and connected to the same subnet, they all have the same
> > MAC address hence it creates a unusable network.
> >
> > A new "serial" property is introduced to the sifive_u SoC to specify
> > the board serial number. When not given, the default serial number
> > 1 is used.
> >
> > Suggested-by: Bin Meng <bmeng.cn@gmail.com>
> > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > ---
> >  hw/riscv/sifive_u.c         | 8 +++++++-
> >  include/hw/riscv/sifive_u.h | 2 ++
> >  2 files changed, 9 insertions(+), 1 deletion(-)
> >
> > diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
> > index 9a0145b5b4..e52f9d0bd4 100644
> > --- a/hw/riscv/sifive_u.c
> > +++ b/hw/riscv/sifive_u.c
> > @@ -488,7 +488,7 @@ static void riscv_sifive_u_soc_init(Object *obj)
> >                            TYPE_SIFIVE_U_PRCI);
> >      sysbus_init_child_obj(obj, "otp", &s->otp, sizeof(s->otp),
> >                            TYPE_SIFIVE_U_OTP);
> > -    qdev_prop_set_uint32(DEVICE(&s->otp), "serial", OTP_SERIAL);
> > +    qdev_prop_set_uint32(DEVICE(&s->otp), "serial", s->serial);
> >      sysbus_init_child_obj(obj, "gem", &s->gem, sizeof(s->gem),
> >                            TYPE_CADENCE_GEM);
> >  }
> > @@ -607,10 +607,16 @@ static void riscv_sifive_u_soc_realize(DeviceState *dev, Error **errp)
> >          memmap[SIFIVE_U_GEM_MGMT].base, memmap[SIFIVE_U_GEM_MGMT].size);
> >  }
> >
> > +static Property riscv_sifive_u_soc_props[] = {
> > +    DEFINE_PROP_UINT32("serial", SiFiveUSoCState, serial, OTP_SERIAL),
> > +    DEFINE_PROP_END_OF_LIST()
>
> I am not sure how adding another level of property in the SoC could
> solve the 'make check' error.

The problem is that you were adding a machine property and then you
had the SoC reach up to the machine object to get the serial value.
This isn't correct and is why the tests fail.

This patch series instead adds a property to the machine and the SoC,
where the machine sets the SoC property.

>
> > +};
> > +
> >  static void riscv_sifive_u_soc_class_init(ObjectClass *oc, void *data)
> >  {
> >      DeviceClass *dc = DEVICE_CLASS(oc);
> >
> > +    device_class_set_props(dc, riscv_sifive_u_soc_props);
> >      dc->realize = riscv_sifive_u_soc_realize;
> >      /* Reason: Uses serial_hds in realize function, thus can't be used twice */
> >      dc->user_creatable = false;
> > diff --git a/include/hw/riscv/sifive_u.h b/include/hw/riscv/sifive_u.h
> > index 82667b5746..a2baa1de5f 100644
> > --- a/include/hw/riscv/sifive_u.h
> > +++ b/include/hw/riscv/sifive_u.h
> > @@ -42,6 +42,8 @@ typedef struct SiFiveUSoCState {
> >      SiFiveUPRCIState prci;
> >      SiFiveUOTPState otp;
> >      CadenceGEMState gem;
> > +
> > +    uint32_t serial;
> >  } SiFiveUSoCState;
> >
> >  #define TYPE_RISCV_U_MACHINE MACHINE_TYPE_NAME("sifive_u")
> > --
>
> But anyway this patch does not actually work as expected. See below:
>
> $ ./riscv64-softmmu/qemu-system-riscv64 -M sifive_u,serial=3
> -nographic -m 2G -bios opensbi_u-boot_sifive_u_64.bin
>
> OpenSBI v0.5 (Oct 31 2019 18:38:50)
>    ____                    _____ ____ _____
>   / __ \                  / ____|  _ \_   _|
>  | |  | |_ __   ___ _ __ | (___ | |_) || |
>  | |  | | '_ \ / _ \ '_ \ \___ \|  _ < | |
>  | |__| | |_) |  __/ | | |____) | |_) || |_
>   \____/| .__/ \___|_| |_|_____/|____/_____|
>         | |
>         |_|
>
> Platform Name          : SiFive Freedom U540
> Platform HART Features : RV64ACDFIMSU
> Platform Max HARTs     : 5
> Current Hart           : 1
> Firmware Base          : 0x80000000
> Firmware Size          : 96 KB
> Runtime SBI Version    : 0.2
>
> PMP0: 0x0000000080000000-0x000000008001ffff (A)
> PMP1: 0x0000000000000000-0xffffffffffffffff (A,R,W,X)
>
>
> U-Boot 2019.10 (Oct 31 2019 - 18:38:33 +0800)
>
> CPU:   rv64imafdcsu
> Model: SiFive HiFive Unleashed A00
> DRAM:  2 GiB
> MMC:
> In:    serial@10010000
> Out:   serial@10010000
> Err:   serial@10010000
> Net:
> Warning: ethernet@10090000 MAC addresses don't match:
> Address in ROM is          52:54:00:12:34:56
> Address in environment is  70:b3:d5:92:f0:01
> eth0: ethernet@10090000
> Hit any key to stop autoboot:  0
>
>
> See this line:
> Address in environment is  70:b3:d5:92:f0:01
>
> It should be: 70:b3:d5:92:f0:03 since I specified serial number as 3.

Fixed, The problem was setting the serial property too early.

Alistair

>
> Regards,
> Bin

