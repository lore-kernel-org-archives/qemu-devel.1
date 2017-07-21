Received: from eggs.gnu.org ([2001:4830:134:3::10]:50521)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dYWoK-0003u2-Fj
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 08:13:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dYWoF-0000Jf-IZ
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 08:13:36 -0400
Received: from mail-wm0-x229.google.com ([2a00:1450:400c:c09::229]:37250)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dYWoF-0000Iq-Ba
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 08:13:31 -0400
Received: by mail-wm0-x229.google.com with SMTP id e131so12393660wme.0
	for <qemu-devel@nongnu.org>; Fri, 21 Jul 2017 05:13:31 -0700 (PDT)
Date: Fri, 21 Jul 2017 13:13:28 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170721121328.GB18014@stefanha-x1.localdomain>
References: <1500625265-23844-1-git-send-email-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="O5XBE6gyVG5Rl6Rj"
Content-Disposition: inline
In-Reply-To: <1500625265-23844-1-git-send-email-mark.cave-ayland@ilande.co.uk>
Subject: Re: [Qemu-devel] [PATCH] block/vpc: fix uninitialised variable
 compiler warning
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org


--O5XBE6gyVG5Rl6Rj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 21, 2017 at 09:21:05AM +0100, Mark Cave-Ayland wrote:
> Since commit cfc87e00 "block/vpc.c: Handle write failures in
> get_image_offset()" older versions of gcc (in this case 4.7) incorrectly
> warn that "ret" can be used uninitialised in vpc_co_pwritev().
>=20
> Setting ret to 0 at the start of vpc_co_pwritev() prevents the warning
> in gcc 4.7 and enables compilation with -Werror to succeed.
>=20
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  block/vpc.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--O5XBE6gyVG5Rl6Rj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZce/oAAoJEJykq7OBq3PIg7AH/i0CNV5rbzxL9D+qHrj6j2MN
bbw8xUvatlfbeit5E20SBAvAAffV9V4LXL4jqvy94uNRhRNc9EZi0+NGEvHYD3rV
YFp/giEMGAhQFmU4OA8nE/djcHHByTFRM4s9F6aUVxvLOvZt4la9qBYNPo4VrVeL
VeuUxf1nCuPRWp0MaYa58U3cE3DN4DAx+jrkwrfyw3YBurIAc3RBhkzrz+GOX9He
kUffjnBm7z8/yLdakUc2bJDfNAV4lj/HsrTk7cChjUyP3Xh0lLGnv5WwyzQkSXoP
7DXaXe8U0b5TqH/bHuTKMv6ISiQhWrA0Y7cP2oOUYHba//rwVPpdS+wRRHa1vS0=
=bPcW
-----END PGP SIGNATURE-----

--O5XBE6gyVG5Rl6Rj--
