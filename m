Received: from eggs.gnu.org ([2001:4830:134:3::10]:55337)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dn7Uz-00082j-Ri
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 14:13:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dn7Uy-0003aV-KR
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 14:13:57 -0400
References: <cover.1504111803.git.jcody@redhat.com>
	<aea3a5d63b6937d8bd87afb3741db6c09ea7436e.1504111803.git.jcody@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <627b615e-b42d-f59c-7b9f-e02fd139a85b@redhat.com>
Date: Wed, 30 Aug 2017 13:13:44 -0500
MIME-Version: 1.0
In-Reply-To: <aea3a5d63b6937d8bd87afb3741db6c09ea7436e.1504111803.git.jcody@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="HMINxs5hu1J01tMeAAT9IOu1tOKOXD8Vm"
Subject: Re: [Qemu-devel] [PATCH v3 3/5] qemu-iotests: add 'blind_remove'
 for python tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, armbru@redhat.com, jsnow@redhat.com, stefanha@redhat.com, kwolf@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--HMINxs5hu1J01tMeAAT9IOu1tOKOXD8Vm
From: Eric Blake <eblake@redhat.com>
To: Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, armbru@redhat.com, jsnow@redhat.com,
 stefanha@redhat.com, kwolf@redhat.com
Message-ID: <627b615e-b42d-f59c-7b9f-e02fd139a85b@redhat.com>
Subject: Re: [PATCH v3 3/5] qemu-iotests: add 'blind_remove' for python tests
References: <cover.1504111803.git.jcody@redhat.com>
 <aea3a5d63b6937d8bd87afb3741db6c09ea7436e.1504111803.git.jcody@redhat.com>
In-Reply-To: <aea3a5d63b6937d8bd87afb3741db6c09ea7436e.1504111803.git.jcody@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/30/2017 11:52 AM, Jeff Cody wrote:
> Add a function to attempt to 'blindly' remove a file, without
> throwing an error if the file doesn't exist.
>=20
> Signed-off-by: Jeff Cody <jcody@redhat.com>
> ---
>  tests/qemu-iotests/iotests.py | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests=
=2Epy
> index 7233983..a2088c7 100644
> --- a/tests/qemu-iotests/iotests.py
> +++ b/tests/qemu-iotests/iotests.py
> @@ -57,6 +57,13 @@ qemu_default_machine =3D os.environ.get('QEMU_DEFAUL=
T_MACHINE')
>  socket_scm_helper =3D os.environ.get('SOCKET_SCM_HELPER', 'socket_scm_=
helper')
>  debug =3D False
> =20
> +def blind_remove(filename):
> +    try:
> +        os.remove(filename)
> +    except OSError, error:

I'm assuming this works for both python 2 and 3?

> +        if error.errno !=3D errno.ENOENT:
> +            raise
> +

Weak, since I'm not the strongest at python, but you can add:
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--HMINxs5hu1J01tMeAAT9IOu1tOKOXD8Vm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmnAFgACgkQp6FrSiUn
Q2oU4Qf+JR/y594HwLa6+fX1i1ZVVdkuV6K6w8zWK2hU8NuVmIhC3wWyk+gshvc1
r8WRyGjeOGqAczVx4L0s73MZzPKfXBy+Cgo3QjbZbmb44W/k6RTBZsoFsJNxhfmn
OW7LG8nHjmHVHNW8ujzxOWCKTCdJHaxzmHFN4M1tdsZLjNaGYxyDmEDX/Avk+aPQ
T3DDxcvx+7N24jiF/eAvgB2Ok8mDSBiPFc3rfRDSF/zV9N61JzZd61CgVgcZws87
YSlbHXlFdBvF06XIPhtJboA6rqQKXPawCdAk44CxbW+HQcAGBmrPBg82ygDcT/4T
nJHigQ0NIQCzPOLqEfwm/R13PRiRJg==
=3gTA
-----END PGP SIGNATURE-----

--HMINxs5hu1J01tMeAAT9IOu1tOKOXD8Vm--
