Received: from eggs.gnu.org ([2001:4830:134:3::10]:45566)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dXWQk-0008O1-8L
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 13:37:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dXWQj-0001Qk-El
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 13:37:06 -0400
References: <1500385286-21142-1-git-send-email-armbru@redhat.com>
	<1500385286-21142-9-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <3ba859c3-b329-c822-1a93-9e730c019ab1@redhat.com>
Date: Tue, 18 Jul 2017 12:36:57 -0500
MIME-Version: 1.0
In-Reply-To: <1500385286-21142-9-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Ml8SNImBRaLF6MMQbh0xs6nW4rMNRDgsV"
Subject: Re: [Qemu-devel] [PATCH for-2.10 08/10] migration: Add TODO
 comments on duplication of QAPI_CLONE()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org, quintela@redhat.com, dgilbert@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Ml8SNImBRaLF6MMQbh0xs6nW4rMNRDgsV
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, kwolf@redhat.com, mreitz@redhat.com,
 qemu-block@nongnu.org, quintela@redhat.com, dgilbert@redhat.com
Message-ID: <3ba859c3-b329-c822-1a93-9e730c019ab1@redhat.com>
Subject: Re: [PATCH for-2.10 08/10] migration: Add TODO comments on
 duplication of QAPI_CLONE()
References: <1500385286-21142-1-git-send-email-armbru@redhat.com>
 <1500385286-21142-9-git-send-email-armbru@redhat.com>
In-Reply-To: <1500385286-21142-9-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/18/2017 08:41 AM, Markus Armbruster wrote:
> qmp_query_migrate_parameters() and qmp_migrate_set_parameters()
> effectively duplicate QAPI_CLONE() inline.  Add suitable TODO
> comments.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  migration/migration.c | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--Ml8SNImBRaLF6MMQbh0xs6nW4rMNRDgsV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlluRzkACgkQp6FrSiUn
Q2o4Ggf+MExW7dm7SUKGKvQaJx4bqrJ9fig0TeBKe7Cm6DZh3lliukBVbv4vRr4w
nAsquDKHY7v9pP9uU8RJFZJ/Am963dmljEgmTjTJgD2jc0e2mwIcXK3yvjU8Duyi
Q0an02cXP1vRrpcuxIFXIhpG7S0GakKlspC0sNsxsNj/dbmL/9FYeW/4CbSVbq4m
jDO0b9oAYy3n3G26rpngDJVe37qIEwizf/04IAI86aamIHlQiPdm6cXRuU1jZBgF
vHJYDcBuly9K/y8m/4AsEVor+JC5EMJVHjUx4cV9TYeTP4QJxHmPFuicRkGgYQwz
yVClK01fK8Sja8T/KFb1D/fMXqBpAA==
=dSu4
-----END PGP SIGNATURE-----

--Ml8SNImBRaLF6MMQbh0xs6nW4rMNRDgsV--
