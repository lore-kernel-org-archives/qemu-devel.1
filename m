Received: from eggs.gnu.org ([2001:4830:134:3::10]:45243)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <otubo@redhat.com>) id 1fsqq2-0004WW-S0
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 10:43:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <otubo@redhat.com>) id 1fsqpy-0002JD-Qc
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 10:43:54 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54496 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <otubo@redhat.com>) id 1fsqpx-0002II-8d
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 10:43:49 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E7D3340241D3
	for <qemu-devel@nongnu.org>; Thu, 23 Aug 2018 14:43:48 +0000 (UTC)
Date: Thu, 23 Aug 2018 16:43:45 +0200
From: Eduardo Otubo <otubo@redhat.com>
Message-ID: <20180823144345.GL3923@vader>
References: <20180822170250.29573-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="E6lVPAHcXg6biC3t"
Content-Disposition: inline
In-Reply-To: <20180822170250.29573-1-marcandre.lureau@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 0/4] seccomp fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, pmoore@redhat.com, berrange@redhat.com, eblake@redhat.com


--E6lVPAHcXg6biC3t
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 22/08/2018 - 19:02:46, Marc-Andr=C3=A9 Lureau wrote:
> Hi,
>=20
> This series fixes 2 issues with -sandbox:
>=20
> - The seccomp action SCMP_ACT_KILL results in immediate termination of
>   the thread that made the bad system call. However, qemu being
>   multi-threaded, it keeps running. There is no easy way for parent
>   process / management layer (libvirt) to know about that situation.
>=20
>   Instead, the default SIGSYS handler when invoked with SCMP_ACT_TRAP
>   will terminate the program and core dump.
>=20
>   This may not be the most secure solution, but probably better than
>   just killing the offending thread. SCMP_ACT_KILL_PROCESS has been
>   added in Linux 4.14 to improve the situation, which I propose to use
>   by default if available.
>=20
>   Related to:
>   https://bugzilla.redhat.com/show_bug.cgi?id=3D1594456
>=20
> - The seccomp filter isn't applied to all threads. We can solve the
>   issue by using SECCOMP_FILTER_FLAG_TSYNC since libseccomp 2.2.0 and
>   kernel >=3D 3.17.
>=20
> v3:
> - modify qemu_seccomp() to set errno=3DENOSYS
> - add patch "seccomp: set the seccomp filter to all threads"
>=20
> v2:
> - fix clang unused inline warning
> - add acked-by/r-b tags
>=20
> Marc-Andr=C3=A9 Lureau (4):
>   seccomp: use SIGSYS signal instead of killing the thread
>   seccomp: prefer SCMP_ACT_KILL_PROCESS if available
>   configure: require libseccomp 2.2.0
>   seccomp: set the seccomp filter to all threads
>=20
>  qemu-seccomp.c | 36 +++++++++++++++++++++++++++++++++++-
>  configure      |  7 ++-----
>  2 files changed, 37 insertions(+), 6 deletions(-)
>=20
> --=20
> 2.18.0.547.g1d89318c48
>=20
Acked-by: Eduardo Otubo <otubo@redhat.com>

--E6lVPAHcXg6biC3t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbfsghAAoJEN8y58Dw//mifkoH/3rP0OVCBkVmp7mkusuF9yvL
7Bju+FVHlUbQYhGCGHeJSQ6MVUQRdRF81GEgC8hl65PMzY4O2rZYt0wUE+2ygoyW
BBWb/rc1s4s6mDmmhOwsaTGGl2u8a6tB8GJMlX3Pk0a2U/Z7F+KhdvX0aVqXscUr
Pd9usorEnRlNVKe87fLpBSAoS+sZcZa9ejgTI1VZQp6tP+Q35w2+VddQYNyxLIyb
Ie6EjYI9FLK9ekhn7+aagsz7mRn33mh/ldGhPNYfEIM2v5o34sPxR+tObdtQkd7v
ZnKmuA8t3hJEtDLZLan2fW+PYTDQZ3Ziw0jX+aJBUpaxd/s1HjIVyxLGQQfOnes=
=n0vz
-----END PGP SIGNATURE-----

--E6lVPAHcXg6biC3t--
