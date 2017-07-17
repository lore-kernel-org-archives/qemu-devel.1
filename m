Received: from eggs.gnu.org ([2001:4830:134:3::10]:50967)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dXATh-0000cO-QZ
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 14:10:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dXATg-0002AY-HF
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 14:10:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51404)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dXATf-00029V-Qq
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 14:10:40 -0400
References: <20170407143847.GM2138@work-vm>
	<1573e08f-9805-eaf4-3fe1-c1172b6ef6e4@amsat.org>
	<1c55bc6d-7ef7-dcf5-81e8-22712f575691@amsat.org>
	<6e4fb953-17b4-a11b-4f98-8ddfd5ff12f8@redhat.com>
	<39dc6b92-dd56-fe33-cd85-92c03d69f133@redhat.com>
	<20170717164641.GA31820@work-vm>
	<a18cd09c-5dbd-525e-c4a6-8286e3ce2333@redhat.com>
	<CAFEAcA9Dc1_1t-N-gYiUsW+FY9-2ZNsKqBFY-WMF9Z-SeXsjiw@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <661f1ccf-6bba-7fd2-c0aa-e8b90066dad4@redhat.com>
Date: Mon, 17 Jul 2017 13:10:35 -0500
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9Dc1_1t-N-gYiUsW+FY9-2ZNsKqBFY-WMF9Z-SeXsjiw@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="DLeCRoimjpDmBQGJi8jMLNjuLHmG4m61a"
Subject: Re: [Qemu-devel] Hacks for building on gcc 7 / Fedora 26
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, QEMU Developers <qemu-devel@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--DLeCRoimjpDmBQGJi8jMLNjuLHmG4m61a
From: Eric Blake <eblake@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <f4bug@amsat.org>, QEMU Developers <qemu-devel@nongnu.org>
Message-ID: <661f1ccf-6bba-7fd2-c0aa-e8b90066dad4@redhat.com>
Subject: Re: [Qemu-devel] Hacks for building on gcc 7 / Fedora 26
References: <20170407143847.GM2138@work-vm>
 <1573e08f-9805-eaf4-3fe1-c1172b6ef6e4@amsat.org>
 <1c55bc6d-7ef7-dcf5-81e8-22712f575691@amsat.org>
 <6e4fb953-17b4-a11b-4f98-8ddfd5ff12f8@redhat.com>
 <39dc6b92-dd56-fe33-cd85-92c03d69f133@redhat.com>
 <20170717164641.GA31820@work-vm>
 <a18cd09c-5dbd-525e-c4a6-8286e3ce2333@redhat.com>
 <CAFEAcA9Dc1_1t-N-gYiUsW+FY9-2ZNsKqBFY-WMF9Z-SeXsjiw@mail.gmail.com>
In-Reply-To: <CAFEAcA9Dc1_1t-N-gYiUsW+FY9-2ZNsKqBFY-WMF9Z-SeXsjiw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/17/2017 12:36 PM, Peter Maydell wrote:
> On 17 July 2017 at 18:29, Eric Blake <eblake@redhat.com> wrote:
>> On 07/17/2017 11:46 AM, Dr. David Alan Gilbert wrote:
>>
>>>> +++ w/hw/usb/bus.c
>>>> @@ -407,8 +407,9 @@ void usb_register_companion(const char *masterbu=
s,
>>>> USBPort *ports[],
>>>>  void usb_port_location(USBPort *downstream, USBPort *upstream, int =
portnr)
>>>>  {
>>>>      if (upstream) {
>>>> -        snprintf(downstream->path, sizeof(downstream->path), "%s.%d=
",
>>>> -                 upstream->path, portnr);
>>>> +        int l =3D snprintf(downstream->path, sizeof(downstream->pat=
h),
>>>> "%s.%d",
>>>> +                         upstream->path, portnr);
>>>> +        assert(l < sizeof(downstream->path));
>>>
>>> You may find this doesn't help in some windows builds;  the assert
>>> functions aren't always marked as noreturn (because they pop up a dia=
log
>>> that asks you whether you want to run into a debugger etc).
>>
>> How would it not help?  Are we using gcc 7 on windows builds?
>=20
> At some point in the future we are likely to, because my
> w32/w64 test setups use the Ubuntu gcc-mingw-w64-x86-64
> packages, and so as I upgrade my desktop they will move
> forward to newer gcc versions. (More generally our users
> may do so before me ;-))

So, does gcc's warning actually depend on the no-return-ness of the
assert() statement added here?

Would there be anything wrong with making osdep.h do this on mingw:

#include <assert.h>
#undef assert
#define assert(expr) g_assert(expr)

so that we can reliably get no-return handling that we desire, without
having to audit lots of other code?

>=20
> We should be consistent -- if we can't trust assert() to
> be marked nonreturn, as it seems we can't, then we shouldn't
> write new code that assumes it always is, even if today
> it doesn't happen to bite us on the compiler/host combinations
> we're testing right now.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--DLeCRoimjpDmBQGJi8jMLNjuLHmG4m61a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlls/ZsACgkQp6FrSiUn
Q2oMwwf/VwTaJdQ9WQVosSJ9cY14c5OMUZ9Bp4GET9bA8PEvrFgFC5YNUk1ohJoK
1pmhgbTgveCvDO3PdWLbKtvmMe2wqZuumuThr0FJOdhxPDzbrTg+wTNLsbePNydD
izIVqMnsjTAY9SsbYoyCamWUygjExb5zrDvxyZH/PbTarAOwL6k1WQCqkg1VZIud
iz19epaNgOlIM7UutELsnoXGqQ0AtPivf2JjQRDczeAbeHrVJuE7bQQvJ4ToHYP1
d9X8rLhJceJepd8JK/pbCfG8Y9kfhZs7WInUQAAwhAOWhFP+JwtxqZ6Y2vKULLwl
XU0UWIJCJFbim8K9VSFKkttDy82CaQ==
=AAtM
-----END PGP SIGNATURE-----

--DLeCRoimjpDmBQGJi8jMLNjuLHmG4m61a--
