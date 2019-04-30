Received: from eggs.gnu.org ([209.51.188.92]:48309)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hLUuk-0007mj-22
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 11:43:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hLUjw-0002fL-Q5
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 11:32:22 -0400
References: <155663248155.10667.17447181616173672748@c2072b67cc0c>
From: Eric Blake <eblake@redhat.com>
Message-ID: <5ea85bff-8f16-d140-c3ac-d9aaea0186e2@redhat.com>
Date: Tue, 30 Apr 2019 10:32:11 -0500
MIME-Version: 1.0
In-Reply-To: <155663248155.10667.17447181616173672748@c2072b67cc0c>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="FtIzyKBbzQ74n16wQSA2Gx4QGPOgtDxvZ"
Subject: Re: [Qemu-devel] [PATCH] qcow2: Fix qcow2_make_empty() with
 external data file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, patchew-devel@patchew.org, kwolf@redhat.com
Cc: fam@euphon.net, qemu-block@nongnu.org, qemu-stable@nongnu.org, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--FtIzyKBbzQ74n16wQSA2Gx4QGPOgtDxvZ
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org, patchew-devel@patchew.org, kwolf@redhat.com
Cc: fam@euphon.net, qemu-block@nongnu.org, qemu-stable@nongnu.org,
 mreitz@redhat.com
Message-ID: <5ea85bff-8f16-d140-c3ac-d9aaea0186e2@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] qcow2: Fix qcow2_make_empty() with external
 data file
References: <155663248155.10667.17447181616173672748@c2072b67cc0c>
In-Reply-To: <155663248155.10667.17447181616173672748@c2072b67cc0c>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 4/30/19 8:54 AM, no-reply@patchew.org wrote:
> Patchew URL: https://patchew.org/QEMU/20190429105741.31033-1-kwolf@redh=
at.com/
>=20
>=20
>=20
> Hi,
>=20
> This series failed the docker-mingw@fedora build test. Please find the =
testing commands and
> their output below. If you have Docker installed, you can probably repr=
oduce it
> locally.
>=20
> =3D=3D=3D TEST SCRIPT BEGIN =3D=3D=3D
> #!/bin/bash
> time make docker-test-mingw@fedora SHOW_ENV=3D1 J=3D14 NETWORK=3D1
> =3D=3D=3D TEST SCRIPT END =3D=3D=3D
>=20
>=20
>=20
>=20
> The full log is available at

Patchew trimmed a bit too much; also, the error appears to be transient
and unrelated to the patch at hand. Quoting from:

> http://patchew.org/logs/20190429105741.31033-1-kwolf@redhat.com/testing=
=2Edocker-mingw@fedora/?type=3Dmessage.



Updating 3c8cf5a9c21ff8782164d1def7f44bd888713384
fatal: git fetch_pack: expected ACK/NAK, got 'ERR upload-pack: not our
ref 1cd70b1217a3e02617dbba76d15d21be1e8e4aa0'
fatal: The remote end hung up unexpectedly
error: Could not fetch 3c8cf5a9c21ff8782164d1def7f44bd888713384
Traceback (most recent call last):
  File "patchew-tester/src/patchew-cli", line 521, in test_one
    git_clone_repo(clone, r["repo"], r["head"], logf, True)
  File "patchew-tester/src/patchew-cli", line 48, in git_clone_repo
    stdout=3Dlogf, stderr=3Dlogf)
  File "/usr/lib64/python3.4/subprocess.py", line 558, in check_call
    raise CalledProcessError(retcode, cmd)
subprocess.CalledProcessError: Command '['git', 'remote', 'add', '-f',
'--mirror=3Dfetch', '3c8cf5a9c21ff8782164d1def7f44bd888713384',
'https://github.com/patchew-project/qemu']' returned non-zero exit status=
 1


> ---
> Email generated automatically by Patchew [https://patchew.org/].
> Please send your feedback to patchew-devel@redhat.com
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--FtIzyKBbzQ74n16wQSA2Gx4QGPOgtDxvZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlzIansACgkQp6FrSiUn
Q2qB4wf9GkhwOjpharJgpF2+GxpIMkx3+jzVP0OXUr0nBHOJ1LRCMoP33wtRG3Sk
tJyQRBCE7dLSSA0SJpNIJGX/VTtUK80B2O2J5KTX2rzGZonMv0KAQ3rOxmQf9y5h
rSCj7oK9wZigfPqmQiLLa3Rnj/uGXL1jNIaE0W73C6q4c8DidmDouO684KPLUwxN
Cb0WdCe4N0Xl4f2U0/jhonuMWlHI3kKqMCspaCxHeofXLs3Jbf1fx02L74yz22ea
/8nZkPdnlkHhqQp+an0fafS3SMOyh5sXhWdAJRhavZZTTujLjNQGNiaxQK8UuuAD
nxWqaqU9nDUPF1IshLN5cHmBHSwuBQ==
=blqk
-----END PGP SIGNATURE-----

--FtIzyKBbzQ74n16wQSA2Gx4QGPOgtDxvZ--
