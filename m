Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83FF2C4346E
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 08:45:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B72F23600
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 08:45:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="doLlnKqS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B72F23600
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLMsB-0005eE-1O
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 04:45:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56950)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1kLMqB-0004Uj-Ih
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 04:42:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:30487)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1kLMq9-0000nT-71
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 04:42:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600936975;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=dd9X8rMMpQkdpjBs/WWLjJ77cyLkIbjNA+nZ6+Dxnk8=;
 b=doLlnKqSEcc3e8E2cp331uJqhM28DdhkZ8LkW2pwWPBnMrj4w/UMeFu/aU6wcFNtOW8beL
 wVZMX54KKi9tas1in6ENRO4mYkB9lPlRSbYtrcz4lCnC4BTA1v8UaH49zfYSi8RP9ITyIm
 zZ753JzS8Qb8BiiJdC8jlKLk5WmPQYg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-190-243ZhUGCO_aNGNs900G0Dg-1; Thu, 24 Sep 2020 04:42:53 -0400
X-MC-Unique: 243ZhUGCO_aNGNs900G0Dg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EFC811007464
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2020 08:42:52 +0000 (UTC)
Received: from [10.36.113.15] (ovpn-113-15.ams2.redhat.com [10.36.113.15])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7EED478828;
 Thu, 24 Sep 2020 08:42:45 +0000 (UTC)
Subject: Re: [PATCH v2 2/2] vhost-vdpa: add trace-events
To: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org
References: <20200921130406.941363-1-lvivier@redhat.com>
 <20200921130406.941363-3-lvivier@redhat.com>
 <eeb7aee3-b15e-919c-d378-5cc3b2f9ff08@redhat.com>
From: Laurent Vivier <lvivier@redhat.com>
Autocrypt: addr=lvivier@redhat.com; prefer-encrypt=mutual; keydata=
 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
 D+Ofp0T3KOr1RUHvCZoLURfFhSQ=
