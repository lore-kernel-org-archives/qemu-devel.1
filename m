Received: from eggs.gnu.org ([2001:4830:134:3::10]:52173)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cOu0u-0003Bl-PF
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 17:26:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cOu0p-0006xA-SW
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 17:26:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46358)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cOu0p-0006wl-K3
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 17:26:27 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8CFD88FCE1
	for <qemu-devel@nongnu.org>; Wed,  4 Jan 2017 22:26:26 +0000 (UTC)
References: <20161212224325.20790-1-marcandre.lureau@redhat.com>
	<20161212224325.20790-15-marcandre.lureau@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9a75912c-5200-29e9-55a9-c4837684c40d@redhat.com>
Date: Wed, 4 Jan 2017 16:26:24 -0600
MIME-Version: 1.0
In-Reply-To: <20161212224325.20790-15-marcandre.lureau@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="8fkAe9HDnU90OuQAVEidt67sNGTuGfaSR"
Subject: Re: [Qemu-devel] [PATCH 14/54] gtk: overwrite the console.c char
 driver
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
--8fkAe9HDnU90OuQAVEidt67sNGTuGfaSR
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
Message-ID: <9a75912c-5200-29e9-55a9-c4837684c40d@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 14/54] gtk: overwrite the console.c char
 driver
References: <20161212224325.20790-1-marcandre.lureau@redhat.com>
 <20161212224325.20790-15-marcandre.lureau@redhat.com>
In-Reply-To: <20161212224325.20790-15-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/12/2016 04:42 PM, Marc-Andr=C3=A9 Lureau wrote:
> Instead of registering a vc handler to allocate the Gtk VC Chardev,
> overwrite the console.c char driver.
>=20
> A later patch, when switching to QOM, will register a default console v=
c
> QOM class if none has been registered before.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  ui/console.c          | 24 +++++++-----------------
>  ui/gtk.c              | 30 +++++++++++++++++++++---------
>  include/sysemu/char.h |  4 +---
>  3 files changed, 29 insertions(+), 29 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--8fkAe9HDnU90OuQAVEidt67sNGTuGfaSR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYbXaQAAoJEKeha0olJ0NqwIkH/i+bpfZwVoumHA79N96sOyxg
vVJphUHMjfUFaUdEgDQCGs683ysosg7m/r67/UTmFIjq/ZdOjd8cNuMulPFJb9+T
H5ppidIwm2imESPydLpqXz2pPcyMxEFpwVXMmtMk1D7whS9UqKAyaeFnPGLXGOUw
v2C85x8Ks0VhVR6fbixgmJwLR3+XbgpEq5lmGbUzjVCR9pYTMOrd2BdwxGnyhy1q
MlWQPn4Bj1psDRCVpJQklG3CdQmZxwIs5zlNKEofbMQR2Le+VMHuqNo8zQC6dsu3
+8X0eEJ0mo+G+HTe6xBRz0Qgrk0pa4rVekBLTBEa02aEBrNiicUi3Z/AcefZwz0=
=MVAD
-----END PGP SIGNATURE-----

--8fkAe9HDnU90OuQAVEidt67sNGTuGfaSR--
