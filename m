Received: from eggs.gnu.org ([2001:4830:134:3::10]:60685)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ddeoK-0000XL-Rx
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 11:46:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ddeoJ-00084p-SV
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 11:46:48 -0400
References: <20170804140942.19342-1-famz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <839fdd63-56d8-2821-37a4-c5b9f4f03720@redhat.com>
Date: Fri, 4 Aug 2017 10:46:36 -0500
MIME-Version: 1.0
In-Reply-To: <20170804140942.19342-1-famz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="UpFFGlBs7eUvfaDBRljj1o3VEkq86WO6W"
Subject: Re: [Qemu-devel] [PATCH for-2.10] vmdk: Fix error
 handling/reporting of vmdk_check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--UpFFGlBs7eUvfaDBRljj1o3VEkq86WO6W
From: Eric Blake <eblake@redhat.com>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Message-ID: <839fdd63-56d8-2821-37a4-c5b9f4f03720@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.10] vmdk: Fix error handling/reporting
 of vmdk_check
References: <20170804140942.19342-1-famz@redhat.com>
In-Reply-To: <20170804140942.19342-1-famz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/04/2017 09:09 AM, Fam Zheng wrote:
> Errors from the callees must be captured and propagated to our caller,
> ensure this for both find_extent() and bdrv_getlength().
>=20
> Reported-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  block/vmdk.c | 26 ++++++++++++++++++--------
>  1 file changed, 18 insertions(+), 8 deletions(-)
>=20

> +        if (ret =3D=3D VMDK_OK) {
> +            int64_t extent_len =3D bdrv_getlength(extent->file->bs);
> +            if (extent_len < 0) {
> +                fprintf(stderr,
> +                        "ERROR: could not get extent file length for s=
ector %"
> +                        PRId64 "\n", sector_num);
> +                ret =3D extent_len;

Pre-existing - our use of fprintf() is not ideal.  But this patch
doesn't make it worse.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--UpFFGlBs7eUvfaDBRljj1o3VEkq86WO6W
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmEltwACgkQp6FrSiUn
Q2oX1Qf+OcO+X9nAgH/A9K9O97C+hXxbHcVPJ+yqsk2V3pPb6mvKZyLIo8hQV2SS
EoAcHXihoxaOe+ivVdfkycM7JHXwPhnxeIcbK306IsBSDVE9H/qVwv/Q4ci7SLxn
/FDvE4qsicKlhunXVXMJLtKcjXY+ErAVG09LxSlOIfYW5rtL07ki3yDPPSSvUwzp
8G5pL3MEhgqYLeT68Mcp1skf2zn2kFT8YUnCWOs7WjJQnjL22GXU+0AwRVkvLLbj
Q+YUXdHHiUUYgnEx2oiccSuNzP2MSSmmDC0FVXbGLVy2qtCgHAZS6LzJVvridRIO
bH3R9K7TsYSlZMH8V8DyoqHfYrkDcQ==
=oBh8
-----END PGP SIGNATURE-----

--UpFFGlBs7eUvfaDBRljj1o3VEkq86WO6W--
