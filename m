Received: from eggs.gnu.org ([2001:4830:134:3::10]:37254)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f5sWA-0004PZ-P7
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 08:36:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f5sW9-0002k9-SM
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 08:36:58 -0400
References: <20180410084210.11737-1-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d5ca9c3f-3116-5a8d-e416-78bb6bfc0a0b@redhat.com>
Date: Tue, 10 Apr 2018 07:36:34 -0500
MIME-Version: 1.0
In-Reply-To: <20180410084210.11737-1-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="LkmBBJHh4e2JHir1cFKtkloswJYF3K2aw"
Subject: Re: [Qemu-devel] [PATCH] qemu-iotests: Remove _supported_fmt dmg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--LkmBBJHh4e2JHir1cFKtkloswJYF3K2aw
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org
Message-ID: <d5ca9c3f-3116-5a8d-e416-78bb6bfc0a0b@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] qemu-iotests: Remove _supported_fmt dmg
References: <20180410084210.11737-1-kwolf@redhat.com>
In-Reply-To: <20180410084210.11737-1-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/10/2018 03:42 AM, Kevin Wolf wrote:
> qemu-iotests doesn't support dmg, and the dmg block driver doesn't
> support image creation. Two test cases declare dmg as supported, but
> that's obviously wrong for both reasons. Remove the declaration.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  tests/qemu-iotests/183 | 2 +-
>  tests/qemu-iotests/194 | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--LkmBBJHh4e2JHir1cFKtkloswJYF3K2aw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlrMr9IACgkQp6FrSiUn
Q2pEKQf+Jo0xe7Zz/jGiQpjjnwfyt/lHK1KrlHu/3ZxsrL2MxhFz9vWsx985b8bL
O1e9dDH2ASoo/veb1N8X0CadkrE/7TlNQpiesAcfQDDiT3LH45a8XExSXhECoZlA
t1o0BL5Ut7MvEc5ONPRWXieo8HpZXDvMjS2NlO5AYGLIvkgmqeyFjfJ14x6QHdro
djFaZRewFINUZp2cs2eIynkswUuWBHwb7OCnbGR37HBrlY0NKzDqHRn5EmT5yiGg
MtBvAUi2tWCCE4Jx3dgj52uWHnU3wiHFcX90ulND9WLvwEIu/1shHTIobQL/ekQy
NlRwcRzMH0a2Y45T6ithlD/MHp0JdA==
=sE8X
-----END PGP SIGNATURE-----

--LkmBBJHh4e2JHir1cFKtkloswJYF3K2aw--
