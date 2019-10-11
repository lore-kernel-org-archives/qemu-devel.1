Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14C94C4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 02:53:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9BC1214E0
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 02:53:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9BC1214E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45342 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIl3U-0001D1-Ls
	for qemu-devel@archiver.kernel.org; Thu, 10 Oct 2019 22:53:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40079)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jasowang@redhat.com>) id 1iIl27-0000bx-AA
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 22:52:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasowang@redhat.com>) id 1iIl22-0002hy-NQ
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 22:51:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54588)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1iIl22-0002c0-8b
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 22:51:54 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id EC2793090FEC;
 Fri, 11 Oct 2019 02:51:51 +0000 (UTC)
Received: from [10.72.12.183] (ovpn-12-183.pek2.redhat.com [10.72.12.183])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B1580600C4;
 Fri, 11 Oct 2019 02:51:43 +0000 (UTC)
Subject: Re: [RFC 2/2] virtio-net: use post load hook
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
References: <20191010180412.26236-1-mst@redhat.com>
 <20191010180412.26236-2-mst@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <79e812aa-644a-8545-ca6c-4a692b3451b4@redhat.com>
Date: Fri, 11 Oct 2019 10:51:42 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191010180412.26236-2-mst@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Fri, 11 Oct 2019 02:51:51 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: mikhail.sennikovskii@cloud.ionos.com, dgilbert@redhat.com,
 stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2019/10/11 =E4=B8=8A=E5=8D=882:04, Michael S. Tsirkin wrote:
> Currently offloads disabled by guest via the VIRTIO_NET_CTRL_GUEST_OFFL=
OADS_SET
> command are not preserved on VM migration.
> Instead all offloads reported by guest features (via VIRTIO_PCI_GUEST_F=
EATURES)
> get enabled.
> What happens is: first the VirtIONet::curr_guest_offloads gets restored
> and offloads are getting set correctly:
>
>   #0  qemu_set_offload (nc=3D0x555556a11400, csum=3D1, tso4=3D0, tso6=3D=
0, ecn=3D0, ufo=3D0) at net/net.c:474
>   #1  virtio_net_apply_guest_offloads (n=3D0x555557701ca0) at hw/net/vi=
rtio-net.c:720
>   #2  virtio_net_post_load_device (opaque=3D0x555557701ca0, version_id=3D=
11) at hw/net/virtio-net.c:2334
>   #3  vmstate_load_state (f=3D0x5555569dc010, vmsd=3D0x555556577c80 <vm=
state_virtio_net_device>, opaque=3D0x555557701ca0, version_id=3D11)
>       at migration/vmstate.c:168
>   #4  virtio_load (vdev=3D0x555557701ca0, f=3D0x5555569dc010, version_i=
d=3D11) at hw/virtio/virtio.c:2197
>   #5  virtio_device_get (f=3D0x5555569dc010, opaque=3D0x555557701ca0, s=
ize=3D0, field=3D0x55555668cd00 <__compound_literal.5>) at hw/virtio/virt=
io.c:2036
>   #6  vmstate_load_state (f=3D0x5555569dc010, vmsd=3D0x555556577ce0 <vm=
state_virtio_net>, opaque=3D0x555557701ca0, version_id=3D11) at migration=
/vmstate.c:143
>   #7  vmstate_load (f=3D0x5555569dc010, se=3D0x5555578189e0) at migrati=
on/savevm.c:829
>   #8  qemu_loadvm_section_start_full (f=3D0x5555569dc010, mis=3D0x55555=
69eee20) at migration/savevm.c:2211
>   #9  qemu_loadvm_state_main (f=3D0x5555569dc010, mis=3D0x5555569eee20)=
 at migration/savevm.c:2395
