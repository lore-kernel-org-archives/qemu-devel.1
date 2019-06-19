Return-Path: <SRS0=PARU=US=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4A0DC31E49
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 14:29:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3E3C2166E
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 14:29:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QJPLDI6q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3E3C2166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38896 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdban-0007Pb-US
	for qemu-devel@archiver.kernel.org; Wed, 19 Jun 2019 10:29:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57332)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alistair23@gmail.com>) id 1hdbZL-0006Lk-NI
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 10:28:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1hdbZJ-00021x-Mx
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 10:28:11 -0400
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:40097)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1hdbZD-0001q8-7P; Wed, 19 Jun 2019 10:28:03 -0400
Received: by mail-lj1-x243.google.com with SMTP id a21so3471192ljh.7;
 Wed, 19 Jun 2019 07:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=HwtxNsMoRWUQgIlnOJ2sPnBJWXTpJU5qkiNmoJTsjoA=;
 b=QJPLDI6qoHbE3XDji7LrYh6Z2GbVNNhSQ8zyEQ7xPOhdwDIAUX/ADk6+V6bdsmKcAE
 mtAPu8Wt7RBOy/+2Ig3xhF/FIY8cRhjwhglnN51QVA20xi5KFSMnfioHfZcEQ2zSznYZ
 tTngUMI0WshjaLK61JsX14QOFVySLUh/7rOMWlq8RgLz+X2Wl2hudGY1LNX3o9lWIiWF
 MiGhNwkn4qhHEU7kV2P4KXGPTEX4mmLGswsp6/Mujbe/pPzg7nJt74F3Y0umyWtrQU2d
 /YlhXGP3h5WVxTRa9EdclgGMPvwtA59Gm7N0G+b5zHxcxMkHTrPK9WSoOJ+kETvyf9Hj
 REGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=HwtxNsMoRWUQgIlnOJ2sPnBJWXTpJU5qkiNmoJTsjoA=;
 b=Xdm1HYIF/wEaTIXWIvTNqxe/jiNbUiX1xEskNUsapsQ8VCkxWSIYHMdn1aKPmmXlxL
 rWqLBeULKBST+wttiz4wuLpvOA5G7Ew7R8hs9doPzMpC+5pksvmqOgj2bpWUhNVEm52F
 69J4ZrKGP8au0La8ZFA4DY7lLGmIu4bddeqel24EB07AM5EJEnIPJn91y759qWFSMmmh
 2ZcAazwhHIsa+5FCe2tHYai2JbkeswU0vsFpOdfrVwHyzdLbhlDoETOGtiCv5ictyyvV
 BGgkLvP6HAz1ROx359By8yQI9xtcXYyUvjFTvj6KNkqh7lRrPrDPW5NCwUtGg1X0erUF
 3ZbA==
X-Gm-Message-State: APjAAAXQnsPZGejIJUrQ1zBd1Ru7QGHKLavFQXQwhQC8WaXAAslM/6oD
 qfxXA+t/GNNdkHcZ7LgpxwDmrLbU1WNP3qdUqkY=
X-Google-Smtp-Source: APXvYqzeMVW+mSIvB5MjPAUw/4Kk7/XFWd30UUkmfZZ2fcwi26nPpf7lah9dr5pQRc7/lhHpq7hF2Fkj6hkn06t+TUU=
X-Received: by 2002:a2e:94ca:: with SMTP id r10mr7717510ljh.196.1560954481143; 
 Wed, 19 Jun 2019 07:28:01 -0700 (PDT)
MIME-Version: 1.0
References: <CAKmqyKMs4nt0eddFkXHG9vOdxnj=yB8jx8s9NivNiwvVg8TObA@mail.gmail.com>
 <mhng-03d5c9ed-4818-4efc-99e0-cdceab2eab3d@palmer-si-x1e>
 <20190611063019.2uiatioxh73lrgqz@sirius.home.kraxel.org>
 <CAKmqyKMgNrGchEa0D+FsbmoOfs259awtge20EaNb=Bv1JtP6vA@mail.gmail.com>
In-Reply-To: <CAKmqyKMgNrGchEa0D+FsbmoOfs259awtge20EaNb=Bv1JtP6vA@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 19 Jun 2019 07:27:34 -0700
Message-ID: <CAKmqyKNBkDXsQ9y73LkmbFV4eRQkMH_BugKuzHHoL0n3+ioKmg@mail.gmail.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::243
Subject: Re: [Qemu-devel] RISC-V: Include ROM in QEMU
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
 Sagar Karandikar <sagark@eecs.berkeley.edu>, onathan@fintelia.io,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmer@sifive.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jun 18, 2019 at 3:17 PM Alistair Francis <alistair23@gmail.com> wrote:
>
> On Mon, Jun 10, 2019 at 11:30 PM Gerd Hoffmann <kraxel@redhat.com> wrote:
> >
> > On Fri, Jun 07, 2019 at 05:03:42PM -0700, Palmer Dabbelt wrote:
> > > On Thu, 06 Jun 2019 16:22:47 PDT (-0700), alistair23@gmail.com wrote:
> > > > Hello,
> > > >
> > > > As a test of the waters, how would the QEMU community feel about
> > > > including the RISC-V OpenSBI project as a ROM submodule?
> > > >
> > > > The idea would be to have OpenSBI (similar to ATF for ARM and a BIOS
> > > > for x86) included by default to simplify the QEMU RISC-V boot process
> > > > for users. This would remove the requirement for users/developers to
> > > > build a RISC-V firmware. The goal here is to allow people to just
> > > > download and run their kernel as easily as they currently do for x86.
> > > >
> > > > We would make sure that it can be disabled! That is users/developers
> > > > can use their own (or none) if they want to. The idea here is just to
> > > > simplify the boot process, not lock anyone out.
> > >
> > > I like it.  My only question is about the mechanics of doing so: are we just
> > > going to assume there's a cross compiler in PATH?  I guess that's less of a
> > > usability headache than needing a complier and a firmware.
> >
> > Usual way to add firmware:
> >
> >   (1) Add a submodule below roms/
> >   (2) Add rules to build the firmware to roms/Makefile.  Firmware
> >       maintainers can use them, and they also document the build process.
> >       A normal qemu build will not automatically build the firmware
> >       though.
> >   (3) Place a pre-built binary in pc-bios/
> >
> > There is some cross compiler detection logic in roms/Makefile which you
> > can use.
>
> Thanks for the info. I have it all working now, just running a few
> more tests. I will send my patches out today or tomorrow.

We hit the problem in RISC-V now that including a firmware by default
will break all existing users as they are already passing the firmware
in via -kernel.

I don't suppose any other architecture ever had this problem and has a
nice fix? At the moment the only fix I can think of is only include
the default firmware if the user specifies "-bios default". Then
hopefully once everyone is doing that we can make it the default and
not break anything. I can't see a sane way to automatically extract
the information from the kernel binary to be smart about the default.

Alistair

>
> Alistair
>
> >
> > cheers,
> >   Gerd
> >

