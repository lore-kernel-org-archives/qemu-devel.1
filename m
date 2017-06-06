Received: from eggs.gnu.org ([2001:4830:134:3::10]:37988)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dIRWI-0003Zu-Nz
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 23:20:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dIRWF-0002Rz-0h
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 23:20:30 -0400
Received: from ozlabs.org ([103.22.144.67]:59687)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1dIRWE-0002P3-DQ
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 23:20:26 -0400
Date: Wed, 7 Jun 2017 09:47:05 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170606234705.GG13397@umbus.fritz.box>
References: <1496404254-17429-1-git-send-email-peterx@redhat.com>
	<1496404254-17429-3-git-send-email-peterx@redhat.com>
	<20170602194523-mutt-send-email-mst@kernel.org>
	<20170605030725.GF4056@pxdev.xzpeter.org>
	<f68502e6-875c-0e46-f7cf-127c23513d20@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="d5ZB48mKYG2jsBgL"
Content-Disposition: inline
In-Reply-To: <f68502e6-875c-0e46-f7cf-127c23513d20@redhat.com>
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
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, Maxime Coquelin <maxime.coquelin@redhat.com>, Jason Wang <jasowang@redhat.com>


--d5ZB48mKYG2jsBgL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 06, 2017 at 04:34:30PM +0200, Paolo Bonzini wrote:
>=20
>=20
> On 05/06/2017 05:07, Peter Xu wrote:
> > I don't sure whether it'll be a good interface for IOTLB. AFAIU at
> > least for VT-d, the IOMMU translation is page aligned which is defined
> > by spec, so it makes sense that (again at least for VT-d) here we'd
> > better just use page_mask/addr_mask.
> >=20
> > That's also how I know about IOMMU in general - I assume it do the
> > translations always with page masks (never arbitary length), though
> > page size can differ from platfrom to platform, that's why here the
> > IOTLB interface used addr_mask, then it works for all platforms. I
> > don't know whether I'm 100% correct here though.
> >=20
> > Maybe David/Paolo/... would comment as well?
>=20
> I would ask David.  There are PowerPC MMUs that allow fast lookup of
> arbitrarily-sized windows (not necessarily power of two),

Uh.. I'm not sure what you mean here.  You might be thinking of the
BATs which really old (32-bit) PowerPC MMUs had - those allow
arbitrary large block translations, but they do have to be a power of
two.

> so maybe the
> IOMMUs can do the same.

The only Power IOMMU I know about uses a fixed, power-of-two page size
per DMA window.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--d5ZB48mKYG2jsBgL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZNz75AAoJEGw4ysog2bOSJ00QAMA3Byrqx3L6+jrdbc4jhegx
UPWaVFfN6wXDaxcmOOOK2xX3YdH7G3qqH+wU3mYEMyDfgl6jYLG4Ctb/DhAB6e7f
gCX4DpEJrx4uvx6taIBR3PQGlgdyvgdnKXtFxkJXDDe4vxNmfutvrEp97Grl7L1d
vZ7hrj2HngjKqrXBH9GH/o3wGaE336rCHt5QXpZjzTdGGmOxV/0vv2GDalIpZiHi
Bqf58hJIaBuThuHaEBSF0GvtWpgmUgQ1FxJb59yiU9Re0KitWYXYGUHndCBkf/9E
4SUtPUo/VzsZYGaG8IGsPqbVSFGC4H4OyZCMiOKiVDVUwQmKJrdKHctDM8lpNhTb
9/+hyQV0EFDA+N5hlhOS+hG6LI5KSZo0TWX/+Ama7KxbC0uLmNbnxZYynnIZkrsA
TbqIfG7DMCK+Rehw0wc8JsRSQJYfg3U6jYceG5gIbwoUFfC3jQ2Ir1k/ELZ9zpst
76RJtSi8gG9Fmi9wHpXl+uaKS1pMhgniZ+c2LBODLZ7WKy0UTshxPnrF1/YVzZ6T
OQ7v5qdB0xHZ34NXbzTXeZAxkfSytL1pSTMn5d1S0ITTxyfn7DkukzyX7ftoHwEQ
hhzdb6AwWUTPvSAQdOLi3KEbfAW+zeY3W17WOvj55PeNrFl9Ofxls04F3xl0oONj
r4IUZ8E9ki9XV68OVQU2
=e5yI
-----END PGP SIGNATURE-----

--d5ZB48mKYG2jsBgL--
