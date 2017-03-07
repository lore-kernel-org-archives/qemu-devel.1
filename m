Received: from eggs.gnu.org ([2001:4830:134:3::10]:43120)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1clFqc-0000gp-Jj
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 09:12:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1clFqZ-0006fa-Du
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 09:12:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45450)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1clFqZ-0006fM-7J
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 09:12:15 -0500
References: <20170307072147.1425-1-ppandit@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e2c19543-7dad-354e-a2d6-829ce2d11cc3@redhat.com>
Date: Tue, 7 Mar 2017 08:12:10 -0600
MIME-Version: 1.0
In-Reply-To: <20170307072147.1425-1-ppandit@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="1MxI5sjUax2qGWnMuB2xeJFfdPKiSdePj"
Subject: Re: [Qemu-devel] [PATCH v3] linux-user: allocate heap memory for
 execve arguments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: P J P <ppandit@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>
Cc: Riku Voipio <riku.voipio@iki.fi>, Jann Horn <jannh@google.com>, Peter Maydell <peter.maydell@linaro.org>, Prasad J Pandit <pjp@fedoraproject.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1MxI5sjUax2qGWnMuB2xeJFfdPKiSdePj
From: Eric Blake <eblake@redhat.com>
To: P J P <ppandit@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>
Cc: Riku Voipio <riku.voipio@iki.fi>, Jann Horn <jannh@google.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Prasad J Pandit <pjp@fedoraproject.org>
Message-ID: <e2c19543-7dad-354e-a2d6-829ce2d11cc3@redhat.com>
Subject: Re: [PATCH v3] linux-user: allocate heap memory for execve arguments
References: <20170307072147.1425-1-ppandit@redhat.com>
In-Reply-To: <20170307072147.1425-1-ppandit@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/07/2017 01:21 AM, P J P wrote:
> From: Prasad J Pandit <pjp@fedoraproject.org>
>=20
> Arguments passed to execve(2) call from user program could
> be large, allocating stack memory for them via alloca(3) call
> would lead to bad behaviour. Use 'g_new0' to allocate memory
> for such arguments.
>=20
> Reported-by: Jann Horn <jannh@google.com>
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
> ---
>  linux-user/syscall.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--1MxI5sjUax2qGWnMuB2xeJFfdPKiSdePj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYvr+6AAoJEKeha0olJ0NqANkH/imlUA3UbGqLwz75+UvNUw4C
SsVKOctTAZ0P8ymJEFKdo9qDXHBHKTnqfAZEE4GGbibUWy4ieaU7e9XbYbg2gIPr
w7h8Ye69EKkcpUPG8eLowHRqkCLT92h3p08Yz8w/be30WqmNgGYsDq3LtrunOIk7
9mJaPxWLVgmO6xMdxmgbyS3n3pz24y78YbtHsuNeyk1RbhcFhWzTlLOG96Al4FDb
tu6KyxTqObOL/yf8RAeQNrQDNWYD2y7hbrPwaFAUIph+D8Plms5mg+TQ8hGvrHeq
NrWj7i/CLRaHCbkMQZvdanG2+JJx6IiDCYIrsBbu5BVKMEDkP8oHBY4kaOuL72Y=
=3uZz
-----END PGP SIGNATURE-----

--1MxI5sjUax2qGWnMuB2xeJFfdPKiSdePj--
