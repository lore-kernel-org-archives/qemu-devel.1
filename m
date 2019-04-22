Return-Path: <SRS0=5Zkg=SY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69EFAC10F14
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2019 03:02:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 353D120833
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2019 03:02:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 353D120833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59819 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hIPE3-0002sy-4a
	for qemu-devel@archiver.kernel.org; Sun, 21 Apr 2019 23:02:35 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56280)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1hIPD9-0002Ws-VU
	for qemu-devel@nongnu.org; Sun, 21 Apr 2019 23:01:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1hIP2G-0007nI-Do
	for qemu-devel@nongnu.org; Sun, 21 Apr 2019 22:50:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53898)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>)
	id 1hIP2G-0007ja-5t; Sun, 21 Apr 2019 22:50:24 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6F87D3DE0B;
	Mon, 22 Apr 2019 02:50:21 +0000 (UTC)
Received: from [10.72.12.161] (ovpn-12-161.pek2.redhat.com [10.72.12.161])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 9C75A5C28D;
	Mon, 22 Apr 2019 02:50:16 +0000 (UTC)
To: Dan Streetman <dan.streetman@canonical.com>,
	"Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
	qemu-stable@nongnu.org
References: <20190416184624.15397-1-dan.streetman@canonical.com>
	<20190416184624.15397-2-dan.streetman@canonical.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <9f3dac2a-15fe-8463-6aee-f6916b8d5e1c@redhat.com>
Date: Mon, 22 Apr 2019 10:50:15 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190416184624.15397-2-dan.streetman@canonical.com>
Content-Type: text/plain; charset="UTF-8"; format="flowed"
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.29]);
	Mon, 22 Apr 2019 02:50:21 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 1/2] add VirtIONet vhost_stopped flag to
 prevent multiple stops
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190422025015.hp-MCVsOCN8tCOBFe5nMJyZn75kiC2IqWZlZWWObfYw@z>


On 2019/4/17 =E4=B8=8A=E5=8D=882:46, Dan Streetman wrote:
> From: Dan Streetman <ddstreet@canonical.com>
>
> Buglink: https://launchpad.net/bugs/1823458
>
> There is a race condition when using the vhost-user driver, between a g=
uest
> shutdown and the vhost-user interface being closed.  This is explained =
in
> more detail at the bug link above; the short explanation is the vhost-u=
ser
> device can be closed while the main thread is in the middle of stopping
> the vhost_net.  In this case, the main thread handling shutdown will
> enter virtio_net_vhost_status() and move into the n->vhost_started (els=
e)
> block, and call vhost_net_stop(); while it is running that function,
> another thread is notified that the vhost-user device has been closed,
> and (indirectly) calls into virtio_net_vhost_status() also.


I think we need figure out why there are multiple vhost_net_stop() calls=20
simultaneously. E.g vhost-user register fd handlers like:

 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_chr_fe_set_handlers(&s->=
chr, NULL, NULL,
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net_vhost_user_event, NULL,=
 nc0->name,=20
NULL,
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 true);

which uses default main context, so it should only be called only in=20
main thread.

Thanks


>   Since the
> vhost_net status hasn't yet changed, the second thread also enters
> the n->vhost_started block, and also calls vhost_net_stop().  This
> causes problems for the second thread when it tries to stop the network
> that's already been stopped.
>
> This adds a flag to the struct that's atomically set to prevent more th=
an
> one thread from calling vhost_net_stop().  The atomic_fetch_inc() is li=
kely
> overkill and probably could be done with a simple check-and-set, but
> since it's a race condition there would still be a (very, very) small
> window without using an atomic to set it.
>
> Signed-off-by: Dan Streetman <ddstreet@canonical.com>
> ---
>   hw/net/virtio-net.c            | 3 ++-
>   include/hw/virtio/virtio-net.h | 1 +
>   2 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index ffe0872fff..d36f50d5dd 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -13,6 +13,7 @@
>  =20
>   #include "qemu/osdep.h"
>   #include "qemu/iov.h"
> +#include "qemu/atomic.h"
>   #include "hw/virtio/virtio.h"
>   #include "net/net.h"
>   #include "net/checksum.h"
> @@ -240,7 +241,7 @@ static void virtio_net_vhost_status(VirtIONet *n, u=
int8_t status)
>                            "falling back on userspace virtio", -r);
>               n->vhost_started =3D 0;
>           }
> -    } else {
> +    } else if (atomic_fetch_inc(&n->vhost_stopped) =3D=3D 0) {
>           vhost_net_stop(vdev, n->nic->ncs, queues);
>           n->vhost_started =3D 0;
>       }
> diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-=
net.h
> index b96f0c643f..d03fd933d0 100644
> --- a/include/hw/virtio/virtio-net.h
> +++ b/include/hw/virtio/virtio-net.h
> @@ -164,6 +164,7 @@ struct VirtIONet {
>       uint8_t nouni;
>       uint8_t nobcast;
>       uint8_t vhost_started;
> +    int vhost_stopped;
>       struct {
>           uint32_t in_use;
>           uint32_t first_multi;

