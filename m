Received: from eggs.gnu.org ([2001:4830:134:3::10]:42812)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eMaik-0006WZ-7g
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 09:30:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eMaij-0005Sy-6V
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 09:30:46 -0500
References: <20171206115726.5237-1-berrange@redhat.com>
	<171741b3-39b8-7c37-8e07-4a9dd590e4c9@redhat.com>
	<20171206142513.GD18296@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f06a9a2f-2f4a-945f-739b-8be9333caf5e@redhat.com>
Date: Wed, 6 Dec 2017 08:30:27 -0600
MIME-Version: 1.0
In-Reply-To: <20171206142513.GD18296@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="VRogcDdqJrQ2cmOjl9W1PkJ28LJQIvsbj"
Subject: Re: [Qemu-devel] [PATCH] qemu-io: fix EOF Ctrl-D handling in
 qemu-io readline code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--VRogcDdqJrQ2cmOjl9W1PkJ28LJQIvsbj
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Message-ID: <f06a9a2f-2f4a-945f-739b-8be9333caf5e@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] qemu-io: fix EOF Ctrl-D handling in qemu-io
 readline code
References: <20171206115726.5237-1-berrange@redhat.com>
 <171741b3-39b8-7c37-8e07-4a9dd590e4c9@redhat.com>
 <20171206142513.GD18296@redhat.com>
In-Reply-To: <20171206142513.GD18296@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/06/2017 08:25 AM, Daniel P. Berrange wrote:

>> Should we instead be looking for a match against the current termios()=

>> c_cc[VEOF] setting, in case the user prefers something other than ^D v=
ia
>> stty?  Does readline provide any functionality for automating this?
>=20
> I was afraid someone was going to suggest doing that. I was being lazy =
by
> hardcoding Ctrl-D, but yes the real readline() library will honour the
> VEOF value.  QEMU though is using a home-grown reimpl of readline...

I understand why we can't use modern libreadline (it is licensed GPLv3+,
making it impossible to use with our GPLv2-only code) - but doesn't BSD
have a readline-alike library with BSD licensing that we could use
instead of implementing readline ourselves?  (Was it named libinput?)

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--VRogcDdqJrQ2cmOjl9W1PkJ28LJQIvsbj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlon/wMACgkQp6FrSiUn
Q2pfRAf/T1ME3OtkuXvK4hdXXocOQi/yv6JglazcJCDwOabr4YhMI8G6KFONhdeA
sjIQYTVb4l3RjGZioi+oGS5iYoIIpz/gXg/V2gtkPUU/+96rZgXsSUtJnc8A2TEq
x/UWLlKBFl1ccx7UUuXxoP0RypfU/bob9HSUmszTiHPyzzMCUfoiLYVsbnNrknNR
YLDDht4CzF+QDivBxAQTk1KfwScxp2RDHCoAYHjnyClx2bJLndSHNxsu/u0J0lIo
JZ/JFnifD2k5EMT5+2HMJiCaJ3n3/v3G/Sy/A60GpSZRczGG6Skv6NEaRn2N+GeK
l8KmBzvcLJoN4Zs0Bz7DIB0SUPFbRg==
=qG7A
-----END PGP SIGNATURE-----

--VRogcDdqJrQ2cmOjl9W1PkJ28LJQIvsbj--
