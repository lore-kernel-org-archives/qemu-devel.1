Received: from eggs.gnu.org ([209.51.188.92]:60558)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hLXWo-0007O9-3a
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 14:30:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hLXWn-0003pt-3v
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 14:30:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37624)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1hLXWm-0003pJ-RF
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 14:30:53 -0400
References: <20190430181343.1362-1-driver1998@foxmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <141080f9-8374-1d16-7b40-a4848a455086@redhat.com>
Date: Tue, 30 Apr 2019 13:30:49 -0500
MIME-Version: 1.0
In-Reply-To: <20190430181343.1362-1-driver1998@foxmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="D5znanzGLs8VqY6uYfzs3jAPpjiNkETT3"
Subject: Re: [Qemu-devel] [PATCH v2 4/4] include/qemu/osdep.h: Move the
 __USE_MINGW_ANSI_STDIO define up to avoid confliction.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cao Jiaxi <driver1998@foxmail.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--D5znanzGLs8VqY6uYfzs3jAPpjiNkETT3
From: Eric Blake <eblake@redhat.com>
To: Cao Jiaxi <driver1998@foxmail.com>, qemu-devel@nongnu.org
Message-ID: <141080f9-8374-1d16-7b40-a4848a455086@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 4/4] include/qemu/osdep.h: Move the
 __USE_MINGW_ANSI_STDIO define up to avoid confliction.
References: <20190430181343.1362-1-driver1998@foxmail.com>
In-Reply-To: <20190430181343.1362-1-driver1998@foxmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 4/30/19 1:13 PM, Cao Jiaxi wrote:
> Signed-off-by: Cao Jiaxi <driver1998@foxmail.com>

Your entire series is missing 'In-Reply-To:' and 'References:' headers,
making each message show up as individual new threads rather than
properly threaded to a 0/4 cover letter. You'll want to fix your sending
habits to avoid that problem in future submissions.

It's unusual to use a trailing '.' in the subject line. Also, your
subject is very long; commit message summaries should typically be
around 60-70 characters because 'git log' shows them with further
indentation, where an 80-column terminal window makes it hard to see the
tail at a glance.  Better might be a short subject line explaining the
"what", and then a non-empty commit message explaining the "why",
perhaps looking like:

osdep: Fix mingw compilation regarding stdio formats

I encountered the following compilation error on mingw:
=2E.. PASTE SOMETHING HERE

It turns out that __USE_MINGW_ANSI_STDIO must be set before any system
headers are included, not just before <stdio.h>.

Signed-off-by:...

> =20
> +/* enable C99/POSIX format strings (needs mingw32-runtime 3.15 or late=
r) */
> +#ifdef __MINGW32__
> +#define __USE_MINGW_ANSI_STDIO 1
> +#endif
> +
>  #include <stdarg.h>
>  #include <stddef.h>
>  #include <stdbool.h>
>  #include <stdint.h>
>  #include <sys/types.h>
>  #include <stdlib.h>
> -
> -/* enable C99/POSIX format strings (needs mingw32-runtime 3.15 or late=
r) */
> -#ifdef __MINGW32__
> -#define __USE_MINGW_ANSI_STDIO 1
> -#endif

Question - does it hurt to make the define of __USE_MINGW_ANSI_STDIO
unconditional?  In other words, we're unlikely to break any non-mingw
platform if we drop the #ifdef __MINGW32__ line.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--D5znanzGLs8VqY6uYfzs3jAPpjiNkETT3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlzIlFoACgkQp6FrSiUn
Q2qsLAf7BKrNA+pbzKmsmL8HdJ9SHauWc3MZG3US/HRC6jJP7izlSLIIMPYAvLsf
LwLWbw5UahmwDhLZUXGELLnVLp1dCBUCwi3cv+DdfR7Z8gnp5KzTIgYgUOdurl5p
T1J0Jv6KLm7uZTrLQ1egqMleZt6RnLyR41QE3dtXQNF4pWWdQk9+IMhCm9Vzx4yu
9i7t5CiFFJAoCdi/JMXrxFDBBuoivNGxafwMYbrkx2WlXicyr7jzgRQ/N8oDN+Jb
Cehgms1pxEQrrSnOtawkNSGFHWCesB6HaELzyRrGREVfuzYZyUe2ECH14YZFX7NY
/RHTDxei6kRudVKJMac7RhRE9IlfbA==
=43lk
-----END PGP SIGNATURE-----

--D5znanzGLs8VqY6uYfzs3jAPpjiNkETT3--
