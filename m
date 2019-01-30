Received: from eggs.gnu.org ([209.51.188.92]:40241)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gogtW-0005Yz-C9
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 22:50:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gogtV-0003wM-9I
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 22:50:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55432)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1gogtV-0003wB-3f
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 22:50:33 -0500
Date: Wed, 30 Jan 2019 11:50:29 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190130035029.GD20241@stefanha-x1.localdomain>
References: <20190129121817.7109-1-jusual@mail.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bjuZg6miEcdLYP6q"
Content-Disposition: inline
In-Reply-To: <20190129121817.7109-1-jusual@mail.ru>
Subject: Re: [Qemu-devel] [PATCH] arm: Clarify the logic of set_pc()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Julia Suvorova <jusual@mail.ru>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>


--bjuZg6miEcdLYP6q
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 29, 2019 at 03:18:17PM +0300, Julia Suvorova wrote:
> Until now, the set_pc logic was unclear, which raised questions about
> whether it should be used directly, applying a value to PC or adding
> additional checks, for example, set the Thumb bit in Arm cpu. Let's set
> the set_pc logic for =E2=80=9CConfigure the PC, as was done in the ELF fi=
le=E2=80=9D
> and implement synchronize_with_tb hook for preserving PC to cpu_tb_exec.
>=20
> Signed-off-by: Julia Suvorova <jusual@mail.ru>
> ---
>  hw/arm/boot.c             |  4 ----
>  include/qom/cpu.h         | 16 ++++++++++++++--
>  target/arm/arm-powerctl.c |  3 ---
>  target/arm/cpu.c          | 26 +++++++++++++++++++++++++-
>  target/arm/cpu64.c        | 15 ---------------
>  5 files changed, 39 insertions(+), 25 deletions(-)

I'm not familiar enough with ARM TCG to review this properly but it
looks like what I would expect:

Acked-by: Stefan Hajnoczi <stefanha@redhat.com>

--bjuZg6miEcdLYP6q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcUR8FAAoJEJykq7OBq3PIiFMH/jVGu7WyqoGCWt9Ear8pnbdN
yeoaKZIreJ+71s9AtUOYNErrB7FFi2tb9HB6IU5KvchUooJDM5b6ZEK1xIyzc4n9
6+a7YRxNYOChkp/wdmLg0YHXrDuospAdrFEaSUo+iaFV/LBrPdEMfHG0nddm0fBH
mcOK49GYBZqgI561xXgwld0DTxJf7pZuIyTeJQgFixR2clQNj2fNaFAFXnsSLtSu
uM/7z06SAhTYzS0xkNt+hRN9XTgFA7bzlWX6eNJZgsYtXr20fjyuryo3Kf022srw
WyuyQxWN6fu3hYLvb2Hj0ePeenIO+N5Q/CVMRS1X/rwYya2O6s4hnDKldXCqZNs=
=hgUT
-----END PGP SIGNATURE-----

--bjuZg6miEcdLYP6q--
