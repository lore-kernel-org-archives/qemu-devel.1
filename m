Received: from eggs.gnu.org ([2001:4830:134:3::10]:48245)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cYI4v-0003jd-11
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 14:57:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cYI4q-0007uw-UM
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 14:57:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37692)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cYI4q-0007uV-Ld
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 14:57:24 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A3A9480F7C
	for <qemu-devel@nongnu.org>; Mon, 30 Jan 2017 19:57:23 +0000 (UTC)
References: <20170130133954.31353-1-marcandre.lureau@redhat.com>
	<20170130133954.31353-20-marcandre.lureau@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d8418752-f15f-4644-ae20-52a74aba75f6@redhat.com>
Date: Mon, 30 Jan 2017 13:57:21 -0600
MIME-Version: 1.0
In-Reply-To: <20170130133954.31353-20-marcandre.lureau@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Qkm7R0egWqJLjK48lxHBVRPVOwD9LwtG6"
Subject: Re: [Qemu-devel] [PATCH v2 19/41] char: remove class kind field
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Qkm7R0egWqJLjK48lxHBVRPVOwD9LwtG6
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
Message-ID: <d8418752-f15f-4644-ae20-52a74aba75f6@redhat.com>
Subject: Re: [PATCH v2 19/41] char: remove class kind field
References: <20170130133954.31353-1-marcandre.lureau@redhat.com>
 <20170130133954.31353-20-marcandre.lureau@redhat.com>
In-Reply-To: <20170130133954.31353-20-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/30/2017 07:39 AM, Marc-Andr=C3=A9 Lureau wrote:
> The class kind is necessary to lookup the chardev name in
> qmp_chardev_add() after calling qemu_chr_new_from_opts() and to set
> the appropriate ChardevBackend (mainly to free the right
> fields).
>=20
> qemu_chr_new_from_opts() can be changed to use a non-qmp function
> using the chardev class typename. Introduce qemu_chardev_add() to be
> called from qemu_chr_new_from_opts() and remove the class chardev kind
> field. Set the backend->type in the parse callback (when non-common
> fields are added).
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  include/sysemu/char.h |  1 -
>  backends/baum.c       |  1 -
>  backends/msmouse.c    |  1 -
>  backends/testdev.c    |  1 -
>  qemu-char.c           | 99 +++++++++++++++++++++++++------------------=
--------
>  spice-qemu-char.c     |  4 +--
>  ui/console.c          |  2 +-
>  ui/gtk.c              |  1 -
>  8 files changed, 51 insertions(+), 59 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--Qkm7R0egWqJLjK48lxHBVRPVOwD9LwtG6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYj5qhAAoJEKeha0olJ0Nq2IMH/RuZdfqjgAtZi4ju9cHpXk/A
Gkco7vx6Pcruugi+7wOBNs0xXfjIN62ddPXvH/U/w6e/sH7O9qOVrmIOf9Rg0HdJ
ixT0mmlGzNRlqNCzLFivsS50fAIxJpnO3yQjm2TGs1rCFmmgPmQjuWTozNkmi4Au
cFuiCy05nMzz3gM8go93rqEnlKKFX4eb0lNLIEf3Awt+iq/yOBrp/55P+Rfm7JeB
gSSMaqdDFJS5Lr6m2e9P9LNi1TlXgQAAcH+MfGPAIl95vo9aPjOnkWvyItxPyqEp
VQPP2r15Y50aF8+EhrnI2EF2od7Rsr7h2TieQaQ3OnIm8raF1eSKwHuIRgZ7awQ=
=qOod
-----END PGP SIGNATURE-----

--Qkm7R0egWqJLjK48lxHBVRPVOwD9LwtG6--
