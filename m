Received: from eggs.gnu.org ([2001:4830:134:3::10]:47893)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1daJgp-0001f9-Dt
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 06:37:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1daJgl-0000sj-0f
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 06:37:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37166)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1daJgk-0000s4-NG
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 06:37:10 -0400
References: <20170725011530.17958-1-f4bug@amsat.org>
	<150102382734.26979.483898024984598924@loki>
	<cb21f5d1-18be-51a4-5e51-e429ab4b1b46@amsat.org>
	<150103762159.26979.13316299204767598566@loki>
	<150103777491.26979.16844695290515425301@loki>
	<cd92adf7-d750-a4e3-d4b6-b339cd7e7e11@amsat.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <12dec790-eeff-d0d2-a949-38af96902393@redhat.com>
Date: Wed, 26 Jul 2017 05:37:07 -0500
MIME-Version: 1.0
In-Reply-To: <cd92adf7-d750-a4e3-d4b6-b339cd7e7e11@amsat.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="rfjuvNSCJP6vgNDe5dciF7m4iQW9FEwjm"
Subject: Re: [Qemu-devel] [PATCH] configure: fix qemu-ga missing '.exe'
 extension on windows
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Michael Roth <mdroth@linux.vnet.ibm.com>, "Daniel P. Berrange" <berrange@redhat.com>, =?UTF-8?B?VG9tw6HFoSBHb2xlbWJpb3Zza8O9?= <tgolembi@redhat.com>, Sameeh Jubran <sjubran@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--rfjuvNSCJP6vgNDe5dciF7m4iQW9FEwjm
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 =?UTF-8?B?VG9tw6HFoSBHb2xlbWJpb3Zza8O9?= <tgolembi@redhat.com>,
 Sameeh Jubran <sjubran@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Laszlo Ersek
 <lersek@redhat.com>, qemu-devel@nongnu.org
Message-ID: <12dec790-eeff-d0d2-a949-38af96902393@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] configure: fix qemu-ga missing '.exe'
 extension on windows
References: <20170725011530.17958-1-f4bug@amsat.org>
 <150102382734.26979.483898024984598924@loki>
 <cb21f5d1-18be-51a4-5e51-e429ab4b1b46@amsat.org>
 <150103762159.26979.13316299204767598566@loki>
 <150103777491.26979.16844695290515425301@loki>
 <cd92adf7-d750-a4e3-d4b6-b339cd7e7e11@amsat.org>
In-Reply-To: <cd92adf7-d750-a4e3-d4b6-b339cd7e7e11@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/25/2017 10:28 PM, Philippe Mathieu-Daud=C3=A9 wrote:

>>> - rm -f $(filter-out %.tlb,$(TOOLS)) $(HELPERS-y) qemu-ga TAGS
>>> cscope.* *.pod *~ */*~
>>> + rm -f $(filter-out %.tlb,$(TOOLS)) $(HELPERS-y) qemu-ga${EXESUF}
>>> TAGS cscope.* *.pod *~ */*~
>>>
>>> It's a bit ugly since `rm -f qemu-ga.exe` would silently fail on posi=
x,

But that's the whole point of 'rm -f' - to silently ignore files that
didn't exist.

>>
>> On w32 I mean, sorry.
>=20
> side question: should we use $(RM) with something like:
>=20
> ifeq ($(OS),Windows_NT)
>     RM =3D cmd //C del //Q //F
> else
>     RM =3D rf -f
> endif
>=20

Absolutely not.  We can at least assume a mingw-like environment that
has all the usual tools like rm.

>>>
>>> Alternatively, you can explicitly check for qemu-ga.exe and remove it=
 if
>>> it exists. I would consider either acceptable, but not this patch as =
it
>>> currently stands.

But that's what 'rm -f' already does - I don't see the point in adding a
racy check for existence prior to deletion, when deletion already
handles the race.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--rfjuvNSCJP6vgNDe5dciF7m4iQW9FEwjm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAll4cNMACgkQp6FrSiUn
Q2pOwQgArZKuUgRpyWf8xlJj30OH05wlaxvDxxNUkJdDybSsUM3Pn7cReyXY+heu
5tPVJYiWSbEA2gZ7qlRHYWhdeoTm5r1AtI+AcL6F3JuUW2N/2uypvoki342sLyJo
dCz0lx9xZHGybtwG/wm6Qf8OTol7WPbocuy60Nv3anpmAMLUwQUZfDZ0f2y6OQFr
P6ACmf857DHDfJIMTcQW9caMj/lQQwVrNRI3JCI2h9J/47jnsuGB+Q4/QLv55PJi
b9hGU+1x0QyT4ojjbvBD8pLnzJxlrXnj23gTb/G2wUhJJhsEi/XHdSKU5AHBYmj7
sLeLbxK7G0ZyIIK5DHPV9LmxxQ6R8w==
=bHNX
-----END PGP SIGNATURE-----

--rfjuvNSCJP6vgNDe5dciF7m4iQW9FEwjm--
