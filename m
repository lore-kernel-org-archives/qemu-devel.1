Received: from eggs.gnu.org ([2001:4830:134:3::10]:39338)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cpy2z-0003gc-U3
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 10:12:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cpy2u-0001uD-W7
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 10:12:33 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:35122)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cpy2u-0001tu-Pd
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 10:12:28 -0400
Received: by mail-wr0-x243.google.com with SMTP id u108so18343636wrb.2
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 07:12:28 -0700 (PDT)
Date: Mon, 20 Mar 2017 14:12:25 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170320141225.GY17887@stefanha-x1.localdomain>
References: <20170316163640.5597-1-pbonzini@redhat.com>
	<20170317094102.GB11116@stefanha-x1.localdomain>
	<ab488c57-5006-e5db-145b-5b0cba1d3ead@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GcSOTaE82DYSpZPK"
Content-Disposition: inline
In-Reply-To: <ab488c57-5006-e5db-145b-5b0cba1d3ead@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] qemu-ga: obey LISTEN_PID when using
 systemd socket activation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, "Richard W.M. Jones" <rjones@redhat.com>


--GcSOTaE82DYSpZPK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 17, 2017 at 11:57:38AM +0100, Paolo Bonzini wrote:
>=20
>=20
> On 17/03/2017 10:41, Stefan Hajnoczi wrote:
> >> Luckily, qemu-nbd also got socket activation code, and its copy does
> >> support LISTEN_PID.  Some extra fixups are needed to ensure that the
> >> code can be used for both, but that's what this patch does.  The
> >> main change is to replace get_listen_fds's "consume" argument with
> >> the FIRST_SOCKET_ACTIVATION_FD macro from the qemu-nbd code.
> >=20
> > I intentionally wrote qga socket activation this way.  It allows socket
> > activation to work together with daemonization.  That combination is
> > probably not very useful so it's fine to get rid of it.
>=20
> This works with my patch (and I've tested it now), because it looks up
> LISTEN_FDS only once, way before daemonization.
>=20
> The run_agent function grew a parameter that tells it to use
> FIRST_SOCKET_ACTIVATION_FD as the file descriptor, without requiring
> another look at the environment.  (And because daemonization forks but
> doesn't exec, setting the cloexec flag doesn't get in the way either).

Good point, I thought it would exec for some reason but it doesn't need
to!

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--GcSOTaE82DYSpZPK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYz+NJAAoJEJykq7OBq3PIwwEIAL7aV49Gychnwv1HpvtX6U7z
ibDUTOLI8occgB0v7g+aclsTez67ffY/6g2Y3nAbqc1HzdSU0gu5quBKjDco7EhD
E8fd2tIZH8OjiJ6fGWJHLYFusK+/KJaSZ4UZmkpa5TC3mgEucyCjzntxmkAZayRy
W8rX6zaVDADk83fLjvo0SzNxI2MTCgG08JuBgEi73kAdIrl1w9ofwMX8z+/ncGft
yy4ZO0mBIhRhmpToY6jbzCecgetCQLSVhL117sT1FQLGX8nmVT/voRe+AgQDFtFt
+6kz+mKBCwBtcusiL/9RrWLU7vZJi89R5qTJ8d31ySGO6m2xYD5P/aKDOkALdgQ=
=xWYJ
-----END PGP SIGNATURE-----

--GcSOTaE82DYSpZPK--
