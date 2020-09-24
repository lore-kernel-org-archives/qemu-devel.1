Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 953D2C4346E
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 09:14:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98CCD2376F
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 09:14:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M0oxymrE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98CCD2376F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47948 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLNL6-0002rz-Io
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 05:14:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36194)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1kLNJd-0002NX-Ra
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 05:13:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:36834)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1kLNJa-0004hK-4v
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 05:13:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600938798;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RfuBZ4yWke5rFshYOFEf/zCh7KMRtSxHQNbUKZ+Dqpo=;
 b=M0oxymrERe5gNRcL6jNGRF0QHHoTnXIQ36GuWtr/dHELSw2yG6NXj0+AnJjcXCs4oGaNyG
 I9iyr1ty6+J4L7E/Ok/Fn9V2eSGQn0dfZ1+nev5QbM/TzbuVkcsOR+DlvB1G/6Xm0s6xsw
 erDq6WR6Ecv0iu8kro5/M3yoOBle8fw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-22-ljBV2VxFMrKmPvIiRplQHA-1; Thu, 24 Sep 2020 05:13:17 -0400
X-MC-Unique: ljBV2VxFMrKmPvIiRplQHA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2C8AE1091062
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2020 09:13:16 +0000 (UTC)
Received: from [10.72.13.109] (ovpn-13-109.pek2.redhat.com [10.72.13.109])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 68B9A5C1DC;
 Thu, 24 Sep 2020 09:13:05 +0000 (UTC)
Subject: Re: [PATCH v2 2/2] vhost-vdpa: add trace-events
To: Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org
References: <20200921130406.941363-1-lvivier@redhat.com>
 <20200921130406.941363-3-lvivier@redhat.com>
 <eeb7aee3-b15e-919c-d378-5cc3b2f9ff08@redhat.com>
 <0622a2db-98e8-6378-9bc4-6119de7042ae@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <2bf402e0-cdef-9ab8-b09c-d7f5768afaf8@redhat.com>
