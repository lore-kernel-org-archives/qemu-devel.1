Received: from eggs.gnu.org ([2001:4830:134:3::10]:42919)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cVqis-0005D0-M7
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 21:20:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cVqio-0002ky-Jq
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 21:20:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50970)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cVqio-0002kq-9K
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 21:20:34 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1C51A3D959
	for <qemu-devel@nongnu.org>; Tue, 24 Jan 2017 02:20:34 +0000 (UTC)
References: <1485207141-1941-1-git-send-email-quintela@redhat.com>
	<1485207141-1941-2-git-send-email-quintela@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f77369a0-8818-0115-ec1b-13dcd0c594f2@redhat.com>
Date: Mon, 23 Jan 2017 20:20:30 -0600
MIME-Version: 1.0
In-Reply-To: <1485207141-1941-2-git-send-email-quintela@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="hMFPVvhCCrmHlwr4BvmUxU5DL0Ki6G7kl"
Subject: Re: [Qemu-devel] [PATCH 01/17] migration: transform remained
 DPRINTF into trace_
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: amit.shah@redhat.com, dgilbert@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hMFPVvhCCrmHlwr4BvmUxU5DL0Ki6G7kl
From: Eric Blake <eblake@redhat.com>
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: amit.shah@redhat.com, dgilbert@redhat.com
Message-ID: <f77369a0-8818-0115-ec1b-13dcd0c594f2@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 01/17] migration: transform remained DPRINTF
 into trace_
References: <1485207141-1941-1-git-send-email-quintela@redhat.com>
 <1485207141-1941-2-git-send-email-quintela@redhat.com>
In-Reply-To: <1485207141-1941-2-git-send-email-quintela@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/23/2017 03:32 PM, Juan Quintela wrote:

In the subject: s/remained/remaining/

> So we can remove DPRINTF() macro
>=20
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  migration/ram.c        | 18 ++++--------------
>  migration/trace-events |  4 ++++
>  2 files changed, 8 insertions(+), 14 deletions(-)
>=20
> diff --git a/migration/ram.c b/migration/ram.c
> index a1c8089..ef8fadf 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -45,14 +45,6 @@
>  #include "qemu/rcu_queue.h"
>  #include "migration/colo.h"
>=20
> -#ifdef DEBUG_MIGRATION_RAM
> -#define DPRINTF(fmt, ...) \
> -    do { fprintf(stdout, "migration_ram: " fmt, ## __VA_ARGS__); } whi=
le (0)
> -#else
> -#define DPRINTF(fmt, ...) \
> -    do { } while (0)

Yay - you're getting rid of the bitrot pattern in this file!

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--hMFPVvhCCrmHlwr4BvmUxU5DL0Ki6G7kl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYhrnvAAoJEKeha0olJ0NqjMoH/AunSKD2S9SjvxYnjPKVIOKD
3bIGWnshRFBASS6RoevUb/EmBDynkxIda1nyfCu3alywco8SCH95bVseHySqcq2P
pFPJWKcs4xEDNkmRp7fwxhZMCHtModJV5AxGrE7llmDccvQcJ77en1IOA89kMTAD
dw6vXc0H3jvUxbDL4W1hA2343COwlUZbGGDCQvYy5M42PVNgbSCDluhDv8IxlEWZ
JNaO9Do6aj6Chll47jDhWBCLC9KiRdQKcodAmvJABvvAFh1GHKr2SlOjcxD8K8lN
h7oQmAgMRMzOq3V/ZLtiRpM4/xb9IqfdjZh6fk0P3XGUSrwda+tUQD17k/UsT2c=
=1S0A
-----END PGP SIGNATURE-----

--hMFPVvhCCrmHlwr4BvmUxU5DL0Ki6G7kl--
