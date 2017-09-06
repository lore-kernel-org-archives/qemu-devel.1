Received: from eggs.gnu.org ([2001:4830:134:3::10]:51509)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dpc2G-00007g-Uk
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 11:14:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dpc2F-0006Dr-S4
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 11:14:36 -0400
References: <20170905191114.5959-1-eblake@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <415e8e6b-d627-0828-2c34-d3f28cd7d336@redhat.com>
Date: Wed, 6 Sep 2017 10:14:12 -0500
MIME-Version: 1.0
In-Reply-To: <20170905191114.5959-1-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="erfGTP5UuJWNiV5D4SOaiuScaj5j2L48k"
Subject: Re: [Qemu-devel] [PATCH 0/3] nbd: Use common read/write-all qio
 functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--erfGTP5UuJWNiV5D4SOaiuScaj5j2L48k
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, qemu-block@nongnu.org
Message-ID: <415e8e6b-d627-0828-2c34-d3f28cd7d336@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/3] nbd: Use common read/write-all qio
 functions
References: <20170905191114.5959-1-eblake@redhat.com>
In-Reply-To: <20170905191114.5959-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/05/2017 02:11 PM, Eric Blake wrote:
> Now that Daniel just added convenience qio channel looping functions,
> we might as well use it in NBD instead of open-coding our own.  In
> doing so, fix a couple of short-falls noticed in the qio code.
>=20
> If Dan is happy with this, I can take the series through the NBD queue.=

>=20
> [The diffstat is slightly misleading - it's a net reduction in lines
> of code, but the added comments hide that fact]
>=20
> Eric Blake (3):
>   io: Yield rather than wait when already in coroutine
>   io: Add new qio_channel_read{,v}_all_eof functions
>   nbd: Use new qio_channel_*_all() functions

Thanks; queued on my NBD tree (after amending the commit message of 1/3,
per Dan's review):
git://repo.or.cz/qemu/ericb.git nbd

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--erfGTP5UuJWNiV5D4SOaiuScaj5j2L48k
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmwEMQACgkQp6FrSiUn
Q2pDwAf+LmGBea/OrdtBg5Q/CojVkSpMWNybepwoZsr9hb2Nk1X8vA8H77WVAPYQ
fp0Bv2Wm2kadqknyfjEfgrbM5S0S11IkaxpTMAXur1mb8zuxbB+NKBTGL1qimHgl
obNx3cgDR3YUhZ1xXvFytYYI/0CJtIjipqxM6BOrTS7R4Z5W8plVVknRj+kM+aNQ
S0c97UAWu6It7tJ8EceWvNXLOvjSzdb+rMu8l5sARiL1KWpnbl5lKYY/GGgSN11z
UO5hOgXDKMEeDuNw4mGfn2SOLRlhFzSu3aNYbkcbXKYITpOoRUp0WCDcAhPIn4RP
N8U6S3QErm20nSK/6YpUF2+DlGy+Fw==
=JWwm
-----END PGP SIGNATURE-----

--erfGTP5UuJWNiV5D4SOaiuScaj5j2L48k--