>   #10 qemu_loadvm_state (f=3D0x5555569dc010) at migration/savevm.c:2467
>   #11 process_incoming_migration_co (opaque=3D0x0) at migration/migrati=
on.c:449
>
> However later on the features are getting restored, and offloads get re=
set to
> everything supported by features:
>
>   #0  qemu_set_offload (nc=3D0x555556a11400, csum=3D1, tso4=3D1, tso6=3D=
1, ecn=3D0, ufo=3D0) at net/net.c:474
>   #1  virtio_net_apply_guest_offloads (n=3D0x555557701ca0) at hw/net/vi=
rtio-net.c:720
>   #2  virtio_net_set_features (vdev=3D0x555557701ca0, features=3D510444=
1767) at hw/net/virtio-net.c:773
>   #3  virtio_set_features_nocheck (vdev=3D0x555557701ca0, val=3D5104441=
767) at hw/virtio/virtio.c:2052
>   #4  virtio_load (vdev=3D0x555557701ca0, f=3D0x5555569dc010, version_i=
d=3D11) at hw/virtio/virtio.c:2220
>   #5  virtio_device_get (f=3D0x5555569dc010, opaque=3D0x555557701ca0, s=
ize=3D0, field=3D0x55555668cd00 <__compound_literal.5>) at hw/virtio/virt=
io.c:2036
>   #6  vmstate_load_state (f=3D0x5555569dc010, vmsd=3D0x555556577ce0 <vm=
state_virtio_net>, opaque=3D0x555557701ca0, version_id=3D11) at migration=
/vmstate.c:143
>   #7  vmstate_load (f=3D0x5555569dc010, se=3D0x5555578189e0) at migrati=
on/savevm.c:829
>   #8  qemu_loadvm_section_start_full (f=3D0x5555569dc010, mis=3D0x55555=
69eee20) at migration/savevm.c:2211
>   #9  qemu_loadvm_state_main (f=3D0x5555569dc010, mis=3D0x5555569eee20)=
 at migration/savevm.c:2395
>   #10 qemu_loadvm_state (f=3D0x5555569dc010) at migration/savevm.c:2467
>   #11 process_incoming_migration_co (opaque=3D0x0) at migration/migrati=
on.c:449
>
> Fix this by pushing out offload initialization to the new post load hoo=
k.
>
> Reported-by: Mikhail Sennikovsky <mikhail.sennikovskii@cloud.ionos.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>   hw/net/virtio-net.c | 14 ++++++++++----
>   1 file changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index 9f11422337..62fb858e2d 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -2333,10 +2333,6 @@ static int virtio_net_post_load_device(void *opa=
que, int version_id)
>           n->curr_guest_offloads =3D virtio_net_supported_guest_offload=
s(n);
>       }
>  =20
> -    if (peer_has_vnet_hdr(n)) {
> -        virtio_net_apply_guest_offloads(n);
> -    }
> -
>       virtio_net_set_queues(n);
>  =20
>       /* Find the first multicast entry in the saved MAC filter */
> @@ -2370,6 +2366,15 @@ static int virtio_net_post_load_device(void *opa=
que, int version_id)
>       return 0;
>   }
>  =20
> +static int virtio_net_post_load_virtio(VirtIODevice *vdev)
> +{
> +    if (peer_has_vnet_hdr(n)) {
> +        virtio_net_apply_guest_offloads(n);
> +    }
> +
> +    return 0;
> +}
> +
>   /* tx_waiting field of a VirtIONetQueue */
>   static const VMStateDescription vmstate_virtio_net_queue_tx_waiting =3D=
 {
>       .name =3D "virtio-net-queue-tx_waiting",
> @@ -2912,6 +2917,7 @@ static void virtio_net_class_init(ObjectClass *kl=
ass, void *data)
>       vdc->guest_notifier_mask =3D virtio_net_guest_notifier_mask;
>       vdc->guest_notifier_pending =3D virtio_net_guest_notifier_pending=
;
>       vdc->legacy_features |=3D (0x1 << VIRTIO_NET_F_GSO);
> +    vdc->post_load =3D virtio_net_post_load_virtio;
>       vdc->vmsd =3D &vmstate_virtio_net_device;
>   }
>  =20


Looks good to me.

Thanks


