Received: from eggs.gnu.org ([2001:4830:134:3::10]:49300)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cOLbO-0007ZY-SX
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 04:41:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cOLbL-0001VU-QS
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 04:41:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48286)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cOLbL-0001VP-LH
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 04:41:51 -0500
Message-ID: <1483436504.24493.5.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 03 Jan 2017 10:41:44 +0100
In-Reply-To: <1767808401.7524716.1483023445359.JavaMail.zimbra@redhat.com>
References: <1483003721-65360-1-git-send-email-liq3ea@gmail.com>
	<1767808401.7524716.1483023445359.JavaMail.zimbra@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] virtio-gpu: fix memory leak in resource
 attach backing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?ISO-8859-1?Q?Marc-Andr=E9?= Lureau <mlureau@redhat.com>
Cc: Li Qiang <liq3ea@gmail.com>, marcandre lureau <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, liqiang6-s@360.cn

> > +    if (res->iov) {
> > +        cmd->error =3D VIRTIO_GPU_RESP_ERR_UNSPEC;
> > +        return;
> > +    }
> > +
>=20
> I think I would rather return an error in the library for this case.

-ENOLIBRARY ;)

This is the 2d mode code, so virglrenderer isn't involved at all.

Added patch to the queue (and the 3d one too).

thanks,
  Gerd
