Received: from eggs.gnu.org ([2001:4830:134:3::10]:48451)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dXU8m-0007fR-9n
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 11:10:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dXU8j-0003Eb-6B
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 11:10:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34310)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dXU8i-0003DO-T9
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 11:10:21 -0400
References: <20170407143847.GM2138@work-vm>
	<1573e08f-9805-eaf4-3fe1-c1172b6ef6e4@amsat.org>
	<1c55bc6d-7ef7-dcf5-81e8-22712f575691@amsat.org>
	<6e4fb953-17b4-a11b-4f98-8ddfd5ff12f8@redhat.com>
	<39dc6b92-dd56-fe33-cd85-92c03d69f133@redhat.com>
	<20170717164641.GA31820@work-vm>
	<a18cd09c-5dbd-525e-c4a6-8286e3ce2333@redhat.com>
	<CAFEAcA9Dc1_1t-N-gYiUsW+FY9-2ZNsKqBFY-WMF9Z-SeXsjiw@mail.gmail.com>
	<f834b5c4-f16c-2099-3018-cd5a2f503ac4@amsat.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <2a198132-689f-9cf2-42da-3b481e49af3a@redhat.com>
Date: Tue, 18 Jul 2017 10:10:15 -0500
MIME-Version: 1.0
In-Reply-To: <f834b5c4-f16c-2099-3018-cd5a2f503ac4@amsat.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="QoMBW4O1XKGtPm03Gh7tU4qI6b9DFLLoq"
Subject: Re: [Qemu-devel] Hacks for building on gcc 7 / Fedora 26
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--QoMBW4O1XKGtPm03Gh7tU4qI6b9DFLLoq
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>
Message-ID: <2a198132-689f-9cf2-42da-3b481e49af3a@redhat.com>
Subject: Re: [Qemu-devel] Hacks for building on gcc 7 / Fedora 26
References: <20170407143847.GM2138@work-vm>
 <1573e08f-9805-eaf4-3fe1-c1172b6ef6e4@amsat.org>
 <1c55bc6d-7ef7-dcf5-81e8-22712f575691@amsat.org>
 <6e4fb953-17b4-a11b-4f98-8ddfd5ff12f8@redhat.com>
 <39dc6b92-dd56-fe33-cd85-92c03d69f133@redhat.com>
 <20170717164641.GA31820@work-vm>
 <a18cd09c-5dbd-525e-c4a6-8286e3ce2333@redhat.com>
 <CAFEAcA9Dc1_1t-N-gYiUsW+FY9-2ZNsKqBFY-WMF9Z-SeXsjiw@mail.gmail.com>
 <f834b5c4-f16c-2099-3018-cd5a2f503ac4@amsat.org>
In-Reply-To: <f834b5c4-f16c-2099-3018-cd5a2f503ac4@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/18/2017 10:04 AM, Philippe Mathieu-Daud=C3=A9 wrote:
>> We should be consistent -- if we can't trust assert() to
>> be marked nonreturn, as it seems we can't, then we shouldn't
>> write new code that assumes it always is, even if today
>> it doesn't happen to bite us on the compiler/host combinations
>> we're testing right now.
>=20
> And there is also the problem when you compiles with CPPFLAGS+=3D-DNDEB=
UG
> some oldschool guys still have in their ~/.cshrc ;)

We don't have problems with people defining NDEBUG in their environment;
such people would already hit at least:

hw/scsi/mptsas.c:#ifdef NDEBUG
hw/scsi/mptsas.c:#error building with NDEBUG is not supported

(maybe we should hoist that to osdep.h, though)

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--QoMBW4O1XKGtPm03Gh7tU4qI6b9DFLLoq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlluJNgACgkQp6FrSiUn
Q2qBbQf/ZGRF/ZC599OsUnhQNNeImOs/1e6hiv6EEhligCiqVsbQxskkTFBBWXPo
wA6O6GnV2XifPrsZ7s3Ru5lubi0jret9aftz7zydBcD8KbcQaAV3ScG2k1Sk/Z0x
S7hTbK7G32V0ohv9K79tyGWO8UsXMPfsQm7DczaVAuI/yOcId7CQUXobk3i6buXu
X7hGka5lQYjZR7TexGiJjw6K2acCMxbc0nEO2xqv8jq6m6c4wf4XRjMV049JdFx5
AUDWVbU/qv56wagUBs2i/vo7VBc86oookQa/tC1AUDL+6hx4c9S6Tt/G7SPC9Jco
n4M04OPHnqaHypw24eu8Tl7hDePvyA==
=cbYK
-----END PGP SIGNATURE-----

--QoMBW4O1XKGtPm03Gh7tU4qI6b9DFLLoq--
