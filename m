Received: from eggs.gnu.org ([2001:4830:134:3::10]:39660)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1d8rvN-0004Fl-1u
	for qemu-devel@nongnu.org; Thu, 11 May 2017 13:30:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1d8rvJ-000829-0a
	for qemu-devel@nongnu.org; Thu, 11 May 2017 13:30:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35904)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1d8rvI-00081Z-R3
	for qemu-devel@nongnu.org; Thu, 11 May 2017 13:30:44 -0400
Date: Thu, 11 May 2017 13:30:38 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170511173038.GA8701@stefanha-x1.localdomain>
References: <1494369432-15418-1-git-send-email-anthony.xu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="45Z9DzgjV8m4Oswq"
Content-Disposition: inline
In-Reply-To: <1494369432-15418-1-git-send-email-anthony.xu@intel.com>
Subject: Re: [Qemu-devel] [PATCH] trace: add sanity check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anthony Xu <anthony.xu@intel.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com


--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 09, 2017 at 03:37:12PM -0700, Anthony Xu wrote:
> If trace backend is set to TRACE_NOP, trace_get_vcpu_event_count
> returns 0, cause bitmap_new call abort.
>=20
> Signed-off-by: Anthony Xu <anthony.xu@intel.com>
> ---
>  qom/cpu.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

Thanks, applied to my tracing tree:
https://github.com/stefanha/qemu/commits/tracing

Stefan

--45Z9DzgjV8m4Oswq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZFJ++AAoJEJykq7OBq3PIXG8H/35PXKv8QbDP4JYThuayfH3U
Dr+ioC06UWYq6k7pCnxPNhZl945P4ejcpeMjfSSX2AFtYtOi9M+wzehgXg0eoygc
a9Bgyof7/uSkTmQ4YNDTdVvOE/9CWGfddUPrZTpMmITbxTrIQxtLsCxdrRiaL4g+
PQRDGLUXR0oy+btXrhzxNjM++7g4H+d2wWPJeqzCSz2/fQ2Jb4adqxE21aEmRGda
xZND5d788mlBozicgsc9M3ADpAq47N1HmSBNs/MnKKDKBpj2Tq7FPGz/wEtQT+rj
UpjSGj+zORTMAghdg3jTDIUYOH3xHSRnl48pw3b7DN4OtUWuMuqnA2np0DSYGoE=
=QKD/
-----END PGP SIGNATURE-----

--45Z9DzgjV8m4Oswq--
