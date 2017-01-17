Received: from eggs.gnu.org ([2001:4830:134:3::10]:34503)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cTXCR-0007zg-6G
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 12:05:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cTXCN-0005pk-18
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 12:05:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53322)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cTXCM-0005pT-Pa
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 12:05:30 -0500
References: <1484559200-2301-1-git-send-email-armbru@redhat.com>
	<CAFEAcA_BBbHeQhWYf_qrL+TwxGT8w34SvUNG_gcNfpNnyaGCzg@mail.gmail.com>
	<87pojmjdep.fsf@dusky.pond.sub.org>
	<CAFEAcA9nhd6x+PT5bG0=YqvmUdxJVFPZ6ACiv-2OKrDFJhrqzg@mail.gmail.com>
	<87h94x99e4.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d8e5834e-c1ee-cfa1-c6dd-1cf5f0dcd027@redhat.com>
Date: Tue, 17 Jan 2017 11:05:27 -0600
MIME-Version: 1.0
In-Reply-To: <87h94x99e4.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="c4u1X0Sk0tAOAXUnx4RMMfa5uDCk1nKDV"
Subject: Re: [Qemu-devel] [PULL v2 000/180] QAPI patches for 2017-01-16
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <mlureau@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--c4u1X0Sk0tAOAXUnx4RMMfa5uDCk1nKDV
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <mlureau@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Message-ID: <d8e5834e-c1ee-cfa1-c6dd-1cf5f0dcd027@redhat.com>
Subject: Re: [Qemu-devel] [PULL v2 000/180] QAPI patches for 2017-01-16
References: <1484559200-2301-1-git-send-email-armbru@redhat.com>
 <CAFEAcA_BBbHeQhWYf_qrL+TwxGT8w34SvUNG_gcNfpNnyaGCzg@mail.gmail.com>
 <87pojmjdep.fsf@dusky.pond.sub.org>
 <CAFEAcA9nhd6x+PT5bG0=YqvmUdxJVFPZ6ACiv-2OKrDFJhrqzg@mail.gmail.com>
 <87h94x99e4.fsf@dusky.pond.sub.org>
In-Reply-To: <87h94x99e4.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/17/2017 06:08 AM, Markus Armbruster wrote:

>=20
> Three possible solutions, in increasing order of complexity:
>=20
> 1. Live with the warning from old versions.  If a new version comes
> around that does something with @subtitle, it'll just work.
>=20
> 2. Suppress the warning with @iftex-hammer.  No change in output now.
> If a new version comes around that does something with @subtitle, we
> won't profit unless we take out the @iftex.
>=20
> 3. Replace -D by @set, either by preprocessing .texi, or by including a=

> generated snippet.  No change in output now.  If a new version comes
> around that does something with @subtitle, it'll just work.

Automake projects use option 3 - they create version.texi with @set
commands, then @include that into the main file.  Should be fairly easy
to crib the makefile magic from an autotooled project if you want to go
that option.

>=20
> My order of preference is aligned with decreasing complexity, i.e. firs=
t
> 1., then 2., then 3.

I'm fine with any of the options (3 is nicest, but also the most work).
I do agree, however, that if we are going to include version information
(which I find useful), then we want it in both pdf and html outputs.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--c4u1X0Sk0tAOAXUnx4RMMfa5uDCk1nKDV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYfk7XAAoJEKeha0olJ0NqXQMH/j0obOFbPgD7Rsm1Xlwwwfq4
6rMixC8J0v+jEDsGODlnM5ABcm+Aj44VMi095DC66pQMf4HFEQjrNky9yRU2tjGl
fiy+7SAct9i42N09b46+x0soRk0HYQPVUcTKzshK3ng4seR8tfezAeWIWVn/f11d
ETEm75q/ieGOomFGlUpY8q8xv+pTqGAk/vRM9wMbn+4kz9RGXsG5VMds+wAKt6bA
wwuhH+vwasVMNb7K8wSdmf/AdXBb23+0WAxg8Z8isXg7VkFz5oAshw8vCf2vtVif
L1yt1/SSXAxqF3bQ4XErxZCn/K8eV1cTNWY3lNUVPXfA+FQpfdLN0JtH/VImuHk=
=bk0L
-----END PGP SIGNATURE-----

--c4u1X0Sk0tAOAXUnx4RMMfa5uDCk1nKDV--
