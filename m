Received: from eggs.gnu.org ([209.51.188.92]:59194)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hDqdA-0006kR-S0
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 09:17:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hDqd9-0007ZN-NR
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 09:17:40 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:39021)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1hDqd9-0007Xy-AE
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 09:17:39 -0400
Received: by mail-wr1-x441.google.com with SMTP id j9so20879085wrn.6
	for <qemu-devel@nongnu.org>; Tue, 09 Apr 2019 06:17:38 -0700 (PDT)
Date: Tue, 9 Apr 2019 14:17:34 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20190409131734.GE16944@stefanha-x1.localdomain>
References: <20190401111843.54528-1-ybettan@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wTWi5aaYRw9ix9vO"
Content-Disposition: inline
In-Reply-To: <20190401111843.54528-1-ybettan@redhat.com>
Subject: Re: [Qemu-devel] [RFC-PATCH] Introducing virtio-example device.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yoni Bettan <ybettan@redhat.com>
Cc: qemu-devel@nongnu.org, ailan@redhat.com, ehabkost@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>


--wTWi5aaYRw9ix9vO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 01, 2019 at 02:18:43PM +0300, Yoni Bettan wrote:
> The main goal is to add an example device to Qemu to be used as template =
or
> guideline for contributors when they wish to create a new virtio device.
>=20
> Another reason for this device is to document "the right way" to write
> a new virtio device in Qemu.
>=20
> This device is a simple device and its functionality is to increase its i=
nput
> by 1.
>=20
> The device driver is located at:
> https://github.com/ybettan/QemuDeviceDrivers.git
>=20
> In addition I am writing a blog to give a logical overview of the virtio
> protocol and a step-by-step guide to write a new virtio device.
> This blog can be found at https://howtovms.wordpress.com.
>=20
> scripts/checkpatch.pl have some errors do to "//" (old style one line com=
ment),
> those lines contains FIXMEs for the next version and will be removed.
>=20
> Signed-off-by: Yoni Bettan <ybettan@redhat.com>

Where is the specification for this device?  The lack of specification
is already not "the right way".

There are multiple problems with the code, but the larger issue is that
this example device is just helping people shoot themselves in the foot
more easily.

The difficulty with VIRTIO is not how to implement devices/drivers, it's
that people don't read the specification and therefore do not understand
the device model properly.  The spec is dry and missing information in
some places.  I think more accessible documentation, like your blog, can
help here.

If you would like to educate people about VIRTIO, then explaining the
device model, lifecycle, how to change a device in a
backwards-compatible way, virtqueue semantics, etc are the topics that
deserve attention.

For someone who has learnt these topics, implementing the device/driver
is not hard.  For someone who doesn't understand these topics, no
example device will help.  At best they will copy-paste together
something that sort of works but has issues.

Stefan

--wTWi5aaYRw9ix9vO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcrJttAAoJEJykq7OBq3PIPPwIAIKF152sgXyO5boc8OrpO4yd
YBOevTT5xhGAWGD8SVLW0aNZ9jcwyFcvFhbpomBSueFTj43U9zedqXPLUjOlsQDE
xsYmo0pGZy7voMJPYHOxQEV6efeBNfsMIqOTIyw5VNRuBu+U6hbyT7oCEsov07SV
A+6DYDVYXaYiajSDgZs3iwihyaZHaRc/GW2zc2W+210WSrwVAijkmxZPg4mIJWzJ
HMhLmAJ/jnKRVSXyZG383TvMe6bZFGwzOk/8+dNQGFqk6BJVcMOvI7WyhE93Ic2G
vCAZ4GfkaQss5Rm+1MBY99A97yIte+iYmn4s9kydR6p+qNLmXVZ0Lq3pxUTUNbU=
=35DD
-----END PGP SIGNATURE-----

--wTWi5aaYRw9ix9vO--
