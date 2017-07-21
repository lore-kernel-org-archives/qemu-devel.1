Received: from eggs.gnu.org ([2001:4830:134:3::10]:53991)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1dYYaj-0002i0-4W
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 10:07:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1dYYai-0000Jl-4c
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 10:07:41 -0400
References: <20170721034730.25612-1-crosa@redhat.com>
	<20170721034730.25612-2-crosa@redhat.com>
	<cce2586b-eafd-27cc-edc7-ea2d3d2275e0@redhat.com>
From: Cleber Rosa <crosa@redhat.com>
Message-ID: <0a8c375b-f787-7ba8-3475-2ec9363f92be@redhat.com>
Date: Fri, 21 Jul 2017 10:07:24 -0400
MIME-Version: 1.0
In-Reply-To: <cce2586b-eafd-27cc-edc7-ea2d3d2275e0@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="E9a1atT8hrR4VExe6SfMoVULLHe5Cedpu"
Subject: Re: [Qemu-devel] [PATCH 1/3] scripts: introduce buildconf.py
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>, Jing Liu <liujbjl@linux.vnet.ibm.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--E9a1atT8hrR4VExe6SfMoVULLHe5Cedpu
From: Cleber Rosa <crosa@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 Jing Liu <liujbjl@linux.vnet.ibm.com>
Message-ID: <0a8c375b-f787-7ba8-3475-2ec9363f92be@redhat.com>
Subject: Re: [PATCH 1/3] scripts: introduce buildconf.py
References: <20170721034730.25612-1-crosa@redhat.com>
 <20170721034730.25612-2-crosa@redhat.com>
 <cce2586b-eafd-27cc-edc7-ea2d3d2275e0@redhat.com>
In-Reply-To: <cce2586b-eafd-27cc-edc7-ea2d3d2275e0@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 07/21/2017 10:00 AM, Eric Blake wrote:
> On 07/20/2017 10:47 PM, Cleber Rosa wrote:
>> scripts/buildconf.py is a command line utility (but also can be used
>> as a Python module) that introspects the build configuration.
>>
>> It uses the generated host level config-host.mak to obtain the general=

>> build configuration, and optionally, also target specific
>> config-target.mak and config-devices.mak.  It does not attempt to
>> implement a Makefile parser, but instead relies on "make" itself to
>> parse those files and output the queried variable.
>>
>> It requires a build tree that has been both configured and built.  By
>> default, for convenience, it will selected a default target, which can=

>> be displayed and overriden.  A few examples follow.
>=20
> s/overriden/overridden/
>=20
>=20

Oops, thanks for spotting it.

>>
>> And for checking a target different than the default one:
>>
>>  $ ./scripts/buildconf.py -c CONFIG_PARALLEL arm-softmmu; echo $?
>>  255
>=20
> Gross.  exit status greater than 128 typically mean death due to signal=
,
> meanwhile, 255 is special-cased by find to kill processing immediately;=

> it is very rare that someone intentionally returns a status of 255, and=

> more often, it is evidence that someone mistakenly used exit(-1).
>=20

Yuck! Yes, it was a clear mistake.

>>
>> Signed-off-by: Cleber Rosa <crosa@redhat.com>
>> ---
>>  scripts/buildconf.py | 278 ++++++++++++++++++++++++++++++++++++++++++=
+++++++++
>>  1 file changed, 278 insertions(+)
>>  create mode 100755 scripts/buildconf.py
>>
>=20
> I don't feel comfortable reviewing the script in depth, but I will requ=
est:
>=20
>=20
>> +                else:
>> +                    sys.exit(-1)
>> +            else:
>> +                conf =3D get_build_conf(config, self.target)
>> +                if conf:
>> +                    print(conf)
>> +                    sys.exit(0)
>> +                else:
>> +                    sys.exit(-1)
>=20
> Please use sys.exit(1), not -1.
>=20

Sure, I 'll fix that.

> Overall, the idea is cool.
>=20

Thanks.  I mean, there's one big issue about the general approach, which
is to require a build root.  Let's see how this specific problem gets a
solution.

--=20
Cleber Rosa
[ Sr Software Engineer - Virtualization Team - Red Hat ]
[ Avocado Test Framework - avocado-framework.github.io ]
[  7ABB 96EB 8B46 B94D 5E0F  E9BB 657E 8D33 A5F2 09F3  ]


--E9a1atT8hrR4VExe6SfMoVULLHe5Cedpu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZcgqcAAoJEGV+jTOl8gnzbBwP/jmyW6tj59q8lFgV6J4aL7na
/H/J2OIsh8HKwnZKAGTxdsyHAvCa80PkUEZPq94JpRahKYHn5LhvTc+Eg0bzXWsF
6hfzZp87or/6dKOWWdJeoc2HQD0BZugvHpMGpvQsmG1mTaKxofEiIAurXR2T7Epr
uNCJb2hUNiOErQRZ4BYmv6F3JvLQElQNhSkF6k1bYiDzJjBiS0ogLCrkE9mRrzSe
O62MASgjrIf+uzQ6d3yeTq7GPv4QNTFJ7m6f2tZ0S0BA9gQ1tK3Z49VKJeeUvDw+
fikyOLswGY+gDKu1JXoaaS/44eW7f+XDJ91cZyTPK70+2fa7BfM9XGN3xzhS6PP9
tFPmp26fHEE/yBV7gL4Iu9fBBDtp7fT+iXHpbaC0WdH5tovnXeXW07az9c8Us/Rm
xOtQGind4LM+QX5ZDrqFW9jEnuDmQ6uktPJGUAOMzcIvIZTyZnuNkazBwcfwLpyJ
4r9unSN1sj1onm+Z8ZEH57z7mUQshaUb9pB1fSdki1YBs6X42/+MTNWiMwkRvzzH
HnbKSEcu5QX1U/aFDjX0f/puuIF5YraJEcz6cK9P1Gpkk2tEIkVwFS95gStj7zJd
1KGu5zNkSjrnBCvnED+TVhIVIoGINnH8XvzP6E5n5TsZxbdL8TVicjy9aZdOtGpg
Zpcc/vde4Act8MPKyRRo
=EUVb
-----END PGP SIGNATURE-----

--E9a1atT8hrR4VExe6SfMoVULLHe5Cedpu--
