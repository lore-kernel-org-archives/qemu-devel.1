Received: from eggs.gnu.org ([2001:4830:134:3::10]:45520)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cntYd-00069Y-16
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 17:00:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cntYU-0006Ia-PR
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 17:00:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35722)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cntYU-0006IB-JU
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 17:00:30 -0400
References: <1489385927-6735-1-git-send-email-armbru@redhat.com>
	<1489385927-6735-39-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e4c730d6-9841-2802-7226-f3b65496f411@redhat.com>
Date: Tue, 14 Mar 2017 16:00:28 -0500
MIME-Version: 1.0
In-Reply-To: <1489385927-6735-39-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="pH4KSKswO4uksSOolmLoA4q6OwIJcObP8"
Subject: Re: [Qemu-devel] [PATCH for-2.9 38/47] qapi: Eliminate check_docs()
 and drop QAPIDoc.expr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--pH4KSKswO4uksSOolmLoA4q6OwIJcObP8
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com
Message-ID: <e4c730d6-9841-2802-7226-f3b65496f411@redhat.com>
Subject: Re: [PATCH for-2.9 38/47] qapi: Eliminate check_docs() and drop
 QAPIDoc.expr
References: <1489385927-6735-1-git-send-email-armbru@redhat.com>
 <1489385927-6735-39-git-send-email-armbru@redhat.com>
In-Reply-To: <1489385927-6735-39-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/13/2017 01:18 AM, Markus Armbruster wrote:
> Move what's left in check_docs() to check_expr().  Delegate the actual
> checking to new QAPIDoc.check_expr().
>=20
> QAPIDoc.expr is now unused; drop it.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  scripts/qapi.py | 27 ++++++++++-----------------
>  1 file changed, 10 insertions(+), 17 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--pH4KSKswO4uksSOolmLoA4q6OwIJcObP8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYyFnsAAoJEKeha0olJ0NqtvoH/RK1KEDEVm/uIzxcNUk6MbKG
MyMuthqvBu5V1ezQ4ia9cIhtiupuKDDle5c1oL3dV67s4+q3RNNjt/r6lJ72lDPM
MKmYYHOmfdSXsUSn6HFWOBCyymZ5+ig3qtR8QM1mzO9aNbsXp4hh4qPodpsqh5Fc
NFi44JvYFWfmiJQkRbR4BYUghb/OJGfB6qWA5b5zDMMlOCRJCQhI/smtC6ppfEvp
BWjSHSCaHb0CbmO+LNtwQ3v4vaPGKWj0vcYT/4+bJTaQV3qfSr50uFlo7giU66Xu
CtwznSJZy8XLtK9urXke1vrjtPsVmYluRsFtGbaNOzjg+PiCc/NP2W/a8AN3Drw=
=12fm
-----END PGP SIGNATURE-----

--pH4KSKswO4uksSOolmLoA4q6OwIJcObP8--
