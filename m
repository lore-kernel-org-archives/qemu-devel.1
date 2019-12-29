Return-Path: <SRS0=KIBN=2T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6121EC2D0C0
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Dec 2019 23:17:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34AE820748
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Dec 2019 23:17:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34AE820748
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55894 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ilho4-0006j7-00
	for qemu-devel@archiver.kernel.org; Sun, 29 Dec 2019 18:17:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41215)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ilhmx-0006HM-Aq
 for qemu-devel@nongnu.org; Sun, 29 Dec 2019 18:16:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ilhmw-0002Jd-3H
 for qemu-devel@nongnu.org; Sun, 29 Dec 2019 18:15:59 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:42061)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ilhmv-0002Iw-Va
 for qemu-devel@nongnu.org; Sun, 29 Dec 2019 18:15:58 -0500
Received: by mail-yw1-f68.google.com with SMTP id x138so13489942ywd.9
 for <qemu-devel@nongnu.org>; Sun, 29 Dec 2019 15:15:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=4muagDWPqCJzbtOgkWuKuhfOywclUY0y4uXBo7SEil0=;
 b=Urrr2J03Yv+t+2f+hNuTuGlpAsclfWyTWR8Sz6L0gNniHuVWZQ+b4QrZKCjbxrqgNT
 pByznzQVqb2Qi6WLVtqRYA7UrzZUDMQeosjh7vui1GzXmuCtajhm7sds56KuTtkytriB
 R76AW39kdo0rWsYkVpZs+0hThkugPlZ0xMWluJay+dkNw4Ixz6JreoR+MKc74ypSdvaL
 P3CGHM8uiKx5GjnXV0pwehh9k/WKTtH4cN822shLdZh5pDnIiENRNBVP6CFSYAt9NYV4
 HBi8/dQEMFWWoyx6x793tp6cIeLiy82gHnUFwo7fV3pqMFd9CnJqNeTNQaKUUe9bfG92
 E3gQ==
X-Gm-Message-State: APjAAAXsm1T7xgxHDIfZh6+nofBCQ079kLiaBJKHcA6dL9mJCX6nI+oj
 gfZ+4apm/r8IhJuSyNjbbCxuUMCnvRDP10jWcPg=
X-Google-Smtp-Source: APXvYqxODyKO6PlreH4qal+980/pQykrdTMAmooIiHVFStsL0NFCQ4m8zNt+gBHKkxIz5xxw+t92teqAyw3f9l+7SmA=
X-Received: by 2002:a81:ac55:: with SMTP id z21mr48536324ywj.499.1577661356991; 
 Sun, 29 Dec 2019 15:15:56 -0800 (PST)
MIME-Version: 1.0
References: <20191220211512.3289-1-svens@stackframe.org>
 <20191220211512.3289-6-svens@stackframe.org>
 <8e0f79d6-46ba-a121-b6cc-8c0a5cc4ea14@amsat.org>
 <20191223175006.GA17323@t470p.stackframe.org>
 <37033554-7247-8301-a527-c48f6d74b91a@redhat.com>
 <851902ba-8b89-09ac-b16f-bd6a99cb2c30@gmx.de>
In-Reply-To: <851902ba-8b89-09ac-b16f-bd6a99cb2c30@gmx.de>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 30 Dec 2019 00:15:46 +0100
Message-ID: <CAAdtpL5RdbFFWbRvfXSKv7Z8_f6R+s_Ljo-pvKb5xdSG2hMkaQ@mail.gmail.com>
Subject: Re: [PATCH v5 5/6] hppa: Add emulation of Artist graphics
To: Helge Deller <deller@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.161.68
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
Cc: Sven Schnelle <svens@stackframe.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Dec 27, 2019 at 9:58 PM Helge Deller <deller@gmx.de> wrote:
> On 24.12.19 01:18, Philippe Mathieu-Daud=C3=A9 wrote:
> > On 12/23/19 6:50 PM, Sven Schnelle wrote:
> >> Hi Philippe,
> >>
> >> On Sun, Dec 22, 2019 at 01:37:48PM +0100, Philippe Mathieu-Daud=C3=A9 =
wrote:
> >>>>   +    if (vga_interface_type !=3D VGA_NONE) {
> >>>> +        dev =3D qdev_create(NULL, "artist");
> >>>> +        qdev_init_nofail(dev);
> >>>> +        s =3D SYS_BUS_DEVICE(dev);
> >>>> +        sysbus_mmio_map(s, 0, LASI_GFX_HPA);
> >>>> +        sysbus_mmio_map(s, 1, ARTIST_FB_ADDR);
> >>>
> >>> How is this chipset connected on the board?
> >>> If it is a card you can plug on a bus, you can use a condition.
> >>> If it is soldered or part of another chipset, then it has to be mappe=
d
> >>> unconditionally.
> >>
> >> Depends on the Model. Hp 9000 712 and 715 had it onboard, for the B160=
L
> >> we're emulating and others it was a GSC add-on card.
> >
> > The B160L case is unclear, do you mean this is not the chipset on the m=
achine, but the software is happy if another chipset is available?
> >
> > Looking at hw/hppa/ I only see one machine:
> >
> >   static void machine_hppa_machine_init(MachineClass *mc)
> >   {
> >       mc->desc =3D "HPPA generic machine";
> >       ...
> >   }
> >   DEFINE_MACHINE("hppa", machine_hppa_machine_init)
> >
> > Are you saying this generic machine is able to run different physical h=
w? Why not add them? This shouldn't take long and it would be clearer, what=
 do you think?
> >
> > Adding different machines here in QEMU mostly mean add a class which de=
clare the different properties used by each machine. Igor Mammedov recently=
 suggested to follow the example of aspeed_machine_types[] in hw/arm/aspeed=
.c.
>
> Yes, we plan to add specific machines like 712 (or 715), and maybe a
> C3000 or B2000 over time, as needed device emulations (e.g. tulip, artist=
)
> gets accepted.
> But for that it would be very beneficial if changes (like the Artist emul=
ation
> here in this thread) would be accepted faster upstream....

IMHO the HPPA patches are merged quicker than various other subsystems...
From the cover, this series contains "3311 insertions". If you do the
ratio lines per patch / time for a patch to get accepted, you are not
that bad ;)

To be constructive, how do you think we can improve?
Looking at the git history, except global refactors, I see only 3
contributors, Richard (who merges your patches), you and Sven.
2 users so far, + Richard as tester.

