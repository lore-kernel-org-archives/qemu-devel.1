Received: from eggs.gnu.org ([2001:4830:134:3::10]:60242)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cgfvM-0001v4-8X
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 18:02:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cgfvL-00085s-8t
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 18:02:16 -0500
References: <1487710908-26356-1-git-send-email-armbru@redhat.com>
	<1487710908-26356-5-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c8d4f4a7-9d99-9cf7-b5d2-8dfd6191bb18@redhat.com>
Date: Wed, 22 Feb 2017 17:02:05 -0600
MIME-Version: 1.0
In-Reply-To: <1487710908-26356-5-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ecKucvOl5P1WJ8SSKQExBnPggsTwHPTot"
Subject: Re: [Qemu-devel] [PATCH RFC v3 4/5] qapi: Factor
 qobject_input_get_autocast() out of methods
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, pkrempa@redhat.com, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ecKucvOl5P1WJ8SSKQExBnPggsTwHPTot
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, pkrempa@redhat.com, qemu-block@nongnu.org
Message-ID: <c8d4f4a7-9d99-9cf7-b5d2-8dfd6191bb18@redhat.com>
Subject: Re: [Qemu-devel] [PATCH RFC v3 4/5] qapi: Factor
 qobject_input_get_autocast() out of methods
References: <1487710908-26356-1-git-send-email-armbru@redhat.com>
 <1487710908-26356-5-git-send-email-armbru@redhat.com>
In-Reply-To: <1487710908-26356-5-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/21/2017 03:01 PM, Markus Armbruster wrote:
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  qapi/qobject-input-visitor.c | 87 ++++++++++++++++++------------------=
--------
>  1 file changed, 35 insertions(+), 52 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

I guess you aren't squashing this into 3/5 because that one kept Dan as
the original author?

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--ecKucvOl5P1WJ8SSKQExBnPggsTwHPTot
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYrhhtAAoJEKeha0olJ0NqwH4H/AjjKMzTjDq4/LyZeCZSVXdE
OVL64Czg3W7VwF3x19LgnFae2ko6QFQrDGjGKTjUcrx2GBH383+maDRRAi1tYoWw
rxz8sGiwzVCae52TQjb9VQQVPqvQuZZitF7yCSqKftetPP+84Pp8Fne6TWoCLd0G
Gi0xLSYYEY1Zq+C7XHDN/kUrtElDoSxyQ0m83MAvHgGubt+yB2C0rFgHNtIuZSIA
z+QBq66eWndz7JJT7lqhPaQo4dZVd/+qVd+9IZdxCKRl0yekPDvYUjtLvvKpFTwk
Gn0rBU6KjyEbaXwP/IijmqRGkNUS7FEntbYI2coc/3aa2XGMqMJdFwa8fAnINBc=
=Bxty
-----END PGP SIGNATURE-----

--ecKucvOl5P1WJ8SSKQExBnPggsTwHPTot--
