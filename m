Received: from eggs.gnu.org ([209.51.188.92]:55771)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1ghXhY-0005nV-Sp
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 05:36:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1ghXhY-0002HV-36
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 05:36:40 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:39769)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1ghXhX-0002Gf-Sq
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 05:36:40 -0500
Received: by mail-wr1-x434.google.com with SMTP id t27so10757112wra.6
	for <qemu-devel@nongnu.org>; Thu, 10 Jan 2019 02:36:39 -0800 (PST)
Date: Thu, 10 Jan 2019 10:36:37 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20190110103636.GG19025@stefanha-x1.localdomain>
References: <20190110083753.GA31730@yangzhon-Virtual>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DNUSDXU7R7AVVM8C"
Content-Disposition: inline
In-Reply-To: <20190110083753.GA31730@yangzhon-Virtual>
Subject: Re: [Qemu-devel] If Qemu support NVMe over Fabrics ?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yang Zhong <yang.zhong@intel.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, fam@euphon.net, pbonzini@redhat.com, keith.busch@intel.com


--DNUSDXU7R7AVVM8C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 10, 2019 at 04:37:53PM +0800, Yang Zhong wrote:
> Do you know if Qemu support NVMe over Fabrics(NVMe-oF)?
> https://nvmexpress.org/wp-content/uploads/NVMe_Over_Fabrics.pdf
>=20
> The Qemu has enabled RDMA in last year, and i am not sure if Qemu=20
> should support NVME-oF. If Qemu support it, would you please share
> me the qemu related command or guides? thanks a lot!

QEMU supports many different storage configurations.  Can you be more
specific?

For example, if your host has NVMe-oF set up then you can give the NVMe
block devices to QEMU just like any other host block device (-drive
file=3D/dev/sdc,...).

But maybe you are thinking about other configurations, like exposing
NVMe-oF to the guest?

Stefan

--DNUSDXU7R7AVVM8C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcNyA0AAoJEJykq7OBq3PIMdQH/3qeicsf5+cMsVFCaVJ/ra20
/NYnten/I9Y5AVv8oxH3RLGioc6yyNLvf3PHr8Oy/IP6gRBptb0nvG5CrZPAvH1k
42UEAi7CTMinwxfnLYZK9Q/e9fSi9YJiDqjGB4xGLG9YuvAQ9EVB1gYhbcIVTu8M
z8GMwI/uhrkB3Wi2cuzQrn1BNHJ2dah1bKhlRXx9Fa3ioN3WJLCvD4Beog/LutEP
zn4L+8iTnU4HLLqcO8tk+qUtRgeuGb4aWEuoGkfn9uskG9Lgulqh4imJSGhK8P9R
AG7pE3T56UM9j7TlZUiHvfGR+lA+wFU/BVLzGlnXdtJmrPW6eZSoShC8TP+tNs8=
=VJce
-----END PGP SIGNATURE-----

--DNUSDXU7R7AVVM8C--
