Received: from eggs.gnu.org ([209.51.188.92]:52250)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1ghzeJ-00055w-PW
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 11:27:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1ghzeE-0000gx-Nx
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 11:27:11 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:32998)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1ghzeE-0000U6-8L
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 11:27:06 -0500
Received: by mail-wm1-x341.google.com with SMTP id r24so2385887wmh.0
	for <qemu-devel@nongnu.org>; Fri, 11 Jan 2019 08:26:52 -0800 (PST)
Date: Fri, 11 Jan 2019 16:26:49 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20190111162649.GC14776@stefanha-x1.localdomain>
References: <20190111131836.107549-1-sgarzare@redhat.com>
	<20190111131836.107549-3-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5QAgd0e35j3NYeGe"
Content-Disposition: inline
In-Reply-To: <20190111131836.107549-3-sgarzare@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/4] linuxboot_dma: move common functions
 in a new header
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, George Kennedy <george.kennedy@oracle.com>, Gerd Hoffmann <kraxel@redhat.com>, Marc-Andre Lureau <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Maran Wilson <maran.wilson@oracle.com>, Richard Henderson <rth@twiddle.net>


--5QAgd0e35j3NYeGe
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 11, 2019 at 02:18:34PM +0100, Stefano Garzarella wrote:
> In order to allow other option roms to use these common
> useful functions and definitions, this patch put them
> in a new C header file called optrom.h, and also add
> useful out*() in*() functions for different size.

It's usually helpful to modify code in a one patch and move it in a
separate patch.  This patch does both, so it's a harder to review.
Don't worry about changing it now, but something to try in the future.

> +#include <stdint.h>
> +#include "optrom.h"
> +#include "optrom_fw_cfg.h"

Can these be moved to the top of the file like a regular C source file?

> diff --git a/pc-bios/optionrom/optrom.h b/pc-bios/optionrom/optrom.h
> new file mode 100644
> index 0000000000..36f43b43fd
> --- /dev/null
> +++ b/pc-bios/optionrom/optrom.h
> @@ -0,0 +1,109 @@
> +/*
> + * Common Option ROM Functions for C code
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, see <http://www.gnu.org/licenses/>.
> + *
> + * Copyright (c) 2015-2019 Red Hat Inc.
> + *   Authors:
> + *     Marc Mar=ED <marc.mari.barcelo@gmail.com>
> + *     Richard W.M. Jones <rjones@redhat.com>
> + *     Stefano Garzarella <sgarzare@redhat.com>
> + */
> +
> +#ifndef OPTROM_H
> +#define OPTROM_H
> +
> +#include "../../include/standard-headers/linux/qemu_fw_cfg.h"

This depends on <stdint.h>, please include it first.

--5QAgd0e35j3NYeGe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcOMPJAAoJEJykq7OBq3PIqR8H/jm0kAIf1qfWru8naTCu/+XA
/ZUU2C2d1wy5cI1S7gDzaRr9sXQy39BuT+KmqdgBW5OS2Gaz1wbhwT1jO3RvrQER
W8tqC55sdINQ9k849pSJuXj0rGwwv/Kf1K+iHwI032GXu41a/cGl9CW1MJv+CoQr
+aOhxkYP2QzoTOxdxRPqN7HPVM/PLYgm19dDJVJpnKq7yUqb5coHvCePCB0Fm2gX
Cj3mhdEz/1VyDT4VqAdMTKsU9gg3y9aNXcgGSAvQ+0xPVhgCz/xxntmmC6E7k239
W8YWjPFV9BOH1UyRPxuXI0rdz8wxnaif/2WFKXwBfI8qRYUyHPs5y7817UYAacs=
=blcG
-----END PGP SIGNATURE-----

--5QAgd0e35j3NYeGe--
