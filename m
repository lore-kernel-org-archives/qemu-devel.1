Received: from eggs.gnu.org ([2001:4830:134:3::10]:45242)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1egtJw-0000Xq-M7
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 09:25:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1egtJr-0004Nz-Rp
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 09:25:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39136)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1egtJr-0004Mw-JA
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 09:24:59 -0500
References: <20180131032800.25578-1-famz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <5c8b634a-0edd-52af-3f9f-aef0205526c8@redhat.com>
Date: Wed, 31 Jan 2018 08:24:24 -0600
MIME-Version: 1.0
In-Reply-To: <20180131032800.25578-1-famz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ulYOmwnXuNLQ817LfBNVsnT86WsLwgwge"
Subject: Re: [Qemu-devel] [PATCH v2] docs: Add docs/devel/testing.rst
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, thuth@redhat.com, berrange@redhat.com, f4bug@amsat.org, mreitz@redhat.com, stefanha@redhat.com, pbonzini@redhat.com, alex.bennee@linaro.org, armbru@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ulYOmwnXuNLQ817LfBNVsnT86WsLwgwge
From: Eric Blake <eblake@redhat.com>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, thuth@redhat.com, berrange@redhat.com, f4bug@amsat.org,
 mreitz@redhat.com, stefanha@redhat.com, pbonzini@redhat.com,
 alex.bennee@linaro.org, armbru@redhat.com
Message-ID: <5c8b634a-0edd-52af-3f9f-aef0205526c8@redhat.com>
Subject: Re: [PATCH v2] docs: Add docs/devel/testing.rst
References: <20180131032800.25578-1-famz@redhat.com>
In-Reply-To: <20180131032800.25578-1-famz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/30/2018 09:28 PM, Fam Zheng wrote:
> To make our efforts on QEMU testing easier to consume by contributors,
> let's add a document. For example, Patchew reports build errors on
> patches that should be relatively easy to reproduce with a few steps, a=
nd
> it is much nicer if there is such a documentation that it can refer to.=

>=20
> This focuses on how to run existing tests and how to write new test
> cases, without going into the frameworks themselves.
>=20
> The VM based testing section is moved from tests/vm/README which now
> is a single line pointing to the new doc.
>=20
> Signed-off-by: Fam Zheng <famz@redhat.com>
>=20

> +Testing with "make check"
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> +
> +The "make check" testing family includes most of the C based tests in =
QEMU. For
> +a quick help, run ``make check-help`` from the source tree.
> +
> +The usual way to run these tests is:
> +
> +.. code::
> +
> +  make check
> +
> +which includes QAPI schema tests, unit tests, and QTests. Different su=
b-types
> +of "make check" testings will be explained below.

s/testings/tests/ or even s/testings//


> +Since unit tests don't require environment variables, the simplest way=
 to debug
> +a unit test failure is often directly invoking it or even running it u=
nder
> +``gdb``. However there can still be differences in behavior between ``=
make``
> +invocations and your manual run, due to ``$MALLOC_PERTURB_`` environme=
nt
> +variable (which affects memory reclaimation and catches invalid pointe=
rs

s/reclaimation/reclamation/


> +  $ sudo groupadd docker
> +  $ sudo usermod $USER -G docker
> +  $ sudo chown :docker /var/run/docker.sock
> +
> +Note that any one of above configurations makes it possible for the us=
er to
> +exploit the whole host with Docker bind mounting or other privileged
> +operations.  So only do it on developement machines.

s/developement/development/

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--ulYOmwnXuNLQ817LfBNVsnT86WsLwgwge
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpx0ZgACgkQp6FrSiUn
Q2rFzwgAnjG6dCAwZHrSCpAEnqMHLliUfbRxDCBlaWXnMD3UrJjKySyZAXk+/8St
OEjliNnr3yKCKqjE9iPKmeo2uvo7P+h8tm7zm8lRrMCAM4vXJjOUHAsJh5PyYNu0
K97OmvtLQDHdNJWVlpRRuo63zXG+PjxNw5XvPHE+sKCRUc13FndRBVoG9jTEt/nD
ktyD71Fnn61p5eFk65pfBcbJRMWiDgPyYC4NttTXQ6XpQq8OwnpBWoWIKSVLNUOF
L5AazpClfTsgHYepjHHdGz+lMonOPBKEAOZPjrKDwnde0xE4KppRY3zqb26ZYaEF
Of24Ti6V2g86Md8tGsV3LN9P9rUWyQ==
=AHpS
-----END PGP SIGNATURE-----

--ulYOmwnXuNLQ817LfBNVsnT86WsLwgwge--
