Received: from eggs.gnu.org ([2001:4830:134:3::10]:51278)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dR3SE-0002Tr-1Y
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 17:27:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dR3SC-0000dy-Vp
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 17:27:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41984)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dR3SC-0000dF-NU
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 17:27:52 -0400
References: <20170628113106.5248-1-quintela@redhat.com>
	<20170628113106.5248-5-quintela@redhat.com>
	<1c10b8db-1d3a-863b-cf06-ccfce5d71498@amsat.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <76e39b4f-b5ba-baa4-e818-e01a0fc2fe79@redhat.com>
Date: Fri, 30 Jun 2017 16:27:46 -0500
MIME-Version: 1.0
In-Reply-To: <1c10b8db-1d3a-863b-cf06-ccfce5d71498@amsat.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="jtqKrDDuDDW6F2E0201pAbb0m10lh0FP0"
Subject: Re: [Qemu-devel] [PULL 04/14] migration: let MigrationState be a
 qdev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--jtqKrDDuDDW6F2E0201pAbb0m10lh0FP0
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org,
 Peter Xu <peterx@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>
Message-ID: <76e39b4f-b5ba-baa4-e818-e01a0fc2fe79@redhat.com>
Subject: Re: [Qemu-devel] [PULL 04/14] migration: let MigrationState be a qdev
References: <20170628113106.5248-1-quintela@redhat.com>
 <20170628113106.5248-5-quintela@redhat.com>
 <1c10b8db-1d3a-863b-cf06-ccfce5d71498@amsat.org>
In-Reply-To: <1c10b8db-1d3a-863b-cf06-ccfce5d71498@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/30/2017 04:18 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi Peter, Juan,
>=20
> On 06/28/2017 08:30 AM, Juan Quintela wrote:
>> From: Peter Xu <peterx@redhat.com>
>>
>> Let the old man "MigrationState" join the object family. Direct benefi=
t
>> is that we can start to use all the property features derived from
>> current QDev, like: HW_COMPAT_* bits, command line setup for migration=

>> parameters (so will never need to set them up each time using HMP/QMP,=

>> this is really, really attractive for test writters), etc.
>>
>> I see no reason to disallow this happen yet. So let's start from this
>> one, to see whether it would be anything good.
>>
>> Now we init the MigrationState struct statically in main() to make sur=
e
>> it's initialized after global properties are applied, since we'll use
>> them during creation of the object.
>>
>> No functional change at all.
>>

> qemu-system-arm: migration/migration.c:127: migrate_get_current:
> Assertion `current_migration' failed.
>=20
> I'v bisected to this commit using the following script:

Known issue;

https://lists.gnu.org/archive/html/qemu-devel/2017-06/msg06958.html

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--jtqKrDDuDDW6F2E0201pAbb0m10lh0FP0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZVsJSAAoJEKeha0olJ0NqqtgIAI15LmJ2ZYOFllQvXx8J0flI
ZM9ekU34VP6Eq2DliED6UkfGDDqVG49M3m9vddWdzC0T0Og3pMquAMPYdsdjbi9h
5i1mPS75t2dGSgXj7auEBJbthN8e3v2aG5XlLMcNNCDvoYBbCJZN/qyQLhMK/X/r
N8s/3tQkqHvHSj8I2iKiWxTNJ0GidWM5yXKHqqnhSfhSCHVECiiLHWZ5bIW5CEm5
T24mhrLgEVadzdGYFB7Hyv5zFlQygLm0PReynCHIDhxjse4cjhefNe20BlXJa/WR
BRZ9KqXpF4obkn/orHxlyz404JqfWVaPP5Z+iw9fVckLOcpNUWsdNwkrrabuqOA=
=3pqA
-----END PGP SIGNATURE-----

--jtqKrDDuDDW6F2E0201pAbb0m10lh0FP0--