Date: Thu, 24 Sep 2020 17:13:03 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <0622a2db-98e8-6378-9bc4-6119de7042ae@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=63.128.21.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/24 01:10:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.228,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Cindy Lu <lulu@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/9/24 下午4:42, Laurent Vivier wrote:
> On 22/09/2020 04:09, Jason Wang wrote:
>> On 2020/9/21 下午9:04, Laurent Vivier wrote:
>>> Add trace functionis in vhost-vdpa.c.
>>>
>>> All traces from this file can be enabled with '-trace vhost_vdpa*'.
>>>
>>> Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
>>> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
>>> ---
>>>    hw/virtio/trace-events | 29 ++++++++++++++
>>>    hw/virtio/vhost-vdpa.c | 86 +++++++++++++++++++++++++++++++++++++++---
>>>    2 files changed, 110 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
>>> index 845200bf109d..2b453f77a4e3 100644
>>> --- a/hw/virtio/trace-events
>>> +++ b/hw/virtio/trace-events
>>> @@ -22,6 +22,35 @@ vhost_user_postcopy_waker(const char *rb, uint64_t
>>> rb_offset) "%s + 0x%"PRIx64
>>>    vhost_user_postcopy_waker_found(uint64_t client_addr) "0x%"PRIx64
>>>    vhost_user_postcopy_waker_nomatch(const char *rb, uint64_t
>>> rb_offset) "%s + 0x%"PRIx64
>>>    +# vhost-vdpa.c
>>> +vhost_vdpa_listener_region_add(void *vdpa, uint64_t iova, uint64_t
>>> llend, void *vaddr, bool readonly) "vdpa: %p iova 0x%"PRIx64" llend
>>> 0x%"PRIx64" vaddr: %p read-only: %d"
>>> +vhost_vdpa_listener_region_del(void *vdpa, uint64_t iova, uint64_t
>>> llend) "vdpa: %p iova 0x%"PRIx64" llend 0x%"PRIx64
>>> +vhost_vdpa_add_status(void *dev, uint8_t status) "dev: %p status:
>>> 0x%"PRIx8
>>> +vhost_vdpa_init(void *dev, void *vdpa) "dev: %p vdpa: %p"
>>> +vhost_vdpa_cleanup(void *dev, void *vdpa) "dev: %p vdpa: %p"
>>> +vhost_vdpa_memslots_limit(void *dev, int ret) "dev: %p = 0x%x"
>>> +vhost_vdpa_set_mem_table(void *dev, uint32_t nregions, uint32_t
>>> padding) "dev: %p nregions: %"PRIu32" padding: 0x%"PRIx32
>>> +vhost_vdpa_dump_regions(void *dev, int i, uint64_t guest_phys_addr,
>>> uint64_t memory_size, uint64_t userspace_addr, uint64_t flags_padding)
>>> "dev: %p %d: guest_phys_addr: 0x%"PRIx64" memory_size: 0x%"PRIx64"
>>> userspace_addr: 0x%"PRIx64" flags_padding: 0x%"PRIx64
>>> +vhost_vdpa_set_features(void *dev, uint64_t features) "dev: %p
>>> features: 0x%"PRIx64
>>> +vhost_vdpa_get_device_id(void *dev, uint32_t device_id) "dev: %p
>>> device_id %"PRIu32
>>> +vhost_vdpa_reset_device(void *dev, uint8_t status) "dev: %p status:
>>> 0x%"PRIx8
>>> +vhost_vdpa_get_vq_index(void *dev, int idx, int vq_idx) "dev: %p idx:
>>> %d vq idx: %d"
>>> +vhost_vdpa_set_vring_ready(void *dev) "dev: %p"
>>> +vhost_vdpa_dump_config(void *dev, const char *line) "dev: %p %s"
>>> +vhost_vdpa_set_config(void *dev, uint32_t offset, uint32_t size,
>>> uint32_t flags) "dev: %p offset: %"PRIu32" size: %"PRIu32" flags:
>>> 0x%"PRIx32
>>> +vhost_vdpa_get_config(void *dev, void *config, uint32_t config_len)
>>> "dev: %p config: %p config_len: %"PRIu32
>>> +vhost_vdpa_dev_start(void *dev, bool started) "dev: %p started: %d"
>>> +vhost_vdpa_set_log_base(void *dev, uint64_t base, unsigned long long
>>> size, int refcnt, int fd, void *log) "dev: %p base: 0x%"PRIx64" size:
>>> %llu refcnt: %d fd: %d log: %p"
>>> +vhost_vdpa_set_vring_addr(void *dev, unsigned int index, unsigned int
>>> flags, uint64_t desc_user_addr, uint64_t used_user_addr, uint64_t
>>> avail_user_addr, uint64_t log_guest_addr) "dev: %p index: %u flags:
>>> 0x%x desc_user_addr: 0x%"PRIx64" used_user_addr: 0x%"PRIx64"
>>> avail_user_addr: 0x%"PRIx64" log_guest_addr: 0x%"PRIx64
>>> +vhost_vdpa_set_vring_num(void *dev, unsigned int index, unsigned int
>>> num) "dev: %p index: %u num: %u"
>>> +vhost_vdpa_set_vring_base(void *dev, unsigned int index, unsigned int
>>> num) "dev: %p index: %u num: %u"
>>> +vhost_vdpa_get_vring_base(void *dev, unsigned int index, unsigned int
>>> num) "dev: %p index: %u num: %u"
>>> +vhost_vdpa_set_vring_kick(void *dev, unsigned int index, int fd)
>>> "dev: %p index: %u fd: %d"
>>> +vhost_vdpa_set_vring_call(void *dev, unsigned int index, int fd)
>>> "dev: %p index: %u fd: %d"
>>
>> It's better to add set/get_vring_addr() and dma_map()/dma_unmap().
> I'm adding dma_map()/dma_unmap().
>
> set_vring_addr() is already in the list, and get_vring_addr() doesn't
> exist.


Your are right. We don't have get_vring_addr() actually.


> As I don't see the link with vhost_vdpa_set_vring_call() I would
> keep it.
>
> Did I miss something?


Nope, there's no link.

Please keep that.

Thanks


>
> Thanks,
> Laurent
>
>


