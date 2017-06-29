Received: from eggs.gnu.org ([2001:4830:134:3::10]:39875)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dQbLl-0003aJ-HV
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 11:27:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dQbLi-0001TW-Dn
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 11:27:21 -0400
References: <20170629132749.997-1-pbonzini@redhat.com>
	<20170629132749.997-9-pbonzini@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <7077653a-8048-d7e8-f678-1eb8dfaa6c2a@redhat.com>
Date: Thu, 29 Jun 2017 10:26:54 -0500
MIME-Version: 1.0
In-Reply-To: <20170629132749.997-9-pbonzini@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="jjDGGp0pb0GDsheLtqUeRQxjqifxjCEbN"
Subject: Re: [Qemu-devel] [PATCH 08/11] qed: introduce bdrv_qed_init_state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org, stefanha@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--jjDGGp0pb0GDsheLtqUeRQxjqifxjCEbN
From: Eric Blake <eblake@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org, stefanha@redhat.com
Message-ID: <7077653a-8048-d7e8-f678-1eb8dfaa6c2a@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 08/11] qed: introduce bdrv_qed_init_state
References: <20170629132749.997-1-pbonzini@redhat.com>
 <20170629132749.997-9-pbonzini@redhat.com>
In-Reply-To: <20170629132749.997-9-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/29/2017 08:27 AM, Paolo Bonzini wrote:
> This will be used in the next patch, which will call bdrv_qed_do_open
> with a CoMutex taken.  bdrv_qed_init_state provides a nice place to
> initialize it.
>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>         RFC->v2: new
>=20
>  block/qed.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--jjDGGp0pb0GDsheLtqUeRQxjqifxjCEbN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZVRw+AAoJEKeha0olJ0NqGEcH/iIHn08ij2MghbwqqKN6b3X4
8HHpGBDDy/z/QmF2l22TJdFjax5DUrDtP0W6Lmfmu6ll9vqyGka6+kSTGKRLUvnG
KMK+Pki9dv+c+oKF9MXCErVNnaXeyTLXIeb6uaW+a/Di2fEd9+qFbSmTnSG11xGS
L/5d7soa+Qj2yDxQ1VJ/3v2qiJKd9kI4eEv2BST7qQYmJGNrBsVikYvZo7iSxZ5r
gDnn2QcZX5ah3D/XadXQKP4+cLGTOHmysFLO96v1gPXmzsRfj56ty5oyPzPNaHmz
fSFBY3ns21fMj9GmD9hHo7YHQQDP0CLX5ce6R4o8DhZEvshJJKT6mWZfDmtjgik=
=9Liy
-----END PGP SIGNATURE-----

--jjDGGp0pb0GDsheLtqUeRQxjqifxjCEbN--
