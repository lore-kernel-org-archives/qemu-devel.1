Received: from eggs.gnu.org ([2001:4830:134:3::10]:39370)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1coDup-0004wV-7h
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 14:44:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1coDuk-0000sx-8J
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 14:44:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39662)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1coDuj-0000sO-Vp
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 14:44:50 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CB4EE80F95
	for <qemu-devel@nongnu.org>; Wed, 15 Mar 2017 18:44:49 +0000 (UTC)
References: <20170315161603.30135-1-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <255b5e08-3e8c-df41-5ca2-c168d1f1cdd6@redhat.com>
Date: Wed, 15 Mar 2017 13:44:46 -0500
MIME-Version: 1.0
In-Reply-To: <20170315161603.30135-1-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="hociG9jtdk0uw1OWMlgQihDUaqCaAWLC8"
Subject: Re: [Qemu-devel] [PATCH for 2.9] migration: use "" as the default
 for tls-creds/hostname
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hociG9jtdk0uw1OWMlgQihDUaqCaAWLC8
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>
Message-ID: <255b5e08-3e8c-df41-5ca2-c168d1f1cdd6@redhat.com>
Subject: Re: [PATCH for 2.9] migration: use "" as the default for
 tls-creds/hostname
References: <20170315161603.30135-1-berrange@redhat.com>
In-Reply-To: <20170315161603.30135-1-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/15/2017 11:16 AM, Daniel P. Berrange wrote:
> The tls-creds parameter has a default value of NULL indicating
> that TLS should not be used. Setting it to non-NULL enables
> use of TLS. Once tls-creds are set to a non-NULL value via the
> monitor, it isn't possible to set them back to NULL again, due
> to current implementation limitations. The empty string is not
> a valid QObject identifier, so this switches to use "" as the
> default, indicating that TLS will not be used
>=20
> The tls-hostname parameter has a default value of NULL indicating
> the the hostname from the migrate connection URI should be used.
> Again, once tls-hostname is set non-NULL, to override the default
> hostname for x509 cert validation, it isn't possible to reset it
> back to NULL via the monitor. The empty string is not a valid
> hostname, so this switches to use "" as the default, indicating
> that the migrate URI hostname should be used.
>=20
> Using "" as the default for both, also means that the monitor
> commands "info migrate_parameters" / "query-migrate-parameters"
> will report existance of tls-creds/tls-parameters even when set
> to their default values.
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  migration/migration.c | 4 ++++
>  migration/tls.c       | 2 +-
>  qapi-schema.json      | 4 ++++
>  3 files changed, 9 insertions(+), 1 deletion(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

And still leaves the door open to future growth if we want to add
"foo":null for resetting a value to default in 2.10.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--hociG9jtdk0uw1OWMlgQihDUaqCaAWLC8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYyYueAAoJEKeha0olJ0Nqmw4H/2dRQ+Qq2Y6qpzJUxhEnjCta
gOzQygs6T818AeG/5/vOaeWm3wQLCeaTiBuqwX1bd5SAfYbbKay35t5BQ92IEilr
KZ2o+tfDuYNx2JKj6rkl1vU4EYiiSaRRYztj9rmvJ+wQ6f4hQpfU2hrA85+M6B5c
sZzbSg+/JVGkoAfN0yp7QgQd13kI6ra5p4U3rcuYdN8xBBybFKT/WJe/3NUKlvDL
ukhSy93lFjfecAvZenwOce7RFpv8h32OV7X4Q01L+nNlpMbZ4W4h6KzOGVDWLvE4
vt4dp0KppHYJDN7PSH4UNdfg7inwTT1BvP+53zDTI7BgSiVGUXtAPdw6nf0lvHg=
=aV5g
-----END PGP SIGNATURE-----

--hociG9jtdk0uw1OWMlgQihDUaqCaAWLC8--
