Received: from eggs.gnu.org ([2001:4830:134:3::10]:42225)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sbruno@freebsd.org>) id 1cLc0o-0003YI-Uh
	for qemu-devel@nongnu.org; Mon, 26 Dec 2016 15:36:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sbruno@freebsd.org>) id 1cLc0l-0003oZ-JG
	for qemu-devel@nongnu.org; Mon, 26 Dec 2016 15:36:50 -0500
Received: from ignoranthack.me ([199.102.79.106]:62523
	helo=mail.ignoranthack.me)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sbruno@freebsd.org>) id 1cLc0l-0003oH-9u
	for qemu-devel@nongnu.org; Mon, 26 Dec 2016 15:36:47 -0500
References: <0505bf58-21d7-7f77-a0f8-25c5a9586c7f@freebsd.org>
	<CAFEAcA-PuTRPUOfpV6Y6aLpBMiFSWmJmKjgytL=Z1MDh3MXHJg@mail.gmail.com>
From: Sean Bruno <sbruno@freebsd.org>
Message-ID: <d122be77-afbe-eea9-2807-a3833dd7ca22@freebsd.org>
Date: Mon, 26 Dec 2016 13:36:42 -0700
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-PuTRPUOfpV6Y6aLpBMiFSWmJmKjgytL=Z1MDh3MXHJg@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="XwaawLOHmTSDg06nSFdmhTfV3cuCw8ujQ"
Subject: Re: [Qemu-devel] Extra linked objects in qemu-system-aarch64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XwaawLOHmTSDg06nSFdmhTfV3cuCw8ujQ
From: Sean Bruno <sbruno@freebsd.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>
Message-ID: <d122be77-afbe-eea9-2807-a3833dd7ca22@freebsd.org>
Subject: Re: [Qemu-devel] Extra linked objects in qemu-system-aarch64
References: <0505bf58-21d7-7f77-a0f8-25c5a9586c7f@freebsd.org>
 <CAFEAcA-PuTRPUOfpV6Y6aLpBMiFSWmJmKjgytL=Z1MDh3MXHJg@mail.gmail.com>
In-Reply-To: <CAFEAcA-PuTRPUOfpV6Y6aLpBMiFSWmJmKjgytL=Z1MDh3MXHJg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 12/26/16 12:55, Peter Maydell wrote:
> On 26 December 2016 at 15:01, Sean Bruno <sbruno@freebsd.org> wrote:
>> FreeBSD detects undeclared dependencies when building "ports" and I've=

>> been ignoring a bunch of warnings from qemu-system-aarch64 that I'm a
>> bit puzzled by.  It appears that we're linking qemu-system-aarch64
>> differently than the other system emulator targets:
>>
>> https://gist.github.com/seanbruno/dd992cc1e425d708e53dc0fd0f958b92
>>
>> I would have expected that all the system targets have the same non-qe=
mu
>> objects linked against it.  Is this something specific to the aarc64
>> emulator that needs to be there?
>=20
> You don't give the other system targets for comparison so it's
> hard to tell. I would expect for instance that the system
> emulators would pull in various things like X11 for the GUI.
> The link lines ought not to be any different, though -- often
> aarch64 appears in warnings just because it happens to be
> lexicographically the first target architecture. Is the
> ports setup just suppressing later identical warnings about
> the same libraries on other binaries?
>=20
> In any case, it looks like a packaging problem to me.
> https://bugs.freebsd.org/bugzilla/show_bug.cgi?id=3D209813
> might or might not be relevant to whether this should be
> fixed in the QEMU packaging or in the handling of the
> things like Gnome we might be linking against (just a
> random related-looking google hit).
>=20
> thanks
> -- PMM
>=20

Agreed.  I'll follow up with freebsd portmgr folks.

sean


--XwaawLOHmTSDg06nSFdmhTfV3cuCw8ujQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQF8BAEBCgBmBQJYYX9aXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRCQUFENDYzMkU3MTIxREU4RDIwOTk3REQx
MjAxRUZDQTFFNzI3RTY0AAoJEBIB78oecn5kq4EH/2rK5vNx/rItaYezbgcRIMkl
jgpFKWgaDKVOXFwsL07OdsJdY/TmFyljRrHq3JcxzqMQyX6X9R87vZxuno3arR7b
j10MHaRvxOa9l3+1vPCmmjJA4XOnskqp7ft3KpGEZD2vB8O72hfObMmxwbV64cM3
E6y8KNkX1jZ9yKGnygp5P1yYcWmWqEezQTGPF3JmRAqug7OmSMM9pbu7uoL9jHqI
/hafsOVxxkQu70dIcgsmDokYZRmkSQdpF1mIBA4p16KkRqdSxORPZCk7HUDcaH3D
diemtFzJ15+c/bcfE/D1haKAyr9yOA1X9SAo/vBp4XS2EOnZJQ64J0aeLyIzejg=
=GGc3
-----END PGP SIGNATURE-----

--XwaawLOHmTSDg06nSFdmhTfV3cuCw8ujQ--
