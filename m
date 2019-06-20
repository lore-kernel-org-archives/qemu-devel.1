Return-Path: <SRS0=JMAk=UT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C5A8C48BE3
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 18:23:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8B6221530
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 18:22:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nAtWZaZA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8B6221530
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52068 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1he1i6-0008A9-UC
	for qemu-devel@archiver.kernel.org; Thu, 20 Jun 2019 14:22:58 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43355)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alistair23@gmail.com>) id 1he1cV-0005MN-Jb
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 14:17:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1he1Pa-0004BR-1X
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 14:03:53 -0400
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43]:42110)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1he1OP-0003b0-0h; Thu, 20 Jun 2019 14:02:38 -0400
Received: by mail-io1-xd43.google.com with SMTP id u19so134381ior.9;
 Thu, 20 Jun 2019 11:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=xiAL8Dxd5KKhwRlNQNGWU4L7hroSCK2EcEjlwDL61N4=;
 b=nAtWZaZA+2zAJWhyY+3kZbjuLSPj4T4rW2ipk2G+CEhrTVZjwDMUjiDqpQ+J1Vp3sJ
 ysgoUsf87zmap8jBti7TkO8kaLBfWjNpvMDJDenfu4et3TiY/kB1Ethp1GOkwhZxG/Aa
 U3JnkGkZoq6xGKfPGGXuiDfJxVv6qfpWnw6jsnNYUIJCYsKJKYv2zBL6Z8+IxYFxADLQ
 69AHNWqLi7NznwOT94OcXViGAKiRodqF+1KsCWcwZ3bcLq9EwcJPK/7/HhaEpu3WHZm9
 wVsmmGhGSZMikRP25q3JYpBEZQOLjA6/sZmVfDO+u4ltIg23rUOEkEjvy32dkLC5i+ot
 WXqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=xiAL8Dxd5KKhwRlNQNGWU4L7hroSCK2EcEjlwDL61N4=;
 b=TOkseE5F3kdr42BDDouGVy8XN3cHf/fgze4g7UeKE7JAOJiyK5Cxh0PBxCbxrbxTAd
 O0NPE+S1Juk2oNzLZqyqtURh//7JVNBtJEMQVfgronUVGZZuAFdUwDu3x4sgmdCbxiF6
 j7/micxIwdMultgibwU6l0DnQkh7jY3ISOAEIONHaWQXWyzq11mYUHib7FlzUT3kjbfP
 35SaUTkD+tIz8hdxWhN6xEoC4IeETTOU8LM2PYu/wbTAbQpKPoJf6jZRIuR9OfuJoKvB
 7bspRHqOPB3g+lVVLulXx8VCVtePHBPwP0fyqNEGC2cT+IcT9z2uEsy3+IJ7+25ISKda
 uHMA==
X-Gm-Message-State: APjAAAWlAoMfgG+TsI8dAsl6TtSm1t0dcUxnTWhxE4G6259IIpwwk9fy
 RoZMdEnzW6gIS5QHE9cwfZBoadZEdSh6tGj8W1A=
X-Google-Smtp-Source: APXvYqzEv97+JGJmkjfEWflVP0LRCdOQQn1qfqB0t5t+kx20rca4EC7WwpmshMonUmtP6XaKHDHjm5iDJTRH94pDvCQ=
X-Received: by 2002:a02:6597:: with SMTP id u145mr6327558jab.26.1561053754290; 
 Thu, 20 Jun 2019 11:02:34 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1560904640.git.alistair.francis@wdc.com>
 <CAEUhbmViJpKtiNXm7CYdF7SPRkOPkvpXJ5+We2m9tZSK_BWi-g@mail.gmail.com>
 <CAKmqyKM4UU+CPKu07AK65bNofbbxxaRkSACqoV_vfFEaH-195A@mail.gmail.com>
 <CAEUhbmUwAVLXY9SSoryWBDeNL8gUfBCE+xweSSmuE9KwzWeX=w@mail.gmail.com>
 <CAKmqyKMmm-38DijX_wL=pAbvxzLQ+KSOtd1xg_GrT4Az70GKsw@mail.gmail.com>
 <11f4e4ff6037427f52824ba586f8a330c12d8dfd.camel@redhat.com>
In-Reply-To: <11f4e4ff6037427f52824ba586f8a330c12d8dfd.camel@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 20 Jun 2019 10:59:43 -0700
Message-ID: <CAKmqyKOh3J07yg3dbaNcOaSzfbDZJJ-kjN3pBh+KqAKq05hzTA@mail.gmail.com>
To: Andrea Bolognani <abologna@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d43
Subject: Re: [Qemu-devel] [Qemu-riscv] [RFC v1 0/5] RISC-V: Add firmware
 loading support and default
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
Cc: Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Palmer Dabbelt <palmer@sifive.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jun 20, 2019 at 1:16 AM Andrea Bolognani <abologna@redhat.com> wrote:
>
> On Wed, 2019-06-19 at 11:23 -0700, Alistair Francis wrote:
> > On Wed, Jun 19, 2019 at 7:42 AM Bin Meng <bmeng.cn@gmail.com> wrote:
> > > On Wed, Jun 19, 2019 at 10:30 PM Alistair Francis <alistair23@gmail.com> wrote:
> > > > On Wed, Jun 19, 2019 at 7:26 AM Bin Meng <bmeng.cn@gmail.com> wrote:
> > > > > >  pc-bios/opensbi-riscv32-fw_jump.elf | Bin 0 -> 197988 bytes
> > > > > >  pc-bios/opensbi-riscv64-fw_jump.elf | Bin 0 -> 200192 bytes
> > > > >
> > > > > Since we are considering adding "bios" images, I prefer to add the
> > > > > pure binary images instead of ELF images here.
> > > >
> > > > I didn't think about that. Can we just boot them in QEMU like we do
> > > > with the ELFs?
> > >
> > > Yes, use load_image_targphys() instead of load_elf().
> >
> > Ah, that is obvious. I'll update it to use the bin files then.
>
> I'm unclear on the advantages of using one format over the other,

The main one that I see is that everyone else is already using .bin
and no one else is using .elf.

> but one question comes to mind: once this is in, we will probably
> want to have OpenSBI packaged separately in distributions, the same
> way it already happens for SeaBIOS, SLOF and edk2-based firmwares.
>
> Will using either of the formats prevent that from happening?

Both options allow this.

OE-Core already packages OpenSBI by default, Fedora and Debian are
moving to OpenSBI for RISC-V targets as well.

Any distro that supports the RISC-V toolchain (which is all
upstreamed) can build OpenSBI.

Alistair

>
> --
> Andrea Bolognani / Red Hat / Virtualization
>

