Received: from eggs.gnu.org ([2001:4830:134:3::10]:46711)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dbAng-00050Q-JS
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 15:19:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dbAnf-0005p3-LN
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 15:19:52 -0400
References: <20170728131151.4802-1-olaf@aepfle.de>
From: Eric Blake <eblake@redhat.com>
Message-ID: <0dd36e3f-c763-22b3-b365-a242854e6e96@redhat.com>
Date: Fri, 28 Jul 2017 14:19:42 -0500
MIME-Version: 1.0
In-Reply-To: <20170728131151.4802-1-olaf@aepfle.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="5Hum0WPOM0BdpRuQTDg3cqvBrNXahe0lq"
Subject: Re: [Qemu-devel] [PATCH v2] xen-disk: use g_new0 to fix build
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Olaf Hering <olaf@aepfle.de>, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:X86" <xen-devel@lists.xenproject.org>, "open list:Block layer core" <qemu-block@nongnu.org>, "open list:All patches CC here" <qemu-devel@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5Hum0WPOM0BdpRuQTDg3cqvBrNXahe0lq
From: Eric Blake <eblake@redhat.com>
To: Olaf Hering <olaf@aepfle.de>, Stefano Stabellini
 <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>,
 Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>,
 "open list:X86" <xen-devel@lists.xenproject.org>,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Message-ID: <0dd36e3f-c763-22b3-b365-a242854e6e96@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] xen-disk: use g_new0 to fix build
References: <20170728131151.4802-1-olaf@aepfle.de>
In-Reply-To: <20170728131151.4802-1-olaf@aepfle.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/28/2017 08:11 AM, Olaf Hering wrote:
> g_malloc0_n is available since glib-2.24. To allow build with older gli=
b

s/is/is only/

> versions use the generic g_new0, which is already used in many other
> places in the code.
>=20
> Fixes commit 3284fad728 ("xen-disk: add support for multi-page shared r=
ings")
>=20
> Signed-off-by: Olaf Hering <olaf@aepfle.de>
> ---
>  hw/block/xen_disk.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--5Hum0WPOM0BdpRuQTDg3cqvBrNXahe0lq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAll7jk4ACgkQp6FrSiUn
Q2qxXwgAhq5PwVDvPA6mLwpRXWh87Spnz7dVy2kQ+UCVtuKPQCuNH+HRMrkyVz5w
wI2ls+q9ZVU4pEbODDifo4TIH4pi5Rfd3ddOUF4HvbtNrpctWgCIXG/Eh+G40s1V
jjj6Ej7ANaYZVOr4RiKKlvZAF5p8x04bLu/GWc2DL0e9WBHy5u8hGROE0Gg3yDmM
CuFF8PzdAtwHK7BerDTcad8F178L8Ctp5h3rB7a+bq+0mXIuFeZgGTOQTNjcXkBB
wztb5pLBMVAUPO7MzBtcvVaOxuKuJE8erFPU6/pt/eP3IspwpO2sCvUVSdEaxHJn
8aQFE46TE3dn6gVoHP0YJ8W9aUPECg==
=fV/b
-----END PGP SIGNATURE-----

--5Hum0WPOM0BdpRuQTDg3cqvBrNXahe0lq--
