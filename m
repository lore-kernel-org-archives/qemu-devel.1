Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79695C7618B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 11:56:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 525DE22BED
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 11:56:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 525DE22BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59082 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqcMT-0004fD-Ap
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 07:56:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56133)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <david@redhat.com>) id 1hqcMA-0003Ym-T0
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 07:56:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1hqcM9-0005wR-Jb
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 07:56:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37014)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>)
 id 1hqcM9-0005w4-A8; Thu, 25 Jul 2019 07:56:21 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1E6E5307845E;
 Thu, 25 Jul 2019 11:56:20 +0000 (UTC)
Received: from [10.36.117.70] (ovpn-117-70.ams2.redhat.com [10.36.117.70])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F0F8F1001E75;
 Thu, 25 Jul 2019 11:56:13 +0000 (UTC)
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20190725113638.4702-1-david@redhat.com>
 <20190725113638.4702-7-david@redhat.com>
 <20190725075054-mutt-send-email-mst@kernel.org>
From: David Hildenbrand <david@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
 SE+xAvmumFBY
Organization: Red Hat GmbH
Message-ID: <9852d84a-992e-9b7c-a55a-72183ebfbb97@redhat.com>
Date: Thu, 25 Jul 2019 13:56:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190725075054-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Thu, 25 Jul 2019 11:56:20 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH-for-4.1 v4 6/7] virtio-balloon: Use
 temporary PBP only
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
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-stable@nongnu.org,
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 25.07.19 13:53, Michael S. Tsirkin wrote:
> On Thu, Jul 25, 2019 at 01:36:37PM +0200, David Hildenbrand wrote:
>> We still have multiple issues in the current code
>> - The PBP is not freed during unrealize()
>> - The PBP is not reset on device resets: After a reset, the PBP is stale.
>> - We are not indicating VIRTIO_BALLOON_F_MUST_TELL_HOST, therefore
>>   guests (esp. legacy guests) will reuse pages without deflating,
>>   turning the PBP stale. Adding that would require compat handling.
>>
>> Instead, let's use the PBP only temporarily, when processing one bulk of
>> inflation requests. This will keep guest_page_size > 4k working (with
>> Linux guests). There is nothing to do for deflation requests anymore.
>> The pbp is only used for a limited amount of time.
>>
>> Fixes: ed48c59875b6 ("virtio-balloon: Safely handle BALLOON_PAGE_SIZE <
>>                      host page size")
>> Cc: qemu-stable@nongnu.org #v4.0.0
>> Suggested-by: Michael S. Tsirkin <mst@redhat.com>
>> Acked-by: David Gibson <david@gibson.dropbear.id.au>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>  hw/virtio/virtio-balloon.c         | 21 +++++++++------------
>>  include/hw/virtio/virtio-balloon.h |  3 ---
>>  2 files changed, 9 insertions(+), 15 deletions(-)
>>
>> diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
>> index 40d493a31a..a6282d58d4 100644
>> --- a/hw/virtio/virtio-balloon.c
>> +++ b/hw/virtio/virtio-balloon.c
>> @@ -34,11 +34,11 @@
>>  
>>  #define BALLOON_PAGE_SIZE  (1 << VIRTIO_BALLOON_PFN_SHIFT)
>>  
>> -struct PartiallyBalloonedPage {
>> +typedef struct PartiallyBalloonedPage {
>>      ram_addr_t base_gpa;
>>      long subpages;
>>      unsigned long *bitmap;
>> -};
>> +} PartiallyBalloonedPage;
>>  
>>  static void virtio_balloon_pbp_free(PartiallyBalloonedPage *pbp)
>>  {
>> @@ -68,11 +68,11 @@ static bool virtio_balloon_pbp_matches(PartiallyBalloonedPage *pbp,
>>  }
>>  
>>  static void balloon_inflate_page(VirtIOBalloon *balloon,
>> -                                 MemoryRegion *mr, hwaddr mr_offset)
>> +                                 MemoryRegion *mr, hwaddr mr_offset,
>> +                                 PartiallyBalloonedPage **pbp)
>>  {
>>      void *addr = memory_region_get_ram_ptr(mr) + mr_offset;
>>      ram_addr_t rb_offset, rb_aligned_offset, base_gpa;
>> -    PartiallyBalloonedPage **pbp = &balloon->pbp;
>>      RAMBlock *rb;
>>      size_t rb_page_size;
>>      int subpages;
>> @@ -149,12 +149,6 @@ static void balloon_deflate_page(VirtIOBalloon *balloon,
>>      rb = qemu_ram_block_from_host(addr, false, &rb_offset);
>>      rb_page_size = qemu_ram_pagesize(rb);
>>  
>> -    if (balloon->pbp) {
>> -        /* Let's play safe and always reset the pbp on deflation requests. */
>> -        virtio_balloon_pbp_free(balloon->pbp);
>> -        balloon->pbp = NULL;
>> -    }
>> -
>>      host_addr = (void *)((uintptr_t)addr & ~(rb_page_size - 1));
>>  
>>      /* When a page is deflated, we hint the whole host page it lives
>> @@ -336,6 +330,7 @@ static void balloon_stats_set_poll_interval(Object *obj, Visitor *v,
>>  static void virtio_balloon_handle_output(VirtIODevice *vdev, VirtQueue *vq)
>>  {
>>      VirtIOBalloon *s = VIRTIO_BALLOON(vdev);
>> +    PartiallyBalloonedPage *pbp = NULL;
>>      VirtQueueElement *elem;
>>      MemoryRegionSection section;
>>  
>> @@ -344,7 +339,7 @@ static void virtio_balloon_handle_output(VirtIODevice *vdev, VirtQueue *vq)
>>          uint32_t pfn;
>>          elem = virtqueue_pop(vq, sizeof(VirtQueueElement));
>>          if (!elem) {
>> -            return;
>> +            break;
>>          }
>>  
>>          while (iov_to_buf(elem->out_sg, elem->out_num, offset, &pfn, 4) == 4) {
>> @@ -373,7 +368,7 @@ static void virtio_balloon_handle_output(VirtIODevice *vdev, VirtQueue *vq)
>>              if (!qemu_balloon_is_inhibited()) {
>>                  if (vq == s->ivq) {
>>                      balloon_inflate_page(s, section.mr,
>> -                                         section.offset_within_region);
>> +                                         section.offset_within_region, &pbp);
>>                  } else if (vq == s->dvq) {
>>                      balloon_deflate_page(s, section.mr, section.offset_within_region);
>>                  } else {
>> @@ -387,6 +382,8 @@ static void virtio_balloon_handle_output(VirtIODevice *vdev, VirtQueue *vq)
>>          virtio_notify(vdev, vq);
>>          g_free(elem);
>>      }
>> +
>> +    virtio_balloon_pbp_free(pbp);
>>  }
>>  
>>  static void virtio_balloon_receive_stats(VirtIODevice *vdev, VirtQueue *vq)
> 
> Oops this is not early enough.
> We must not track pbp across elements: once we push an element
> guest can reuse the page.
> 

Right, it has to go into the loop.

-- 

Thanks,

David / dhildenb

