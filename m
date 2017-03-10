Received: from eggs.gnu.org ([2001:4830:134:3::10]:58319)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cmCCe-0008EW-Ig
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 23:30:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cmCCa-0003eX-La
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 23:30:56 -0500
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:33995)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cmCCa-0003dd-G3
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 23:30:52 -0500
Received: by mail-pg0-x242.google.com with SMTP id b5so8941264pgg.1
	for <qemu-devel@nongnu.org>; Thu, 09 Mar 2017 20:30:52 -0800 (PST)
Date: Fri, 10 Mar 2017 12:30:48 +0800
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170310043048.GC4589@stefanha-x1.localdomain>
References: <20170303113255.28262-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lCAWRPmW1mITcIfM"
Content-Disposition: inline
In-Reply-To: <20170303113255.28262-1-berrange@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3] os: don't corrupt pre-existing
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
Cc: qemu-devel@nongnu.org, Andrea Arcangeli <aarcange@redhat.com>, Michal Privoznik <mprivozn@redhat.com>, Jitendra Kolhe <jitendra.kolhe@hpe.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>


--lCAWRPmW1mITcIfM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 03, 2017 at 11:32:55AM +0000, Daniel P. Berrange wrote:
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
> Changed in v3:
>=20
>  - Mark the target of the write as volatile, instead of the intermedia
>    variable (Andrea)
>=20
>  util/oslib-posix.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)

There are no official maintainers for this source file.  I want to make
sure this patch goes into QEMU 2.9, so...

Thanks, applied to my block tree:
https://github.com/stefanha/qemu/commits/block

Stefan

--lCAWRPmW1mITcIfM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYwiv4AAoJEJykq7OBq3PIQKYH/jwJpMTRqQl1OVoL4pYl8qps
TWZAVkBF55FTpU/OgrofJrRMPmaJwOrg0aVuYoJbwGX3uMN4aYFj7qj9eliYJInM
C4Gxk08FsBmnL+lvzu70AREaIZT6CMNvqN5VX7XAD+TM7JlPH6iMWa11m6WovUQS
i3Y7GjnOO1UBsfY5Ufr3dkChyuFptDuXPOgBDgGOQJr9kx0LyXr9wt2REK58QnEK
rQgpMGIusiGnOlqTcwZeQRwV6cXADYoLQQoLNSZg98GDkrWsKYFcuJWk+47+ITAE
ykjT3TPXwmFOD7qjbffsDkeJ3Q4kZjYJiVGoT/NEOxFD391EGU0Esirg3EYc7Kw=
=o3Cx
-----END PGP SIGNATURE-----

--lCAWRPmW1mITcIfM--
