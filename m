Received: from eggs.gnu.org ([2001:4830:134:3::10]:45464)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dHw7Z-00014D-5f
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 13:48:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dHw7Y-0001qs-9i
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 13:48:53 -0400
References: <1496682098-1540-1-git-send-email-peter.maydell@linaro.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9aa7798d-e205-97ac-c3bb-14c13e4e91c0@redhat.com>
Date: Mon, 5 Jun 2017 12:48:42 -0500
MIME-Version: 1.0
In-Reply-To: <1496682098-1540-1-git-send-email-peter.maydell@linaro.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="paaWjxP0NvV7XLQhGbAg8wferWTHs7HVw"
Subject: Re: [Qemu-devel] [PATCH] block/gluster.c: Handle
 qdict_array_entries() failure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Jeff Cody <jcody@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org, patches@linaro.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--paaWjxP0NvV7XLQhGbAg8wferWTHs7HVw
From: Eric Blake <eblake@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Jeff Cody <jcody@redhat.com>,
 Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org, patches@linaro.org
Message-ID: <9aa7798d-e205-97ac-c3bb-14c13e4e91c0@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] block/gluster.c: Handle
 qdict_array_entries() failure
References: <1496682098-1540-1-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1496682098-1540-1-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/05/2017 12:01 PM, Peter Maydell wrote:
> In qemu_gluster_parse_json(), the call to qdict_array_entries()
> could return a negative error code, which we were ignoring
> because we assigned the result to an unsigned variable.
> Fix this by using the 'int' type instead, which matches the
> return type of qdict_array_entries() and also the type
> we use for the loop enumeration variable 'i'.
>=20
> (Spotted by Coverity, CID 1360960.)
>=20
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  block/gluster.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--paaWjxP0NvV7XLQhGbAg8wferWTHs7HVw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZNZl6AAoJEKeha0olJ0NqT40IAJ/zVA2O0aCN171OqSYshJs2
UFdw8RXOtLQzv9ool/E2FW1NIBqlhgnqbM6sVvwenLr1ZEShsym7IWAIUbNc92IH
v8Ylslen5iQpqYPNG9lBWnUutBmsf7y1LIntV3pF3hpgAxzzTi86FSHxfmyhrSMy
1KZ7Z64tABMO767a5wjZSNEnLOold1QU3XgJu/5aVJ7QU1d/yspCNDG3o53E/pU4
pXR95v7eEJkwEtHc+kzWLKNcNTvI4mCovKJc4xee7IFXVjAqjqQax4Xn+wjNWGrT
ljPoZOWRk2AJeuVcIy4iwMj1Ah5denv9CBcfxoErYMygfmeHg5oG9GC5ckU5Mqk=
=Asp8
-----END PGP SIGNATURE-----

--paaWjxP0NvV7XLQhGbAg8wferWTHs7HVw--
