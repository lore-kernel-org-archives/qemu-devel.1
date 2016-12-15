Received: from eggs.gnu.org ([2001:4830:134:3::10]:44327)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cHR4m-0002wP-Ej
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 03:07:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cHR4j-00017g-4b
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 03:07:40 -0500
Received: from mail-wm0-f50.google.com ([74.125.82.50]:35391)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cHR4i-00017Q-VF
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 03:07:37 -0500
Received: by mail-wm0-f50.google.com with SMTP id a197so150992202wmd.0
	for <qemu-devel@nongnu.org>; Thu, 15 Dec 2016 00:07:36 -0800 (PST)
Date: Thu, 15 Dec 2016 08:06:34 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20161215080634.GF26169@stefanha-x1.localdomain>
References: <CA+scX6=9y4wDBWzXyqpGh9U__usKUa6sxwdc63iA8YRmpWFPqA@mail.gmail.com>
	<20161214193107.GB20648@stefanha-x1.localdomain>
	<CA+scX6=oc_eGteY8A0d8tuwzJFSu9M_6wnXBd5Tp=XGrg8FotQ@mail.gmail.com>
	<CA+scX6n+xcY7qi=XbBcno=OQOfUfJf77ZGfS2s5FbhUCEHQp3A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yH1ZJFh+qWm+VodA"
Content-Disposition: inline
In-Reply-To: <CA+scX6n+xcY7qi=XbBcno=OQOfUfJf77ZGfS2s5FbhUCEHQp3A@mail.gmail.com>
Subject: Re: [Qemu-devel] Lock contention in QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Weiwei Jia <harrynjit@gmail.com>
Cc: qemu-devel@nongnu.org


--yH1ZJFh+qWm+VodA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 15, 2016 at 12:17:09AM -0500, Weiwei Jia wrote:
> BTW, do we have an example to show users how to config following
> virtio-blk dataplane commands into XML configuration file?
>=20
> qemu -object iothread,id=3Diothread0 \
>       -drive if=3Dnone,id=3Ddrive0,file=3Dtest.img,format=3Draw,cache=3Dn=
one \
>       -device virtio-blk-pci,iothread=3Diothread0,drive=3Ddrive0

https://libvirt.org/formatdomain.html#elementsIOThreadsAllocation

See also <cputune><iothreadpin> and <driver iothread=3D>.

--yH1ZJFh+qWm+VodA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYUk8KAAoJEJykq7OBq3PIuCAIAJ8doPsVE4Hl1P7Bz2gDpDtG
lQCdEM9jraa+MSa2xE/WHCECuEnKXVqBcU1+GK+8MexgXY3hozR3IPW/1dlP0tVC
bnicIy1Lb36XtPauQAexhytAZ1BbNOo7RWG9XuOmalwoWi2RJJp5PraZpRXfk+h8
gcebFr6DzGpnbvlKqTMNIlPGX3s8ZB38QgZL+jrZ0STWhgRtfo2oRijaaaprlSy6
GbcyqET9gwunen2h1PWXkUIzA4jAMU9MZHzNaYUmFQEIvx4RdiVDSCw1+mFh2D80
4SmqD+Su3k1PBBy/2LAoFi6CoA9zMcfs+XKyPjezlMcCNI/nTfcjwnXMRzH5iBg=
=+sgp
-----END PGP SIGNATURE-----

--yH1ZJFh+qWm+VodA--
