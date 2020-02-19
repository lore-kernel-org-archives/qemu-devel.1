Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72E2DC34031
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 01:07:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4890024655
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 01:07:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4890024655
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43890 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4Dpy-0001HI-EG
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 20:07:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42921)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <fthain@telegraphics.com.au>) id 1j4Doy-0008KJ-TF
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 20:06:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <fthain@telegraphics.com.au>) id 1j4Dox-0002nB-Kv
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 20:06:36 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:43902)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <fthain@telegraphics.com.au>)
 id 1j4Dox-0002kE-Fe; Tue, 18 Feb 2020 20:06:35 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
 by kvm5.telegraphics.com.au (Postfix) with ESMTP id 36AA329AB9;
 Tue, 18 Feb 2020 20:06:30 -0500 (EST)
Date: Wed, 19 Feb 2020 12:06:27 +1100 (AEDT)
From: Finn Thain <fthain@telegraphics.com.au>
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>, 
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>
Subject: Re: [PATCH v4 00/14] Fixes for DP8393X SONIC device emulation
In-Reply-To: <CAL1e-=iOQ52y0vbXAYaYDKqoepD09xO2=3d55WM32=9TFwFzAg@mail.gmail.com>
Message-ID: <alpine.LNX.2.22.394.2002191150440.8@nippy.intranet>
References: <cover.1580290069.git.fthain@telegraphics.com.au>
 <CAL1e-=iOQ52y0vbXAYaYDKqoepD09xO2=3d55WM32=9TFwFzAg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="-1463811774-1115368016-1582073893=:8"
Content-ID: <alpine.LNX.2.22.394.2002191159100.8@nippy.intranet>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 98.124.60.144
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
Cc: Jason Wang <jasowang@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811774-1115368016-1582073893=:8
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <alpine.LNX.2.22.394.2002191159101.8@nippy.intranet>

On Tue, 18 Feb 2020, Aleksandar Markovic wrote:

> On Wednesday, January 29, 2020, Finn Thain <fthain@telegraphics.com.au>
> wrote:
>=20
> > Hi All,
> >
> > There are bugs in the emulated dp8393x device that can stop packet
> > reception in a Linux/m68k guest (q800 machine).
> >
> > With a Linux/m68k v5.5 guest (q800), it's possible to remotely trigger
> > an Oops by sending ping floods.
> >
> > With a Linux/mips guest (magnum machine), the driver fails to probe
> > the dp8393x device.
> >
> > With a NetBSD/arc 5.1 guest (magnum), the bugs in the device can be
> > fatal to the guest kernel.
> >
> > Whilst debugging the device, I found that the receiver algorithm
> > differs from the one described in the National Semiconductor
> > datasheet.
> >
> > This patch series resolves these bugs.
> >
> > AFAIK, all bugs in the Linux sonic driver were fixed in Linux v5.5.
> > ---
>=20
>=20
> Herve,
>=20
> Do your Jazz tests pass with these changes?
>=20

AFAIK those tests did not expose the NetBSD panic that is caused by=20
mainline QEMU (mentioned above).

I have actually run the tests you requested (Herv=C3=A9 described them in a=
n=20
earlier thread). There was no regression. Quite the reverse -- it's no=20
longer possible to remotely crash the NetBSD kernel.

Apparently my testing was also the first time that the jazzsonic driver=20
(from the Linux/mips Magnum port) was tested successfully with QEMU. It=20
doesn't work in mainline QEMU.

Anyway, more testing is always nice, and I'd certainly welcome an=20
'acked-by' or 'tested-by' if Herv=C3=A9 would like to send one.

Please consider backporting this series of bug fixes to QEMU stable=20
branch(es).

Regards,
Finn

> Regards,
> Aleksandar
>=20
>=20
>=20
> > Changed since v1:
> >  - Minor revisions as described beneath commit logs.
> >  - Dropped patches 4/10 and 7/10.
> >  - Added 5 new patches.
> >
> > Changed since v2:
> >  - Minor revisions as described beneath commit logs.
> >  - Dropped patch 13/13.
> >  - Added 2 new patches.
> >
> > Changed since v3:
> >  - Replaced patch 13/14 with patch suggested by Philippe Mathieu-Daud=
=C3=A9.
> >
> >
> > Finn Thain (14):
> >   dp8393x: Mask EOL bit from descriptor addresses
> >   dp8393x: Always use 32-bit accesses
> >   dp8393x: Clean up endianness hacks
> >   dp8393x: Have dp8393x_receive() return the packet size
> >   dp8393x: Update LLFA and CRDA registers from rx descriptor
> >   dp8393x: Clear RRRA command register bit only when appropriate
> >   dp8393x: Implement packet size limit and RBAE interrupt
> >   dp8393x: Don't clobber packet checksum
> >   dp8393x: Use long-word-aligned RRA pointers in 32-bit mode
> >   dp8393x: Pad frames to word or long word boundary
> >   dp8393x: Clear descriptor in_use field to release packet
> >   dp8393x: Always update RRA pointers and sequence numbers
> >   dp8393x: Don't reset Silicon Revision register
> >   dp8393x: Don't stop reception upon RBE interrupt assertion
> >
> >  hw/net/dp8393x.c | 202 +++++++++++++++++++++++++++++++----------------
> >  1 file changed, 134 insertions(+), 68 deletions(-)
> >
> > --
> > 2.24.1
> >
> >
> >
>=20
---1463811774-1115368016-1582073893=:8--

