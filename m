Received: from eggs.gnu.org ([2001:4830:134:3::10]:52362)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1djlYk-0007gL-LS
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 08:11:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1djlYg-00071D-SZ
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 08:11:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47489)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1djlYg-00070y-Mg
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 08:11:54 -0400
Message-ID: <1503317503.26016.13.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 21 Aug 2017 14:11:43 +0200
In-Reply-To: <93cb052b-78fb-6934-fd35-1d2805090d2a@msgid.tls.msk.ru>
References: <93cb052b-78fb-6934-fd35-1d2805090d2a@msgid.tls.msk.ru>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] xhci: guard xhci_kick_epctx against recursive
 calls for 2.8?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel qemu-devel <qemu-devel@nongnu.org>


> After applying commit 96d87bdda3919bb16f754b3d3fd1227e1f38f13c:
>=20
> Author: Gerd Hoffmann <kraxel@redhat.com>
> Date:=C2=A0=C2=A0=C2=A0Thu Feb 2 12:36:12 2017 +0100
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0xhci: guard xhci_kick_epctx against recursive c=
alls

> to 2.8, to fix the CVE-2017-9375 in 2.8, it starts to fail at
> startup with the assertion failure introduced in this commit:
>=20
> =C2=A0hw/usb/hcd-xhci.c:2169: xhci_kick_epctx: Assertion `!epctx-
> >kick_active' failed.
>=20
> The commit itself looks sane, but might be there were other
> fixes before this one, on top of 2.8, required for it to
> functioning properly?=C2=A0=C2=A0I'm not sure I understand the xhci
> machinery right.

ddb603ab6c981c1d67cb42266fc700c33e5b2d8f probably.

13e8ff7abbf1dde46280536ab4fae5012661b8b0 should help too, for cherry-
picking without conflicts.

(just back from vacation).

cheers,
  Gerd
