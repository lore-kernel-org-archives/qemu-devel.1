Received: from eggs.gnu.org ([2001:4830:134:3::10]:49878)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cTGSu-0003gu-Tj
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 18:13:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cTGSt-0004dq-W5
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 18:13:28 -0500
References: <20170111181432.18868-1-mreitz@redhat.com>
	<20170116204921.31578-5-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <1f850049-e72f-93a6-29f0-c9047933b455@redhat.com>
Date: Mon, 16 Jan 2017 17:13:20 -0600
MIME-Version: 1.0
In-Reply-To: <20170116204921.31578-5-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ELo5guVqSHw7etR1WaPPS104vVXOWB3T1"
Subject: Re: [Qemu-devel] [PATCH v4 12/25] quorum: Make bdrv_dirname()
 return NULL
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Alberto Garcia <berto@igalia.com>, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ELo5guVqSHw7etR1WaPPS104vVXOWB3T1
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Alberto Garcia <berto@igalia.com>,
 Kevin Wolf <kwolf@redhat.com>
Message-ID: <1f850049-e72f-93a6-29f0-c9047933b455@redhat.com>
Subject: Re: [PATCH v4 12/25] quorum: Make bdrv_dirname() return NULL
References: <20170111181432.18868-1-mreitz@redhat.com>
 <20170116204921.31578-5-mreitz@redhat.com>
In-Reply-To: <20170116204921.31578-5-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/16/2017 02:49 PM, Max Reitz wrote:
> While the common implementation for bdrv_dirname() should return NULL
> for quorum BDSs already (because they do not have a file node and their=

> exact_filename field should be empty), there is no reason not to make
> that explicit.
>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  block/quorum.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--ELo5guVqSHw7etR1WaPPS104vVXOWB3T1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYfVOQAAoJEKeha0olJ0Nq0xIH/A88WOfQDgSYbtqQ6twFvFKS
fUM8+50NNrc8ToEkmyDD9JfPMITGzXA8+DgSiEun8tcf7gavHzjdl/HLC3SVkzrm
wL430U+mxp+ODVHSw++hwx8xUWDDcMm0rGXLMvtNZ6sRGb+jM620ntwBeUx1N33p
d9rHP/xh4UDPhdrmVhZil1tU2es9OzXnBBhxF4BhBYPL0ph1o2ENOdiVoWC/85XO
GAQqKkpnfuZENmQZKE6HlRamo5NtTMpJ9D7xA8B3I/Z9cWsdQ4JaErZJty51HzET
Yig4OvmkE/qXmFt/VkZpYscZf2FrIC6B5uDlGVUUzJCFE4+f5zSFUxP/fcd0bdE=
=GDgb
-----END PGP SIGNATURE-----

--ELo5guVqSHw7etR1WaPPS104vVXOWB3T1--
