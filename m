Received: from eggs.gnu.org ([2001:4830:134:3::10]:58850)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fBR7d-000385-3C
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 16:34:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fBR7b-0001Pu-VX
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 16:34:37 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40052 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fBR7b-0001Pa-NV
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 16:34:35 -0400
References: <20180425200326.72337-1-dgilbert@redhat.com>
	<20180425200326.72337-2-dgilbert@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <5ac3b2f4-fff5-f9bc-1f90-289638f8e94f@redhat.com>
Date: Wed, 25 Apr 2018 15:34:33 -0500
MIME-Version: 1.0
In-Reply-To: <20180425200326.72337-2-dgilbert@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="i2cVth5NEHnEfZEcSYrqxylhPVanaWO73"
Subject: Re: [Qemu-devel] [PULL 01/16] migration: introduce
 postcopy-blocktime capability
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>, qemu-devel@nongnu.org, quintela@redhat.com, peterx@redhat.com, a.perevalov@samsung.com, xiaoguangrong@tencent.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--i2cVth5NEHnEfZEcSYrqxylhPVanaWO73
From: Eric Blake <eblake@redhat.com>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>,
 qemu-devel@nongnu.org, quintela@redhat.com, peterx@redhat.com,
 a.perevalov@samsung.com, xiaoguangrong@tencent.com
Message-ID: <5ac3b2f4-fff5-f9bc-1f90-289638f8e94f@redhat.com>
Subject: Re: [Qemu-devel] [PULL 01/16] migration: introduce postcopy-blocktime
 capability
References: <20180425200326.72337-1-dgilbert@redhat.com>
 <20180425200326.72337-2-dgilbert@redhat.com>
In-Reply-To: <20180425200326.72337-2-dgilbert@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/25/2018 03:03 PM, Dr. David Alan Gilbert (git) wrote:
> From: Alexey Perevalov <a.perevalov@samsung.com>
>=20
> Right now it could be used on destination side to
> enable vCPU blocktime calculation for postcopy live migration.
> vCPU blocktime - it's time since vCPU thread was put into
> interruptible sleep, till memory page was copied and thread awake.
>=20
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Signed-off-by: Alexey Perevalov <a.perevalov@samsung.com>
> Reviewed-by: Juan Quintela <quintela@redhat.com>
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> Message-Id: <1521742647-25550-2-git-send-email-a.perevalov@samsung.com>=

> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---

> +++ b/qapi/migration.json
> @@ -354,16 +354,20 @@
>  #
>  # @x-multifd: Use more than one fd for migration (since 2.11)
>  #
> +#
>  # @dirty-bitmaps: If enabled, QEMU will migrate named dirty bitmaps.

Why is the extra blank line added here?  Doesn't hold up the pull
request, but might be worth a trivial followup patch.

>  #                 (since 2.12)
>  #
> +# @postcopy-blocktime: Calculate downtime for postcopy live migration
> +#                     (since 2.13)
> +#
>  # Since: 1.2
>  ##
>  { 'enum': 'MigrationCapability',
>    'data': ['xbzrle', 'rdma-pin-all', 'auto-converge', 'zero-blocks',
>             'compress', 'events', 'postcopy-ram', 'x-colo', 'release-ra=
m',
>             'block', 'return-path', 'pause-before-switchover', 'x-multi=
fd',
> -           'dirty-bitmaps' ] }
> +           'dirty-bitmaps', 'postcopy-blocktime' ] }
> =20
>  ##
>  # @MigrationCapabilityStatus:
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--i2cVth5NEHnEfZEcSYrqxylhPVanaWO73
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlrg5lkACgkQp6FrSiUn
Q2ptpAgAsNrqDubb/x3p00ExI3ZhK/RKk4mRxUeJm5SVQPVT+3Efg0zlrGGUTUYQ
AgvtGvBeANuOFjkWW5TvhuLaJLCR6SLDcfTLZQQNCUu6JEpASi6tegK19NBv5xCg
jzEJn0q8FTKSzwCtYX1P9TR9iJDGS5pbuQuEDf24FC4sx02l1Q/4R2X364LRJzK5
yxlBvnukAcZ3h/uCdTEJzHT8Q3jG14CEQ2NqIR1VpCm2kKumdFGlMVQXdZVUW74v
fYsY8ot5aHx+dB2UGarVfXPRG1uc/5aNqzBs0rGU5GQCsj2wN0SX7FeNUlVcIGzm
aNiC54VRmX+xU5I4FzrWGk27OsVAMQ==
=6ezQ
-----END PGP SIGNATURE-----

--i2cVth5NEHnEfZEcSYrqxylhPVanaWO73--
