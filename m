Received: from eggs.gnu.org ([2001:4830:134:3::10]:40714)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1df1WD-0002Wn-U6
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 06:13:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1df1WC-0007ny-UO
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 06:13:45 -0400
Date: Tue, 8 Aug 2017 11:13:38 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170808101338.GH16801@stefanha-x1.localdomain>
References: <20170804144354.21985-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AzNpbZlgThVzWita"
Content-Disposition: inline
In-Reply-To: <20170804144354.21985-1-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] block/null: Remove 'filename'
 option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, armbru@redhat.com, qemu-devel@nongnu.org


--AzNpbZlgThVzWita
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 04, 2017 at 04:43:54PM +0200, Kevin Wolf wrote:
> This option was only added to allow 'null-co://' and 'null-aio://' as
> filenames, its value never served any actual purpose and was ignored.
> Nevertheless it was accepted as '-drive driver=3Dnull,filename=3Dfoo'.
>=20
> The correct way to enable the protocol prefixes (and that without adding
> a useless -drive option) is implementing .bdrv_parse_filename. This is
> what this patch does.
>=20
> Technically, this is an incompatible change, but the null block driver
> is only used for benchmarking, testing and debugging, and an option
> without effect isn't likely to be used by anyone anyway, so no bad
> effects are to be expected.
>=20
> Reported-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/null.c | 31 ++++++++++++++++++++++++++-----
>  1 file changed, 26 insertions(+), 5 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--AzNpbZlgThVzWita
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZiY7SAAoJEJykq7OBq3PIr2oIAJAEMxeH6nQYSWaKxstv6fYF
9EU+J3eTi3/FYb5JCmgexPncvtshlBq7yHgUT5Ea0+b6AlBWhy0jlzSh4LJckQlv
SQ3sRmu9Hqm7Qtn/1WvEwx9PO1mDBFoZwXHKWBe7+e1W/Mk8qSvegobZa2GG+BWJ
NwMlmtuKPOhgiMkv9z5XUK4STrUmjofYHJtrhUTSFbslaquEVOTTKj+G2zDjJiDY
f8nZtTtXoXaNHy6Mv94ftt7gEZtUBI/ggNmum+k5wF3K1SVlmrvcJGnhSCPe+nHr
2igUVl7PkuEQRGFhtc6k+C78HgfqOCtN0YbnbyGMdZ/vhMiamOn2QC+TVQ/y3u0=
=29Gu
-----END PGP SIGNATURE-----

--AzNpbZlgThVzWita--
