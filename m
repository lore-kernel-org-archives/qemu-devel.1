Received: from eggs.gnu.org ([209.51.188.92]:54637)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hLsHJ-0005VL-Lc
	for qemu-devel@nongnu.org; Wed, 01 May 2019 12:40:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hLsHF-0005xE-Rk
	for qemu-devel@nongnu.org; Wed, 01 May 2019 12:40:17 -0400
Received: from mail-io1-xd31.google.com ([2607:f8b0:4864:20::d31]:41748)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1hLsHD-0005ip-Qt
	for qemu-devel@nongnu.org; Wed, 01 May 2019 12:40:13 -0400
Received: by mail-io1-xd31.google.com with SMTP id r10so15267436ioc.8
	for <qemu-devel@nongnu.org>; Wed, 01 May 2019 09:40:09 -0700 (PDT)
Date: Wed, 1 May 2019 12:40:06 -0400
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20190501164006.GH21155@stefanha-x1.localdomain>
References: <1556608500-12183-1-git-send-email-wangjie88@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="bpVaumkpfGNUagdU"
Content-Disposition: inline
In-Reply-To: <1556608500-12183-1-git-send-email-wangjie88@huawei.com>
Subject: Re: [Qemu-devel] [PATCH] vhost: fix memory leak in
 vhost_user_scsi_realize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jie Wang <wangjie88@huawei.com>
Cc: qemu-devel@nongnu.org, wu.wubin@huawei.com, mst@redhat.com


--bpVaumkpfGNUagdU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 30, 2019 at 03:15:00PM +0800, Jie Wang wrote:
> fix memory leak in vhost_user_scsi_realize
>=20
> Signed-off-by: Jie Wang <wangjie88@huawei.com>
> ---
>  hw/scsi/vhost-user-scsi.c | 3 +++
>  1 file changed, 3 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--bpVaumkpfGNUagdU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAlzJy+YACgkQnKSrs4Gr
c8jdTAf/XASDBhfsUuQ2Eg2K16EIYqccv1L6AWfV9aAIzlXP7wOdQmqpad1Fwq0u
gXJ5Hs64+dJfJt14pGPVoK1Jkics7ll1lykjrVuOR5kD2+3j7YadbTvbHa5T52a+
s+RcW3xtb2KwAugoaBPH3+GS8/aaYGfgkRxAVWh150bpmFVcI19Rc8f9ZxlNqiBZ
gIPB8kwbg0gDYj54nF6AV+iD49ifYuEWYtDEKIJXbJTtUWJigZqkxKM+qGKxhLn4
4aydVzUWLJJ2W3O2sS5HUBKHVXcAcnbFCRD0dvW2W5leTfRM0aVQ2ce4zcq3i7DF
VYThl2NMVK7l5QbVXupoLB3OyUESGg==
=I4BG
-----END PGP SIGNATURE-----

--bpVaumkpfGNUagdU--
