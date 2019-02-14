Received: from eggs.gnu.org ([209.51.188.92]:57145)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gu7q2-0000Zu-Vw
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 22:37:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gu7q2-0002ke-3P
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 22:37:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37838)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1gu7q1-0002h4-Rk
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 22:37:26 -0500
Date: Thu, 14 Feb 2019 11:37:17 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190214033717.GE21877@stefanha-x1.localdomain>
References: <1550022537-27565-1-git-send-email-changpeng.liu@intel.com>
	<20190213080143.GE26332@stefanha-x1.localdomain>
	<20190213083227.xkih3ckbtiromd2v@steredhat>
	<20190213121703.zmzpgl4fvvsfg4pf@steredhat>
	<20190213120418-mutt-send-email-mst@kernel.org>
	<CAGxU2F7Pn2N4fxr54jg4fUsNNT2Yo-OR10XHqfCLKv=BhQUCBQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FEz7ebHBGB6b2e8X"
Content-Disposition: inline
In-Reply-To: <CAGxU2F7Pn2N4fxr54jg4fUsNNT2Yo-OR10XHqfCLKv=BhQUCBQ@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v4] virtio-blk: set correct config size for
 the host driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, Changpeng Liu <changpeng.liu@intel.com>, qemu devel list <qemu-devel@nongnu.org>, Lukas Doktor <ldoktor@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Greg Kurz <groug@kaod.org>


--FEz7ebHBGB6b2e8X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 13, 2019 at 06:45:20PM +0100, Stefano Garzarella wrote:
> I'm not sure if using the feature_sizes array the migration works well.
> I mean if we have QEMU 3.1 with a single queue and we want to migrate to
> QEMU 4.0 with a single queue, the config_size could be different,
> because VIRTIO_NET_F_MQ is not set in the host_features.
>=20
> Maybe we should initialize a config_size to the VIRTIO_BLK_CFG_SIZE macro
> defined by Changpeng and then use the feature_sizes arrays only for the
> new features (i.e.  discard, write_zeroes)
>=20
> What do you think?

I agree.  The config size must not change for existing machine types.

Your code makes sense for future features but old features must use the
static config size.

Stefan

--FEz7ebHBGB6b2e8X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcZOJtAAoJEJykq7OBq3PIj28H/2OPFSoHyiL6/0Ceag8R/FDL
BZJ9KSnWsmXexNCmxfhUujlxEjRkwvWvzgohgxf9MKAvtoeAMaXndboIDedtwXYX
ASqUYuQZNn6fG8Y4RUlw9tLugRrWteiKKpJRWiZk/KaP1KTSG2xehgtVPGxwKh3N
yc1zNTD5Nc38LZd0EGmYo72gvu5o70pJuJCUjx9elhgaLP+G8HmPh6KVTV2Y4vpP
QRvufhy7+cfw+XCqKyJmIZepkkjZaPfRfQkw43GMgAXneLjZqcC4ljw8dg80942W
0PdrBHJJu+pYUxjLIlS2PgxeT6CBFF+eTERN5+2Yv9a8wTWYLrK9DKvZjtnUp60=
=0UXa
-----END PGP SIGNATURE-----

--FEz7ebHBGB6b2e8X--
