Received: from eggs.gnu.org ([2001:4830:134:3::10]:38016)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1coKpG-0004Is-6m
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 22:07:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1coKpD-0008G3-2t
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 22:07:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50792)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1coKpC-0008Fa-QC
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 22:07:35 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B9D6F61E61
	for <qemu-devel@nongnu.org>; Thu, 16 Mar 2017 02:07:34 +0000 (UTC)
References: <20170313051108.26811-1-stefanha@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <7062cd7c-6271-7a77-e306-13075dcd1c2e@redhat.com>
Date: Thu, 16 Mar 2017 03:07:29 +0100
MIME-Version: 1.0
In-Reply-To: <20170313051108.26811-1-stefanha@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="PXhH6u1VKLgi5joGs2AQQ9cUOc1qQk4cO"
Subject: Re: [Qemu-devel] [PATCH] qemu-img: show help for invalid global
 options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--PXhH6u1VKLgi5joGs2AQQ9cUOc1qQk4cO
From: Max Reitz <mreitz@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>
Message-ID: <7062cd7c-6271-7a77-e306-13075dcd1c2e@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] qemu-img: show help for invalid global
 options
References: <20170313051108.26811-1-stefanha@redhat.com>
In-Reply-To: <20170313051108.26811-1-stefanha@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 13.03.2017 06:11, Stefan Hajnoczi wrote:
> The qemu-img sub-command executes regardless of invalid global options:=

>=20
>   $ qemu-img --foo info test.img
>   qemu-img: unrecognized option '--foo'
>   image: test.img
>   ...
>=20
> The unrecognized option warning may be missed by the user.  This can
> hide incorrect command-lines in scripts and confuse users.
>=20
> This patch prints the help information and terminates instead of
> executing the sub-command.
>=20
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  qemu-img.c | 1 +
>  1 file changed, 1 insertion(+)

Well, now you get blown away by a wall of text and spotting what went
wrong is actually not quite simple. Maybe we should follow the way of
the coreutils, that is:

qemu-img: unrecognized option '--foo'
Try 'qemu-img --help' for more information.

?

Max


--PXhH6u1VKLgi5joGs2AQQ9cUOc1qQk4cO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAljJ82ESHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AWXQIAIBAMZEFotK+/4n3/CChnw/NUmXOAGo9
o2t5Ei3/z2JwEs4Zr9tGmTlsQ4YYkRmxNhtr/osyASskxPJjufBp1TdPSZ9ed/3I
t1ZE+HpqOgdFVpdBlmd8ILo0ocWqQwk0H5/lSTsHji+DnMZ3GIEC3QFluB0JNIjK
oTdDimXIMCjGWXp6NfT0xkgv/sQqg8kbK/CsFMKC0MxZV35jtArpo/XWKocRPnhs
OcGuknfp1B+eqr426pNYrnVORiVE3LCk/CNtwKCCWXY0XH89DLkzMkfiVc267r6N
jQPL93j84RMe3QKzi22dillB5U5Ye4hRmu1obCSV1h+i94ghkKXEErc=
=Z4Br
-----END PGP SIGNATURE-----

--PXhH6u1VKLgi5joGs2AQQ9cUOc1qQk4cO--
