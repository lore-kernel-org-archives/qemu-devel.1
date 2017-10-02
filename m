Received: from eggs.gnu.org ([2001:4830:134:3::10]:40711)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dz2hs-00057x-1v
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 11:32:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dz2hr-0003DM-Ba
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 11:32:32 -0400
References: <20171002140307.5292-1-armbru@redhat.com>
	<20171002140307.5292-5-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f799fc38-d15f-e74e-bec2-ca1105e63e91@redhat.com>
Date: Mon, 2 Oct 2017 10:32:22 -0500
MIME-Version: 1.0
In-Reply-To: <20171002140307.5292-5-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="9WBWoti05me931IhXgeD40NofD72UvcPq"
Subject: Re: [Qemu-devel] [PATCH 4/8] qemu-options: Move -iscsi under "Block
 device options"
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Ronnie Sahlberg <ronniesahlberg@gmail.com>, Max Reitz <mreitz@redhat.com>
List-ID: <qemu-devel.nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9WBWoti05me931IhXgeD40NofD72UvcPq
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Ronnie Sahlberg <ronniesahlberg@gmail.com>, Max Reitz <mreitz@redhat.com>
Message-ID: <f799fc38-d15f-e74e-bec2-ca1105e63e91@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 4/8] qemu-options: Move -iscsi under "Block
 device options"
References: <20171002140307.5292-1-armbru@redhat.com>
 <20171002140307.5292-5-armbru@redhat.com>
In-Reply-To: <20171002140307.5292-5-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/02/2017 09:03 AM, Markus Armbruster wrote:
> -iscsi ended up under the "Device URL Syntax" heading by a sequence of
> errors, as explained in the previous commit.  Move it under the "Block
> device options" heading.  Nothing left under "Device URL Syntax";
> drop the heading.
>=20
> Cc: Ronnie Sahlberg <ronniesahlberg@gmail.com>
> Cc: Kevin Wolf <kwolf@redhat.com>
> Cc: Max Reitz <mreitz@redhat.com>
> Cc: qemu-block@nongnu.org
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  qemu-options.hx | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--9WBWoti05me931IhXgeD40NofD72UvcPq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnSXAYACgkQp6FrSiUn
Q2oGtQf/eWqsnu++FcWVD90cGQ2bt/p9N6W+xB17rCG3MqxS/nKvZNoyFpL5ivjH
jtJy3HvPbJMF8BpRzOg3DDPvSxk7T2lUIg+TmrflwdR7lGFfQPpkombb2R01SsTx
/vNjlVqVdl43GvtI1/b/qwLJaNzXaavZOrlHUT8NYlRDBAZaKFM98sN+EFpa+7Zz
gWMCABVgx0+6Ok1IABH4UpRbaFsH8RAd8InCkErM1EwjX3kniH+Ucwcgo00nC0M5
tMUttIwzSKZ+48+icjK/rNTW3WSRSx8AEHx9VhR1swRw97uo+Bpjl2Ute4w+fn2v
hKeyI3cYpMdZyvw2Tte17XJhr6bhCQ==
=Rdht
-----END PGP SIGNATURE-----

--9WBWoti05me931IhXgeD40NofD72UvcPq--
