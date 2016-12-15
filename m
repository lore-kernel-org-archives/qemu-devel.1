Received: from eggs.gnu.org ([2001:4830:134:3::10]:48710)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cHKY5-0004QV-5Q
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 20:09:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cHKY4-00033i-81
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 20:09:29 -0500
Received: from [45.249.212.187] (port=2499 helo=dggrg01-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cHKY3-0002yT-IZ
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 20:09:28 -0500
From: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Date: Thu, 15 Dec 2016 01:08:51 +0000
Message-ID: <33183CC9F5247A488A2544077AF19020DA16320F@DGGEMA505-MBX.china.huawei.com>
References: <1481716249-185392-1-git-send-email-arei.gonglei@huawei.com>
	<1481716249-185392-2-git-send-email-arei.gonglei@huawei.com>
	<bcf62fa0-8fc9-daaf-ea7b-e09eb83b593a@linux.vnet.ibm.com>
	<33183CC9F5247A488A2544077AF19020DA163033@DGGEMA505-MBX.china.huawei.com>
	<82063967A54EF84C8AFCD6BD7F6AD93310C14374@SHSMSX103.ccr.corp.intel.com>
In-Reply-To: <82063967A54EF84C8AFCD6BD7F6AD93310C14374@SHSMSX103.ccr.corp.intel.com>
Content-Language: zh-CN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v7 1/1] crypto: add virtio-crypto driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Zeng, Xin" <xin.zeng@intel.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>
Cc: "Huangweidong (C)" <weidong.huang@huawei.com>, Claudio Fontana <Claudio.Fontana@huawei.com>, "mst@redhat.com" <mst@redhat.com>, Luonengjun <luonengjun@huawei.com>, "Hanweidong (Randy)" <hanweidong@huawei.com>, "Xuquan (Quan Xu)" <xuquan8@huawei.com>, "Wanzongshun (Vincent)" <wanzongshun@huawei.com>, "stefanha@redhat.com" <stefanha@redhat.com>, "Zhoujian (jay, Euler)" <jianjay.zhou@huawei.com>, "cornelia.huck@de.ibm.com" <cornelia.huck@de.ibm.com>, longpeng <longpeng2@huawei.com>, "arei.gonglei@hotmail.com" <arei.gonglei@hotmail.com>, "davem@davemloft.net" <davem@davemloft.net>, "Wubin (H)" <wu.wubin@huawei.com>, "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>





Regards,
-Gonglei


> -----Original Message-----
> From: Zeng, Xin [mailto:xin.zeng@intel.com]
> Sent: Thursday, December 15, 2016 8:59 AM
> To: Gonglei (Arei); Halil Pasic; linux-kernel@vger.kernel.org;
> qemu-devel@nongnu.org; virtio-dev@lists.oasis-open.org;
> virtualization@lists.linux-foundation.org; linux-crypto@vger.kernel.org
> Cc: Huangweidong (C); Claudio Fontana; mst@redhat.com; Luonengjun;
> Hanweidong (Randy); Xuquan (Quan Xu); Wanzongshun (Vincent);
> stefanha@redhat.com; Zhoujian (jay, Euler); cornelia.huck@de.ibm.com;
> longpeng; arei.gonglei@hotmail.com; davem@davemloft.net; Wubin (H);
> herbert@gondor.apana.org.au
> Subject: RE: [Qemu-devel] [PATCH v7 1/1] crypto: add virtio-crypto driver
>=20
> On Thursday, December 15, 2016 8:45 AM, Gonglei (Arei) Wrote:
> < > > diff --git a/drivers/crypto/virtio/virtio_crypto_core.c
> < > b/drivers/crypto/virtio/virtio_crypto_core.c
> < > > new file mode 100644
> < > > index 0000000..c0854a1
> < > > --- /dev/null
> < > > +++ b/drivers/crypto/virtio/virtio_crypto_core.c
> < > > @@ -0,0 +1,474 @@
> < > [..]
> < > > +
> < > > +static void virtcrypto_dataq_callback(struct virtqueue *vq)
> < > > +{
> < > > +	struct virtio_crypto *vcrypto =3D vq->vdev->priv;
> < > > +	struct virtio_crypto_request *vc_req;
> < > > +	unsigned long flags;
> < > > +	unsigned int len;
> < > > +	struct ablkcipher_request *ablk_req;
> < > > +	int error;
> < > > +
> < > > +	spin_lock_irqsave(&vcrypto->lock, flags);
> < >
> < > Would it make sense to use a per virtqueue lock
> < > like in virtio_blk for example instead of locking on the whole
> < > device? OK, it seems you use only one dataqueue, so it
> < > may not be that relevant.
> < >
> < Currently yes, both the backend device (cryptodev-backend-builtin)
> < and the frontend driver use one dataqueue.
> <
>=20
> I think it makes sense to use per virtqueue lock here though it only uses=
 one
> queue so far,
> but in the spec we already have multi queues support.
>=20
Yes, I agree. Will do that in V8 soon.=20
Hope to catch up with Michael's pull request for 4.10.

Regards,
-Gonglei
