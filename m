Received: from eggs.gnu.org ([2001:4830:134:3::10]:49218)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dwZI1-00069H-0u
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 15:43:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dwZI0-0006NC-A3
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 15:43:37 -0400
References: <20170925122808.14561-1-kwolf@redhat.com>
	<20170925122808.14561-4-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d990a587-0082-08e7-c507-0f60def33fb4@redhat.com>
Date: Mon, 25 Sep 2017 14:43:28 -0500
MIME-Version: 1.0
In-Reply-To: <20170925122808.14561-4-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="EOgl7Vr9uLAQsoQU22LEUXSxoPSVL6wBQ"
Subject: Re: [Qemu-devel] [PATCH 3/5] qemu-iotests: Allow QMP pretty
 printing in common.qemu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: mreitz@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--EOgl7Vr9uLAQsoQU22LEUXSxoPSVL6wBQ
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: mreitz@redhat.com, qemu-devel@nongnu.org
Message-ID: <d990a587-0082-08e7-c507-0f60def33fb4@redhat.com>
Subject: Re: [PATCH 3/5] qemu-iotests: Allow QMP pretty printing in
 common.qemu
References: <20170925122808.14561-1-kwolf@redhat.com>
 <20170925122808.14561-4-kwolf@redhat.com>
In-Reply-To: <20170925122808.14561-4-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/25/2017 07:28 AM, Kevin Wolf wrote:
> QMP responses to certain commands can become quite long, which doesn't
> only make reading them hard, but also means that the maximum line lengt=
h
> in patch emails can be exceeded. Allow tests to switch to QMP pretty
> printing, which results in more, but shorter lines.
>=20
> We also need to make sure to keep indentation in the response for this
> to work as expected.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  tests/qemu-iotests/common.qemu | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)

Nice!
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--EOgl7Vr9uLAQsoQU22LEUXSxoPSVL6wBQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnJXGAACgkQp6FrSiUn
Q2oETwgAl8rVPqJ1gFRCanZtBJ9K8+4t3VNgJWHWDMbsbskfmAkiapbAtL02blnJ
V6uYEzgiydOtX6pasJlgdS04Lj+nhkcHJR3ACQ6qKFQbbbmgrqCyi/DCbsr9Qwf9
wtngKdycC1BA7MyQgY2naJEAz3DrEV6H+XTa98SlPyF6Kdt4hmpa5NCi/HqWENtN
jUeWANltcIYoQ8AV1s983h5Od5bIf6e/IKqk6kGvWtvsiDrXSULm8N8CX8K8hve5
a8x0t0BYqfIMKeIWik4jmp/I1ie6NX59g3vGWmY88M+Eqquws1rT0Npb/5jpqpjl
huLs7aRsPbfs1d2kJNQvrdWjZjpeZg==
=saym
-----END PGP SIGNATURE-----

--EOgl7Vr9uLAQsoQU22LEUXSxoPSVL6wBQ--
