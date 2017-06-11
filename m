Received: from eggs.gnu.org ([2001:4830:134:3::10]:56046)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dK1ic-0003Uc-7Z
	for qemu-devel@nongnu.org; Sun, 11 Jun 2017 08:11:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dK1ib-00032D-5x
	for qemu-devel@nongnu.org; Sun, 11 Jun 2017 08:11:46 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:47283)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1dK1ia-00031t-OV
	for qemu-devel@nongnu.org; Sun, 11 Jun 2017 08:11:45 -0400
Date: Sun, 11 Jun 2017 20:10:15 +0800
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170611121015.GA18542@umbus>
References: <20170602194523-mutt-send-email-mst@kernel.org>
	<20170605030725.GF4056@pxdev.xzpeter.org>
	<f68502e6-875c-0e46-f7cf-127c23513d20@redhat.com>
	<20170606234705.GG13397@umbus.fritz.box>
	<20170607034443.GA7983@pxdev.xzpeter.org>
	<20170607160445-mutt-send-email-mst@kernel.org>
	<20170608061150.GA3628@pxdev.xzpeter.org>
	<20170608215918-mutt-send-email-mst@kernel.org>
	<20170609015847.GG3628@pxdev.xzpeter.org>
	<20170611130710-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ZPt4rx8FFjLCG7dd"
Content-Disposition: inline
In-Reply-To: <20170611130710-mutt-send-email-mst@kernel.org>
Subject: Re: [Qemu-devel] [PATCH 2/3] exec: simplify
 address_space_get_iotlb_entry
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, Maxime Coquelin <maxime.coquelin@redhat.com>, Jason Wang <jasowang@redhat.com>, Alex Williamson <alex.williamson@redhat.com>


--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 11, 2017 at 01:09:26PM +0300, Michael S. Tsirkin wrote:
> On Fri, Jun 09, 2017 at 09:58:47AM +0800, Peter Xu wrote:
> > > > The problem is that when I was fixing the problem that vhost had wi=
th
> > > > PT (a764040, "exec: abstract address_space_do_translate()"), I did
> > > > broke the IOTLB translation a bit (it was using page masks). IMHO we
> > > > need to fix it first for correctness (patch 1/2).
> > > >=20
> > > > For patch 3, if we can have Jason's patch to allow dynamic
> > > > iommu_platform switching, that'll be the best, then I can rewrite
> > > > patch 3 with the switching logic rather than caching anything. But
> > > > IMHO that can be separated from patch 1/2 if you like.
> > > >=20
> > > > Or do you have better suggestion on how should we fix it?
> > > >=20
> > > > Thanks,
> > >=20
> > > Can we drop masks completely and replace with length? I think we
> > > should do that instead of trying to fix masks.
> >=20
> > Do you mean to modify IOMMUTLBEntry.addr_mask into length?
>=20
> I think it's better than alternatives.
>=20
> > Again, I am not sure this is good... At least we need to get ack from
> > David since spapr should be the initial user of it, and possibly also
> > Alex since vfio should be assuming that (IIUC both in QEMU and kernel)
> > addr_mask is page masks rather than arbirary length.
> >=20
> > (CC Alex)
> >=20
> > Thanks,
>=20
> Callbacks that need powers of two can easily split up the range.

I think I missed part of the thread.  What's the original use case for
non-power-of-two IOTLB entries?  It certainly won't happen on Power.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--ZPt4rx8FFjLCG7dd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZPTMkAAoJEGw4ysog2bOSeWIP/1KlxVjyMWvs9Kkg9vc10aHR
xGSOI/DJALgg2ZbgKp/dcOuaJmBtcao4hd9Xmu8W42pDsqzOv5UI2mFaWUuq+MD3
FQlf6wH8hLWacLCU5yI0nGT7w+Zt5GFPE2hQp1g9KZSE8KfRGRlnFj2/ZJhZAJWo
nNgfogL9AhjtT+GT1vvwc9AWq1PYYZZk1AVTpMqI52dB92ugn3phufCXC3OrHML3
CVu5D4//FB/bbaCj6QruzUizGmddv451qbBXI1vjkE6hF0UJ/jh4rY9RWeMY4+xE
ofSmQNL0jyQuewCV3kov4U+z71azOuVSGV1eN0ihYQrdYhTYTxb5lHaLtQ5Mq7tU
Mgwk6vQPcC/QcRdOh8yDT1K4s5etm3d4Nnb/twtb6dUbeh2aIQFflOzg1P8zt3kq
oVI8U3O6MGvASUWAV7I/Tvy/5zSfb6ymstoUn+Xp3fNvOm3Y5+JbWgLRIA3MXIwF
5HeDQbyBrUdmC7ogp0JsqdSPGpWKGgpAoaXJF4yTZS+MCAy6dsrGQgYeyc62V57D
U8/ZglITg4WDdMejAPeW74//DwMVnM974wIPL7WjfhwfpmxX6zASu7M76Ex0eoxY
lBsiji+f6S+AWrzf7kf82cFbvJeU99kNvwIGX2xm2MuFCCnki/k6SdEatKt6D/z/
wZIOO02UI9OmnBv2LBz+
=E6R2
-----END PGP SIGNATURE-----

--ZPt4rx8FFjLCG7dd--
