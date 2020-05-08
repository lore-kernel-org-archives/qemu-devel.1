Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61539C35280
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 03:06:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2570C20746
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 03:06:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bRvGx5Vf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2570C20746
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45918 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWtKp-0000us-BH
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 23:05:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52252)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jWtJ9-0008VZ-34
 for qemu-devel@nongnu.org; Thu, 07 May 2020 23:04:15 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:44649
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jWtJ8-0005Xc-5k
 for qemu-devel@nongnu.org; Thu, 07 May 2020 23:04:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588907053;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GYZYpsQMf4a0OYsaG0GcbbgQxqIgSI8WLHoXeiPHa8U=;
 b=bRvGx5VfexT8WACBdFKhKrzZ0f65OW73eOG6GvlvP9iBOY/ZK24wdWSt6V6IJEb3V81IKw
 tkCG8lR89rtmhBYCtAe49KfoOGnp5HOoD/AluJg9idcZBMYquIM6c0q4VrPemJutZ7WJXK
 RJJIXQmXJMoSF79qVOEqdFYDO1urasM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-412-EmH0rb_nP-m5I4lknbZ1eQ-1; Thu, 07 May 2020 23:04:09 -0400
X-MC-Unique: EmH0rb_nP-m5I4lknbZ1eQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EFDEC8014D6;
 Fri,  8 May 2020 03:04:07 +0000 (UTC)
Received: from [10.72.13.98] (ovpn-13-98.pek2.redhat.com [10.72.13.98])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 40CA370545;
 Fri,  8 May 2020 03:03:42 +0000 (UTC)
Subject: Re: [RFC v3 5/6] qmp: add QMP command x-debug-virtio-queue-element
To: Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org
References: <20200507114927.6733-1-lvivier@redhat.com>
 <20200507114927.6733-6-lvivier@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <5964e564-4ab1-93d2-c41e-b961ae9054c4@redhat.com>
Date: Fri, 8 May 2020 11:03:41 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200507114927.6733-6-lvivier@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/07 22:21:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org,
 David Hildenbrand <david@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, Amit Shah <amit@kernel.org>,
 Max Reitz <mreitz@redhat.com>, Eric Auger <eric.auger@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/5/7 =E4=B8=8B=E5=8D=887:49, Laurent Vivier wrote:
