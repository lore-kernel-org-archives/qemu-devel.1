Received: from eggs.gnu.org ([2001:4830:134:3::10]:38057)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dvUWe-0007aJ-0z
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 16:26:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dvUWa-00056T-1w
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 16:26:16 -0400
References: <20170922161345.331-1-f4bug@amsat.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <cae93aba-ca97-1d21-354d-aab209ce05cd@redhat.com>
Date: Fri, 22 Sep 2017 15:26:03 -0500
MIME-Version: 1.0
In-Reply-To: <20170922161345.331-1-f4bug@amsat.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="QKpr6CPG6jWFjxP1jTLmd8I0f0PTlWhSV"
Subject: Re: [Qemu-devel] [PATCH] scripts/orderfile: keep MAINTAINERS at
 bottom
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Gerd Hoffmann <kraxel@redhat.com>, "Emilio G . Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--QKpr6CPG6jWFjxP1jTLmd8I0f0PTlWhSV
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Gerd Hoffmann <kraxel@redhat.com>, "Emilio G . Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Message-ID: <cae93aba-ca97-1d21-354d-aab209ce05cd@redhat.com>
Subject: Re: [PATCH] scripts/orderfile: keep MAINTAINERS at bottom
References: <20170922161345.331-1-f4bug@amsat.org>
In-Reply-To: <20170922161345.331-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/22/2017 11:13 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  scripts/git.orderfile | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/scripts/git.orderfile b/scripts/git.orderfile
> index ac699700b1..34619769c2 100644
> --- a/scripts/git.orderfile
> +++ b/scripts/git.orderfile
> @@ -27,3 +27,4 @@ Makefile*
>  # code
>  *.c
> =20
> +MAINTAINERS

Well, after any file that matches above, but before any file that
doesn't match any pattern, so not strictly the end.

But why not earlier with the build system?  Generally, if you are going
to add a file, you are going to also tweak a Makefile to get it to build
- at which point, a MAINTAINERS tweak feels more on par with a Makefile
tweak.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--QKpr6CPG6jWFjxP1jTLmd8I0f0PTlWhSV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnFcd0ACgkQp6FrSiUn
Q2o6ywf7BAl5P9hknD37LOzo/t8F50TF1Ov7kzbdLSCEQpiN7IueJbg79m1b5qEf
aAU2/6beqmK5Ay/5bAoDmmIbuoqr91vh0+Tlf1bJVjD8JGq1Z8hcLnbUhFqJOPvT
XzkHSRlbtWOAcd75AKAQ93i8UHwSdXxlMIJdi4larVZ32t48MEWW9JaJ1pGlYHd2
8OQRKBRutgD/96AcqdjGOYHU+8BqvJ4UNDAJz6o8cvI1E4gwd8jnaOrQe1gZOWSJ
/OV987skPZr4Zm6gl+fpILLqAx3Us7w/eI/ettVoIEjRbiRQ8q5y+qpCXvAM29Na
JwWrpFMsdp21o9yXIyCke3gvvZvY8g==
=ZMy2
-----END PGP SIGNATURE-----

--QKpr6CPG6jWFjxP1jTLmd8I0f0PTlWhSV--
