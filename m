Received: from eggs.gnu.org ([2001:4830:134:3::10]:34411)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dGo1K-0007JS-GC
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 10:57:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dGo1I-0000cb-K1
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 10:57:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42740)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dGo1I-0000bJ-4f
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 10:57:44 -0400
References: <20170602040838.29995-1-quwenruo@cn.fujitsu.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <936f8428-8ee1-17a3-a94d-1a9237ad5dc7@redhat.com>
Date: Fri, 2 Jun 2017 09:57:40 -0500
MIME-Version: 1.0
In-Reply-To: <20170602040838.29995-1-quwenruo@cn.fujitsu.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="5XQoch20rgdIK0IdQAjnsdTHxndIQIt27"
Subject: Re: [Qemu-devel] [PATCH] gitignore: Ignore vim per-project config
 and clang complete
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Qu Wenruo <quwenruo@cn.fujitsu.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5XQoch20rgdIK0IdQAjnsdTHxndIQIt27
From: Eric Blake <eblake@redhat.com>
To: Qu Wenruo <quwenruo@cn.fujitsu.com>, qemu-devel@nongnu.org
Message-ID: <936f8428-8ee1-17a3-a94d-1a9237ad5dc7@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] gitignore: Ignore vim per-project config and
 clang complete
References: <20170602040838.29995-1-quwenruo@cn.fujitsu.com>
In-Reply-To: <20170602040838.29995-1-quwenruo@cn.fujitsu.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/01/2017 11:08 PM, Qu Wenruo wrote:
> Since we have already ignored ctags, ignoring .clangcomplete for
> vim-clang_completion is quite reasonable for me.
> (Not to mention vim-clang_completion provides better and more accurate
> completion and definition search)
>=20
> Also, qemu coding style is using 4 space as indent other than 8-space
> tab, it also makes sense to ignore per-project vim config file.

We already have a per-project emacs config file (.dir-locals.el); I
think it would be a better idea if you were to propose adding an
appropriate .vim* file for inclusion in the project that makes vim work
out-of-the-box with correct settings, rather than masking the file as
unaddable and requiring all vim-using contributors to recreate the same
settings.  (But as I am not personally a vim user, I can neither provide
such a sample file myself, nor review one if you post it).

>=20
> Signed-off-by: Qu Wenruo <quwenruo@cn.fujitsu.com>
> ---
>  .gitignore | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/.gitignore b/.gitignore
> index 55a001e3b8..c7c6eec0b6 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -113,6 +113,8 @@
>  cscope.*
>  tags
>  TAGS
> +.vim*
> +.clang_complete

The idea of adding .clang_complete to the exclusions makes sense to me.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--5XQoch20rgdIK0IdQAjnsdTHxndIQIt27
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZMXzlAAoJEKeha0olJ0NqmfgH/2o4Ay8P1Wz0GVwPoI6ZiM8f
MW2pFZC2THWeIbA52ALpQ182kKxRCG/dshL8hD2NAlT6EJZbrTSeTsrC2XLHC3Cy
VdhlrjAXDVn3vcxC487itWuV0adSVxNch/kyXtT8358vuY2wbz7tqfs+xAZAg9h2
Z3+srKKeb+20/2MAyMoEtfj6obPdKQ+6J82+2SXY2aUbcc6/UdOu9VIHTGG0xK3M
qvvuzT7LwZsWYqA+bsPcQBkKmgJ7lTWRgfILzdXBAnUSYBRfcMOhamMr/v6fHGjT
mgrUqktRM613cCIfTznggB2yPFj1bTPmYsjEpV/l60N5arYJ/GUZClseLav8UEQ=
=4ekZ
-----END PGP SIGNATURE-----

--5XQoch20rgdIK0IdQAjnsdTHxndIQIt27--
