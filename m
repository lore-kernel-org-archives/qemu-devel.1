Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36769C35280
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 02:58:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0013820731
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 02:58:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bCSjEvjh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0013820731
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41330 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWtDX-0006Jc-6D
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 22:58:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50782)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jWtCx-0005qS-IZ
 for qemu-devel@nongnu.org; Thu, 07 May 2020 22:57:51 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:33968
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jWtCw-00031L-Kw
 for qemu-devel@nongnu.org; Thu, 07 May 2020 22:57:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588906669;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=doTu5dYoS8ND08F1Nqnq9rPcJ5QJwC7fuuyIZsSrvL0=;
 b=bCSjEvjhzQdS1rF5X9cuFoDDfiUnwERt9PsVNQWLIi6s62h1UZBvj0o2117domsUf4UoCL
 TXVgQYXBy+5wocdputwyNv4xYZA8hSoZmdApa4mI4rJEdw+kcfp1hph0CoVPBo3HJ0ElQT
 q4/pVeNnbutJ1TNr6vWn4WY6vWiTVg8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-104-a_GrDiMvNQiU_Aa2y3NWaQ-1; Thu, 07 May 2020 22:57:48 -0400
X-MC-Unique: a_GrDiMvNQiU_Aa2y3NWaQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9AAB2461;
 Fri,  8 May 2020 02:57:46 +0000 (UTC)
Received: from [10.72.13.98] (ovpn-13-98.pek2.redhat.com [10.72.13.98])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 20E6F5C1BE;
 Fri,  8 May 2020 02:57:21 +0000 (UTC)
Subject: Re: [RFC v3 4/6] qmp: add QMP command x-debug-virtio-queue-status
To: Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org
References: <20200507114927.6733-1-lvivier@redhat.com>
 <20200507114927.6733-5-lvivier@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <126aefa1-ec80-4006-36c2-c1ce0a8306bd@redhat.com>
Date: Fri, 8 May 2020 10:57:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200507114927.6733-5-lvivier@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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
> This new command shows internal status of a VirtQueue.
> (vrings and indexes).
>
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>


It looks to me that packed virtqueue is not supported. It's better to=20
add them in the future.


> ---
>   hw/virtio/virtio-stub.c |  6 +++
>   hw/virtio/virtio.c      | 35 +++++++++++++++
>   qapi/virtio.json        | 98 +++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 139 insertions(+)
>
> diff --git a/hw/virtio/virtio-stub.c b/hw/virtio/virtio-stub.c
> index ddb592f72eee..3c1bf172acf6 100644
> --- a/hw/virtio/virtio-stub.c
> +++ b/hw/virtio/virtio-stub.c
> @@ -17,3 +17,9 @@ VirtioStatus *qmp_x_debug_virtio_status(const char* pat=
h, Error **errp)
>   {
>       return qmp_virtio_unsupported(errp);
>   }
> +
> +VirtQueueStatus *qmp_x_debug_virtio_queue_status(const char *path,
> +                                                 uint16_t queue, Error *=
*errp)
> +{
> +    return qmp_virtio_unsupported(errp);
> +}
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index 59bf6ef651a6..57552bf05014 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -3877,6 +3877,41 @@ static VirtIODevice *virtio_device_find(const char=
 *path)
