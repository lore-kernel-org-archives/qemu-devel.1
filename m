Received: from eggs.gnu.org ([2001:4830:134:3::10]:51301)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d6Jee-0005qx-9E
	for qemu-devel@nongnu.org; Thu, 04 May 2017 12:31:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d6Jed-0004oZ-9z
	for qemu-devel@nongnu.org; Thu, 04 May 2017 12:31:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42580)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1d6Jed-0004oA-0U
	for qemu-devel@nongnu.org; Thu, 04 May 2017 12:30:59 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 59E61448D8A
	for <qemu-devel@nongnu.org>; Thu,  4 May 2017 16:30:57 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
References: <20170503104257.5127-1-dgilbert@redhat.com>
Message-ID: <dcdd1530-4e73-f998-b85f-06db4f1c4b63@redhat.com>
Date: Thu, 4 May 2017 11:30:53 -0500
MIME-Version: 1.0
In-Reply-To: <20170503104257.5127-1-dgilbert@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="6Xru2LkoWualfgKhfSU5SWPC3rrJFhRnh"
Subject: Re: [Qemu-devel] [PATCH] block migration: Allow compile time disable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>, qemu-devel@nongnu.org, quintela@redhat.com, jcody@redhat.com, kwolf@redhat.com
Cc: kashyap@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6Xru2LkoWualfgKhfSU5SWPC3rrJFhRnh
From: Eric Blake <eblake@redhat.com>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>,
 qemu-devel@nongnu.org, quintela@redhat.com, jcody@redhat.com,
 kwolf@redhat.com
Cc: kashyap@redhat.com
Message-ID: <dcdd1530-4e73-f998-b85f-06db4f1c4b63@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] block migration: Allow compile time disable
References: <20170503104257.5127-1-dgilbert@redhat.com>
In-Reply-To: <20170503104257.5127-1-dgilbert@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/03/2017 05:42 AM, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>=20
> Many users now prefer to use drive_mirror over NBD as an
> alternative to the older migrate -b option; drive_mirror is
> more complex to setup but gives you more options (e.g. only
> migrating some of the disks if some of them are shared).
>=20
> Allow the large chunk of block migration code to be compiled
> out for those who don't use it.
>=20
> Based on a downstream-patch we've had for a while by Jeff Cody.
>=20
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
> @@ -1222,6 +1226,14 @@ void qmp_migrate(const char *uri, bool has_blk, =
bool blk,
>      params.blk =3D has_blk && blk;
>      params.shared =3D has_inc && inc;
> =20
> +#ifndef CONFIG_LIVE_BLOCK_MIGRATION
> +    if (params.blk || params.shared) {
> +        error_setg(errp, "QEMU compiled without old-style block migrat=
ion. "
> +                         "Use drive_mirror+NBD.");

error_setg() should not be used with '.' (it should be a single phrase,
here you are trying to stuff in two sentences).  error_append_hint() can
be used to supply the advice about using drive_mirror+NBD as the
alternative.

Otherwise this looks reasonable to me.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org



--6Xru2LkoWualfgKhfSU5SWPC3rrJFhRnh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZC1c9AAoJEKeha0olJ0Nqu7QH/RAM6jvhr1wmzDOBST94Wwuc
NSz83csqOX4q1rN7bf2FMpw6u1arJ7BECF0mEe5zMTAvmLgthFFEZZw+5cutei/+
gR3CPNfb/VBnJUHmUZUXBxEyuJY+oCY70Ckg66BRUYDXmjcGKeKK6Zn4tK5WBfrq
UqajPWiyNY7yadWofkhKNfjeXpbSs7nm21SKph/lWfxX7MfP+eEfMj/y5fjtzugl
qWcLE6lJw3+yV3g2mDfQU4uI1LZqZeYfqNRYHdMcGWbRuSgHIngXC+M/+4hN877r
UUpAQC39MQYjm7Et50uxeyVIKSeLFO6hBQCZ7hVfWifGzPBm7/5UeuprEKDEkFI=
=B5PR
-----END PGP SIGNATURE-----

--6Xru2LkoWualfgKhfSU5SWPC3rrJFhRnh--
