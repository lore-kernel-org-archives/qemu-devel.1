Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDA68C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 03:33:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9018207F9
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 03:33:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GvpYP/Ps"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9018207F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33460 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jaWWT-00027H-Ts
	for qemu-devel@archiver.kernel.org; Sun, 17 May 2020 23:33:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38172)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jaWVj-0001Kl-UD
 for qemu-devel@nongnu.org; Sun, 17 May 2020 23:32:18 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:32165
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jaWVe-0006P7-0N
 for qemu-devel@nongnu.org; Sun, 17 May 2020 23:32:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589772728;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CHEwL4KjGGHTbXgRzf/nVvxNc9TYMqLOuh0bVgbAQMk=;
 b=GvpYP/PsRgFcQCSRHS4aYRyWh0lrj5HuMkfQ3D9+E9eM8iMJXMRiAbXnySuIZzwoXNPawl
 L56iPAcg8hSmG808gTR0wCGPJ83nWVFkC3y9PswipdsPMf9gPtO0SB5O+lxN+/9pqtSsXD
 Gp5P+irnIDV5SolbqpcZNkKOp3VIj6s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-310-zGmUn736P72UM9693Ey70A-1; Sun, 17 May 2020 23:32:06 -0400
X-MC-Unique: zGmUn736P72UM9693Ey70A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EF0A01005512;
 Mon, 18 May 2020 03:32:04 +0000 (UTC)
Received: from [10.72.13.232] (ovpn-13-232.pek2.redhat.com [10.72.13.232])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8C3045C1B2;
 Mon, 18 May 2020 03:31:41 +0000 (UTC)
Subject: Re: [RFC v3 4/6] qmp: add QMP command x-debug-virtio-queue-status
To: Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org
References: <20200507114927.6733-1-lvivier@redhat.com>
 <20200507114927.6733-5-lvivier@redhat.com>
 <126aefa1-ec80-4006-36c2-c1ce0a8306bd@redhat.com>
 <e9a92c29-162f-e2eb-0a6c-c1e08e99ffa7@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <f16d440f-bb1a-5564-c9ba-44e933e19560@redhat.com>
Date: Mon, 18 May 2020 11:31:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <e9a92c29-162f-e2eb-0a6c-c1e08e99ffa7@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/17 23:32:08
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


On 2020/5/15 下午11:16, Laurent Vivier wrote:
> On 08/05/2020 04:57, Jason Wang wrote:
>> On 2020/5/7 下午7:49, Laurent Vivier wrote:
>>> This new command shows internal status of a VirtQueue.
>>> (vrings and indexes).
>>>
>>> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
>>
>> It looks to me that packed virtqueue is not supported. It's better to
>> add them in the future.
> I agree, it's why the series still remains an "RFC".
>
> ...
>>> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
>>> index 59bf6ef651a6..57552bf05014 100644
>>> --- a/hw/virtio/virtio.c
>>> +++ b/hw/virtio/virtio.c
>>> @@ -3877,6 +3877,41 @@ static VirtIODevice *virtio_device_find(const
>>> char *path)
>>>        return NULL;
>>>    }
>>>    +VirtQueueStatus *qmp_x_debug_virtio_queue_status(const char *path,
>>> +                                                 uint16_t queue,
>>> Error **errp)
>>> +{
>>> +    VirtIODevice *vdev;
>>> +    VirtQueueStatus *status;
>>> +
>>> +    vdev = virtio_device_find(path);
>>> +    if (vdev == NULL) {
>>> +        error_setg(errp, "Path %s is not a VirtIO device", path);
>>> +        return NULL;
>>> +    }
>>> +
>>> +    if (queue >= VIRTIO_QUEUE_MAX || !virtio_queue_get_num(vdev,
>>> queue)) {
>>> +        error_setg(errp, "Invalid virtqueue number %d", queue);
>>> +        return NULL;
>>> +    }
>>> +
>>> +    status = g_new0(VirtQueueStatus, 1);
>>> +    status->queue_index = vdev->vq[queue].queue_index;
>>> +    status->inuse = vdev->vq[queue].inuse;
>>> +    status->vring_num = vdev->vq[queue].vring.num;
>>> +    status->vring_num_default = vdev->vq[queue].vring.num_default;
>>> +    status->vring_align = vdev->vq[queue].vring.align;
>>> +    status->vring_desc = vdev->vq[queue].vring.desc;
>>> +    status->vring_avail = vdev->vq[queue].vring.avail;
>>> +    status->vring_used = vdev->vq[queue].vring.used;
>>> +    status->last_avail_idx = vdev->vq[queue].last_avail_idx;
>>
>> This might not be correct when vhost is used.
>>
>> We may consider to sync last_avail_idx from vhost backends here?
> Yes, but I don't know how to do that. Where can I find the information?


It could be synced through vhost ops vhost_get_vring_base(), see 
vhost_virtqueue_stop().

Thanks


>
> Thanks,
> Laurent


