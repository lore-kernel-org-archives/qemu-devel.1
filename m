Received: from eggs.gnu.org ([2001:4830:134:3::10]:58858)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cRolV-0002UK-57
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 18:26:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cRolQ-00053r-9r
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 18:26:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48896)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cRolQ-0004x3-23
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 18:26:36 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EE90183F3A
	for <qemu-devel@nongnu.org>; Thu, 12 Jan 2017 23:26:35 +0000 (UTC)
References: <20170111172956.11255-1-marcandre.lureau@redhat.com>
	<20170111172956.11255-28-marcandre.lureau@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e3ce4505-4349-3b5a-84d5-decb39dab03d@redhat.com>
Date: Thu, 12 Jan 2017 17:26:33 -0600
MIME-Version: 1.0
In-Reply-To: <20170111172956.11255-28-marcandre.lureau@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="XVreN522AnJb0TLpqp1xd99Gsctqb8Edp"
Subject: Re: [Qemu-devel] [PATCH 27/40] char: move QIOChannel-related in
 char-io.h
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
--XVreN522AnJb0TLpqp1xd99Gsctqb8Edp
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
Message-ID: <e3ce4505-4349-3b5a-84d5-decb39dab03d@redhat.com>
Subject: Re: [PATCH 27/40] char: move QIOChannel-related in char-io.h
References: <20170111172956.11255-1-marcandre.lureau@redhat.com>
 <20170111172956.11255-28-marcandre.lureau@redhat.com>
In-Reply-To: <20170111172956.11255-28-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/11/2017 11:29 AM, Marc-Andr=C3=A9 Lureau wrote:

Grammar in subject is a bit terse; maybe:

char: move QIOChannel-related stuff to char-io.h

> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  chardev/char-io.h     |  24 +++++++
>  chardev/char-io.c     | 168 ++++++++++++++++++++++++++++++++++++++++++=
++++++
>  chardev/char.c        | 174 +-----------------------------------------=
--------
>  chardev/Makefile.objs |   1 +
>  4 files changed, 194 insertions(+), 173 deletions(-)
>  create mode 100644 chardev/char-io.h
>  create mode 100644 chardev/char-io.c
>=20
> diff --git a/chardev/char-io.h b/chardev/char-io.h
> new file mode 100644
> index 0000000000..ea559fd124
> --- /dev/null
> +++ b/chardev/char-io.h
> @@ -0,0 +1,24 @@
> +#ifndef CHAR_IO_H
> +#define CHAR_IO_H

Must... resist... the temptation to repeat myself!

> +
> +#include "qemu/osdep.h"

=2Eh files should NOT include osdep.h; since all .c files included it
before any other .h file, then all things in osdep.h are already in
scope at the point the .h file starts.


> +static gboolean io_watch_poll_prepare(GSource *source,
> +                                      gint *timeout_)
> +{

Why the weird spelling of timeout_ ?  Maybe timeout_unused is better?


> +++ b/chardev/char.c

> -static gboolean io_watch_poll_prepare(GSource *source,
> -                                      gint *timeout_)

Then again, it's code motion.  Again, up to you if you want to tweak
style things during code motion, or split them into a general cleanup
patch separately.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--XVreN522AnJb0TLpqp1xd99Gsctqb8Edp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYeBCpAAoJEKeha0olJ0Nq9eEIAK1bCBCt3/pW+JziCL/KCYBG
Nin3IvYJu+RRikOAJAdtH3Mf1mRZHIzOtkmfJSJaBE7WUbN6Z2rRtXv/AhF06tHG
Bb4QFHjDY5h3n2rDYFcj4v1vSznSLwM7ndYm1dsroqUOdffAz6+iyfpd/BhmLKBO
hSMFW5MV1fTmujvX1C6lDzMG/3MR6qxFVFNQ6cejxuQ8VCgiI/oqYad5bY3oMUxF
kcvAaDtr9fIILAuICHwbrPT37NT1pmY/rFXsJW9/tzeVszFQrxtjwR0QJvAIVKuK
ADwW//yOUvV04h34M0HqHbpKu/IKBaUYNX+jF+ptXSjY4N+uaWO+cRbJkXco+Xg=
=9mRm
-----END PGP SIGNATURE-----

--XVreN522AnJb0TLpqp1xd99Gsctqb8Edp--
