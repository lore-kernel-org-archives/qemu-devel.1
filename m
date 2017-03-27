Received: from eggs.gnu.org ([2001:4830:134:3::10]:59699)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1csUdq-0001Uo-50
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 09:25:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1csUdm-0005sI-WC
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 09:25:02 -0400
Received: from mail-wr0-x234.google.com ([2a00:1450:400c:c0c::234]:36122)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1csUdm-0005s7-OW
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 09:24:58 -0400
Received: by mail-wr0-x234.google.com with SMTP id w11so42923247wrc.3
	for <qemu-devel@nongnu.org>; Mon, 27 Mar 2017 06:24:58 -0700 (PDT)
Date: Mon, 27 Mar 2017 14:24:54 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170327132454.GD28620@stefanha-x1.localdomain>
References: <4712D8F4B26E034E80552F30A67BE0B1A3D97E@ORSMSX112.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AkbCVLjbJ9qUtAXD"
Content-Disposition: inline
In-Reply-To: <4712D8F4B26E034E80552F30A67BE0B1A3D97E@ORSMSX112.amr.corp.intel.com>
Subject: Re: [Qemu-devel] [PATCH] Create libqemutrace.a for all trace.o
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Xu, Anthony" <anthony.xu@intel.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Daniel Berrange <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>


--AkbCVLjbJ9qUtAXD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 24, 2017 at 04:28:32PM +0000, Xu, Anthony wrote:
> Create libqemutrace.a for all trace.o
> Currently all trace.o are linked into qemu-system, qemu-img,=20
> qemu-nbd, qemu-io etc., even the corresponding components=20
> are not included.
> Create a libqemutrace.a that the linker would only pull in .o=20
> files containing symbols that are actually referenced by the=20
> program.
> ./trace.o, ./qapi/trace.o and ./util/trace.o are added into=20
> libqemuutil.a  to avoid recursive dependencies between=20
> libqemuutil.a and libqemutrace.a.

Why would libqemutrace.a depend on libqemuutil.a?

Tracing code shouldn't call other QEMU code.  That would could create
infinite recursion when a trace event is fired.

--AkbCVLjbJ9qUtAXD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJY2RKmAAoJEJykq7OBq3PI2HwH/Au+YCZgW+qGQeOtesqP3524
8sgTNrJeXnYZOdobrVOQ5EU/olwtODbTMRCq8kBEYQToXDCXL8R46and+M9tuqNn
y5uulY8Jr/AlxbAWddLTuNAFAYx88npUgYa64oVX5bv5+mL3WECzj/8NyJ5LZFg2
IxNIdtyH5WEBLUPwCpSp2EuMyJDiYoWjirIlEp+XU0MhjpxNfa7WRC8GmLGzaFBM
US/qLSax7d6x9W1TGaRWIay5Zvsgfqq81VxUbhyUA4++7MNIH8j380vWBxXMZqIC
htJ4d78dmI8Q19flgsnay/doNcz4bk/XY9e4QyketvhaT6YUwfqGmHkKBBF+IbI=
=tz1w
-----END PGP SIGNATURE-----

--AkbCVLjbJ9qUtAXD--
