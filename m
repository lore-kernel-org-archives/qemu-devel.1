Return-Path: <SRS0=3XOk=S2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ABA4C10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 12:18:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 104FB21773
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 12:17:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 104FB21773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40776 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJGqc-0005kZ-BO
	for qemu-devel@archiver.kernel.org; Wed, 24 Apr 2019 08:17:58 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37107)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1hJGmk-0002ls-W4
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 08:14:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1hJGY4-0004p1-Ni
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 07:58:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47418)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1hJGY4-0004n8-Fj
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 07:58:48 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7014C307028B;
	Wed, 24 Apr 2019 11:58:47 +0000 (UTC)
Received: from [10.72.12.170] (ovpn-12-170.pek2.redhat.com [10.72.12.170])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E9FEB60C64;
	Wed, 24 Apr 2019 11:58:43 +0000 (UTC)
To: mst@redhat.com, qemu-devel@nongnu.org
References: <20190409055850.25797-1-jasowang@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <c2bf2ef7-36ab-723f-b245-055d22f68978@redhat.com>
Date: Wed, 24 Apr 2019 19:58:42 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190409055850.25797-1-jasowang@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format="flowed"
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.44]);
	Wed, 24 Apr 2019 11:58:47 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH V3] vhost_net: don't set backend for the
 uninitialized virtqueue
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: yuri.benditovich@daynix.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190424115842.RBzME6IF_bhakkCsYeFS72V1fscBxVE-1XuuufebRFU@z>


On 2019/4/9 =E4=B8=8B=E5=8D=881:58, Jason Wang wrote:
> We used to set backend unconditionally, this won't work for some
> guests (e.g windows driver) who may not initialize all virtqueues. For
> kernel backend, this will fail since it may try to validate the rings
> during setting backend.
>
> Fixing this by simply skipping the backend set when we find desc is
> not ready.
>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
> Changes from V1:
> - introduce a generic helper to check if a virtqueue is enabled
> ---


Michael, does this look good to you?

Thanks


>   hw/net/vhost_net.c         | 10 ++++++++++
>   hw/virtio/virtio.c         |  5 +++++
>   include/hw/virtio/virtio.h |  1 +
>   3 files changed, 16 insertions(+)
>
> diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
> index be3cc88370..a6b719035c 100644
> --- a/hw/net/vhost_net.c
> +++ b/hw/net/vhost_net.c
> @@ -244,6 +244,11 @@ static int vhost_net_start_one(struct vhost_net *n=
et,
>           qemu_set_fd_handler(net->backend, NULL, NULL, NULL);
>           file.fd =3D net->backend;
>           for (file.index =3D 0; file.index < net->dev.nvqs; ++file.ind=
ex) {
> +            if (!virtio_queue_enabled(dev, net->dev.vq_index +
> +                                      file.index)) {
> +                /* Queue might not be ready for start */
> +                continue;
> +            }
>               r =3D vhost_net_set_backend(&net->dev, &file);
>               if (r < 0) {
>                   r =3D -errno;
> @@ -256,6 +261,11 @@ fail:
>       file.fd =3D -1;
>       if (net->nc->info->type =3D=3D NET_CLIENT_DRIVER_TAP) {
>           while (file.index-- > 0) {
> +            if (!virtio_queue_enabled(dev, net->dev.vq_index +
> +                                      file.index)) {
> +                /* Queue might not be ready for start */
> +                continue;
> +            }
>               int r =3D vhost_net_set_backend(&net->dev, &file);
>               assert(r >=3D 0);
>           }
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index 2626a895cb..28056a7ef7 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -2318,6 +2318,11 @@ hwaddr virtio_queue_get_desc_addr(VirtIODevice *=
vdev, int n)
>       return vdev->vq[n].vring.desc;
>   }
>  =20
> +bool virtio_queue_enabled(VirtIODevice *vdev, int n)
> +{
> +    return virtio_queue_get_desc_addr(vdev, n) !=3D 0;
> +}
> +
>   hwaddr virtio_queue_get_avail_addr(VirtIODevice *vdev, int n)
>   {
>       return vdev->vq[n].vring.avail;
> diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
> index ce9516236a..7140381e3a 100644
> --- a/include/hw/virtio/virtio.h
> +++ b/include/hw/virtio/virtio.h
> @@ -282,6 +282,7 @@ typedef struct VirtIORNGConf VirtIORNGConf;
>                         VIRTIO_F_IOMMU_PLATFORM, false)
>  =20
>   hwaddr virtio_queue_get_desc_addr(VirtIODevice *vdev, int n);
> +bool virtio_queue_enabled(VirtIODevice *vdev, int n);
>   hwaddr virtio_queue_get_avail_addr(VirtIODevice *vdev, int n);
>   hwaddr virtio_queue_get_used_addr(VirtIODevice *vdev, int n);
>   hwaddr virtio_queue_get_desc_size(VirtIODevice *vdev, int n);

