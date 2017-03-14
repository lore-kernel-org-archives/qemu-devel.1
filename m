Received: from eggs.gnu.org ([2001:4830:134:3::10]:49729)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cnrsB-0001Pv-77
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 15:12:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cnrs7-0000Dt-8G
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 15:12:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55540)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cnrs7-0000DO-1g
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 15:12:39 -0400
References: <1489385927-6735-1-git-send-email-armbru@redhat.com>
	<1489385927-6735-25-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <7fee33e8-ba6f-35bf-ebd8-571f35849641@redhat.com>
Date: Tue, 14 Mar 2017 14:12:36 -0500
MIME-Version: 1.0
In-Reply-To: <1489385927-6735-25-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="IBsvkehixHqO6G262QMvEBEVrWVOOKPGc"
Subject: Re: [Qemu-devel] [PATCH for-2.9 24/47] qapi2texi: Implement boxed
 argument documentation
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
--IBsvkehixHqO6G262QMvEBEVrWVOOKPGc
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com
Message-ID: <7fee33e8-ba6f-35bf-ebd8-571f35849641@redhat.com>
Subject: Re: [PATCH for-2.9 24/47] qapi2texi: Implement boxed argument
 documentation
References: <1489385927-6735-1-git-send-email-armbru@redhat.com>
 <1489385927-6735-25-git-send-email-armbru@redhat.com>
In-Reply-To: <1489385927-6735-25-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/13/2017 01:18 AM, Markus Armbruster wrote:
> This replaces manual references like "For the arguments, see the
> documentation of ..." by a generated reference "Arguments: the members
> of ...".
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  qapi-schema.json     |  2 +-
>  qapi/block-core.json | 10 ----------
>  scripts/qapi2texi.py |  8 +++++++-
>  3 files changed, 8 insertions(+), 12 deletions(-)

Should be even more handy when you add html links to the type
documentation from the command documentation, later in the series.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--IBsvkehixHqO6G262QMvEBEVrWVOOKPGc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYyECkAAoJEKeha0olJ0Nqmm0H/3qq4K1g9KQfcIZ1sfqF5ZVB
+MpB+anRNdzxja4zYY64a3SeRpDX94TzHrwNDNTxjWxdc7UwY5l9zySiAEejuSvs
SyixOQ+9qHnJXZET4BKsYKH3q+IGEpx1WUSHduXsD8XgI7CZDrqIVRgLZB6nfuSE
3gzvpSDDluqFVIH8rTFjvKbzO5Eq3Krj1dp81Jd6rmHNFomjzX51Oj62/RSqEXbF
V50HK0U1G88AbAewVbQKDZLT/54aOpLCcDmWh5z7dypZCJgVD4IrKBt7uNaOPPEL
9WjvK+Cj/xFCocP37P9XIkL8XpADtsnDDCSoeG89ZroSs/upCQbBd4gNwn3R5W4=
=XnWd
-----END PGP SIGNATURE-----

--IBsvkehixHqO6G262QMvEBEVrWVOOKPGc--
