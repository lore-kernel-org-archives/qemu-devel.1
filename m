Received: from eggs.gnu.org ([2001:4830:134:3::10]:55719)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dehOX-0000m1-4N
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 08:44:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dehOS-0006z9-0w
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 08:44:29 -0400
References: <1502109458-31251-1-git-send-email-pradeep.jagadeesh@huawei.com>
	<1502109458-31251-3-git-send-email-pradeep.jagadeesh@huawei.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <4329dde2-984f-8fcc-8d16-76d55dd9f538@redhat.com>
Date: Mon, 7 Aug 2017 07:44:09 -0500
MIME-Version: 1.0
In-Reply-To: <1502109458-31251-3-git-send-email-pradeep.jagadeesh@huawei.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="B0248kjUtu1svKp4XF4acbDEk9OiVVvM8"
Subject: Re: [Qemu-devel] [PATCH V8 2/6] qmp: Create IOThrottle structure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pradeep Jagadeesh <pradeepkiruvale@gmail.com>, greg kurz <groug@kaod.org>
Cc: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>, alberto garcia <berto@igalia.com>, jani kokkonen <jani.kokkonen@huawei.com>, qemu-devel@nongnu.org, Manos Pitsidianakis <el13635@mail.ntua.gr>, qemu block <qemu-block@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--B0248kjUtu1svKp4XF4acbDEk9OiVVvM8
From: Eric Blake <eblake@redhat.com>
To: Pradeep Jagadeesh <pradeepkiruvale@gmail.com>, greg kurz <groug@kaod.org>
Cc: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>,
 alberto garcia <berto@igalia.com>, jani kokkonen <jani.kokkonen@huawei.com>,
 qemu-devel@nongnu.org, Manos Pitsidianakis <el13635@mail.ntua.gr>,
 qemu block <qemu-block@nongnu.org>
Message-ID: <4329dde2-984f-8fcc-8d16-76d55dd9f538@redhat.com>
Subject: Re: [PATCH V8 2/6] qmp: Create IOThrottle structure
References: <1502109458-31251-1-git-send-email-pradeep.jagadeesh@huawei.com>
 <1502109458-31251-3-git-send-email-pradeep.jagadeesh@huawei.com>
In-Reply-To: <1502109458-31251-3-git-send-email-pradeep.jagadeesh@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/07/2017 07:37 AM, Pradeep Jagadeesh wrote:
> This patch enables qmp interfaces for the fsdev
> devices. This provides two interfaces one
> for querying info of all the fsdev devices. The second one
> to set the IO limits for the required fsdev device.
>=20
> Signed-off-by: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>
> Reviewed-by: Greg Kurz <groug@kaod.org>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Alberto Garcia <berto@igalia.com>
> ---
>  qapi/block-core.json | 76 ++------------------------------------------=
-
>  qapi/iothrottle.json | 88 ++++++++++++++++++++++++++++++++++++++++++++=
++++++++
>  2 files changed, 91 insertions(+), 73 deletions(-)
>  create mode 100644 qapi/iothrottle.json

I'm wondering how much of this overlaps or even duplicates Manos'
efforts on making throttling a separate filter BDS.


> +++ b/qapi/iothrottle.json
> @@ -0,0 +1,88 @@
> +# -*- Mode: Python -*-
> +
> +##
> +# =3D=3D QAPI IOThrottle definitions
> +##
> +
> +##
> +# @IOThrottle:
> +#
> +# A set of parameters describing IO throttling
> +#
> +# @id: The name or QOM path of the guest device (since: 2.8)

> +# Since: 2.10

Also, we've missed freeze for 2.10; this refactoring now belongs in 2.11.=


> +##
> +{ 'struct': 'IOThrottle',
> +  'data': { '*id': 'str', 'bps': 'int', 'bps_rd': 'int',
> +            'bps_wr': 'int', 'iops': 'int', 'iops_rd': 'int', 'iops_wr=
': 'int',
> +            '*bps_max': 'int', '*bps_rd_max': 'int',
> +            '*bps_wr_max': 'int', '*iops_max': 'int',
> +            '*iops_rd_max': 'int', '*iops_wr_max': 'int',
> +            '*bps_max_length': 'int', '*bps_rd_max_length': 'int',
> +            '*bps_wr_max_length': 'int', '*iops_max_length': 'int',
> +            '*iops_rd_max_length': 'int', '*iops_wr_max_length': 'int'=
,
> +            '*iops_size': 'int' } }
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--B0248kjUtu1svKp4XF4acbDEk9OiVVvM8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmIYJkACgkQp6FrSiUn
Q2oHUgf/UswRIHYAYM6LYy9rPeVKbfLkIKLDD42lXWvawjeKDqZ3SQSntHt0S2Xk
cBbibubFykJgsuQHqw+BfPisNiZImRxuRAiZDstbKyOPLxb1k29cO7sE9mwwe+TQ
Et+GQD4ZYwzCfQFJijf6Qb8M6j9VVPmrVCfq6k2fYoIAu6zKe7qsbHxjsZsXdghM
IQSPH+GrpkWP5ExKUjopp2uCB5QjD2wzilvJuujQtLEya42IQSLm5KoNoZVZQpdZ
C6q3B8Z/eYOF9aVSyVKBczEHyA63+k5WwRRcWqLsaQWXemtiyYJrnpJ8cp7nwLs0
v4z4+aeWWCigIBYateCfmjziSplCCw==
=ntHa
-----END PGP SIGNATURE-----

--B0248kjUtu1svKp4XF4acbDEk9OiVVvM8--
