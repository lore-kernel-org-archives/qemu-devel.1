Received: from eggs.gnu.org ([2001:4830:134:3::10]:53965)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dhHrs-0003pw-Db
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 12:05:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dhHro-0002RY-Fp
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 12:05:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33646)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dhHro-0002RA-6y
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 12:05:24 -0400
References: <35BC0F0B-7CB0-424C-86EA-2B5D8E219634@gmail.com>
	<20170811215845.n667iobglz5cef3z@var.youpi.perso.aquilenet.fr>
	<CAFEAcA_XrnDxZLhX5FGFBh+Mh-_80z3Z6b+0LkmQuoWzrWK0tA@mail.gmail.com>
	<20170812110410.rosk6yhkj22w346s@var.youpi.perso.aquilenet.fr>
	<CAFEAcA-N5pAM+3PXvjaJ-LMPFswAtmkAXA6yn151CCtfn+=JQA@mail.gmail.com>
	<20170812112925.mpi2mmewt46wna7j@var.youpi.perso.aquilenet.fr>
	<60ba7c95-8989-13bb-3aaf-ac9a8389320f@redhat.com>
	<52a8c2c0-5d51-9c92-3dbe-3c25bd09e16e@amsat.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <0ff38a6f-f310-887d-dddb-f45e00f367cd@redhat.com>
Date: Mon, 14 Aug 2017 11:05:14 -0500
MIME-Version: 1.0
In-Reply-To: <52a8c2c0-5d51-9c92-3dbe-3c25bd09e16e@amsat.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="AP3dOQspf7NrFLF4d0gcGnsBJsaUPN2Eq"
Subject: Re: [Qemu-devel] SLIRP warning messages displayed while compiling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Samuel Thibault <samuel.thibault@gnu.org>, Peter Maydell <peter.maydell@linaro.org>
Cc: Programmingkid <programmingkidx@gmail.com>, "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>, Jan Kiszka <jan.kiszka@siemens.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--AP3dOQspf7NrFLF4d0gcGnsBJsaUPN2Eq
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Samuel Thibault <samuel.thibault@gnu.org>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: Programmingkid <programmingkidx@gmail.com>,
 "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>,
 Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <0ff38a6f-f310-887d-dddb-f45e00f367cd@redhat.com>
Subject: Re: [Qemu-devel] SLIRP warning messages displayed while compiling
References: <35BC0F0B-7CB0-424C-86EA-2B5D8E219634@gmail.com>
 <20170811215845.n667iobglz5cef3z@var.youpi.perso.aquilenet.fr>
 <CAFEAcA_XrnDxZLhX5FGFBh+Mh-_80z3Z6b+0LkmQuoWzrWK0tA@mail.gmail.com>
 <20170812110410.rosk6yhkj22w346s@var.youpi.perso.aquilenet.fr>
 <CAFEAcA-N5pAM+3PXvjaJ-LMPFswAtmkAXA6yn151CCtfn+=JQA@mail.gmail.com>
 <20170812112925.mpi2mmewt46wna7j@var.youpi.perso.aquilenet.fr>
 <60ba7c95-8989-13bb-3aaf-ac9a8389320f@redhat.com>
 <52a8c2c0-5d51-9c92-3dbe-3c25bd09e16e@amsat.org>
In-Reply-To: <52a8c2c0-5d51-9c92-3dbe-3c25bd09e16e@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/12/2017 10:38 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi Eric,
>=20
> On 08/12/2017 08:41 AM, Eric Blake wrote:
>> Here's an idea:  Instead of using struct ip6 { ... } QEMU_PACKED, use
>>
>> struct ip6 {
>> ...
>> };
>> QEMU_BUG_ON(sizeof(struct ip6) !=3D 32);
>>
>> so that the compiler explicitly chokes if it introduced any padding, a=
nd
>> then we know all our accesses are naturally aligned which shuts up the=

>> warning.
>=20
> Following your suggestion I tried:
>=20
> #define QEMU_BUG_STRUCT_UNALIGNED(s) \
>         QEMU_BUILD_BUG_ON(sizeof(s) !=3D sizeof(s QEMU_PACKED))

I don't think gcc likes that (you can't just add attribute packed in
arbitrary places, but only where the type is declared).

>=20
> QEMU_BUG_STRUCT_UNALIGNED(struct ip6);
>=20
> but this gives:
>=20
> qemu/slirp/ip6.h:157:1: warning: 'packed' attribute ignored when parsin=
g
> type [-Wignored-attributes]
> QEMU_BUG_STRUCT_UNALIGNED(struct ip6);
> ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Indeed, there's the evidence that your attempt at a shortcut didn't
work. My proposal was to put in a hard-coded number, rather than try to
make the compiler compute two variants of the type and check that they
occupy the same space (although I agree with your idea that if you CAN
get the compiler to do that, it's nicer than hand-computing the number
to compare against).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--AP3dOQspf7NrFLF4d0gcGnsBJsaUPN2Eq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmRyjoACgkQp6FrSiUn
Q2p76gf/f9TmczYjtmAlfILZdxgBul4vEhxq5Qsxc2sFK4nIUH/bQyEN5u5JC+Y4
0WHXWG8VHYBjW/b1bzzontUqTExrmQ2Kysc8LAH7Qy5Rpcb3E9VB/Y3OI4l1qGZh
ruTtCG38vfJhnYua8UbXPkNnReinmwBD9BywOh4a53+TygL0aPmnSX/Pv8HlHLEi
C9Z654PGc8oA6FjyN8aOkb6wrOF2CkWbOL4HphXuBMGZnuIva0HotU8/4uk3GF19
EDvuSCuto1P0igRKWbjOnBS7DOcrmsyFY4qyC67wwM7BkVJXw6BF5vUW1E9YPqPF
39TTCn5GpDqwjczyMRk+kJ6KLVAONA==
=CuDw
-----END PGP SIGNATURE-----

--AP3dOQspf7NrFLF4d0gcGnsBJsaUPN2Eq--
