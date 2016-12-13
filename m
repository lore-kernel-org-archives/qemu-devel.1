Received: from eggs.gnu.org ([2001:4830:134:3::10]:47851)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cGlsF-0006IY-00
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 07:07:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cGlsB-00069W-0Z
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 07:07:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47464)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cGlsA-00069N-S6
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 07:07:54 -0500
Message-ID: <1481630872.27088.128.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 13 Dec 2016 13:07:52 +0100
In-Reply-To: <alpine.LFD.2.20.1612131703450.6298@wniryva>
References: <20161213071439.32322-1-ppandit@redhat.com>
	<1481627861.27088.116.camel@redhat.com>
	<alpine.LFD.2.20.1612131703450.6298@wniryva>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] display: virtio-gpu-3d: check virgl
 capabilities max_size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: P J P <ppandit@redhat.com>
Cc: Qemu Developers <qemu-devel@nongnu.org>, Zhenhao Hong <zhenhaohong@gmail.com>

> | This is not the guest returning the size, it is the host renderer
> | library saying how much space it needs ...
>=20
>   The library funcion checks 'capset_id' supplied via the 'cmd' object, a=
s=20
> 'gc' is initialised from a given command 'cmd'. It sets 'max_size=3D0' if=
=20
> capset_id !=3D VREND_CAP_SET.

Ah, ok, that makes sense.

I guess we want throw an error (VIRTIO_GPU_RESP_ERR_INVALID_PARAMETER)
in the error case then instead of leaving resp->hdr.type unset.

cheers,
  Gerd
