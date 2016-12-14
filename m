Received: from eggs.gnu.org ([2001:4830:134:3::10]:39570)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1cH3b3-0004RE-K3
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 02:03:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1cH3az-0003nb-LK
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 02:03:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54102)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1cH3az-0003nW-GJ
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 02:03:21 -0500
Date: Wed, 14 Dec 2016 12:33:15 +0530 (IST)
From: P J P <ppandit@redhat.com>
In-Reply-To: <CAJ+F1CLUhToO9jNsx3V88h6aVmswdJE3Z8KtM2j75OVdqy6gHg@mail.gmail.com>
Message-ID: <alpine.LFD.2.20.1612141232080.22765@wniryva>
References: <20161213071439.32322-1-ppandit@redhat.com>
	<1481627861.27088.116.camel@redhat.com>
	<alpine.LFD.2.20.1612131703450.6298@wniryva>
	<1481630872.27088.128.camel@redhat.com>
	<alpine.LFD.2.20.1612131946260.6601@wniryva>
	<CAJ+F1CLUhToO9jNsx3V88h6aVmswdJE3Z8KtM2j75OVdqy6gHg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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
To: =?ISO-8859-15?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@gmail.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, Zhenhao Hong <zhenhaohong@gmail.com>, Qemu Developers <qemu-devel@nongnu.org>

+-- On Tue, 13 Dec 2016, Marc-Andr=C3=A9 Lureau wrote --+
| > -    resp =3D g_malloc(sizeof(*resp) + max_size);
| > +    if (!max_size) {
| > +        cmd->error =3D VIRTIO_GPU_RESP_ERR_INVALID_PARAMETER;
| > +        return;
| > +    }
| >
| > +    resp =3D g_malloc(sizeof(*resp) + max_size);
| >      resp->hdr.type =3D VIRTIO_GPU_RESP_OK_CAPSET;
|
| That looks good to me, waiting for the proper patch.

Okay, sent. Thank you.
--
Prasad J Pandit / Red Hat Product Security Team
47AF CE69 3A90 54AA 9045 1053 DD13 3D32 FE5B 041F
