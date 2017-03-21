Received: from eggs.gnu.org ([2001:4830:134:3::10]:58763)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cqO3p-0004O6-Nf
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 13:59:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cqO3n-0005no-43
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 13:59:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52342)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cqO3m-0005nj-RQ
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 13:59:07 -0400
References: <CAFEAcA9pqDoCWrPAJ+KVxLC_eRy-xRg36oYuARYg2YP8VpGpBg@mail.gmail.com>
	<20170316154643.GT15193@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <bb405833-37ca-f7c0-023b-a7b81d197fc3@redhat.com>
Date: Tue, 21 Mar 2017 12:59:04 -0500
MIME-Version: 1.0
In-Reply-To: <20170316154643.GT15193@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="h5xrHS3nVWGfmePm7AISmbgIx3EAkpG57"
Subject: Re: [Qemu-devel] Proposal for deprecating unsupported host OSes &
 architecutures
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--h5xrHS3nVWGfmePm7AISmbgIx3EAkpG57
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>
Message-ID: <bb405833-37ca-f7c0-023b-a7b81d197fc3@redhat.com>
Subject: Re: [Qemu-devel] Proposal for deprecating unsupported host OSes &
 architecutures
References: <CAFEAcA9pqDoCWrPAJ+KVxLC_eRy-xRg36oYuARYg2YP8VpGpBg@mail.gmail.com>
 <20170316154643.GT15193@redhat.com>
In-Reply-To: <20170316154643.GT15193@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/16/2017 10:46 AM, Daniel P. Berrange wrote:

>=20
>> Should "native CYGWIN" be in the drop list? I only test
>> mingw cross compile, but configure has a separate section for
>> CYGWIN in its $targetos case statement.
>=20
> Cygwin is different enough from mingw that I'd basically call
> it a completely separate platform. IOW, successfull mingw
> builds don't offer a strong guarantee of a succesfull cygwin
> build.

I'm late to the thread, but I'll chime in here:
I don't think qemu has ever successfully built on native cygwin.  There
have already been cleanup patches to the list in the meantime to rip out
the (stunted) configure support for using cygwin as the host to do a
cross-compilation to mingw, which as long as it was present meant that
no one could even attempt a native cygwin build (at least not without
jumping through some big hoops).

I have a soft spot for Cygwin (after all, I still maintain several
packages for that platform), but not enough time to even attempt a qemu
build (to see what breaks), nor enough resources to contribute a Cygwin
CI machine to the build-bots, so I have no heartbreak that Cygwin is
(currently) in the list of unsupported platforms.  If someone (maybe me)
ever cares enough to get qemu building on Cygwin, we can always amend
the list of supported platforms at that date.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--h5xrHS3nVWGfmePm7AISmbgIx3EAkpG57
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY0WnoAAoJEKeha0olJ0Nqt7MH/js/1DOsNccSJ31aWgR77BTa
0OptDW1Gq8sIlZ1askbelBSzrmrlC9AlYMw83VjYJiAVB4B8Fo3dqdexvPymoooO
3DcrUZDhBmHVv/nmA9TzAzgCtOO8oKDy1pPJ5fNfYk6TJ0qlqOUjH0qQg7UkT7f3
T2RgdlDVsbNLeNX8QhZfgDyfilnDupbihLoZhunKoqhqhDyMeJe1CbIU8npy1IPK
f7m0sOWw+PZfPKLjcnGuYNHwz+DwGD8n7RhfHbAUYh+k93l3+xtVpGFHvTDLCv+t
qiy4dVjFB2Ce/LL8JruhUTHzNhqB7+BcvY4b3bQO+PEJMYDf+CG9e38L9ot1DoM=
=eRZO
-----END PGP SIGNATURE-----

--h5xrHS3nVWGfmePm7AISmbgIx3EAkpG57--
