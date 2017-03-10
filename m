Received: from eggs.gnu.org ([2001:4830:134:3::10]:58028)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cmC9v-0007cJ-Md
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 23:28:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cmC9q-0002g7-PX
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 23:28:07 -0500
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:34261)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cmC9q-0002fr-Jw
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 23:28:02 -0500
Received: by mail-pf0-x244.google.com with SMTP id o126so9418733pfb.1
	for <qemu-devel@nongnu.org>; Thu, 09 Mar 2017 20:28:02 -0800 (PST)
Date: Fri, 10 Mar 2017 12:27:56 +0800
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170310042756.GB4589@stefanha-x1.localdomain>
References: <20170303113255.28262-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tjCHc7DPkfUGtrlw"
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


--tjCHc7DPkfUGtrlw
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

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--tjCHc7DPkfUGtrlw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYwitMAAoJEJykq7OBq3PI0h4IAKsI1M1587YVwIFH30JKnwW+
lSuu+KeNP32TtdYA/vcVEoh89xQEAuQOSfddqsExFrzuRr6y392PHLInRlN7Gsun
ip8RD4SsS4Fl1Nr/0LGe7803D0jelqKaEte/4qtHLU3KS2tRdUctJLriT1isIEfg
ebgQYtohz3SC9kjro5nnYFm/48HFs8JtW6rDFYSZ88s5Q2a2p3AD0UEyUdxg0xNm
VENtVFISXsknE393BjYdDIo5u+2Ax38JslUtCtHWjEpQaiDFvlrPuW5xep/Xjo4O
OF0762Oj6kp/TYL94ZgpXPhPExb8IafrXMMeueDtogUjD4Tf4lm7OHmkZz1Oei0=
=rQCK
-----END PGP SIGNATURE-----

--tjCHc7DPkfUGtrlw--
