Received: from eggs.gnu.org ([2001:4830:134:3::10]:46011)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d5Ygv-0006gW-Tj
	for qemu-devel@nongnu.org; Tue, 02 May 2017 10:22:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d5Ygs-0002DU-O1
	for qemu-devel@nongnu.org; Tue, 02 May 2017 10:22:13 -0400
Received: from mail-wr0-x229.google.com ([2a00:1450:400c:c0c::229]:33814)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1d5Ygs-0002DG-H7
	for qemu-devel@nongnu.org; Tue, 02 May 2017 10:22:10 -0400
Received: by mail-wr0-x229.google.com with SMTP id l9so82102214wre.1
	for <qemu-devel@nongnu.org>; Tue, 02 May 2017 07:22:10 -0700 (PDT)
Date: Tue, 2 May 2017 15:22:07 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170502142207.GJ22502@stefanha-x1.localdomain>
References: <CAEfK_46MMR6cH3ahuJ=zfcuKAp07iU20Ps+yZYv5s9woCPnsSw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BEa57a89OpeoUzGD"
Content-Disposition: inline
In-Reply-To: <CAEfK_46MMR6cH3ahuJ=zfcuKAp07iU20Ps+yZYv5s9woCPnsSw@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH] gdbstub: implement remote debugging
 protocol escapes for command receive
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Doug Gale <doug16k@gmail.com>
Cc: qemu-devel@nongnu.org


--BEa57a89OpeoUzGD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 01, 2017 at 01:16:55PM -0400, Doug Gale wrote:
> The attached patch implements the GDB Remote Serial Protocol for
> command receive as per the documentation provided at
> https://sourceware.org/gdb/onlinedocs/gdb/Remote-Protocol.html#Remote-Pro=
tocol
> and from inspection of remote.c in the gdb source (the documentation
> didn't clearly document whether the packet or the unescaped data were
> used for the checksum, turns out the packet data is used for the
> checksum, as expected).
>=20
> get_maintainer.pl didn't find a maintainer for gdbstub.c, so I didn't
> cc any maintainers.

Please see the guidelines for submitting patches:
http://wiki.qemu.org/Contribute/SubmitAPatch

Patches must be sent inline, not as attachments.

Thanks,
Stefan

--BEa57a89OpeoUzGD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZCJYPAAoJEJykq7OBq3PIUF4H/A9LYsK1yrOHryzJwDMJ2SF1
woJAPfEoVwjVBdOMd5CcU5jmyz0WuFoxXeGBrT9SUFs4YJyT4/1HekzyzrdCm5OD
AzuE5wKIQ98gLevS/Z4l6n2OU6P55LB2vPq28akXQlLNSVXW1DEL4PGklYRCP7xk
8HSVS2/UoMUPtamnP3Or/WwvfQjs2TSGFZ6Y3xWnXTImeKgHNhRQeBsj0kWy0Plu
ki5C/PCUktNw/ups2PYw0oDUTZvha9DNOP9jmJxBAkKIcufPttgwgZlzl2BpBJw4
W647vJJSnd/6QCKxNsPdF1N15BUycbHWHjdJw46fFFl+qkYs7v/9M/Dx8+KXh/Y=
=j+St
-----END PGP SIGNATURE-----

--BEa57a89OpeoUzGD--
