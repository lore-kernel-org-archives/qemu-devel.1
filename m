Received: from eggs.gnu.org ([2001:4830:134:3::10]:58771)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dSjq1-0004Bm-Ld
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 08:55:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dSjpx-0002Lq-P7
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 08:55:25 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:35195)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dSjpx-0002LJ-I7
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 08:55:21 -0400
Received: by mail-wm0-x242.google.com with SMTP id u23so32343849wma.2
	for <qemu-devel@nongnu.org>; Wed, 05 Jul 2017 05:55:21 -0700 (PDT)
Date: Wed, 5 Jul 2017 13:55:17 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170705125517.GB1280@stefanha-x1.localdomain>
References: <20170615163813.7255-1-stefanha@redhat.com>
	<27a724bc-95c0-9d9f-ea90-015fcdf7dc92@virtuozzo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Yylu36WmvOXNoKYn"
Content-Disposition: inline
In-Reply-To: <27a724bc-95c0-9d9f-ea90-015fcdf7dc92@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH 0/5] qemu-iotests: test savevm/loadvm
 iothread (and make it work!)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Butsykin <pbutsykin@virtuozzo.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, "Denis V. Lunev" <den@openvz.org>, Roman Kagan <rkagan@virtuozzo.com>


--Yylu36WmvOXNoKYn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 19, 2017 at 03:26:56PM +0300, Pavel Butsykin wrote:
> On 15.06.2017 19:38, Stefan Hajnoczi wrote:
> > This series extends qemu-iotests 068 to also run with iothread enabled.=
  Doing
> > so was harder than expected because:
> >=20
> > 1. ioeventfd is disabled without -M accel=3Dkvm even though it should w=
ork
> > 2. loadvm still has an iothread bug
> >=20
> > Instead of adding a ./check -iothread option I decided to always run th=
e test.
> > Kevin recently recommended this approach; the advantage is that iothrea=
d *will*
> > always be tested iothread mode whereas people won't run ./check -iothre=
ad.
>=20
> Why not just add -iothread option in check-block.sh? We can do an
> additional run with -iothread, as it is done for different block
> formats.
>=20
> Because all the test cases already exist, we can just reuse them.

=46rom the email:

  "the advantage is that iothread *will* always be tested iothread mode
  whereas people won't run ./check -iothread"

Both approaches have pros and cons.

If we decide to use ./check -iothread then it's necessary to figure out
which tests -iothread even applies to.  Tests that use qemu-img/qemu-io
do not use iothread.  Only tests that launch QEMU can take advantage of
iothread today.

Stefan

--Yylu36WmvOXNoKYn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZXOG1AAoJEJykq7OBq3PIDhwIAKA61M7E3TvSFxCf+8MoMBIl
VQYNyX+eF4ez9JBll7xpT+5H2FpDwOo8Q/fvEsVSYy0XV0dUbrF7DLZfFt3zAcRz
NOz4AYx7PUWnFuz0l5X2AX0VnvgftWtcRFsWewfezTQvvDPOupVjs4hOuQBUS/LI
w5mxT5g/cICKRpQnzeKvS5d/UvQoZkxxZvSj1Hbv148NCH3iish42s/JyYQAKFez
zW7pwAtWOwD1g2JPxdnRj9ppGCFFE42x8Nd5IOPyNH4DEL5clJunTpncM4ReaviY
jc0a2wsp00d0l7wSq+T+llpRkGz6UANVTVbEyoJ4LFrnOeCOvQ/LNrlTeMAn4cg=
=JyEu
-----END PGP SIGNATURE-----

--Yylu36WmvOXNoKYn--
