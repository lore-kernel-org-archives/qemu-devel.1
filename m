Received: from eggs.gnu.org ([2001:4830:134:3::10]:48857)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1ciLM2-0006ck-Ns
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 08:28:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1ciLLy-0005Gl-R3
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 08:28:42 -0500
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:33671)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1ciLLy-0005GV-Jw
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 08:28:38 -0500
Received: by mail-wr0-x244.google.com with SMTP id g10so10132186wrg.0
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 05:28:38 -0800 (PST)
Date: Mon, 27 Feb 2017 13:28:35 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170227132835.GR28403@stefanha-x1.localdomain>
References: <20170224172714.26026-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qOEfHYdX8LquYLAx"
Content-Disposition: inline
In-Reply-To: <20170224172714.26026-1-berrange@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] os: don't corrupt pre-existing
 memory-backend data with prealloc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Jitendra Kolhe <jitendra.kolhe@hpe.com>, Michal Privoznik <mprivozn@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>


--qOEfHYdX8LquYLAx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 24, 2017 at 05:27:14PM +0000, Daniel P. Berrange wrote:
> When using a memory-backend object with prealloc turned on, QEMU
> will memset() the first byte in every memory page to zero. While
> this might have been acceptable for memory backends associated
> with RAM, this corrupts application data for NVDIMMs.
>=20
> Instead of setting every page to zero, read the current byte
> value and then just write that same value back, so we are not
> corrupting the original data. Directly write the value instead
> of memset()ing it, since there's no benefit to memset for a
> single byte write.
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>=20
> NB, I have not tested performance of this, so no idea if this
> makes it better/worse/no-change. Would appreciate if Jitendra
> could repeat tests to see if it impacts scalability at all.
>=20
>  util/oslib-posix.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--qOEfHYdX8LquYLAx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYtCmDAAoJEJykq7OBq3PIJhQH/jzKnqh8tsIRGk0p/nzokIpa
HV6yADLrM+rS6j4l/XF3P/HzYHkVcMP/zesAbmcArnWRZFqXE4oQ+AFnYNnu5fw0
2m7LU+5L/D86bsV/GDbzhIlStf8rmIBuKDfBZHtpkyGnnL69hbBcIuvFj5pZS5Ho
NL+hotAMxor9lyEROQnuCbiuai/7uxHvATWDUwubK4eQZIWJVm1BeqMzlBkqZlMJ
Ut0p4+gM5Xi47RrknE+44HPS0pTg1EzgUFgX59z5i8usdH6ddfrLwZmn7u5gQue4
+Lw0OgpRiX4QgIJlqmWns65wrlmVYRPfLL4exbzXq+kbabRdhtQrekuiv8DUxLM=
=kJbw
-----END PGP SIGNATURE-----

--qOEfHYdX8LquYLAx--
