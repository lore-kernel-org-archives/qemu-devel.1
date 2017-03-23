Received: from eggs.gnu.org ([2001:4830:134:3::10]:38195)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cr4Ro-0008N4-DT
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 11:14:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cr4Rl-0004iS-A0
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 11:14:44 -0400
Received: from mail-wm0-x236.google.com ([2a00:1450:400c:c09::236]:37564)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cr4Rl-0004iD-3G
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 11:14:41 -0400
Received: by mail-wm0-x236.google.com with SMTP id n11so65764160wma.0
	for <qemu-devel@nongnu.org>; Thu, 23 Mar 2017 08:14:40 -0700 (PDT)
Date: Thu, 23 Mar 2017 15:14:37 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170323151437.GE12560@stefanha-x1.localdomain>
References: <CAPww8bgFdJpx=_JKu+zgCiSGwzC2jcVweP13QsRUZtUp_eu0Zg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UnaWdueM1EBWVRzC"
Content-Disposition: inline
In-Reply-To: <CAPww8bgFdJpx=_JKu+zgCiSGwzC2jcVweP13QsRUZtUp_eu0Zg@mail.gmail.com>
Subject: Re: [Qemu-devel] Qemu socket address
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ashish Gahlot <dreamashish21@gmail.com>
Cc: qemu-devel@nongnu.org


--UnaWdueM1EBWVRzC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 11, 2017 at 10:53:33PM +0530, Ashish Gahlot wrote:
> Sorry if I'm asking a silly question but why doesn't Qemu support *socket
> address reuse *when we use remote debugging with gdb with options "-S -s"?
>=20
> Is there a support in the upstream version? I am using Qemu version 2.7.0.

It appears to have always called setsockopt(SO_REUSEADDR) since
gdbstub.c was added to the source tree (commit
b4608c0455a410994b31888b458a552d640b9765 "added gdb support to vl").

Please post details of the problem you are experiencing, including the
exact command-line used to launch QEMU and the error message.

Stefan

--UnaWdueM1EBWVRzC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJY0+ZdAAoJEJykq7OBq3PIrAYH/j2UhAfRnQdQVufuMDCXD7Kb
zNG4fHy7sZ4uca/Mb72yzQ6IUjV4O2P4G4OAoqWtn/0h/Rfi5tvyJfD61DyYItLU
k7mhGFBeJPKmTw+JBvxDauXCzI6MPosHU+eW46l5ds4XuqPeLUWFCtWw8xmSYxpd
ISM5ThW8aAicGL6S7BaB9+ysfqweeFk6Qd0LHETH8w7E5sZxMeEAjAmXfvGbNaiW
l8jrsRcNSIEo8OZiq2pDvKTArLQ+9MjJ89gvFFIYjH8Mty2OlLW5ipdt6EXeYFzP
TtWPxHFveBaH5ZdoLBqnUAQ9Q+5TAH7sjc8eFRFYzNfceT/LCVs72S9OLLqJ9tQ=
=ro/k
-----END PGP SIGNATURE-----

--UnaWdueM1EBWVRzC--
