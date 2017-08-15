Received: from eggs.gnu.org ([2001:4830:134:3::10]:41089)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dhc4a-0001yE-0U
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 09:39:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dhc4W-00044O-Pt
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 09:39:56 -0400
Received: from mail-wm0-x22a.google.com ([2a00:1450:400c:c09::22a]:38514)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dhc4W-00043k-IK
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 09:39:52 -0400
Received: by mail-wm0-x22a.google.com with SMTP id f15so10104617wmg.1
	for <qemu-devel@nongnu.org>; Tue, 15 Aug 2017 06:39:52 -0700 (PDT)
Date: Tue, 15 Aug 2017 14:39:48 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170815133948.GA12671@stefanha-x1.localdomain>
References: <20170814231552.24593-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9amGYk9869ThD9tj"
Content-Disposition: inline
In-Reply-To: <20170814231552.24593-1-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for 2.10?] qxl: call
 qemu_spice_display_init_common for secondary devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, ademaria@redhat.com, kraxel@redhat.com


--9amGYk9869ThD9tj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 15, 2017 at 01:15:52AM +0200, Paolo Bonzini wrote:
> Fixes this 2.10 regression:
>=20
>   $ qemu-system-x86_64  -cpu host -m 6144 -vga qxl -device qxl
>   qemu-system-x86_64: util/qemu-thread-posix.c:64: qemu_mutex_lock: Asser=
tion `mutex->initialized' failed.
>=20
> Reported-by: ademaria@redhat.com
> Cc: kraxel@redhat.com
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  hw/display/qxl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

I have audited the code and cannot see any bad side-effects.  Looks good
to me!

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--9amGYk9869ThD9tj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZkvmkAAoJEJykq7OBq3PIHsEH/jli+P/rBH5t+QFTFjSz5KRX
NazR2s5dd+0Q1CHi3x72vEo9kCmChZiEPU1TTFCW3vUiengPmsNHWG7FH0Ywzqgg
YUnN6p7f8/cmI1dhxR2096y6nQz8h9C63/Haqd63ZNREGmLFkyXNhFPiSN3LtTlF
1t2ICs2Hn9NQQ8OCYFm1s2t3XheDYOHJFkQe0kNaOc3BQNYKJsZ+ZDCYle26M0Ek
in3Va0YLvxp2dMCyG9f5+dYP+/pODddXjXAQrQAxge+sz41UDYAH7Hg9suIFeOrH
dtj06EAO7pTiz4nB+vJtEYu1kN28WljfIk8esbEuSXBUr4Js2AgGXCiIjFJ/D7c=
=N0d4
-----END PGP SIGNATURE-----

--9amGYk9869ThD9tj--
