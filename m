Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 159B1C3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 08:52:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0F8F22D6D
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 08:52:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0F8F22D6D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45516 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0MLi-00082y-SD
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 04:52:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56943)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1i0MKJ-0006gX-1Q
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 04:50:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1i0MKI-0001P5-2Z
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 04:50:42 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:53445)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1i0MKB-0001M4-Il; Wed, 21 Aug 2019 04:50:35 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue011 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1M4alK-1hzo5h1FJu-001k9C; Wed, 21 Aug 2019 10:50:31 +0200
To: Anton Kuchin <antonkuchin@yandex-team.ru>, qemu-devel@nongnu.org
References: <20190716090839.19708-1-antonkuchin@yandex-team.ru>
From: Laurent Vivier <laurent@vivier.eu>
Openpgp: preference=signencrypt
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <f8bd0053-c19d-b92b-be05-f58c7de72f4d@vivier.eu>
Date: Wed, 21 Aug 2019 10:50:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190716090839.19708-1-antonkuchin@yandex-team.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:6xu2yOiuB1NjvYXb/Yu74dkwe7ewD1uY+nQ2xiiOZf6qYoGC125
 7l4+pY0q3CgHQtKAbqFZhhBWHq6qPiXU8FK0g4UkI18kVRYeOrRWUQJ7iXcjq/xN2qKvxDK
 0cqyX7wZ22CDZA2GFikMAXVy1O2qfTz+FGQxyaDWz+elpSRNsS6Nrd1egFdcHfMIQP3kmqt
 0CL6domwFiH971y+XWBTQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:lEjroSYHwBc=:1SAzX6alBehrluGZD14jPl
 09bKxXI5jSDt2B7xCWoeSmb/IxbWwGpNL5mJwDbiP0xP5GmFEakAet5NEwSA82PF9uD/5GjzZ
 JLldAFeLxST2VzL5GW8VNnE8+M9MO5YoL+U6yAwUvcaVetUWqDLwtVWkmYf36WkMpQTBrjIwk
 M4WLrZIJBXQmSQpZHkQ/KtoaVa9KkdHeQxtusnTHHB+BTp7t1xRa2FQVcdJjJw3GE+CpCIlfW
 B5bnaJrmIf3f65Ik45R1cVtd5PchclcyxGm2DS5EtV7H2PREomiwDyQQZB1lavxVIdXP/57yc
 C4yQcbt3S7wQOO5YBfzb/QdZ8/4xB0XHFvJwMNsqXQi2QwXwR2e86KYOaokuE9uabcrCYxFnE
 I5wcKVwQOmQnz2PQF17S1aICxrSAq3IqyjokKhcfqZkCk884bTKcv33BhXQP1LGcdQryFSNZo
 3uNOSy1+l29VHiGJraYgd14sOmVPl8Zk4Kh79pLAmAYy7TA5sAiXbkT567aubSXesxrWkXdkp
 RgGlatkHDeQSp2RCHuP9kpjdKw2AcaPcmtiUUncu6RDy3QsdmtxlIk5rhGi8CKs+I/pFpyBEe
 /FVJDFVUL0SiT94cRkJFhCKvu/x5dsGzkuxYk0ShWBjvcSkU/UcVCGVV+rJeYaKbfjdLXxH6x
 JFYX5swZpvY8YNyoQoNz6i4uJaN7qUQtBJHu32XB7RQaPxnoap/yaaR9HHx18ADicZB+PUZPq
 S3WWJCdT62/HsjBJuXmGbFpbDVTFdueijPS87B/6qjxH05bDWQWeikCP364=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.133
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH] virtio-net: remove
 redundant qdev from VirtIONet
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
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Could you add a commit message describing why we can remove the qdev field?

Thanks,
Laurent

Le 16/07/2019 à 11:08, Anton Kuchin a écrit :
> Signed-off-by: Anton Kuchin <antonkuchin@yandex-team.ru>
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
> 


