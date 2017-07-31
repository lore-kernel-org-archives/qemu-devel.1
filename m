Received: from eggs.gnu.org ([2001:4830:134:3::10]:33319)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dcD7A-0001ri-CX
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 12:00:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dcD71-0007Sd-5r
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 12:00:16 -0400
Date: Mon, 31 Jul 2017 17:59:55 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170731155955.GD12064@localhost.localdomain>
References: <20170726130337.24102-1-stefanha@redhat.com>
	<ac8960ca-5149-19d3-3853-bcd8c0445e8f@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="24zk1gE8NUlDmwG9"
Content-Disposition: inline
In-Reply-To: <ac8960ca-5149-19d3-3853-bcd8c0445e8f@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3] docs: add qemu-block-drivers(7) man page
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, el13635@mail.ntua.gr


--24zk1gE8NUlDmwG9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 31.07.2017 um 17:56 hat Eric Blake geschrieben:
> On 07/26/2017 08:03 AM, Stefan Hajnoczi wrote:
> > Block driver documentation is available in qemu-doc.html.  It would be
> > convenient to have documentation for formats, protocols, and filter
> > drivers in a man page.
> >=20
> > Extract the relevant part of qemu-doc.html into a new file called
> > docs/qemu-block-drivers.texi.  This file can also be built as a
> > stand-alone document (man, html, etc).
> >=20
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> > v3:
> >  * Rebased due to LUKS documentation conflict [Kevin]
>=20
> Building in-tree on Kevin's block branch now sees this in git status:
>=20
> Untracked files:
>   (use "git add <file>..." to include in what will be committed)
>=20
> 	docs/qemu-block-drivers.html
> 	docs/qemu-block-drivers.txt
>=20
> Can we get those added to .gitignore (either squashed in here, or as a
> followup)?

I also noticed this warning today:

docs/qemu-block-drivers.texi: warning: must specify a title with a title co=
mmand or @top

Kevin

--24zk1gE8NUlDmwG9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJZf1P7AAoJEH8JsnLIjy/Wqg0QALhzq2eQolUII4RTcIsnv+m+
ozQ0FH679H5ubS4Pzx6d2SwXCXfiFpt+tftRiN1sas4ykOTruPdD+PsBx04ZPGat
0orVIJy/5VMMIKtB3U1dfSW/BatLQMBeY58Whr8oqhWdzD5N9pSVQjslO7uStVa4
b3UVa0DTJDWTkwtD+xNB1EIPUH7hicqZO3OWkFgHy+4iyA6igvhFewCjzVLwrnxG
KpKb5YXWNYRhxGNSIGRlyqNeI7edHp3ur89YkpZrSYG6TL9kayle5wFLnW/IEmgN
lVQsnH+jACANXdb+B6EfeTOVaLPe4sim1HTTCi6/fX9n9F1MaDN0QzKtIZKzoika
+FClnE4CIg3HyzNmdKq4Pv9hd7U8mGy4AYYFEACLlCEyWE1uAgqBY5rANdokxiII
PWYwYBk/kAwPH20BLTLNkI0CzcHvVk+pbAicW/xsN9IR5gVqrjCpsx32nAfCewyU
svLU1S30Ze4kXXm2EQIoQK4zUJWNj3ZqnqUi6A+6Ah0o5Xt9+2IJ12mWL8UgxuVi
gzyMDUwTJj2VvpFtZeLklFTxi3BgZvl+YxM26DTwiwklcbUtgqG2PP4Ezygb8pKu
qVKJdDBUEK5txRWdYosaM3iwjouNz3rsaW0s7Hod+ynuQTG50AaqioTUUujjvyPP
andbRTmDfshDwwm+mlMP
=nm86
-----END PGP SIGNATURE-----

--24zk1gE8NUlDmwG9--
