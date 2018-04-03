Received: from eggs.gnu.org ([2001:4830:134:3::10]:56738)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f3Qwd-00059M-2g
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 14:46:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f3QwZ-0000LZ-W0
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 14:46:11 -0400
References: <20180327202152.1799131-1-eblake@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <46f09a31-addb-32e0-d9b6-827166690a72@redhat.com>
Date: Tue, 3 Apr 2018 13:46:04 -0500
MIME-Version: 1.0
In-Reply-To: <20180327202152.1799131-1-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="qZ2UBiHB56auBNwWtwQIq8IqTIyyt6ICy"
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
Cc: qemu-trivial@nongnu.org, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--qZ2UBiHB56auBNwWtwQIq8IqTIyyt6ICy
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?=
 <marcandre.lureau@redhat.com>
Message-ID: <46f09a31-addb-32e0-d9b6-827166690a72@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.12] dump: Fix build with newer gcc
References: <20180327202152.1799131-1-eblake@redhat.com>
In-Reply-To: <20180327202152.1799131-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/27/2018 03:21 PM, Eric Blake wrote:
> gcc 8 on rawhide is picky enough to complain:
>=20
> /home/dummy/qemu/dump.c: In function 'create_header32':
> /home/dummy/qemu/dump.c:817:5: error: 'strncpy' output truncated before=
 terminating nul copying 8 bytes from a string of the same length [-Werro=
r=3Dstringop-truncation]
>      strncpy(dh->signature, KDUMP_SIGNATURE, strlen(KDUMP_SIGNATURE));
>      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>=20
> But we already have SIG_LEN defined as the right length without needing=

> to do a strlen(), and memcpy() is better than strncpy() when we know
> we do not want a trailing NUL byte.
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  dump.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

I'll include this in my qapi+misc pull request for 2.12-rc2

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--qZ2UBiHB56auBNwWtwQIq8IqTIyyt6ICy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlrDy+wACgkQp6FrSiUn
Q2o3vgf/SVub2+3iCn2l7G4GRrJZctRogD0J/fC9gk3NvANKSiNKBvZzh8QB9B9M
lpxHsNRfDEhxsV8zZXusBzTTwEj7c6Lna1wu5K2JoneQNXLVM2WeI/1s957XqXao
Ag9+i0++px9GMgdB43uWDDDnrGa3WsnyVtGbPZJVyfYwnxxb88I8Vm+ovmU4vpGo
rqbewErui82CH3HpjNUsN9qBZO9+g+tI2bTjnGVDdtJioQSzsBZyHsh+5GkTr2bR
RkjADJ4NtgyxpiGy5d+QyIPjNdCne2CXl+xguV17/MBGTTlxrca6wRU2P+D1SQxz
eAsWOp2LS4NYf02opQ8Xjrv/qITOqQ==
=eT0y
-----END PGP SIGNATURE-----

--qZ2UBiHB56auBNwWtwQIq8IqTIyyt6ICy--
