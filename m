Received: from eggs.gnu.org ([2001:4830:134:3::10]:54967)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d8XUJ-0001Ab-0K
	for qemu-devel@nongnu.org; Wed, 10 May 2017 15:41:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d8XUE-0007DY-S8
	for qemu-devel@nongnu.org; Wed, 10 May 2017 15:41:31 -0400
References: <20170506004106.3291-1-f4bug@amsat.org>
	<7f51d88d-0dea-5d64-7c6d-530365e29923@redhat.com>
	<f7193a8d-0086-d61c-b214-76c7f204d062@amsat.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <118e342f-4c48-5652-10e6-1d15e6a5537d@redhat.com>
Date: Wed, 10 May 2017 14:41:23 -0500
MIME-Version: 1.0
In-Reply-To: <f7193a8d-0086-d61c-b214-76c7f204d062@amsat.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="BDAf9VrTJOrwJlbLNF2fC47UJWIaq6n0n"
Subject: Re: [Qemu-devel] [PATCH] syscall: fix compiler warnings (clang 5)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Laurent Vivier <lvivier@redhat.com>, Riku Voipio <riku.voipio@iki.fi>
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--BDAf9VrTJOrwJlbLNF2fC47UJWIaq6n0n
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Laurent Vivier <lvivier@redhat.com>, Riku Voipio <riku.voipio@iki.fi>
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org
Message-ID: <118e342f-4c48-5652-10e6-1d15e6a5537d@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] syscall: fix compiler warnings (clang 5)
References: <20170506004106.3291-1-f4bug@amsat.org>
 <7f51d88d-0dea-5d64-7c6d-530365e29923@redhat.com>
 <f7193a8d-0086-d61c-b214-76c7f204d062@amsat.org>
In-Reply-To: <f7193a8d-0086-d61c-b214-76c7f204d062@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


>>
>> The "for" loop scans the structure to find the rt_dev field, and we
>> should always enter in the first "if", so "host_rt_dev_ptr" is always
>> set.
>=20
> It's better indeed, I'll use g_assert_nonnull() and resend.

Careful - we haven't yet resolved whether g_assert_nonnull() is safe to u=
se.
https://lists.gnu.org/archive/html/qemu-devel/2017-04/msg05499.html

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--BDAf9VrTJOrwJlbLNF2fC47UJWIaq6n0n
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZE2zjAAoJEKeha0olJ0Nq8gAIAI+r+KaKMnRS4JeJglqjL/EQ
P/KetYrD9jGWB2Kq1hCM8xZ/ncQU5hx+g9xW88e0RA2sdZGrUkUpWm8nWGOvkaBM
9XOqRajTCOIwdHx4orQhgdUaRaBG3j7KyFAD3tz0ZXwDhM2c3vozzFgxmfKE8Wzs
71kyOwhxfjSxgDsYY2ieTRdM4fgQbq9PsTEarkC7TPa/lw7qbaovK2S9X3y3g0dx
i67cynyACM2VSrj+dBJErxo8MRigetzxK/cagE51ByS5IP8ILPtJQxRRXn7oUTc9
VtE1svq6y6XNzcTrTvPl2tf/3KiDwl3/w1QhrxVgyM0IB9foijbk2H3x15dWHQg=
=/JWl
-----END PGP SIGNATURE-----

--BDAf9VrTJOrwJlbLNF2fC47UJWIaq6n0n--
