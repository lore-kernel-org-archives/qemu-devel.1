Received: from eggs.gnu.org ([2001:4830:134:3::10]:41979)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eDChZ-00087Y-RG
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 12:02:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eDChV-0004nH-Ji
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 12:02:45 -0500
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:43297)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1eDChV-0004mF-CK
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 12:02:41 -0500
Received: by mail-wr0-x241.google.com with SMTP id 4so9170878wrt.0
	for <qemu-devel@nongnu.org>; Fri, 10 Nov 2017 09:02:40 -0800 (PST)
Date: Fri, 10 Nov 2017 17:02:37 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20171110170237.GA18834@stefanha-x1.localdomain>
References: <1509951528-30976-1-git-send-email-longpeng2@huawei.com>
	<1509951528-30976-2-git-send-email-longpeng2@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8t9RHnE3ZwKMSgU+"
Content-Disposition: inline
In-Reply-To: <1509951528-30976-2-git-send-email-longpeng2@huawei.com>
Subject: Re: [Qemu-devel] [v21 RESEND 1/2] virtio-crypto: Add virtio crypto
 device specification
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Longpeng(Mike)" <longpeng2@huawei.com>
Cc: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, pasic@linux.vnet.ibm.com, Ola.Liljedahl@arm.com, brian.a.keating@intel.com, wangxinxin.wang@huawei.com, mst@redhat.com, xin.zeng@intel.com, jasowang@redhat.com, luonengjun@huawei.com, agraf@suse.de, john.griffin@intel.com, arei.gonglei@huawei.com, liang.j.ma@intel.com, stefanha@redhat.com, jianjay.zhou@huawei.com, cornelia.huck@de.ibm.com, Varun.Sethi@freescale.com, Jani.Kokkonen@huawei.com, vincent.jardin@6wind.com, denglingli@chinamobile.com, weidong.huang@huawei.com


--8t9RHnE3ZwKMSgU+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 06, 2017 at 02:58:47PM +0800, Longpeng(Mike) wrote:
> From: Gonglei <arei.gonglei@huawei.com>
>=20
> The virtio crypto device is a virtual crypto device (ie. hardware
> crypto accelerator card). Currently, the virtio crypto device provides
> the following crypto services: CIPHER, MAC, HASH, and AEAD.
>=20
> In this patch, CIPHER, MAC, HASH, AEAD services are introduced.
>=20
> VIRTIO-153
>=20
> Signed-off-by: Gonglei <arei.gonglei@huawei.com>
> Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>

This doesn't build cleanly for me on commit
2faf9b0666886abc0ca99f6813446a4e2a04f3ca
(https://github.com/oasis-tcs/virtio-spec master):

  $=20
  $ ./makeall.sh
  ! LaTeX Error: Lonely \item--perhaps a missing list environment.

See the LaTeX manual or LaTeX Companion for explanation.
Type  H <return>  for immediate help.
 ...

l.384 \item I
             f the VIRTIO_CRYPTO_F_MUX_MODE feature bit is NOT negotiated, =
the
?

> diff --git a/acknowledgements.tex b/acknowledgements.tex
> index 6c86d12..c4b6844 100644
> --- a/acknowledgements.tex
> +++ b/acknowledgements.tex
> @@ -26,6 +26,8 @@ Sasha Levin,	Oracle	\newline
>  Sergey Tverdyshev,	Thales e-Security	\newline
>  Stefan Hajnoczi,	Red Hat	\newline
>  Tom Lyon,	Samya Systems, Inc.	\newline
> +Lei Gong,	Huawei	\newline
> +Peng Long,	Huawei	\newline
>  \end{oasistitlesection}
> =20
>  The following non-members have provided valuable feedback on this
> @@ -43,4 +45,5 @@ Laura Novich, Red Hat	\newline
>  Patrick Durusau,	Technical Advisory Board, OASIS	\newline
>  Thomas Huth,	IBM	\newline
>  Yan Vugenfirer, Red Hat / Daynix	\newline
> +Halil Pasic,	IBM	\newline
>  \end{oasistitlesection}

These lists of names are in alphabetical order.  Please insert names at
the appropriate place.

> +If VIRTIO_CRYPTO_F_MUX_MODE is negotioated the device may support both s=
ession mode

s/negotioated/negotiated/

--8t9RHnE3ZwKMSgU+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaBdusAAoJEJykq7OBq3PI8ysH/2fP8F0dD42DGe8tR3R8aKjM
f++zo6InB5PL3dyjyuFLsktGH/DVcaI3YSVf4h4fz3BNHpGYtbSI9mZsnRTgOVv0
c51akttQsLjdHiJ3/tmLXwlFlcY+b/xyPIb6/v1XXLVBqqZ9Zmib0EUwP1i2z+eL
oLwh1vqVtIdvYIUckJ6DnXU35zdSHdLMJTmMe2Y8c02tEuQq9As4sI9MaR3SZJCt
hDSA1t+Pf5gubJQ6sCY7x/pq24rz2MHCpJJ96SAjEOza5cr/SjvReEmuR6Z7P7Ub
qzaKepBuf5Rybso80Z9DZ4x0IN2WQdxj4eNNMh2qruWm4D1Cp3jSR5H0UR5WcIQ=
=O3QO
-----END PGP SIGNATURE-----

--8t9RHnE3ZwKMSgU+--
