Received: from eggs.gnu.org ([2001:4830:134:3::10]:55112)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1etAs3-0001lh-Po
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 06:35:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1etAs0-0001ul-LW
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 06:35:03 -0500
Received: from mail-wm0-x234.google.com ([2a00:1450:400c:c09::234]:37700)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1etAs0-0001uJ-Bt
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 06:35:00 -0500
Received: by mail-wm0-x234.google.com with SMTP id 139so21645936wmn.2
	for <qemu-devel@nongnu.org>; Tue, 06 Mar 2018 03:35:00 -0800 (PST)
Date: Tue, 6 Mar 2018 11:34:57 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180306113457.GE31045@stefanha-x1.localdomain>
References: <CAB3_1NuKx8EspXZstkUYRTtXfNLQiDBF3QUW2WsGtycOd4Vmpw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ytoMbUMiTKPMT3hY"
Content-Disposition: inline
In-Reply-To: <CAB3_1NuKx8EspXZstkUYRTtXfNLQiDBF3QUW2WsGtycOd4Vmpw@mail.gmail.com>
Subject: Re: [Qemu-devel] SSD virtio-scsi passthrough
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nitin Gupta <nitin.gupta981@gmail.com>
Cc: qemu-devel@nongnu.org


--ytoMbUMiTKPMT3hY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2018 at 02:51:38PM +0530, Nitin Gupta wrote:
> Please let me know the qemu command for doing ssd virtio-scsi passthrough=
 .
> i am able to do the pass through with virsh .but same command when i am
> trying with qemu , VM is not coming up
>=20
> Please let me know how can i proceed further . any help will be appreciat=
ed

Something like this:

  -drive if=3Dnone,id=3Ddrive0,file=3D/dev/sdX,format=3Draw,aio=3Dnative,ca=
che=3Dnone
  -device virtio-scsi-pci,id=3Dvirtio-scsi-pci0
  -device scsi-block,drive=3Ddrive0,bus=3Dvirtio-scsi-pci0.0

Stefan

--ytoMbUMiTKPMT3hY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJannzhAAoJEJykq7OBq3PI08gIAIO2P8aKYe3P9ufnieC7+AOq
wQeQR+euD+H1GxEBmBOgKcBTww5bdCB1DPrKeR4P5TW3ziO+mhy97cLQaOCyOIVe
4qiKfpIG7NnB1PWK1CDfOAx59zmAfXFfkK+yuyImw0pmYOl7OcJ+I/FNiictuGvr
Nz5gfroPQtynVCJPN7Q4l8TtEqpz+dj9HRKTipq4H/Z2rSV1gK0t86bcZ7QvleqI
5FDXVQXJ8oYiM1oq++jgeONxnKMbH6wB45JcyJdYFN18CubFSNRXQ2hkuePyupoS
WHOpSiyrwUQAhjcRdhLpnOUH5ss1NFUQPOjOihYZfIWinV5qGOorcwpDvvzYtng=
=o2uA
-----END PGP SIGNATURE-----

--ytoMbUMiTKPMT3hY--
