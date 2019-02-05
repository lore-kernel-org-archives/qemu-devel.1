Received: from eggs.gnu.org ([209.51.188.92]:48693)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gr2Cb-0002Yr-Qw
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 09:59:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gr2Ca-0002qi-7Y
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 09:59:57 -0500
Received: from 2.mo1.mail-out.ovh.net ([178.32.119.250]:37570)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1gr2CX-0002gG-Ou
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 09:59:54 -0500
Received: from player168.ha.ovh.net (unknown [10.109.143.249])
	by mo1.mail-out.ovh.net (Postfix) with ESMTP id BB000159C7F
	for <qemu-devel@nongnu.org>; Tue,  5 Feb 2019 15:59:38 +0100 (CET)
Date: Tue, 5 Feb 2019 15:59:15 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20190205155915.32033d52@bahia.lan>
In-Reply-To: <20190205061346.GM22661@umbus.fritz.box>
References: <154774526588.1208625.11295698301887807297.stgit@bahia.lan>
	<154774528595.1208625.15523908858345133758.stgit@bahia.lan>
	<20190205061346.GM22661@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	boundary="Sig_/DQRZdotr82vdwTFlsgGD=Yh";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH v3 03/19] xics: Disintricate allocation and
 type setting of interrupts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, Alexey Kardashevskiy <aik@ozlabs.ru>, =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>, Michael Roth <mdroth@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Dmitry Fleytman <dmitry.fleytman@gmail.com>, Thomas Huth <thuth@redhat.com>

--Sig_/DQRZdotr82vdwTFlsgGD=Yh
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 5 Feb 2019 17:13:46 +1100
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Thu, Jan 17, 2019 at 06:14:46PM +0100, Greg Kurz wrote:
> > The current code assumes that an interrupt is allocated as soon as its
> > type is set to MSI or LSI. PHB hotplug will require to be able to set
> > the type of an interrupt before actually allocating it. =20
>=20
> Hm.. why?
>=20

The justification for that is given in patch 6 actually:

Every PHB needs to claim 4 LSIs to support legacy PCI devices. This is
currently done at PHB realize. When using in-kernel XICS (or upcoming
in-kernel XIVE), QEMU synchronizes the state of all irqs, including
these LSIs, later on at machine reset.

In order to support PHB hotplug, we need a way to tell KVM about the
LSIs that doesn't require a machine reset. Since these irq numbers are
fixed values derived from the PHB index, let's identify them all at
machine init. Older machines that don't have fixed irq numbers cannot
support PHB hotplug and keep the existing behavior.



FYI, I'm currently reworking that part entirely. Maybe not worth wasting to
much time on reviewing this v3.

--Sig_/DQRZdotr82vdwTFlsgGD=Yh
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEtIKLr5QxQM7yo0kQcdTV5YIvc9YFAlxZpMMACgkQcdTV5YIv
c9Zizg/7BYbK0jvR0cyfwtUr1UeeMoCAbCB4Yt3vgO9U1UBqEXGUkxWGZXI6KbD3
M86RgLjNJAFQ9hkMvvp5Vy3tWAd4eVmPELnPw6HU6A4s66JEkP4SvpRsZTbEmqFM
B0VatlHP4wtdqYuAStGB12DnH5G8wFmrLK9/lMfrm7igZMNnkh1uYvmiaZtCsjUY
UDk4jj3Xk3XyNBK0i4GfchltzAZE5atZ5Bewo5U8ZZkJmE+JbqN3HbXNv57fSP4o
fR0kuaUsFL+I4/apFLWStLjB3Odgn8/zBaRAFF4jOcSazVKslfMNdFtmMjYcTJ0r
QPrzp/vrqbvKVS8eViaP57WSXKcRGqdTc5/TtYAdg8KqnMboXMtif8gghmBznBKm
h9p6Oxke4l4lugLXtoTKxT+JNpUEdzDgd74HWpkpNSRWVbCf3H1oW3ImReg7O+Ik
bZhH6yuh1NbziF4wr9wjs1zJAL0d12r1n4MjoPadxPyfJWkamDDakebRMGaaAQRC
x7Tgu3Mylh/gLsB6Ceecz3lvUNqvSnGKi/1FENPrGv5nHP0h8sd/dXyg1CSbziyv
wEdvEOTRkFNRg3eNZu5zmanStaXcxOe0/4ZFzw0OG0eJZvujf7kwkQ5x2CLnUo/r
Fo5XMbfH2GKVa47EvjuLGUtWlzRZpg6aapVqKB8ytEUXW5fQydo=
=4CZD
-----END PGP SIGNATURE-----

--Sig_/DQRZdotr82vdwTFlsgGD=Yh--
