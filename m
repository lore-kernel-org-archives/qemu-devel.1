Received: from eggs.gnu.org ([2001:4830:134:3::10]:46573)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dJKcy-000736-Uw
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 10:11:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dJKcv-0004WN-NA
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 10:11:04 -0400
References: <1497009003-25794-1-git-send-email-kwolf@redhat.com>
	<1497009003-25794-4-git-send-email-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <cca5d6f7-0747-5759-f940-1d8755b1a523@redhat.com>
Date: Fri, 9 Jun 2017 16:10:54 +0200
MIME-Version: 1.0
In-Reply-To: <1497009003-25794-4-git-send-email-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="B19LTSKX4o7tpkvwfD84RmlxRrHqbPKU2"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 3/3] qemu-iotests: Test
 exiting qemu with running job
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--B19LTSKX4o7tpkvwfD84RmlxRrHqbPKU2
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org
Message-ID: <cca5d6f7-0747-5759-f940-1d8755b1a523@redhat.com>
Subject: Re: [Qemu-block] [PATCH 3/3] qemu-iotests: Test exiting qemu with
 running job
References: <1497009003-25794-1-git-send-email-kwolf@redhat.com>
 <1497009003-25794-4-git-send-email-kwolf@redhat.com>
In-Reply-To: <1497009003-25794-4-git-send-email-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-06-09 13:50, Kevin Wolf wrote:
> When qemu is exited, all running jobs should be cancelled successfully.=

> This adds a test for this for all types of block jobs that currently
> exist in qemu.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  tests/qemu-iotests/185     | 189 +++++++++++++++++++++++++++++++++++++=
++++++++
>  tests/qemu-iotests/185.out |  59 ++++++++++++++
>  tests/qemu-iotests/group   |   1 +
>  3 files changed, 249 insertions(+)
>  create mode 100755 tests/qemu-iotests/185
>  create mode 100644 tests/qemu-iotests/185.out
>=20
> diff --git a/tests/qemu-iotests/185 b/tests/qemu-iotests/185
> new file mode 100755
> index 0000000..645ec9a
> --- /dev/null
> +++ b/tests/qemu-iotests/185

[...]

> +_supported_fmt qcow2 raw
> +_supported_proto file
> +_supported_os Linux

[...]

> +echo
> +echo =3D=3D=3D Creating backing chain =3D=3D=3D
> +echo
> +
> +_send_qemu_cmd $h \
> +    "{ 'execute': 'blockdev-snapshot-sync',
> +       'arguments': { 'device': 'disk',
> +                      'snapshot-file': '$TEST_IMG.mid',
> +                      'format': '$IMGFMT',

Not having looked at this series further yet (sorry...), I just noticed
that this does not work very well with raw.

Max

> +                      'mode': 'absolute-paths' } }" \
> +    "return"
> +
> +_send_qemu_cmd $h \
> +    "{ 'execute': 'human-monitor-command',
> +       'arguments': { 'command-line':
> +                      'qemu-io disk \"write 0 4M\"' } }" \
> +    "return"
> +
> +_send_qemu_cmd $h \
> +    "{ 'execute': 'blockdev-snapshot-sync',
> +       'arguments': { 'device': 'disk',
> +                      'snapshot-file': '$TEST_IMG',
> +                      'format': '$IMGFMT',
> +                      'mode': 'absolute-paths' } }" \
> +    "return"


--B19LTSKX4o7tpkvwfD84RmlxRrHqbPKU2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEvBAEBCAAZBQJZOqxuEhxtcmVpdHpAcmVkaGF0LmNvbQAKCRD0B9sAYdXPQHf+
CACmfbd36VuNn2gGEK04wtHSnGzv10Enm0eFLf5g88VEummaDLYJQEb0Qj32aNj6
gvYthve/7I4rzff3DbL0AdkPCPZL5j2BAfQ/KoR5svrQCk2JNauP2lEFAvdUEKgM
i7VnPH6Mh3CGF4CxcoXEYVi91TS6qaD/4k3+/MRtOpTwpPZKIAAaQEMiatGZPifn
crsj9zX4jqiBUY63/1+VvILpXy1KJnRWTK0C/PWzhA/t96YvAP4NmOwMCwID7dT8
AJANIH1cZm/uu1+zeRIoaUaUVsWQbzhffvqGzu919lMwStzyXrhQAnvV9V/7YLUE
Luim7rj76U/ffrGPXbcLCU6T
=XQqv
-----END PGP SIGNATURE-----

--B19LTSKX4o7tpkvwfD84RmlxRrHqbPKU2--
