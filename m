Received: from eggs.gnu.org ([2001:4830:134:3::10]:50388)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cYIBR-0006TU-CV
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 15:04:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cYIBN-0001hx-6C
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 15:04:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50534)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cYIBM-0001hg-UY
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 15:04:09 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B9DE5C04B946
	for <qemu-devel@nongnu.org>; Mon, 30 Jan 2017 20:04:08 +0000 (UTC)
References: <20170130133954.31353-1-marcandre.lureau@redhat.com>
	<20170130133954.31353-25-marcandre.lureau@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a68604ee-0575-7c50-6d42-ccf89ab45b94@redhat.com>
Date: Mon, 30 Jan 2017 14:04:06 -0600
MIME-Version: 1.0
In-Reply-To: <20170130133954.31353-25-marcandre.lureau@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="8LTM5kaXpWbQOnl9MEf7nBonaOmh0hUvM"
Subject: Re: [Qemu-devel] [PATCH v2 24/41] char: move mux to its own file
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
--8LTM5kaXpWbQOnl9MEf7nBonaOmh0hUvM
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
Message-ID: <a68604ee-0575-7c50-6d42-ccf89ab45b94@redhat.com>
Subject: Re: [PATCH v2 24/41] char: move mux to its own file
References: <20170130133954.31353-1-marcandre.lureau@redhat.com>
 <20170130133954.31353-25-marcandre.lureau@redhat.com>
In-Reply-To: <20170130133954.31353-25-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/30/2017 07:39 AM, Marc-Andr=C3=A9 Lureau wrote:
> A mechanical move, except that qemu_chr_write_all() needs to be declare=
d
> in char.h header to be used from chardev unit files.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  chardev/char-mux.h    |  63 +++++++++
>  include/sysemu/char.h |   3 +-
>  chardev/char-mux.c    | 358 ++++++++++++++++++++++++++++++++++++++++++=
++++++++
>  chardev/char.c        | 352 +-----------------------------------------=
-------
>  chardev/Makefile.objs |   1 +
>  5 files changed, 426 insertions(+), 351 deletions(-)
>  create mode 100644 chardev/char-mux.h
>  create mode 100644 chardev/char-mux.c
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--8LTM5kaXpWbQOnl9MEf7nBonaOmh0hUvM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYj5w2AAoJEKeha0olJ0Nq9JQH/iLaWo0R/Cfb4kmonpDEatE5
MhZDeo0iUao5sbqNnHX3Grh35pyC2BMjfqgRol5ilvpZidxBKPJLSeLhJia6IU4o
LGKR2eOIVdfeK8UwLXwIO8lfyW7cxkcq/kjZ31HlHdt10632t8ldE1rWpm8HEBcR
pY+PsVBTE8YCvr8+2j4KfC6WY3pFnthvzGCWB+9FgZ9Zpiz5Dy83IQpAVi0RXAEZ
+V1oLJ+dqkmUwPlvq4Ax6JLAK7IbzEF2Fyly5yaHnGmKbMltnsfWvOcUBa6cHDxF
IKWYaaeZ0qabY6PSzSWbZMaopyoT8/Y+5nfAGPPY1WukStI+8ONmBpqtDEvHFJw=
=yng2
-----END PGP SIGNATURE-----

--8LTM5kaXpWbQOnl9MEf7nBonaOmh0hUvM--