> This new command shows the information of a VirtQueue element.
>
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> ---
>   hw/virtio/virtio-stub.c |   9 +++
>   hw/virtio/virtio.c      | 130 ++++++++++++++++++++++++++++++++++++++++
>   qapi/virtio.json        |  94 +++++++++++++++++++++++++++++
>   3 files changed, 233 insertions(+)
>
> diff --git a/hw/virtio/virtio-stub.c b/hw/virtio/virtio-stub.c
> index 3c1bf172acf6..8275e31430e7 100644
> --- a/hw/virtio/virtio-stub.c
> +++ b/hw/virtio/virtio-stub.c
> @@ -23,3 +23,12 @@ VirtQueueStatus *qmp_x_debug_virtio_queue_status(const=
 char *path,
>   {
>       return qmp_virtio_unsupported(errp);
>   }
> +
> +VirtioQueueElement *qmp_x_debug_virtio_queue_element(const char* path,
> +                                                     uint16_t queue,
> +                                                     bool has_index,
> +                                                     uint16_t index,
> +                                                     Error **errp)
> +{
> +    return qmp_virtio_unsupported(errp);
> +}
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index 57552bf05014..66dc2cef1b39 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -4033,6 +4033,136 @@ VirtioStatus *qmp_x_debug_virtio_status(const cha=
r* path, Error **errp)
>       return status;
>   }
>  =20
> +static VirtioRingDescFlagsList *qmp_decode_vring_desc_flags(uint16_t fla=
gs)
> +{
> +    VirtioRingDescFlagsList *list =3D NULL;
> +    VirtioRingDescFlagsList *node;
> +    int i;
> +    struct {
> +        uint16_t flag;
> +        VirtioRingDescFlags value;
> +    } map[] =3D {
> +        { VRING_DESC_F_NEXT, VIRTIO_RING_DESC_FLAGS_NEXT },
> +        { VRING_DESC_F_WRITE, VIRTIO_RING_DESC_FLAGS_WRITE },
> +        { VRING_DESC_F_INDIRECT, VIRTIO_RING_DESC_FLAGS_INDIRECT },
> +        { 1 << VRING_PACKED_DESC_F_AVAIL, VIRTIO_RING_DESC_FLAGS_AVAIL }=
,
> +        { 1 << VRING_PACKED_DESC_F_USED, VIRTIO_RING_DESC_FLAGS_USED },
> +        { 0, -1 }
> +    };
> +
> +    for (i =3D 0; map[i].flag; i++) {
> +        if ((map[i].flag & flags) =3D=3D 0) {
> +            continue;
> +        }
> +        node =3D g_malloc0(sizeof(VirtioRingDescFlagsList));
> +        node->value =3D map[i].value;
> +        node->next =3D list;
> +        list =3D node;
> +    }
> +
> +    return list;
> +}
> +
> +VirtioQueueElement *qmp_x_debug_virtio_queue_element(const char* path,
> +                                                     uint16_t queue,
> +                                                     bool has_index,
> +                                                     uint16_t index,
> +                                                     Error **errp)
> +{
> +    VirtIODevice *vdev;
> +    VirtQueue *vq;
> +    VirtioQueueElement *element =3D NULL;
> +
> +    vdev =3D virtio_device_find(path);
> +    if (vdev =3D=3D NULL) {
> +        error_setg(errp, "Path %s is not a VirtIO device", path);
> +        return NULL;
> +    }
> +
> +    if (queue >=3D VIRTIO_QUEUE_MAX || !virtio_queue_get_num(vdev, queue=
)) {
> +        error_setg(errp, "Invalid virtqueue number %d", queue);
> +        return NULL;
> +    }
> +    vq =3D &vdev->vq[queue];
> +
> +    if (virtio_vdev_has_feature(vdev, VIRTIO_F_RING_PACKED)) {
> +        error_setg(errp, "Packed ring not supported");
> +        return NULL;
> +    } else {
> +        unsigned int head, i, max;
> +        VRingMemoryRegionCaches *caches;
> +        MemoryRegionCache indirect_desc_cache =3D MEMORY_REGION_CACHE_IN=
VALID;
> +        MemoryRegionCache *desc_cache;
> +        VRingDesc desc;
> +        VirtioRingDescList *list =3D NULL;
> +        VirtioRingDescList *node;
> +        int rc;
> +
> +        RCU_READ_LOCK_GUARD();
> +
> +        max =3D vq->vring.num;
> +
> +        if (!has_index) {
> +            head =3D vring_avail_ring(vq, vq->last_avail_idx % vq->vring=
.num);
> +        } else {
> +            head =3D vring_avail_ring(vq, index % vq->vring.num);
> +        }
> +        i =3D head;
> +
> +        caches =3D vring_get_region_caches(vq);
> +        if (!caches) {
> +            error_setg(errp, "Region caches not initialized");
> +            return NULL;
> +        }
> +
> +        if (caches->desc.len < max * sizeof(VRingDesc)) {
> +            error_setg(errp, "Cannot map descriptor ring");
> +            return NULL;
> +        }
> +
> +        desc_cache =3D &caches->desc;
> +        vring_split_desc_read(vdev, &desc, desc_cache, i);
> +        if (desc.flags & VRING_DESC_F_INDIRECT) {
> +            int64_t len;
> +
> +            len =3D address_space_cache_init(&indirect_desc_cache, vdev-=
>dma_as,
> +                                           desc.addr, desc.len, false);
> +            desc_cache =3D &indirect_desc_cache;
> +            if (len < desc.len) {
> +                error_setg(errp, "Cannot map indirect buffer");
> +                goto done;
> +            }
> +            i =3D 0;
> +            vring_split_desc_read(vdev, &desc, desc_cache, i);
> +        }
> +
> +        element =3D g_new0(VirtioQueueElement, 1);
> +        element->index =3D head;
> +        element->ndescs =3D 0;
> +
> +        do {
> +            node =3D g_new0(VirtioRingDescList, 1);
> +            node->value =3D g_new0(VirtioRingDesc, 1);
> +            node->value->addr =3D desc.addr;
> +            node->value->len =3D desc.len;
> +            node->value->flags =3D qmp_decode_vring_desc_flags(desc.flag=
s);
> +            node->next =3D list;
> +            list =3D node;
> +
> +            element->ndescs++;
> +
> +            rc =3D virtqueue_split_read_next_desc(vdev, &desc, desc_cach=
e,
> +                                                max, &i);
> +        } while (rc =3D=3D VIRTQUEUE_READ_DESC_MORE);


It's better to limit the maximum number of iterations here to e.g=20
vring.num. A buggy driver may produce a infinite loop here.

Thanks


> +
> +        element->descs =3D list;
> +done:
> +        address_space_cache_destroy(&indirect_desc_cache);
> +    }
> +
> +    return element;
> +}
> +
>   static const TypeInfo virtio_device_info =3D {
>       .name =3D TYPE_VIRTIO_DEVICE,
>       .parent =3D TYPE_DEVICE,
> diff --git a/qapi/virtio.json b/qapi/virtio.json
> index 43c234a9fc69..a55103dca780 100644
> --- a/qapi/virtio.json
> +++ b/qapi/virtio.json
> @@ -406,3 +406,97 @@
>     'data': { 'path': 'str', 'queue': 'uint16' },
>     'returns': 'VirtQueueStatus'
>   }
> +
> +##
> +# @VirtioRingDescFlags:
> +#
> +# An enumeration of the virtio ring descriptor flags
> +#
> +# Since: 5.1
> +#
> +##
> +
> +{ 'enum': 'VirtioRingDescFlags',
> +  'data': [ 'next', 'write', 'indirect', 'avail', 'used' ]
> +}
> +
> +##
> +# @VirtioRingDesc:
> +#
> +# @addr: guest physical address of the descriptor data
> +#
> +# @len: length of the descriptor data
> +#
> +# @flags: descriptor flags
> +#
> +# Since: 5.1
> +#
> +##
> +
> +{ 'struct': 'VirtioRingDesc',
> +  'data': {
> +    'addr': 'uint64',
> +    'len': 'uint32',
> +    'flags': [ 'VirtioRingDescFlags' ]
> +  }
> +}
> +
> +##
> +# @VirtioQueueElement:
> +#
> +# @index: index of the element in the queue
> +#
> +# @ndescs: number of descriptors
> +#
> +# @descs: list of the descriptors
> +#
> +# Since: 5.1
> +#
> +##
> +
> +{ 'struct': 'VirtioQueueElement',
> +  'data': {
> +    'index': 'uint32',
> +    'ndescs': 'uint32',
> +    'descs': ['VirtioRingDesc']
> +  }
> +}
> +
> +##
> +# @x-debug-virtio-queue-element:
> +#
> +# Return the information about an element queue (by default head)
> +#
> +# @path: QOBject path of the VirtIODevice
> +#
> +# @queue: queue number to examine
> +#
> +# @index: the index in the queue, by default head
> +#
> +# Returns: the element information
> +#
> +# Since: 5.1
> +#
> +# Example:
> +#
> +# -> { "execute": "x-debug-virtio-queue-element",
> +#      "arguments": {
> +#          "path": "/machine/peripheral-anon/device[3]/virtio-backend",
> +#          "queue": 0
> +#      }
> +#   }
> +# -> { "return": {
> +#         "index": 24,
> +#         "ndescs": 1,
> +#         "descs": [
> +#             { "flags": ["write"], "len": 1536, "addr": 2027557376 }
> +#         ]
> +#      }
> +#   }
> +#
> +##
> +
> +{ 'command': 'x-debug-virtio-queue-element',
> +  'data': { 'path': 'str', 'queue': 'uint16', '*index': 'uint16' },
> +  'returns': 'VirtioQueueElement'
> +}


