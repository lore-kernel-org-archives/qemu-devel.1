Received: from eggs.gnu.org ([2001:4830:134:3::10]:56401)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cmnIE-0001to-Sc
	for qemu-devel@nongnu.org; Sat, 11 Mar 2017 15:07:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cmnIA-0003BQ-Ij
	for qemu-devel@nongnu.org; Sat, 11 Mar 2017 15:07:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40862)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cmnIA-0003Ao-A0
	for qemu-devel@nongnu.org; Sat, 11 Mar 2017 15:07:06 -0500
References: <20170311132256.22951-1-marcandre.lureau@redhat.com>
	<20170311132256.22951-13-marcandre.lureau@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <500da6c2-fe51-71ac-5963-15946ab0faa5@redhat.com>
Date: Sat, 11 Mar 2017 14:07:02 -0600
MIME-Version: 1.0
In-Reply-To: <20170311132256.22951-13-marcandre.lureau@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="STQ7OKjjBFGC6leEPRHdNTxLmvfI9j1Kc"
Subject: Re: [Qemu-devel] [PATCH 12/21] test-qga: drop everything until
 guest-sync
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: mdroth@linux.vnet.ibm.com, armbru@redhat.com, anderson@redhat.com, pbonzini@redhat.com, lersek@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--STQ7OKjjBFGC6leEPRHdNTxLmvfI9j1Kc
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: mdroth@linux.vnet.ibm.com, armbru@redhat.com, anderson@redhat.com,
 pbonzini@redhat.com, lersek@redhat.com
Message-ID: <500da6c2-fe51-71ac-5963-15946ab0faa5@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 12/21] test-qga: drop everything until
 guest-sync
References: <20170311132256.22951-1-marcandre.lureau@redhat.com>
 <20170311132256.22951-13-marcandre.lureau@redhat.com>
In-Reply-To: <20170311132256.22951-13-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/11/2017 07:22 AM, Marc-Andr=C3=A9 Lureau wrote:
> In the following commits, qemu-ga will emit an event on connect that
> a real client should treat or ignore and test-qga can skip.
>=20

By the way, I still have a patch pending to fix test-qga:
https://lists.gnu.org/archive/html/qemu-devel/2017-01/msg03664.html

that we may want to incorporate first

> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  tests/test-qga.c | 27 ++++++++++++++++++++-------
>  1 file changed, 20 insertions(+), 7 deletions(-)
>=20

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--STQ7OKjjBFGC6leEPRHdNTxLmvfI9j1Kc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYxFjmAAoJEKeha0olJ0NqxesH/0QzVtAIUa3Sqfyc3L6sGTa9
0rD4VL2tcnGlj+KFu/Acc83J02LICRrlduMpMizBrY8lj2iwPpQ7wh1RaO53TPEe
ovSDOEg0ATqzXaXmLZN8na2kzx3xkDLucS60Gw5vjNqB//4FylVD1fRk0S94+085
EdxS690xJhLaWCp17clZPTaatBjXqkh/yoO1GpcqjD84qWh/iBpGEaBCGnXiOi+y
6ZxPaqcBRiO/9xbH26wc2lzPclw8fN+Pvnb9B7Zc4EesI1l2AsetW4De6scslJpS
qXqVfLZiYK4OzRE3BEbemxs9VHtlNB/qjzDV7LI0RfO9bJXYoQlTRO8Br02T50w=
=yhXe
-----END PGP SIGNATURE-----

--STQ7OKjjBFGC6leEPRHdNTxLmvfI9j1Kc--
