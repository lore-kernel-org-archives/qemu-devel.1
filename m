Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 430CEC76188
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 09:14:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CB4C21743
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 09:14:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CB4C21743
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46682 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnJXD-0004LI-8a
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 05:14:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52287)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mst@redhat.com>) id 1hnJX3-0003uT-9g
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 05:13:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1hnJX2-0005h9-AR
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 05:13:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53384)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>)
 id 1hnJX2-0005ge-3P; Tue, 16 Jul 2019 05:13:56 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 66FFB308A9E2;
 Tue, 16 Jul 2019 09:13:55 +0000 (UTC)
Received: from redhat.com (ovpn-120-234.rdu2.redhat.com [10.10.120.234])
 by smtp.corp.redhat.com (Postfix) with SMTP id 9C98619C59;
 Tue, 16 Jul 2019 09:13:53 +0000 (UTC)
Date: Tue, 16 Jul 2019 05:13:52 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Anton Kuchin <antonkuchin@yandex-team.ru>
Message-ID: <20190716051345-mutt-send-email-mst@kernel.org>
References: <20190716090839.19708-1-antonkuchin@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190716090839.19708-1-antonkuchin@yandex-team.ru>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Tue, 16 Jul 2019 09:13:55 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] virtio-net: remove redundant qdev from
 VirtIONet
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
Cc: qemu-trivial@nongnu.org, Jason Wang <jasowang@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jul 16, 2019 at 12:08:39PM +0300, Anton Kuchin wrote:
> Signed-off-by: Anton Kuchin <antonkuchin@yandex-team.ru>

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  hw/net/virtio-net.c            | 3 +--
>  include/hw/virtio/virtio-net.h | 1 -
>  2 files changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index b9e1cd71cf..16d2ad5927 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -387,7 +387,7 @@ static void rxfilter_notify(NetClientState *nc)
>      VirtIONet *n = qemu_get_nic_opaque(nc);
>  
>      if (nc->rxfilter_notify_enabled) {
> -        gchar *path = object_get_canonical_path(OBJECT(n->qdev));
> +        gchar *path = object_get_canonical_path(OBJECT(n));
>          qapi_event_send_nic_rx_filter_changed(!!n->netclient_name,
>                                                n->netclient_name, path);
>          g_free(path);
> @@ -2759,7 +2759,6 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
>      nc->rxfilter_notify_enabled = 1;
>  
>      QTAILQ_INIT(&n->rsc_chains);
> -    n->qdev = dev;
>  }
>  
>  static void virtio_net_device_unrealize(DeviceState *dev, Error **errp)
> diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-net.h
> index b96f0c643f..4a1b599d48 100644
> --- a/include/hw/virtio/virtio-net.h
> +++ b/include/hw/virtio/virtio-net.h
> @@ -174,7 +174,6 @@ struct VirtIONet {
>      uint32_t *vlans;
>      virtio_net_conf net_conf;
>      NICConf nic_conf;
> -    DeviceState *qdev;
>      int multiqueue;
>      uint16_t max_queues;
>      uint16_t curr_queues;
> -- 
> 2.20.1

