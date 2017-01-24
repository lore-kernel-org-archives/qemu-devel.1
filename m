Received: from eggs.gnu.org ([2001:4830:134:3::10]:36211)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cVz9X-0002c2-Ux
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 06:20:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cVz9U-0006K7-Pc
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 06:20:43 -0500
Received: from indium.canonical.com ([91.189.90.7]:60291)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cVz9U-0006JK-9j
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 06:20:40 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cVz9S-0006Rr-BN
	for <qemu-devel@nongnu.org>; Tue, 24 Jan 2017 11:20:38 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 4E52F2E80BF
	for <qemu-devel@nongnu.org>; Tue, 24 Jan 2017 11:20:38 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Jan 2017 11:10:25 -0000
From: Gerd Hoffmann <1658634@bugs.launchpad.net>
Reply-To: Bug 1658634 <1658634@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20170123095738.20994.7212.malonedeb@gac.canonical.com>
	<1485253217-7405-1-git-send-email-kraxel@redhat.com>
	<CAJ+F1CKV8R7bpOjVHjHt=N2QqGdV-O3-Tb8DGs=ZWfKf4WYPDA@mail.gmail.com>
Message-Id: <1485256225.32716.33.camel@redhat.com>
Errors-To: bounces@canonical.com
Subject: Re: [Qemu-devel] [Bug 1658634] [PATCH] console: fix console resize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

> > -    if (s->surface &&
> > +    if (s->surface && (surface->flags & QEMU_ALLOCATED_FLAG) &&
> >          pixman_image_get_width(s->surface->image) =3D=3D width &&
> >          pixman_image_get_height(s->surface->image) =3D=3D height) {
> >          return;
> >
> =

> You are missing the 's->' !

Good catch.  /me wonders why gcc didn't throw a warning on that one.

Fixed.

thanks,
  Gerd

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1658634

Title:
  Can't get correct display with latest QEMU and OVMF BIOS

Status in QEMU:
  Confirmed

Bug description:
  I tried to install a Ubuntu 16.04.1 Desktop 64bits with latest QEMU and O=
VMF UEFI BIOS, however I can't get correct display output with default vga =
configuration (-vga std). However, qemu works with a couple of different co=
nfigurations:
  1. "-vga cirrus" + "-bios OVMF.fd": works
  2. "-vga std" + non-UEFI bios: works

  The same error with QEMU 2.8.0 release. Everything works well on
  2.7.0/1.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1658634/+subscriptions
