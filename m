Received: from eggs.gnu.org ([2001:4830:134:3::10]:45928)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1edzxN-0003UH-KF
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 09:53:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1edzxM-00083u-Ow
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 09:53:49 -0500
References: <1516366207-109842-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1516366207-109842-9-git-send-email-anton.nefedov@virtuozzo.com>
	<b0066a7f-0197-73c9-4012-67b5e48e178a@redhat.com>
	<0ef02c21-bfd0-eb67-78bb-4728a8384cdb@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f509bbd3-b6a4-93ab-d432-0cfe104be721@redhat.com>
Date: Tue, 23 Jan 2018 08:53:34 -0600
MIME-Version: 1.0
In-Reply-To: <0ef02c21-bfd0-eb67-78bb-4728a8384cdb@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="FOvRpM1W6OGDH90KzBXVW03wTtXoFfgjj"
Subject: Re: [Qemu-devel] [PATCH v2 8/8] qapi: query-blockstat: add driver
 specific file-posix stats
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, armbru@redhat.com, jsnow@redhat.com, pbonzini@redhat.com, den@virtuozzo.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--FOvRpM1W6OGDH90KzBXVW03wTtXoFfgjj
From: Eric Blake <eblake@redhat.com>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com,
 armbru@redhat.com, jsnow@redhat.com, pbonzini@redhat.com, den@virtuozzo.com
Message-ID: <f509bbd3-b6a4-93ab-d432-0cfe104be721@redhat.com>
Subject: Re: [PATCH v2 8/8] qapi: query-blockstat: add driver specific
 file-posix stats
References: <1516366207-109842-1-git-send-email-anton.nefedov@virtuozzo.com>
 <1516366207-109842-9-git-send-email-anton.nefedov@virtuozzo.com>
 <b0066a7f-0197-73c9-4012-67b5e48e178a@redhat.com>
 <0ef02c21-bfd0-eb67-78bb-4728a8384cdb@virtuozzo.com>
In-Reply-To: <0ef02c21-bfd0-eb67-78bb-4728a8384cdb@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/23/2018 05:28 AM, Anton Nefedov wrote:

>>> +
>>> +##
>>> +# @BlockDriverStats:
>>> +#
>>> +# Statistics of a block driver (driver-specific)
>>> +#
>>> +# Since: 2.12
>>> +##
>>> +{ 'union': 'BlockDriverStats',
>>> +=C2=A0 'data': {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'file': 'BlockDriverStatsFile'
>>> +=C2=A0 } }
>>
>> Markus has been adamant that we add no new "simple unions" (unions wit=
h
>> a 'discriminator' field) - because they are anything but simple in the=

>> long run.

>=20
> Right, forgot about those unions.. Will fix.
>=20
> (I guess I will need an extra enum, like BlockdevDriverWithStats with a=

> single 'file' member, otherwise it seems to require to define data for
> each BlockdevDriver type)

Kevin also recently requested an easier way to make a flat union that
uses only a subset of a larger enum.  Maybe it's worth investing some
time in a QAPI generator patch to make this part easier (I have a
potential patch floating on one of my older branches that would allow
'branch':{} rather than having to declare a dummy type, but that's
slightly different than not even supplying the branches that you aren't
implementing).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--FOvRpM1W6OGDH90KzBXVW03wTtXoFfgjj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpnTG4ACgkQp6FrSiUn
Q2riGwf/R4fQjNWkDegKGXxTMVk37b5qYdEWZUl+aIionw9pVQuQT6UYlLdfM6hB
R1f9x6EPNJFyOjfBACioFxmsvDhHlHTf00VVZHHiX8Vgy6nuugrAuDco9QnImTTW
zTMswiYA1PL+1hs9fG0faWuu2wCxU/mZZleLazcpD+O5lo4QacxHZTSReLo7a3Jc
BMO+fa4ZtJNR2zZ5wNVqPULfy1xm7G8tKRa4UYq9btXmGY2a3jxyUAu4u+C0sWfH
tVVuksueWgvycoJ5ojnL5XFJ5pbmAWcKoEUy7ShMW1NKtBJicpBi29FFlZQ5OdBU
hl5bRb0Sorzyx7mGiKG+R0Kk+Fw99Q==
=Evm9
-----END PGP SIGNATURE-----

--FOvRpM1W6OGDH90KzBXVW03wTtXoFfgjj--
