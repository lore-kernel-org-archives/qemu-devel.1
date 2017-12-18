Received: from eggs.gnu.org ([2001:4830:134:3::10]:43193)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eQvVY-0008QC-Fp
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 08:31:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eQvVV-0004wf-Sv
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 08:31:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35652)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eQvVV-0004vv-My
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 08:31:01 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BE8DB4A6FF
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 13:31:00 +0000 (UTC)
Date: Mon, 18 Dec 2017 13:30:56 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171218133056.GC16653@stefanha-x1.localdomain>
References: <20171215150659.1811-1-marcandre.lureau@redhat.com>
	<20171215150659.1811-13-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="B4IIlcmfBL/1gGOG"
Content-Disposition: inline
In-Reply-To: <20171215150659.1811-13-marcandre.lureau@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 12/13] ucontext: annotate coroutine
 stack for ASAN
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>


--B4IIlcmfBL/1gGOG
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 15, 2017 at 04:06:58PM +0100, Marc-Andr=E9 Lureau wrote:
> It helps ASAN to detect more leaks on coroutine stacks, as found in
> the following patch.
>=20
> A similar work would need to be done for sigaltstack & windows fibers
> to have similar coverage. Since ucontext is prefered, I didn't bother
> checking the other coroutine implementations for now.
>=20
> Signed-off-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> ---
>  include/qemu/compiler.h   |  4 ++++
>  util/coroutine-ucontext.c | 46 +++++++++++++++++++++++++++++++++++++++++=
+++++
>  2 files changed, 50 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--B4IIlcmfBL/1gGOG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaN8MQAAoJEJykq7OBq3PIivIIAMHCUBVlnWP6QWsPzRvM/yhn
C4blm8CzJ2XDNM4jnO6Pe5B7qy+oFOZbgpdvgmPqJ99uSljLKGwEtKnxEMPkc078
oW70wi87G+A7W8wNThsdLmjyy5FkdUFXFP+PZHzyHzUD8AcNOsKVvPLFEXZa4yBf
o4lDIF2IRMMMuqNyDPRyVqcUS7A1FoFBGR4Vzzk7UOO5sE6sRhLP/YTiok4pMn2M
aTt16KOnJ79LDbj4uwS4QYY1LmgKramSh24ArRHZ8PcD0QM9teqHgorHW1ogptbc
6SVi1jEeH4JsxfEhtYH3DT84nsfsBH4gb1IZ6SANvoTkANqvvA4E7Kgkv4oVMNs=
=/+N3
-----END PGP SIGNATURE-----

--B4IIlcmfBL/1gGOG--
