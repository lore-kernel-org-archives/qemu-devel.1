Received: from eggs.gnu.org ([2001:4830:134:3::10]:50801)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eFhlc-0006UQ-0l
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 09:37:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eFhlb-0007FT-6N
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 09:37:16 -0500
Date: Fri, 17 Nov 2017 15:37:08 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20171117143708.GG4795@localhost.localdomain>
References: <20171117112913.21875-1-berrange@redhat.com>
	<9f180831-1ecd-7326-7659-19f79170439e@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="azLHFNyN32YCQGCU"
Content-Disposition: inline
In-Reply-To: <9f180831-1ecd-7326-7659-19f79170439e@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 (for-2.11)] qcow2: fix image corruption
 after committing qcow2 image into base
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>


--azLHFNyN32YCQGCU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 17.11.2017 um 15:32 hat Eric Blake geschrieben:
> On 11/17/2017 05:29 AM, Daniel P. Berrange wrote:
> > After committing the qcow2 image contents into the base image, qemu-img
> > will call bdrv_make_empty to drop the payload in the layered image.
> >=20
> > When this is done for qcow2 images, it blows away the LUKS encryption
> > header, making the resulting image unusable. There are two codepaths
> > for emptying a qcow2 image, and the second (slower) codepath leaves
> > the LUKS header intact, so force use of that codepath.
> >=20
> > Reviewed-by: Eric Blake <eblake@redhat.com>
> > Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> > ---
>=20
> > =20
> >      if (s->qcow_version >=3D 3 && !s->snapshots &&
> > -        3 + l1_clusters <=3D s->refcount_block_size) {
> > +        3 + l1_clusters <=3D s->refcount_block_size &&
> > +        s->crypt_method_header !=3D QCOW_CRYPT_LUKS) {
>=20
> Missing the check for s->nb_bitmaps =3D=3D 0 that Vladimir mentioned on v=
1.
> Either we can add that in this patch, or I can post the obvious followup
> that also needs queuing.

I've already queued this, so please just send a follow-up patch.

Kevin

--azLHFNyN32YCQGCU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJaDvQUAAoJEH8JsnLIjy/WWbsQAKC2fn37mEzbnwG0koBqi9/v
pUyvTiNzznsjbdqgwhiMJNks6Vr+B4Kxwmf5If9xLMDhEEP91H9HDqydCezhGRnb
DvMcOMYQ6OE2a/GmG0REUemZC9eo57uffDt4rCOic9Sgo2VeeF2FuKAdLt3xpPrA
zTtOiUIsXqBV043Vckzwccd7RW82Kw1rqGNAqZrfqLnAnObZIH7YsWQVpvkRuo2Y
/ZYSskDsKebYcx0+T5gk9Sd2kArOAcghmEqhCsr8ygXVUU1YzX7tqe0JFOZNjQic
nM12Z+JMM5ugBcrkcS3HS8xhikSyFc/k3iCzal2gmLOA8tHDPnzPzJe4OMBOeHnV
E7RL5zLa59bXvRB+q6T1ltolLn2223n27SZ2mTXJJG1HdvJc+Eiy6uHuFQ8jhX7O
2GLbSd0LrfNXb3e+fGXrMsxuPewEOByLAt4+wZx14u1deal5BBjkRxO7X1atiMBH
2ilNbfhCrAoEr5zAjPnnq82ohyQPnInP27Kip3EmOBFcQggLP8b4pvBG0iZrrDVX
ZxV+S1a2zjzE7gM3Jr4pYv5EdQWVe790L+uByTPvmR/JEvW+5nqk9xFO6xY5DLND
OV067ahpLH0vdV/G1mo4BZYaZT5WNKtQ3xNDbonRzWmzJADC9OtDvYhuRHCdEp9d
gKL3Mp+8UDAyqIoGx7/+
=V/Nt
-----END PGP SIGNATURE-----

--azLHFNyN32YCQGCU--
