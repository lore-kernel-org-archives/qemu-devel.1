Received: from eggs.gnu.org ([2001:4830:134:3::10]:44677)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eCtty-0002cb-6j
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 15:58:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eCttw-0007xs-Vl
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 15:58:18 -0500
References: <20171109203025.27493-1-mreitz@redhat.com>
	<20171109203025.27493-5-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <73d1bcb3-aeaf-24d1-5cf0-359c58de0283@redhat.com>
Date: Thu, 9 Nov 2017 14:58:07 -0600
MIME-Version: 1.0
In-Reply-To: <20171109203025.27493-5-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="V8Af10O83cQ2km6T1l9qMN2KxaHvLhHmJ"
Subject: Re: [Qemu-devel] [PATCH v2 4/5] iotests: Make 083 less flaky
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--V8Af10O83cQ2km6T1l9qMN2KxaHvLhHmJ
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <73d1bcb3-aeaf-24d1-5cf0-359c58de0283@redhat.com>
Subject: Re: [PATCH v2 4/5] iotests: Make 083 less flaky
References: <20171109203025.27493-1-mreitz@redhat.com>
 <20171109203025.27493-5-mreitz@redhat.com>
In-Reply-To: <20171109203025.27493-5-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11/09/2017 02:30 PM, Max Reitz wrote:
> 083 has (at least) two issues:
>=20
> 1. By launching the nbd-fault-injector in background, it may not be
>    scheduled until the first grep on its output file is executed.
>    However, until then, that file may not have been created yet -- so i=
t
>    either does not exist yet (thus making the grep emit an error), or i=
t
>    does exist but contains stale data (thus making the rest of the test=

>    case work connect to a wrong address).
>    Fix this by explicitly overwriting the output file before executing
>    nbd-fault-injector.
>=20
> 2. The nbd-fault-injector prints things other than "Listening on...".
>    It also prints a "Closing connection" message from time to time.  We=

>    currently invoke sed on the whole file in the hope of it only
>    containing the "Listening on..." line yet.  That hope is sometimes
>    shattered by the brutal reality of race conditions, so invoke grep
>    before sed.

Comment is now stale; s/invoke grep before sed/make the sed script more
robust/

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--V8Af10O83cQ2km6T1l9qMN2KxaHvLhHmJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAloEwV8ACgkQp6FrSiUn
Q2r1YQgAnuY4iZp1XgCd21sOA5oIcySlztfyF8iattX/jkasBzg8OiZexMHlRBDw
u/dtzITvXfu/X5a6D6RoLiyhCCj0BNBvSavrBMGEAOOCkZJpnAUfnoiSxPlgid+q
Dw+K2RfdUtMT0qT511hK0073kDtVteXSwkMYTIZCYe47oJW59DVHwt0eGbruurzu
1vo6uOqkfd7rq+d+VrRyJhIJmP8uYuwn9ex1FA2byg9H7bld/MbE/Q/CZZN35k3R
wjenC1d4HYo+W5bMQ18T/cKDroCkW5RowtjIGg9VaQVs8BwoV5+4Z3ujQz9gRYl0
QfYj9M1hgm4l/FRSZsLfhRZ3O2Ip+Q==
=YK3S
-----END PGP SIGNATURE-----

--V8Af10O83cQ2km6T1l9qMN2KxaHvLhHmJ--
