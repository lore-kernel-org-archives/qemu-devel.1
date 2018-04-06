Received: from eggs.gnu.org ([2001:4830:134:3::10]:54043)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f4Sx9-0005T1-Nk
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 11:07:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f4Sx6-0003Qf-Ga
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 11:06:59 -0400
References: <20180327202152.1799131-1-eblake@redhat.com>
	<46f09a31-addb-32e0-d9b6-827166690a72@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <82cc73cb-ba8a-be38-496a-5dc66d2c6850@redhat.com>
Date: Fri, 6 Apr 2018 10:06:44 -0500
MIME-Version: 1.0
In-Reply-To: <46f09a31-addb-32e0-d9b6-827166690a72@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="pxI2nFiyG4AUO5p6qX0ndrHZc9PSxztLI"
Subject: Re: [Qemu-devel] [PATCH for-2.12] dump: Fix build with newer gcc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--pxI2nFiyG4AUO5p6qX0ndrHZc9PSxztLI
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?=
 <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <82cc73cb-ba8a-be38-496a-5dc66d2c6850@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.12] dump: Fix build with newer gcc
References: <20180327202152.1799131-1-eblake@redhat.com>
 <46f09a31-addb-32e0-d9b6-827166690a72@redhat.com>
In-Reply-To: <46f09a31-addb-32e0-d9b6-827166690a72@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/03/2018 01:46 PM, Eric Blake wrote:
> On 03/27/2018 03:21 PM, Eric Blake wrote:
>> gcc 8 on rawhide is picky enough to complain:
>>
>> /home/dummy/qemu/dump.c: In function 'create_header32':
>> /home/dummy/qemu/dump.c:817:5: error: 'strncpy' output truncated befor=
e terminating nul copying 8 bytes from a string of the same length [-Werr=
or=3Dstringop-truncation]
>>      strncpy(dh->signature, KDUMP_SIGNATURE, strlen(KDUMP_SIGNATURE));=

>>      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>
>> But we already have SIG_LEN defined as the right length without needin=
g
>> to do a strlen(), and memcpy() is better than strncpy() when we know
>> we do not want a trailing NUL byte.
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>> ---
>>  dump.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> I'll include this in my qapi+misc pull request for 2.12-rc2

That pull request was abandoned; Paolo, do you want to pick this up in
your misc tree?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--pxI2nFiyG4AUO5p6qX0ndrHZc9PSxztLI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlrHjQQACgkQp6FrSiUn
Q2qceAf7BkHwlDmsvJKVHOEr2c3eD8hMjNhcr9IBDNDSwtZDmqtHODQmsFHt+xtO
Ed8TJfm8kfdl2j1lF7tRXt+9bfPPltBclDOAakk0GS0RdBP/w4IrbSgHIDhafk+f
lD0lr7AkWx8vJ9V8o1GnE2wq4v2I9fOeHd+85k02h3Vu7tee09jCPadztPIUtvlB
2Xc9LSJHSxVBkNPgoIT2V3ceLg2Y19r82KPioHeU7FKxWy0fApa7bOVmiquo6IT7
QLuQavzsk5j4pdcE/hA0XReMkSia4X8kQyq/NWXBzuuQQobIwa3NIReP0/orufah
HSG29b2wi6P7Qqn7Uh06ZWKDIn65vA==
=dsCN
-----END PGP SIGNATURE-----

--pxI2nFiyG4AUO5p6qX0ndrHZc9PSxztLI--
