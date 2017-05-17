Received: from eggs.gnu.org ([2001:4830:134:3::10]:45196)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dB1Ho-000545-2b
	for qemu-devel@nongnu.org; Wed, 17 May 2017 11:54:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dB1Hl-0003TH-25
	for qemu-devel@nongnu.org; Wed, 17 May 2017 11:54:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34172)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dB1Hk-0003Sz-P7
	for qemu-devel@nongnu.org; Wed, 17 May 2017 11:54:48 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id ADC3A23E6D8
	for <qemu-devel@nongnu.org>; Wed, 17 May 2017 15:54:47 +0000 (UTC)
References: <20170517153812.21993-1-quintela@redhat.com>
	<20170517153812.21993-4-quintela@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ca163777-4ffe-4361-eace-98eab28d6781@redhat.com>
Date: Wed, 17 May 2017 10:54:44 -0500
MIME-Version: 1.0
In-Reply-To: <20170517153812.21993-4-quintela@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="wDrp00mqtKqccrdEjgG4mn7FvlvsVAmQa"
Subject: Re: [Qemu-devel] [PATCH 3/5] migration: Remove use of old
 MigrationParams
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com, armbru@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wDrp00mqtKqccrdEjgG4mn7FvlvsVAmQa
From: Eric Blake <eblake@redhat.com>
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com,
 armbru@redhat.com
Message-ID: <ca163777-4ffe-4361-eace-98eab28d6781@redhat.com>
Subject: Re: [PATCH 3/5] migration: Remove use of old MigrationParams
References: <20170517153812.21993-1-quintela@redhat.com>
 <20170517153812.21993-4-quintela@redhat.com>
In-Reply-To: <20170517153812.21993-4-quintela@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/17/2017 10:38 AM, Juan Quintela wrote:
> We have change in the previous patch to use migration capabilities for
> it.  Notice that we continue using the old command line flags from
> migrate command from the time being.  Remove the set_params method as
> now it is empty.
>=20
> For savevm, one can't do a:
>=20
> savevm -b/-i foo
>=20
> but now one can do:
>=20
> migrate_set_capability block on
> savevm foo
>=20
> And we can't use block migration. We could disable block capability
> unconditionally, but it would not be much better.
>=20
> Signed-off-by: Juan Quintela <quintela@redhat.com>
>=20
> ---
> - Maintain shared/enabled dependency (Xu suggestion)
> - Now we maintain the dependency on the setter functions
> - improve error messages
>=20
> Signed-off-by: Juan Quintela <quintela@redhat.com>

This second S-o-b gets stripped, but the one that counts is in place
(I've made the same mistake before, as well - doing 'git commit --amend
-s' on a commit where I already had a --- separator)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--wDrp00mqtKqccrdEjgG4mn7FvlvsVAmQa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZHHJEAAoJEKeha0olJ0Nqf0EIAIBOsJjGx6XOsCcYM+OZlIqd
BU9gO8X3fp+oZyZ/5UH3KUQvIVZCKaZ/qwHHM4gNjzEftK2m2HQJU7oFGIZ1e+LF
YagmgJxSOf1nH3Asoh+nn5SU7TCtHDzZX/Empxv7ruRwjpov/h65iMza2/jOA47B
ZNMOWjWEUjAH2m987SmK/ATJ9OA6ElQFUNhX/ynxIdNd+uHWb9zMqS2T93Wmot6D
IL7C5xPJ6B7+rZkQDYjM6O9elkeQJE0B+I8CaL/Z+FznUxM/h4ldXea8Fdf9cTPz
e3GKhkebbc9HXQ1U/16MLUQQJpi70R2vWvyVLA6A/QcP4F02w6dGlDspRcLjrcs=
=ZF6S
-----END PGP SIGNATURE-----

--wDrp00mqtKqccrdEjgG4mn7FvlvsVAmQa--
