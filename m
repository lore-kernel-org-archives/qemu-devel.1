Received: from eggs.gnu.org ([2001:4830:134:3::10]:43614)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cECQx-0005IJ-U0
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 04:53:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cECQs-00013q-Of
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 04:53:11 -0500
Received: from mail-wj0-f196.google.com ([209.85.210.196]:36029)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cECQs-00013b-IU
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 04:53:06 -0500
Received: by mail-wj0-f196.google.com with SMTP id j10so15468166wjb.3
	for <qemu-devel@nongnu.org>; Tue, 06 Dec 2016 01:53:06 -0800 (PST)
Date: Tue, 6 Dec 2016 09:52:03 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20161206095203.GH12630@stefanha-x1.localdomain>
References: <1480960775-5002-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="U3BNvdZEnlJXqmh+"
Content-Disposition: inline
In-Reply-To: <1480960775-5002-1-git-send-email-peter.maydell@linaro.org>
Subject: Re: [Qemu-devel] [PULL 0/1] target-arm queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>


--U3BNvdZEnlJXqmh+
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 05, 2016 at 05:59:34PM +0000, Peter Maydell wrote:
> One patch for 2.8-rc3, which is Alex's partial revert
> of 1dd089d0 to fix A64 ldaxp.
>=20
> thanks
> -- PMM
>=20
> The following changes since commit bc66cedb4141fb7588f2462c74310d8fb5dd4c=
f1:
>=20
>   Merge remote-tracking branch 'yongbok/tags/mips-20161204' into staging =
(2016-12-05 10:56:45 +0000)
>=20
> are available in the git repository at:
>=20
>   git://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-=
20161205
>=20
> for you to fetch changes up to 5460da501a57cd72eda6fec736d76539122e2f99:
>=20
>   target-arm/translate-a64: fix gen_load_exclusive (2016-12-05 17:52:01 +=
0000)
>=20
> ----------------------------------------------------------------
> target-arm queue:
>  * fix gen_load_exclusive handling of ldaxp
>=20
> ----------------------------------------------------------------
> Alex Benn=E9e (1):
>       target-arm/translate-a64: fix gen_load_exclusive
>=20
>  target-arm/translate-a64.c | 42 +++++++++++++++++++---------------------=
--
>  1 file changed, 19 insertions(+), 23 deletions(-)
>=20

Thanks, applied to my staging tree:
https://github.com/stefanha/qemu/commits/staging

Stefan

--U3BNvdZEnlJXqmh+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYRopDAAoJEJykq7OBq3PIvjoH/2abu5UqlH/5YNCzvapwLnaW
xxeyOcCk1SQGBtJNIWYt4MCgTC61vnhrUEB1ss831eZSi/UVbg3vgwm9bR6wNxAz
bnCNFt41DbSBJagose+FkemYZBu9G/AL7wdvMGuuBTo3h/kp0HVks7xXfnfSFQq9
vmq7y80SrzUV/hQu99zU4q23pPH3LHlNptT3kWbGialXtKKfvTKA4s7XjclXhPpu
VWnekZ2P+cPxwRDQu3DHP0RIhdUz0Dr1rqiZR5irYOZrBJtU9j6cBhc9E7mAV8FL
kOEvBStcg7Fp2OKdhPgHSeOe8fhkL6Un2HyDpdrAxfNIG9wHATTBHNVx+C7DnNE=
=z8WU
-----END PGP SIGNATURE-----

--U3BNvdZEnlJXqmh+--
