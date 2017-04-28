Received: from eggs.gnu.org ([2001:4830:134:3::10]:33044)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d4AxJ-0001wc-Hz
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 14:49:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d4AxF-0002Wd-IR
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 14:49:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59938)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1d4AxF-0002Vr-8v
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 14:49:21 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2BF1D64387
	for <qemu-devel@nongnu.org>; Fri, 28 Apr 2017 18:49:20 +0000 (UTC)
References: <20170425103049.4073-1-quintela@redhat.com>
	<20170425103049.4073-3-quintela@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <65604da7-3582-4e8e-2ca3-baf3b2813fa0@redhat.com>
Date: Fri, 28 Apr 2017 13:49:12 -0500
MIME-Version: 1.0
In-Reply-To: <20170425103049.4073-3-quintela@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ijMnNGQhElmi3AfcgaeaJ9aWwLDd6NtbQ"
Subject: Re: [Qemu-devel] [PATCH 2/3] migration: Remove use of old
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
Cc: lvivier@redhat.com, dgilbert@redhat.com, peterx@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ijMnNGQhElmi3AfcgaeaJ9aWwLDd6NtbQ
From: Eric Blake <eblake@redhat.com>
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: lvivier@redhat.com, dgilbert@redhat.com, peterx@redhat.com
Message-ID: <65604da7-3582-4e8e-2ca3-baf3b2813fa0@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/3] migration: Remove use of old
 MigrationParams
References: <20170425103049.4073-1-quintela@redhat.com>
 <20170425103049.4073-3-quintela@redhat.com>
In-Reply-To: <20170425103049.4073-3-quintela@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/25/2017 05:30 AM, Juan Quintela wrote:
> We have change in the previous patch to use migration capabilities for
> it.  Notice that we continue using the old command line flags from
> migrate command from the time being.  Remove the set_params method as
> now it is empty.
>=20
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  include/migration/migration.h |  3 +--
>  migration/block.c             | 17 ++---------------
>  migration/colo.c              |  3 ---
>  migration/migration.c         |  8 +++++---
>  migration/savevm.c            |  2 --
>  5 files changed, 8 insertions(+), 25 deletions(-)
>=20
> diff --git a/include/migration/migration.h b/include/migration/migratio=
n.h
> index 618ab0e..2917baa 100644
> --- a/include/migration/migration.h
> +++ b/include/migration/migration.h
> @@ -42,8 +42,7 @@
>  extern int only_migratable;
> =20
>  struct MigrationParams {
> -    bool blk;
> -    bool shared;
> +    bool unused; /* C don't allow empty structs */

s/don't/doesn't/

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--ijMnNGQhElmi3AfcgaeaJ9aWwLDd6NtbQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZA46oAAoJEKeha0olJ0NqOO0IAJqWlW2jyXSled0rva3qGZSm
vyhboKVTxYN7DDukRkeEByu37Oo34fj0taHFb3jLUT796BeBZBhqgVbQx7bOTW2m
k2MDvXfBO3QbNx/hCC79uYPOL5EBTy9cAoH6Sv/Du6T834C5L2ben4dVZgMj71UY
cojiR1KmMQPlYqYTzuSMPxO1hbynobrLHKjIehuhKzjiPbQkoRCfSEOypCANA7bb
6V0N3W7S69A3OvKuwLJkKW4XAg+l4tt5c+c4MEiRwm5dF6IxpCdPin0UFDJa5fvg
PY0H0Nkq73J+RMZHkj9F+RlPcc0iAVnt/pG/9xwwU4Pr87JSYYQPXeow983+5VA=
=GDJG
-----END PGP SIGNATURE-----

--ijMnNGQhElmi3AfcgaeaJ9aWwLDd6NtbQ--
