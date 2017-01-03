Received: from eggs.gnu.org ([2001:4830:134:3::10]:57505)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cOR1Z-0000bB-A2
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 10:29:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cOR1W-0006UR-7A
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 10:29:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37456)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cOR1W-0006UK-12
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 10:29:14 -0500
References: <1483371890-289981-1-git-send-email-imammedo@redhat.com>
	<1483371890-289981-3-git-send-email-imammedo@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <85a3e929-1317-0e13-0515-2a30c112997a@redhat.com>
Date: Tue, 3 Jan 2017 09:29:11 -0600
MIME-Version: 1.0
In-Reply-To: <1483371890-289981-3-git-send-email-imammedo@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="8CQbWexmIjGu2mL0VArsfJei2kb865bhb"
Subject: Re: [Qemu-devel] [PATCH 2/3] reuse user_creatable_add_opts()
 instead of user_creatable_add() in monitor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: ehabkost@redhat.com, armbru@redhat.com, dgilbert@redhat.com, afaerber@suse.de

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8CQbWexmIjGu2mL0VArsfJei2kb865bhb
From: Eric Blake <eblake@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: ehabkost@redhat.com, armbru@redhat.com, dgilbert@redhat.com,
 afaerber@suse.de
Message-ID: <85a3e929-1317-0e13-0515-2a30c112997a@redhat.com>
Subject: Re: [PATCH 2/3] reuse user_creatable_add_opts() instead of
 user_creatable_add() in monitor
References: <1483371890-289981-1-git-send-email-imammedo@redhat.com>
 <1483371890-289981-3-git-send-email-imammedo@redhat.com>
In-Reply-To: <1483371890-289981-3-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/02/2017 09:44 AM, Igor Mammedov wrote:
> Simplify code by dropping ~57LOC by merging user_creatable_add()
> into user_creatable_add_opts() and using the later from monutor.
> Along with it allocate opts_visitor_new() once in user_creatable_add_op=
ts().
>=20
> As result we have one less API func and a more readable/simple
> user_creatable_add_opts() vs user_creatable_add().
>=20
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--8CQbWexmIjGu2mL0VArsfJei2kb865bhb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYa8NHAAoJEKeha0olJ0NqubYH/jDSxXepRjGGF587QdjDOtYQ
J6rkXVYVXN425um4f+UNQ3cuYUAoGalWvp8G/+4b/lkQ1AvepJcxagn0taf+SVNj
m9yHRJSL+k7JKT+BBVlDUtti6YXMtA41p2tYSf25PT/+CPlrOjyP1P2w5s9DJ8GQ
FPI3q7i80Xxr23eW+OvF9RFan+KMUAiESiyhrjxJf2jP1x5culNaWHjeePtJcX/s
x99I2aCN128BRFsZR6Wd0eibMG5RSIzuJokYXVi6sIRFh+z1oMVkiNGFwOBTeCWr
IdsYHw01p1JDSl204jYOXi2a7zdZTWrCvwOsi3QxHku10vAVAJKtRd5rc5jaDFU=
=E4R6
-----END PGP SIGNATURE-----

--8CQbWexmIjGu2mL0VArsfJei2kb865bhb--
