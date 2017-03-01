Received: from eggs.gnu.org ([2001:4830:134:3::10]:35759)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cjAHU-00043l-FV
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 14:51:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cjAHQ-0004OI-9J
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 14:51:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42258)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cjAHQ-0004No-3I
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 14:51:20 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3B25E3A7690
	for <qemu-devel@nongnu.org>; Wed,  1 Mar 2017 19:51:19 +0000 (UTC)
References: <20170227134202.2991-1-marcandre.lureau@redhat.com>
	<20170227134202.2991-3-marcandre.lureau@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d6661473-78e4-5960-ec4a-8cdffce44e6e@redhat.com>
Date: Wed, 1 Mar 2017 13:51:06 -0600
MIME-Version: 1.0
In-Reply-To: <20170227134202.2991-3-marcandre.lureau@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="XHIKoiJoNngQ7k8Eed2Phb4dq21qbM0Hp"
Subject: Re: [Qemu-devel] [PATCH v2 02/21] mux: simplfy muxes_realize_done
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
--XHIKoiJoNngQ7k8Eed2Phb4dq21qbM0Hp
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
Message-ID: <d6661473-78e4-5960-ec4a-8cdffce44e6e@redhat.com>
Subject: Re: [PATCH v2 02/21] mux: simplfy muxes_realize_done
References: <20170227134202.2991-1-marcandre.lureau@redhat.com>
 <20170227134202.2991-3-marcandre.lureau@redhat.com>
In-Reply-To: <20170227134202.2991-3-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/27/2017 07:41 AM, Marc-Andr=C3=A9 Lureau wrote:
> mux_chr_event() already send events to all backends, rename it,
> export it, and use it from muxes_realize_done. This should help abstrac=
t
> away mux implementation.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  chardev/char-mux.h |  2 +-
>  chardev/char-mux.c | 11 ++++++++---
>  chardev/char.c     |  9 ++-------
>  3 files changed, 11 insertions(+), 11 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--XHIKoiJoNngQ7k8Eed2Phb4dq21qbM0Hp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYtyYqAAoJEKeha0olJ0NqbXYH/0TmAPSOqVOLgxUPCS7i4apq
srSpIT8HJ8j5lzbR11BJQxkXunCDbTRvrq/71lSpnA7HeL/Q1EJ60g5/2QIC+Ja4
Eir/brfxQ8jIyQJKEXBEl9qLjJFLQAsXBsqltHnqQ9B+hM/lMXXTL7M/vb3XsDHJ
mVyzkDYuX2j6w6SQgvVXQ1RyAIvtt6ZeWk6XmVAm2hzPSdDZdm0Nd9kXvUXNwJu+
ED4/WHh+jq673WqgaJz8fEu3jDHpa7JCIQkH2z+MDqEX9BwccXp2mb9eEMzETXwm
Nv0e4SBCigLVYijLJ3avYvCwRdQrQpMJKgyx3D76i5AMEc/WdrLxjy7urQkk5go=
=gl7Z
-----END PGP SIGNATURE-----

--XHIKoiJoNngQ7k8Eed2Phb4dq21qbM0Hp--
