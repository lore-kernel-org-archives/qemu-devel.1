Received: from eggs.gnu.org ([2001:4830:134:3::10]:38956)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dCq4E-0006Hz-Kw
	for qemu-devel@nongnu.org; Mon, 22 May 2017 12:20:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dCq4A-0002Fc-Ft
	for qemu-devel@nongnu.org; Mon, 22 May 2017 12:20:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40914)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dCq4A-0002FP-6e
	for qemu-devel@nongnu.org; Mon, 22 May 2017 12:20:18 -0400
References: <1494595886-30912-1-git-send-email-a.perevalov@samsung.com>
	<CGME20170512133146eucas1p2ba4841cabf508b66410fae6784952eaa@eucas1p2.samsung.com>
	<1494595886-30912-6-git-send-email-a.perevalov@samsung.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <43617b5a-0fcc-d171-aa19-4a24a4007e35@redhat.com>
Date: Mon, 22 May 2017 11:20:13 -0500
MIME-Version: 1.0
In-Reply-To: <1494595886-30912-6-git-send-email-a.perevalov@samsung.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="KbUcJPTxjCPGOw2wCcvAcIjxqG0Cuhd7T"
Subject: Re: [Qemu-devel] [PATCH V5 5/9] migration: introduce
 postcopy-blocktime capability
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Perevalov <a.perevalov@samsung.com>, qemu-devel@nongnu.org
Cc: i.maximets@samsung.com, dgilbert@redhat.com, peterx@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--KbUcJPTxjCPGOw2wCcvAcIjxqG0Cuhd7T
From: Eric Blake <eblake@redhat.com>
To: Alexey Perevalov <a.perevalov@samsung.com>, qemu-devel@nongnu.org
Cc: i.maximets@samsung.com, dgilbert@redhat.com, peterx@redhat.com
Message-ID: <43617b5a-0fcc-d171-aa19-4a24a4007e35@redhat.com>
Subject: Re: [Qemu-devel] [PATCH V5 5/9] migration: introduce
 postcopy-blocktime capability
References: <1494595886-30912-1-git-send-email-a.perevalov@samsung.com>
 <CGME20170512133146eucas1p2ba4841cabf508b66410fae6784952eaa@eucas1p2.samsung.com>
 <1494595886-30912-6-git-send-email-a.perevalov@samsung.com>
In-Reply-To: <1494595886-30912-6-git-send-email-a.perevalov@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/12/2017 08:31 AM, Alexey Perevalov wrote:
> Right now it could be used on destination side to
> enable vCPU blocktime calculation for postcopy live migration.
> vCPU blocktime - it's time since vCPU thread was put into
> interruptible sleep, till memory page was copied and thread awake.
>=20
> Signed-off-by: Alexey Perevalov <a.perevalov@samsung.com>
> ---
>  include/migration/migration.h | 1 +
>  migration/migration.c         | 9 +++++++++
>  qapi-schema.json              | 5 ++++-
>  3 files changed, 14 insertions(+), 1 deletion(-)
>=20

> +++ b/qapi-schema.json
> @@ -894,11 +894,14 @@
>  # @release-ram: if enabled, qemu will free the migrated ram pages on t=
he source
>  #        during postcopy-ram migration. (since 2.9)
>  #
> +# @postcopy-blocktime: Calculate downtime for postcopy live migration =
(since 2.10)
> +#
>  # Since: 1.2
>  ##
>  { 'enum': 'MigrationCapability',
>    'data': ['xbzrle', 'rdma-pin-all', 'auto-converge', 'zero-blocks',
> -           'compress', 'events', 'postcopy-ram', 'x-colo', 'release-ra=
m'] }
> +           'compress', 'events', 'postcopy-ram', 'x-colo', 'release-ra=
m',
> +           'postcopy-blocktime'] }

Why does this need to be a capability that we have to turn on, and not
something that is collected unconditionally? Is there a drawback to
having the stat collection always enabled without a capability?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--KbUcJPTxjCPGOw2wCcvAcIjxqG0Cuhd7T
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZIw+9AAoJEKeha0olJ0NqkDgIAIvAL4FRpv3zMQ8m0HgCseCQ
2TzSI7vW+2hCkCFDHIiK/z2bDHlzhKSGZrTI2B2rukxdy0chu+WAAwwWLaeutt9P
4OVDQ3ySJyRBshETnAjdGtwaKsRK4rooKqTdavBcHVbOmJvg4Dy8E58tHGMlPcMY
gmGiIiRpoV7M4ktN2sgTrT0uWhXNrtRVEQXvOrGGiNSkI+cJ4OZ1BuXnVqVAU90g
khAp37FwW7NkwxtnNT5me6LlxOji/7heuu06KGiC+KS9ITap87/cf1KZx7YctcSk
ODDQTVf8ThbNqZd9q+WlRysSHoxrhJjoqwYAHABIRXDsImb6J7Cm/aHX3uyYG6U=
=4W8P
-----END PGP SIGNATURE-----

--KbUcJPTxjCPGOw2wCcvAcIjxqG0Cuhd7T--
