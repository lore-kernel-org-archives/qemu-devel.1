Received: from eggs.gnu.org ([2001:4830:134:3::10]:39701)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ecdK0-0000ZO-4d
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 15:31:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ecdJx-0008KH-0n
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 15:31:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51466)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ecdJw-0008J8-OL
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 15:31:28 -0500
References: <20180119162554.27270-1-marcandre.lureau@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e103bfb4-af00-5a5c-cbba-4f808ccdf4af@redhat.com>
Date: Fri, 19 Jan 2018 14:31:23 -0600
MIME-Version: 1.0
In-Reply-To: <20180119162554.27270-1-marcandre.lureau@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Cl3vpFV2WrauaDVZ3RB7NwuI85D45aJBX"
Subject: Re: [Qemu-devel] [PATCH v2] dump-guest-memory.py: fix python 2
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, lersek@redhat.com, Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Cl3vpFV2WrauaDVZ3RB7NwuI85D45aJBX
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, lersek@redhat.com,
 Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>
Message-ID: <e103bfb4-af00-5a5c-cbba-4f808ccdf4af@redhat.com>
Subject: Re: [PATCH v2] dump-guest-memory.py: fix python 2 support
References: <20180119162554.27270-1-marcandre.lureau@redhat.com>
In-Reply-To: <20180119162554.27270-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/19/2018 10:25 AM, Marc-Andr=C3=A9 Lureau wrote:
> Python GDB support may use Python 2 or 3.
>=20
> Inferior.read_memory() may return a 'buffer' with Python 2 or a
> 'memoryview' with Python 3 (see also
> https://sourceware.org/gdb/onlinedocs/gdb/Inferiors-In-Python.html)
>=20
> The elf.add_vmcoreinfo_note() method expects a "bytes" object. Wrap
> the returned memory with bytes(), which works with both 'memoryview'
> and 'buffer'.
>=20
> Fixes a regression introduced with commit
> d23bfa91b7789534d16ede6cb7d925bfac3f3c4c ("add vmcoreinfo").
>=20
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  scripts/dump-guest-memory.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--Cl3vpFV2WrauaDVZ3RB7NwuI85D45aJBX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpiVZsACgkQp6FrSiUn
Q2q8/Qf7BqZpKj4tLyRH7p8YQLD2initpzkKufxZD83+4bDq5lKXKvaNHIGYm6O7
Twctpy+CUP/buLXVhScIxs2M9pBM62969G0LCWkItjEueB/jXWb1BbJe6scmmSgm
+FUzr9xU+1SR5QaffYPPrqH+IRIFXuy/CQqxhXCRFGjekNqR4A2H7bguOt7Z6xA+
ayM5NP5lpmHkVnmp4aAUhTAJl6qVAQ5c4my6L6Cbtsl0P73wsHI4cOeBGhE9VA/Z
XYpGUUcPAPWsBg1dmbdJhhYf675qk/wnZG2OMnXecqH4YKIbiAFNj+3bmVROgnmz
aw+ujEMWeQAGIAeePb6U17raaMFlPQ==
=kcpv
-----END PGP SIGNATURE-----

--Cl3vpFV2WrauaDVZ3RB7NwuI85D45aJBX--
