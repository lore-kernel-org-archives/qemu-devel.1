Received: from eggs.gnu.org ([2001:4830:134:3::10]:53725)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cgWw9-0000do-61
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 08:26:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cgWw8-0005Ha-B4
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 08:26:29 -0500
References: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
	<1487689130-30373-11-git-send-email-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <6fc9c274-7718-0933-e1f0-6401cf62ace2@redhat.com>
Date: Wed, 22 Feb 2017 14:26:17 +0100
MIME-Version: 1.0
In-Reply-To: <1487689130-30373-11-git-send-email-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="fDN7T6lPP9XnA0IFRgxhAdc381BGewioG"
Subject: Re: [Qemu-devel] [PATCH 10/54] vvfat: Use opened node as backing
 file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--fDN7T6lPP9XnA0IFRgxhAdc381BGewioG
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org
Message-ID: <6fc9c274-7718-0933-e1f0-6401cf62ace2@redhat.com>
Subject: Re: [PATCH 10/54] vvfat: Use opened node as backing file
References: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
 <1487689130-30373-11-git-send-email-kwolf@redhat.com>
In-Reply-To: <1487689130-30373-11-git-send-email-kwolf@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 21.02.2017 15:58, Kevin Wolf wrote:
> We should not try to assign a not yet opened node as the backing file,
> because as soon as the permission system is added it will fail.  The
> just added bdrv_new_open_driver() function is the right tool to open a
> file with an internal driver, use it.
>=20
> In case anyone wonders whether that magic fake backing file to trigger =
a
> special action on 'commit' actually works today: No, not for me. One
> reason is that we've been adding a raw format driver on top for several=

> years now and raw doesn't support commit. Other reasons include that th=
e
> backing file isn't writable and the driver doesn't support reopen, and
> it's also size 0 and the driver doesn't support bdrv_truncate. All of
> these are easily fixable, but then 'commit' ended up in an infinite loo=
p
> deep in the vvfat code for me, so I thought I'd best leave it alone. I'=
m
> not really sure what it was supposed to do anyway.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/vvfat.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--fDN7T6lPP9XnA0IFRgxhAdc381BGewioG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlitkXkSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9ADhMIAJNJWRqgmNBMo12hlAh68ICC3NXfqemC
UaputQrtSL5vlSic2/79rPShrhgE9XdQErSNb50LVBI120cmQ1mhmjPALLKwLIqo
97nh0kKs17af2CQi2soBhtYG1ZlDxQCyu045Habd+3sINGMnl4ASMGjGf9r6bk2x
uSe0Zj/H+2/7pOC5iyxo0EOow+hybnne+91+B+I4YZlLjXR0WgEtwMkhpXBSr1o8
oXUwyOSNUymvzgqnzWvgx+LMHZD+4n46fknBWAL0AJm+Rdw76yhmI+RZn70zi43u
UwYf/r922jKsXZBmmPPQfFqobwhRAOcJsks6qpUp8GON1zYgwK8nJH4=
=2nkt
-----END PGP SIGNATURE-----

--fDN7T6lPP9XnA0IFRgxhAdc381BGewioG--