Message-ID: <0622a2db-98e8-6378-9bc4-6119de7042ae@redhat.com>
Date: Thu, 24 Sep 2020 10:42:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <eeb7aee3-b15e-919c-d378-5cc3b2f9ff08@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=lvivier@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=63.128.21.124; envelope-from=lvivier@redhat.com;
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
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Cindy Lu <lulu@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 22/09/2020 04:09, Jason Wang wrote:
> 
> On 2020/9/21 下午9:04, Laurent Vivier wrote:
>> Add trace functionis in vhost-vdpa.c.
>>
>> All traces from this file can be enabled with '-trace vhost_vdpa*'.
>>
>> Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
>> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
>> ---
>>   hw/virtio/trace-events | 29 ++++++++++++++
>>   hw/virtio/vhost-vdpa.c | 86 +++++++++++++++++++++++++++++++++++++++---
>>   2 files changed, 110 insertions(+), 5 deletions(-)
>>
>> diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
>> index 845200bf109d..2b453f77a4e3 100644
>> --- a/hw/virtio/trace-events
>> +++ b/hw/virtio/trace-events
>> @@ -22,6 +22,35 @@ vhost_user_postcopy_waker(const char *rb, uint64_t
>> rb_offset) "%s + 0x%"PRIx64
>>   vhost_user_postcopy_waker_found(uint64_t client_addr) "0x%"PRIx64
>>   vhost_user_postcopy_waker_nomatch(const char *rb, uint64_t
>> rb_offset) "%s + 0x%"PRIx64
>>   +# vhost-vdpa.c
>> +vhost_vdpa_listener_region_add(void *vdpa, uint64_t iova, uint64_t
>> llend, void *vaddr, bool readonly) "vdpa: %p iova 0x%"PRIx64" llend
>> 0x%"PRIx64" vaddr: %p read-only: %d"
>> +vhost_vdpa_listener_region_del(void *vdpa, uint64_t iova, uint64_t
>> llend) "vdpa: %p iova 0x%"PRIx64" llend 0x%"PRIx64
>> +vhost_vdpa_add_status(void *dev, uint8_t status) "dev: %p status:
>> 0x%"PRIx8
>> +vhost_vdpa_init(void *dev, void *vdpa) "dev: %p vdpa: %p"
>> +vhost_vdpa_cleanup(void *dev, void *vdpa) "dev: %p vdpa: %p"
>> +vhost_vdpa_memslots_limit(void *dev, int ret) "dev: %p = 0x%x"
>> +vhost_vdpa_set_mem_table(void *dev, uint32_t nregions, uint32_t
>> padding) "dev: %p nregions: %"PRIu32" padding: 0x%"PRIx32
>> +vhost_vdpa_dump_regions(void *dev, int i, uint64_t guest_phys_addr,
>> uint64_t memory_size, uint64_t userspace_addr, uint64_t flags_padding)
>> "dev: %p %d: guest_phys_addr: 0x%"PRIx64" memory_size: 0x%"PRIx64"
>> userspace_addr: 0x%"PRIx64" flags_padding: 0x%"PRIx64
>> +vhost_vdpa_set_features(void *dev, uint64_t features) "dev: %p
>> features: 0x%"PRIx64
>> +vhost_vdpa_get_device_id(void *dev, uint32_t device_id) "dev: %p
>> device_id %"PRIu32
>> +vhost_vdpa_reset_device(void *dev, uint8_t status) "dev: %p status:
>> 0x%"PRIx8
>> +vhost_vdpa_get_vq_index(void *dev, int idx, int vq_idx) "dev: %p idx:
>> %d vq idx: %d"
>> +vhost_vdpa_set_vring_ready(void *dev) "dev: %p"
>> +vhost_vdpa_dump_config(void *dev, const char *line) "dev: %p %s"
>> +vhost_vdpa_set_config(void *dev, uint32_t offset, uint32_t size,
>> uint32_t flags) "dev: %p offset: %"PRIu32" size: %"PRIu32" flags:
>> 0x%"PRIx32
>> +vhost_vdpa_get_config(void *dev, void *config, uint32_t config_len)
>> "dev: %p config: %p config_len: %"PRIu32
>> +vhost_vdpa_dev_start(void *dev, bool started) "dev: %p started: %d"
>> +vhost_vdpa_set_log_base(void *dev, uint64_t base, unsigned long long
>> size, int refcnt, int fd, void *log) "dev: %p base: 0x%"PRIx64" size:
>> %llu refcnt: %d fd: %d log: %p"
>> +vhost_vdpa_set_vring_addr(void *dev, unsigned int index, unsigned int
>> flags, uint64_t desc_user_addr, uint64_t used_user_addr, uint64_t
>> avail_user_addr, uint64_t log_guest_addr) "dev: %p index: %u flags:
>> 0x%x desc_user_addr: 0x%"PRIx64" used_user_addr: 0x%"PRIx64"
>> avail_user_addr: 0x%"PRIx64" log_guest_addr: 0x%"PRIx64
>> +vhost_vdpa_set_vring_num(void *dev, unsigned int index, unsigned int
>> num) "dev: %p index: %u num: %u"
>> +vhost_vdpa_set_vring_base(void *dev, unsigned int index, unsigned int
>> num) "dev: %p index: %u num: %u"
>> +vhost_vdpa_get_vring_base(void *dev, unsigned int index, unsigned int
>> num) "dev: %p index: %u num: %u"
>> +vhost_vdpa_set_vring_kick(void *dev, unsigned int index, int fd)
>> "dev: %p index: %u fd: %d"
>> +vhost_vdpa_set_vring_call(void *dev, unsigned int index, int fd)
>> "dev: %p index: %u fd: %d"
> 
> 
> It's better to add set/get_vring_addr() and dma_map()/dma_unmap().

I'm adding dma_map()/dma_unmap().

set_vring_addr() is already in the list, and get_vring_addr() doesn't
exist. As I don't see the link with vhost_vdpa_set_vring_call() I would
keep it.

Did I miss something?

Thanks,
Laurent


