Received: from eggs.gnu.org ([2001:4830:134:3::10]:42070)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dZlH0-0008Ue-R1
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 17:52:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dZlGz-00011N-QH
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 17:52:18 -0400
References: <20170724182751.18261-1-f4bug@amsat.org>
	<20170724182751.18261-22-f4bug@amsat.org>
	<CAFEAcA_PRH_BuUOTtC=cvRFT7Gtiwt50T6C3avm+Sy13aDS4tg@mail.gmail.com>
	<ae090923-3523-3e56-fbc1-65b270680939@amsat.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e0d37c83-537a-5288-b033-e5be3b8858ca@redhat.com>
Date: Mon, 24 Jul 2017 16:52:09 -0500
MIME-Version: 1.0
In-Reply-To: <ae090923-3523-3e56-fbc1-65b270680939@amsat.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="l9RFM3AgJNSNcte6CEQxSIlxWFvq3fLSQ"
Subject: Re: [Qemu-devel] [PATCH for 2.10 21/35] arm/sysbus-fdt: fix null
 pointer dereference
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--l9RFM3AgJNSNcte6CEQxSIlxWFvq3fLSQ
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>
Message-ID: <e0d37c83-537a-5288-b033-e5be3b8858ca@redhat.com>
Subject: Re: [PATCH for 2.10 21/35] arm/sysbus-fdt: fix null pointer
 dereference
References: <20170724182751.18261-1-f4bug@amsat.org>
 <20170724182751.18261-22-f4bug@amsat.org>
 <CAFEAcA_PRH_BuUOTtC=cvRFT7Gtiwt50T6C3avm+Sy13aDS4tg@mail.gmail.com>
 <ae090923-3523-3e56-fbc1-65b270680939@amsat.org>
In-Reply-To: <ae090923-3523-3e56-fbc1-65b270680939@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/24/2017 04:48 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> On 07/24/2017 06:09 PM, Peter Maydell wrote:
>> On 24 July 2017 at 19:27, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org=
> wrote:
>>> Use error_report() + exit() instead of error_setg(&error_fatal).
>>>
>>> hw/arm/sysbus-fdt.c:322:9: warning: Array access (from variable
>>> 'node_path') results in a null pointer dereference
>>>      if (node_path[1]) {
>>>          ^~~~~~~~~~~~
>>
>> I don't understand what this warning is trying to say.
>> We can't get to this point with a NULL node_path,
>> because of the previous conditional, which is using
>> error_setg(&error_fatal).
>=20
> Ok I see, Clang is unaware than error_setg(&error_fatal) is a noreturn.=


Indeed, and that's because error_setg(&error_fatal) is not in preferred
form.

>=20
> Patch dropped.

That's a shame.  Rather, we should patch this file (and others) to avoid
all the inconsistent uses of error_setg(&error_*), to comply with the
error.h documentation.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--l9RFM3AgJNSNcte6CEQxSIlxWFvq3fLSQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAll2bAkACgkQp6FrSiUn
Q2rVvgf/aejekJz3XvoPgk6p5kJ6tkS6bhEhtudG7/yMKOByAjF5aQpw/kO5/iQe
r13Ij7wBdFcnuvaU7RT2PWdTbli4eyhH2McJAx6QB7Kc0ENRollGiswPaYVJmuzk
P+IttKEkIAwNE8HfKBVKnaMiGzUnQWVhgsTw1pgABw/XuePpEy6zjkXNqVVX+YBI
mbKAy+0W3m/XFmDPGFj2UG33UQqHbwkHVTEtBxNj/ikcRmxqmaLTgrO6GJ2fJRpL
iF3twolzITZ4Cxcwyi7Pe7Lr87zP9JVQrb/bZUKfvqylboOqqpaAlNqRwDvkSHne
A/5vavexjDBxky2TrLSJL4Uz0UaQjA==
=8cWt
-----END PGP SIGNATURE-----

--l9RFM3AgJNSNcte6CEQxSIlxWFvq3fLSQ--
