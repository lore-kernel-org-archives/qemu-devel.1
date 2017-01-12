Received: from eggs.gnu.org ([2001:4830:134:3::10]:54713)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cRoRw-0001RY-Eg
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 18:06:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cRoRt-0006SB-AR
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 18:06:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50452)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cRoRt-0006RR-1w
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 18:06:25 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0E3717F7C6
	for <qemu-devel@nongnu.org>; Thu, 12 Jan 2017 23:06:25 +0000 (UTC)
References: <20170111172956.11255-1-marcandre.lureau@redhat.com>
	<20170111172956.11255-24-marcandre.lureau@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f8481781-715e-4d7a-9af0-d1a407af1c0f@redhat.com>
Date: Thu, 12 Jan 2017 17:06:22 -0600
MIME-Version: 1.0
In-Reply-To: <20170111172956.11255-24-marcandre.lureau@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="XS0kQUQDKt8O8Vv5S9MoDRFbx0cpJe01O"
Subject: Re: [Qemu-devel] [PATCH 23/40] char: move mux to its own file
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
--XS0kQUQDKt8O8Vv5S9MoDRFbx0cpJe01O
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
Message-ID: <f8481781-715e-4d7a-9af0-d1a407af1c0f@redhat.com>
Subject: Re: [PATCH 23/40] char: move mux to its own file
References: <20170111172956.11255-1-marcandre.lureau@redhat.com>
 <20170111172956.11255-24-marcandre.lureau@redhat.com>
In-Reply-To: <20170111172956.11255-24-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/11/2017 11:29 AM, Marc-Andr=C3=A9 Lureau wrote:
> A mechanical move, except that qemu_chr_write_all() needs to be declare=
d
> in char.h header to be used from chardev unit files.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---

> +++ b/chardev/char-mux.h
> @@ -0,0 +1,40 @@
> +#ifndef CHAR_MUX_H
> +#define CHAR_MUX_H

Again, missing copyright blurbs. You'll need to respin to get that
right, but I'll quit pointing it out.

> +
> +#include "sysemu/char.h"
> +
> +extern bool muxes_realized;
> +
> +#define MAX_MUX 4
> +#define MUX_BUFFER_SIZE 32 /* Must be a power of 2.  */
> +#define MUX_BUFFER_MASK (MUX_BUFFER_SIZE - 1)
> +typedef struct MuxChardev {
> +    Chardev parent;
> +    CharBackend *backends[MAX_MUX];
> +    CharBackend chr;
> +    int focus;
> +    int mux_cnt;
> +    int term_got_escape;
> +    int max_size;
> +    /* Intermediate input buffer allows to catch escape sequences even=
 if the

s/allows to catch/catches/

Dunno if cleanups like that should be mixed with code motion, or done
separately.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--XS0kQUQDKt8O8Vv5S9MoDRFbx0cpJe01O
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYeAvuAAoJEKeha0olJ0NqV1QH/i781aEzojPLo9jdySX1Ythf
Won2jAeGMRhf7TuXgrwpjFQwcRcDKzN5408ys0iJrmGk5TDzEswOw7WBhOGG5sAG
V7ZjL23vBnQX7uQ1HaiaQ45PCKaSBWL6WBJ9M3o1xdxK64oUfPN3asHDN/hZfEK4
13IjEmsC5Qni9AYoq7ixZIMSRcTNUa//lRqHdnYdGYy8sHmloPf/iHYoBXTAdIfa
eQALzuc4pGdKTg7dY5tzPCBohPVGDNXltBSvTDdweuzX6+lerPc0PxYxlqt7iGSj
lgvw6AUMUAjZJ0yM+akDWFXtuFnTd+UTeRlOcSx5zmi9G4Q1DaOZu8hIBseqzKw=
=xXfz
-----END PGP SIGNATURE-----

--XS0kQUQDKt8O8Vv5S9MoDRFbx0cpJe01O--
