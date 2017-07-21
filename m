Received: from eggs.gnu.org ([2001:4830:134:3::10]:54316)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dYX8V-0003tM-4x
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 08:34:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dYX8U-0005SF-7g
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 08:34:27 -0400
References: <20170721102059.14663-1-famz@redhat.com>
	<20170721115608.GC4228@noname.redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f184e2a9-7832-c9f5-37c0-91b773ca1e33@redhat.com>
Date: Fri, 21 Jul 2017 07:34:11 -0500
MIME-Version: 1.0
In-Reply-To: <20170721115608.GC4228@noname.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="iI7Fx2UwFqnJVcIaCkv1aNncLdqVVXs3q"
Subject: Re: [Qemu-devel] [PATCH 0/2] block: Do OFD lock check at runtime
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Andrew Baumann <Andrew.Baumann@microsoft.com>, jsnow@redhat.com, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--iI7Fx2UwFqnJVcIaCkv1aNncLdqVVXs3q
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Andrew Baumann <Andrew.Baumann@microsoft.com>, jsnow@redhat.com,
 Max Reitz <mreitz@redhat.com>
Message-ID: <f184e2a9-7832-c9f5-37c0-91b773ca1e33@redhat.com>
Subject: Re: [PATCH 0/2] block: Do OFD lock check at runtime
References: <20170721102059.14663-1-famz@redhat.com>
 <20170721115608.GC4228@noname.redhat.com>
In-Reply-To: <20170721115608.GC4228@noname.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/21/2017 06:56 AM, Kevin Wolf wrote:
>>
>> Convert to runtime check to cope with that.
>=20
> Fair enough in this specific case because we still support older Linux
> kernels and we want to fail gracefully if the binary was built against
> a newer kernel.

Or, more likely: if we are built against a newer glibc (that has the
constants) but an older kernel (that lacks support for the constants).

>=20
> However, I think the real problem here is with the WSL ecosystem if qem=
u
> is routinely built against a real Linux while WSL doesn't provide the
> same functionality. WSL should provide kernel headers that match what
> it can provide (i.e. either remove the unimplemnted constants or
> implement them).

In other words, you're arguing that binaries built for WSL should be
cross-compiled rather than native compiled (similar to how mingw
binaries are built in a Cygwin environment), such that the
cross-compiler picks up the correct altered headers for WSL limitations.
 I agree - but I have no influence on how likely that is to come about.

>=20
> So for the future, I'm not sure that we should add workarounds for WSL
> shortcomings when no real Linux is affected.
>=20
> This is even more true when the reporter is a Microsoft employee.
>=20
> Kevin
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--iI7Fx2UwFqnJVcIaCkv1aNncLdqVVXs3q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAllx9MMACgkQp6FrSiUn
Q2pjWgf8DIGn81ckqtYipF1/6/nI81krWli+c2oEveNHBaVj9vSJEw3WxV5QSyIo
9NmouywqfQUfAw6YRWOn+ylh4B87q1TWni53opW2rAVbAaLmXk9lKXYtpsRil57p
q+UVEVKzL5KtK0wdPWXJuGkEAK1jwWrJdgvVpJXtOS2QpLcQUS71d51Phvr9aFfa
95tzqh+R8mrUtH5TVBWn56RGhEkIHWKWgjLbUOAWGtmLktt3dDxc9h6eBWkT6A/o
vX7zagXaj/eEaFq7Jm4tVJU43L8U/7p/CAhu6WhlhPPDoLG96nk5XMQ3n+41lCdb
UsDZEU84Koy+ZDwFwemvT5d6iIhaUw==
=Q6Ud
-----END PGP SIGNATURE-----

--iI7Fx2UwFqnJVcIaCkv1aNncLdqVVXs3q--