>       return NULL;
>   }
>  =20
> +VirtQueueStatus *qmp_x_debug_virtio_queue_status(const char *path,
> +                                                 uint16_t queue, Error *=
*errp)
> +{
> +    VirtIODevice *vdev;
> +    VirtQueueStatus *status;
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
> +
> +    status =3D g_new0(VirtQueueStatus, 1);
> +    status->queue_index =3D vdev->vq[queue].queue_index;
> +    status->inuse =3D vdev->vq[queue].inuse;
> +    status->vring_num =3D vdev->vq[queue].vring.num;
> +    status->vring_num_default =3D vdev->vq[queue].vring.num_default;
> +    status->vring_align =3D vdev->vq[queue].vring.align;
> +    status->vring_desc =3D vdev->vq[queue].vring.desc;
> +    status->vring_avail =3D vdev->vq[queue].vring.avail;
> +    status->vring_used =3D vdev->vq[queue].vring.used;
> +    status->last_avail_idx =3D vdev->vq[queue].last_avail_idx;


This might not be correct when vhost is used.

We may consider to sync last_avail_idx from vhost backends here?

Thanks


> +    status->shadow_avail_idx =3D vdev->vq[queue].shadow_avail_idx;
> +    status->used_idx =3D vdev->vq[queue].used_idx;
> +    status->signalled_used =3D vdev->vq[queue].signalled_used;
> +    status->signalled_used_valid =3D vdev->vq[queue].signalled_used_vali=
d;
> +
> +    return status;
> +}
> +
>   #define CONVERT_FEATURES(type, map)                \
>       ({                                           \
>           type *list =3D NULL;                         \
> diff --git a/qapi/virtio.json b/qapi/virtio.json
> index 69dd107d0c9b..43c234a9fc69 100644
> --- a/qapi/virtio.json
> +++ b/qapi/virtio.json
> @@ -308,3 +308,101 @@
>     'data': { 'path': 'str' },
>     'returns': 'VirtioStatus'
>   }
> +
> +##
> +# @VirtQueueStatus:
> +#
> +# Status of a VirtQueue
> +#
> +# @queue-index: VirtQueue queue_index
> +#
> +# @inuse: VirtQueue inuse
> +#
> +# @vring-num: VirtQueue vring.num
> +#
> +# @vring-num-default: VirtQueue vring.num_default
> +#
> +# @vring-align: VirtQueue vring.align
> +#
> +# @vring-desc: VirtQueue vring.desc
> +#
> +# @vring-avail: VirtQueue vring.avail
> +#
> +# @vring-used: VirtQueue vring.used
> +#
> +# @last-avail-idx: VirtQueue last_avail_idx
> +#
> +# @shadow-avail-idx: VirtQueue shadow_avail_idx
> +#
> +# @used-idx: VirtQueue used_idx
> +#
> +# @signalled-used: VirtQueue signalled_used
> +#
> +# @signalled-used-valid: VirtQueue signalled_used_valid
> +#
> +# Since: 5.1
> +#
> +##
> +
> +{ 'struct': 'VirtQueueStatus',
> +  'data': {
> +    'queue-index': 'uint16',
> +    'inuse': 'uint32',
> +    'vring-num': 'int',
> +    'vring-num-default': 'int',
> +    'vring-align': 'int',
> +    'vring-desc': 'uint64',
> +    'vring-avail': 'uint64',
> +    'vring-used': 'uint64',
> +    'last-avail-idx': 'uint16',
> +    'shadow-avail-idx': 'uint16',
> +    'used-idx': 'uint16',
> +    'signalled-used': 'uint16',
> +    'signalled-used-valid': 'uint16'
> +  }
> +}
> +
> +##
> +# @x-debug-virtio-queue-status:
> +#
> +# Return the status of a given VirtQueue
> +#
> +# @path: QOBject path of the VirtIODevice
> +#
> +# @queue: queue number to examine
> +#
> +# Returns: Status of the VirtQueue
> +#
> +# Since: 5.1
> +#
> +# Example:
> +#
> +# -> { "execute": "x-debug-virtio-queue-status",
> +#      "arguments": {
> +#          "path": "/machine/peripheral-anon/device[3]/virtio-backend",
> +#          "queue": 0
> +#      }
> +#   }
> +# <- { "return": {
> +#      "signalled-used": 373,
> +#      "inuse": 0,
> +#      "vring-desc": 864411648,
> +#      "vring-num-default": 256,
> +#      "signalled-used-valid": 1,
> +#      "vring-avail": 864415744,
> +#      "last-avail-idx": 373,
> +#      "queue-index": 0,
> +#      "vring-used": 864416320,
> +#      "shadow-avail-idx": 619,
> +#      "used-idx": 373,
> +#      "vring-num": 256,
> +#      "vring-align": 4096
> +#      }
> +#    }
> +#
> +##
> +
> +{ 'command': 'x-debug-virtio-queue-status',
> +  'data': { 'path': 'str', 'queue': 'uint16' },
> +  'returns': 'VirtQueueStatus'
> +}


