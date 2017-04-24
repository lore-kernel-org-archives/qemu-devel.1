Received: from eggs.gnu.org ([2001:4830:134:3::10]:45128)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d2gDa-0006RK-CT
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 11:48:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d2gDZ-0005NU-Cc
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 11:48:02 -0400
References: <1492957997-28587-1-git-send-email-lidongchen@tencent.com>
	<1492957997-28587-2-git-send-email-lidongchen@tencent.com>
	<7c616dbd-f83f-1643-d211-f5be8d8b2dc4@redhat.com>
	<7bb35794-6a50-c92f-fee7-e8f9cc55a1d0@amsat.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f9ce81bc-72d5-d436-5cb6-58c9dbb10aa4@redhat.com>
Date: Mon, 24 Apr 2017 10:47:55 -0500
MIME-Version: 1.0
In-Reply-To: <7bb35794-6a50-c92f-fee7-e8f9cc55a1d0@amsat.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="AqWPufBVRxdT1g0LgOFmHGddIEALGICVo"
Subject: Re: [Qemu-devel] [PATCH 2/2] qemu-img: fix some spelling errors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, jemmy858585@gmail.com, Lidong Chen <lidongchen@tencent.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--AqWPufBVRxdT1g0LgOFmHGddIEALGICVo
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 jemmy858585@gmail.com, Lidong Chen <lidongchen@tencent.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, mreitz@redhat.com,
 qemu-block@nongnu.org
Message-ID: <f9ce81bc-72d5-d436-5cb6-58c9dbb10aa4@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/2] qemu-img: fix some spelling errors
References: <1492957997-28587-1-git-send-email-lidongchen@tencent.com>
 <1492957997-28587-2-git-send-email-lidongchen@tencent.com>
 <7c616dbd-f83f-1643-d211-f5be8d8b2dc4@redhat.com>
 <7bb35794-6a50-c92f-fee7-e8f9cc55a1d0@amsat.org>
In-Reply-To: <7bb35794-6a50-c92f-fee7-e8f9cc55a1d0@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/24/2017 10:37 AM, Philippe Mathieu-Daud=C3=A9 wrote:

>>>  /*
>>> - * Returns true iff the first sector pointed to by 'buf' contains at=

>>> least
>>> - * a non-NUL byte.
>>> + * Returns true if the first sector pointed to by 'buf' contains at
>>> least
>>> + * a non-NULL byte.
>>
>> NACK to both changes.  'iff' is an English word that is shorthand for
>> "if and only if".  "NUL" means the one-byte character, while "NULL"
>> means the 8-byte (or 4-byte, on 32-bit platform) pointer value.
>=20
> I agree with Lidong shorthands are not obvious from non-native speaker.=

>=20
> What about this?
>=20
>  * Returns true if (and only if) the first sector pointed to by 'buf'
> contains

That might be okay.

>  * at least a non-null character.

But that still doesn't make sense.  The character name is NUL, and
non-NULL refers to something that is a pointer, not a character.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--AqWPufBVRxdT1g0LgOFmHGddIEALGICVo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY/h4rAAoJEKeha0olJ0NqgkgH/3yu/GC2qMBvdztoMtGiHcSi
SCYYriy97HkW0TwS/MkB7cA4vvsJ7n6rtDwRlecq928WYmFJNX4BlW5XpSZ2qZpU
0yj4QWucLMvXdVbPxYL/RDRQeQbLSWdzpBBZgaI8GJRQB66XOEgtbAERYxUxLGGk
gCIR70Ogm/ZSzmGS5hwEaMmDgZUtaMy/aCVwN2+oqJvcMRulB/BB+EVixx8KBmSi
3bmunbAzE/OatbzekASPnIsciH0GO0veLNTCOVZxOQmlUtqNQgSdxWvucfPcfI1i
q48/fTYy9eFL87v+aO/JZl4RERXXLnm3LNBnRFyQk+SjKznfdgc9V5vCRYpKRpA=
=9PBk
-----END PGP SIGNATURE-----

--AqWPufBVRxdT1g0LgOFmHGddIEALGICVo--
