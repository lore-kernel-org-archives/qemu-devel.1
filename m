Return-Path: <SRS0=J7/p=6I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F89FC54FD0
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 15:13:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D1B62075A
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 15:13:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b5zIY3pZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D1B62075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41048 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jS00h-0004DJ-9M
	for qemu-devel@archiver.kernel.org; Fri, 24 Apr 2020 11:12:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47422)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1jRzzm-0003Bi-PJ
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 11:12:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1jRzzl-0000mk-EB
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 11:12:02 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:60540
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1jRzzk-0000lV-Vh
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 11:12:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587741119;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=TW8fiDLJbiMfILkel1vAQKUlY4h/2oCtJELufvKPUio=;
 b=b5zIY3pZrab9gQ94FJYo1jOM3sfRoWPDw3yYyR28UDLiMvhEmdJXDM0UgmZmceh8eW7NvE
 OtAkvJ9OGSg74iAeA+Iow1G7G/0IO+CSKlrFYElrYfaf9NjWZtMA3Ll6JejJjeas2z7F4Y
 y2cOyrnCB6omBA8DEDieMBPD+bezNhM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-452-7WNuZs6rMQukwWAwOEBJcQ-1; Fri, 24 Apr 2020 11:11:57 -0400
X-MC-Unique: 7WNuZs6rMQukwWAwOEBJcQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 67EE01800D51;
 Fri, 24 Apr 2020 15:11:56 +0000 (UTC)
Received: from [10.36.113.138] (ovpn-113-138.ams2.redhat.com [10.36.113.138])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 258F4600EF;
 Fri, 24 Apr 2020 15:11:52 +0000 (UTC)
Subject: Re: [PATCH v21 QEMU 3/5] virtio-balloon: Replace free page hinting
 references to 'report' with 'hint'
To: Alexander Duyck <alexander.duyck@gmail.com>
References: <20200422181649.12258.37077.stgit@localhost.localdomain>
 <20200422182113.12258.56556.stgit@localhost.localdomain>
 <69bf1579-78db-2a2c-6ac0-169daaa50153@redhat.com>
 <CAKgT0UeZLJfZtLyDo8DcQF2KmwoNxPYnkSrx6C-j=LxU9t0ovw@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
Organization: Red Hat GmbH
Message-ID: <799e5942-4deb-7f75-5347-bc7dbd8a838e@redhat.com>
Date: Fri, 24 Apr 2020 17:11:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAKgT0UeZLJfZtLyDo8DcQF2KmwoNxPYnkSrx6C-j=LxU9t0ovw@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/24 02:57:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 24.04.20 16:56, Alexander Duyck wrote:
> On Fri, Apr 24, 2020 at 4:23 AM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 22.04.20 20:21, Alexander Duyck wrote:
>>> From: Alexander Duyck <alexander.h.duyck@linux.intel.com>
>>>
>>> In an upcoming patch a feature named Free Page Reporting is about to be
>>> added. In order to avoid any confusion we should drop the use of the word
>>> 'report' when referring to Free Page Hinting. So what this patch does is go
>>> through and replace all instances of 'report' with 'hint" when we are
>>> referring to free page hinting.
>>>
>>> Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
>>> ---
>>>  hw/virtio/virtio-balloon.c         |   74 ++++++++++++++++++------------------
>>>  include/hw/virtio/virtio-balloon.h |   20 +++++-----
>>>  2 files changed, 47 insertions(+), 47 deletions(-)
>>>
>>> diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
>>> index a4729f7fc930..a1d6fb52c876 100644
>>> --- a/hw/virtio/virtio-balloon.c
>>> +++ b/hw/virtio/virtio-balloon.c
>>> @@ -466,21 +466,21 @@ static bool get_free_page_hints(VirtIOBalloon *dev)
>>>              ret = false;
>>>              goto out;
>>>          }
>>> -        if (id == dev->free_page_report_cmd_id) {
>>> -            dev->free_page_report_status = FREE_PAGE_REPORT_S_START;
>>> +        if (id == dev->free_page_hint_cmd_id) {
>>> +            dev->free_page_hint_status = FREE_PAGE_HINT_S_START;
>>>          } else {
>>>              /*
>>>               * Stop the optimization only when it has started. This
>>>               * avoids a stale stop sign for the previous command.
>>>               */
>>> -            if (dev->free_page_report_status == FREE_PAGE_REPORT_S_START) {
>>> -                dev->free_page_report_status = FREE_PAGE_REPORT_S_STOP;
>>> +            if (dev->free_page_hint_status == FREE_PAGE_HINT_S_START) {
>>> +                dev->free_page_hint_status = FREE_PAGE_HINT_S_STOP;
>>>              }
>>>          }
>>>      }
>>>
>>>      if (elem->in_num) {
>>> -        if (dev->free_page_report_status == FREE_PAGE_REPORT_S_START) {
>>> +        if (dev->free_page_hint_status == FREE_PAGE_HINT_S_START) {
>>>              qemu_guest_free_page_hint(elem->in_sg[0].iov_base,
>>>                                        elem->in_sg[0].iov_len);
>>>          }
>>> @@ -506,11 +506,11 @@ static void virtio_ballloon_get_free_page_hints(void *opaque)
>>>          qemu_mutex_unlock(&dev->free_page_lock);
>>>          virtio_notify(vdev, vq);
>>>        /*
>>> -       * Start to poll the vq once the reporting started. Otherwise, continue
>>> +       * Start to poll the vq once the hinting started. Otherwise, continue
>>>         * only when there are entries on the vq, which need to be given back.
>>>         */
>>>      } while (continue_to_get_hints ||
>>> -             dev->free_page_report_status == FREE_PAGE_REPORT_S_START);
>>> +             dev->free_page_hint_status == FREE_PAGE_HINT_S_START);
>>>      virtio_queue_set_notification(vq, 1);
>>>  }
>>>
>>> @@ -531,14 +531,14 @@ static void virtio_balloon_free_page_start(VirtIOBalloon *s)
>>>          return;
>>>      }
>>>
>>> -    if (s->free_page_report_cmd_id == UINT_MAX) {
>>> -        s->free_page_report_cmd_id =
>>> -                       VIRTIO_BALLOON_FREE_PAGE_REPORT_CMD_ID_MIN;
>>> +    if (s->free_page_hint_cmd_id == UINT_MAX) {
>>> +        s->free_page_hint_cmd_id =
>>> +                       VIRTIO_BALLOON_FREE_PAGE_HINT_CMD_ID_MIN;
>>>      } else {
>>> -        s->free_page_report_cmd_id++;
>>> +        s->free_page_hint_cmd_id++;
>>>      }
>>>
>>> -    s->free_page_report_status = FREE_PAGE_REPORT_S_REQUESTED;
>>> +    s->free_page_hint_status = FREE_PAGE_HINT_S_REQUESTED;
>>>      virtio_notify_config(vdev);
>>>  }
>>>
>>> @@ -546,18 +546,18 @@ static void virtio_balloon_free_page_stop(VirtIOBalloon *s)
>>>  {
>>>      VirtIODevice *vdev = VIRTIO_DEVICE(s);
>>>
>>> -    if (s->free_page_report_status != FREE_PAGE_REPORT_S_STOP) {
>>> +    if (s->free_page_hint_status != FREE_PAGE_HINT_S_STOP) {
>>>          /*
>>>           * The lock also guarantees us that the
>>>           * virtio_ballloon_get_free_page_hints exits after the
>>> -         * free_page_report_status is set to S_STOP.
>>> +         * free_page_hint_status is set to S_STOP.
>>>           */
>>>          qemu_mutex_lock(&s->free_page_lock);
>>>          /*
>>>           * The guest hasn't done the reporting, so host sends a notification
>>>           * to the guest to actively stop the reporting.
>>>           */
>>> -        s->free_page_report_status = FREE_PAGE_REPORT_S_STOP;
>>> +        s->free_page_hint_status = FREE_PAGE_HINT_S_STOP;
>>>          qemu_mutex_unlock(&s->free_page_lock);
>>>          virtio_notify_config(vdev);
>>>      }
>>> @@ -567,15 +567,15 @@ static void virtio_balloon_free_page_done(VirtIOBalloon *s)
>>>  {
>>>      VirtIODevice *vdev = VIRTIO_DEVICE(s);
>>>
>>> -    s->free_page_report_status = FREE_PAGE_REPORT_S_DONE;
>>> +    s->free_page_hint_status = FREE_PAGE_HINT_S_DONE;
>>>      virtio_notify_config(vdev);
>>>  }
>>>
>>>  static int
>>> -virtio_balloon_free_page_report_notify(NotifierWithReturn *n, void *data)
>>> +virtio_balloon_free_page_hint_notify(NotifierWithReturn *n, void *data)
>>>  {
>>>      VirtIOBalloon *dev = container_of(n, VirtIOBalloon,
>>> -                                      free_page_report_notify);
>>> +                                      free_page_hint_notify);
>>>      VirtIODevice *vdev = VIRTIO_DEVICE(dev);
>>>      PrecopyNotifyData *pnd = data;
>>>
>>> @@ -624,7 +624,7 @@ static size_t virtio_balloon_config_size(VirtIOBalloon *s)
>>>      if (virtio_has_feature(features, VIRTIO_BALLOON_F_FREE_PAGE_HINT)) {
>>>          return offsetof(struct virtio_balloon_config, poison_val);
>>>      }
>>> -    return offsetof(struct virtio_balloon_config, free_page_report_cmd_id);
>>> +    return offsetof(struct virtio_balloon_config, free_page_hint_cmd_id);
>>>  }
>>>
>>>  static void virtio_balloon_get_config(VirtIODevice *vdev, uint8_t *config_data)
>>> @@ -635,14 +635,14 @@ static void virtio_balloon_get_config(VirtIODevice *vdev, uint8_t *config_data)
>>>      config.num_pages = cpu_to_le32(dev->num_pages);
>>>      config.actual = cpu_to_le32(dev->actual);
>>>
>>> -    if (dev->free_page_report_status == FREE_PAGE_REPORT_S_REQUESTED) {
>>> -        config.free_page_report_cmd_id =
>>> -                       cpu_to_le32(dev->free_page_report_cmd_id);
>>> -    } else if (dev->free_page_report_status == FREE_PAGE_REPORT_S_STOP) {
>>> -        config.free_page_report_cmd_id =
>>> +    if (dev->free_page_hint_status == FREE_PAGE_HINT_S_REQUESTED) {
>>> +        config.free_page_hint_cmd_id =
>>> +                       cpu_to_le32(dev->free_page_hint_cmd_id);
>>> +    } else if (dev->free_page_hint_status == FREE_PAGE_HINT_S_STOP) {
>>> +        config.free_page_hint_cmd_id =
>>>                         cpu_to_le32(VIRTIO_BALLOON_CMD_ID_STOP);
>>> -    } else if (dev->free_page_report_status == FREE_PAGE_REPORT_S_DONE) {
>>> -        config.free_page_report_cmd_id =
>>> +    } else if (dev->free_page_hint_status == FREE_PAGE_HINT_S_DONE) {
>>> +        config.free_page_hint_cmd_id =
>>>                         cpu_to_le32(VIRTIO_BALLOON_CMD_ID_DONE);
>>>      }
>>>
>>> @@ -743,14 +743,14 @@ static int virtio_balloon_post_load_device(void *opaque, int version_id)
>>>      return 0;
>>>  }
>>>
>>> -static const VMStateDescription vmstate_virtio_balloon_free_page_report = {
>>> +static const VMStateDescription vmstate_virtio_balloon_free_page_hint = {
>>>      .name = "virtio-balloon-device/free-page-report",
>>>      .version_id = 1,
>>>      .minimum_version_id = 1,
>>>      .needed = virtio_balloon_free_page_support,
>>>      .fields = (VMStateField[]) {
>>> -        VMSTATE_UINT32(free_page_report_cmd_id, VirtIOBalloon),
>>> -        VMSTATE_UINT32(free_page_report_status, VirtIOBalloon),
>>> +        VMSTATE_UINT32(free_page_hint_cmd_id, VirtIOBalloon),
>>> +        VMSTATE_UINT32(free_page_hint_status, VirtIOBalloon),
>>>          VMSTATE_END_OF_LIST()
>>>      }
>>>  };
>>> @@ -766,7 +766,7 @@ static const VMStateDescription vmstate_virtio_balloon_device = {
>>>          VMSTATE_END_OF_LIST()
>>>      },
>>>      .subsections = (const VMStateDescription * []) {
>>> -        &vmstate_virtio_balloon_free_page_report,
>>> +        &vmstate_virtio_balloon_free_page_hint,
>>>          NULL
>>>      }
>>>  };
>>> @@ -797,12 +797,12 @@ static void virtio_balloon_device_realize(DeviceState *dev, Error **errp)
>>>                             VIRTIO_BALLOON_F_FREE_PAGE_HINT)) {
>>>          s->free_page_vq = virtio_add_queue(vdev, VIRTQUEUE_MAX_SIZE,
>>>                                             virtio_balloon_handle_free_page_vq);
>>> -        s->free_page_report_status = FREE_PAGE_REPORT_S_STOP;
>>> -        s->free_page_report_cmd_id =
>>> -                           VIRTIO_BALLOON_FREE_PAGE_REPORT_CMD_ID_MIN;
>>> -        s->free_page_report_notify.notify =
>>> -                                       virtio_balloon_free_page_report_notify;
>>> -        precopy_add_notifier(&s->free_page_report_notify);
>>> +        s->free_page_hint_status = FREE_PAGE_HINT_S_STOP;
>>> +        s->free_page_hint_cmd_id =
>>> +                           VIRTIO_BALLOON_FREE_PAGE_HINT_CMD_ID_MIN;
>>> +        s->free_page_hint_notify.notify =
>>> +                                       virtio_balloon_free_page_hint_notify;
>>> +        precopy_add_notifier(&s->free_page_hint_notify);
>>>          if (s->iothread) {
>>>              object_ref(OBJECT(s->iothread));
>>>              s->free_page_bh = aio_bh_new(iothread_get_aio_context(s->iothread),
>>> @@ -827,7 +827,7 @@ static void virtio_balloon_device_unrealize(DeviceState *dev, Error **errp)
>>>      if (virtio_balloon_free_page_support(s)) {
>>>          qemu_bh_delete(s->free_page_bh);
>>>          virtio_balloon_free_page_stop(s);
>>> -        precopy_remove_notifier(&s->free_page_report_notify);
>>> +        precopy_remove_notifier(&s->free_page_hint_notify);
>>>      }
>>>      balloon_stats_destroy_timer(s);
>>>      qemu_remove_balloon_handler(s);
>>> diff --git a/include/hw/virtio/virtio-balloon.h b/include/hw/virtio/virtio-balloon.h
>>> index d1c968d2376e..108cff97e71a 100644
>>> --- a/include/hw/virtio/virtio-balloon.h
>>> +++ b/include/hw/virtio/virtio-balloon.h
>>> @@ -23,7 +23,7 @@
>>>  #define VIRTIO_BALLOON(obj) \
>>>          OBJECT_CHECK(VirtIOBalloon, (obj), TYPE_VIRTIO_BALLOON)
>>>
>>> -#define VIRTIO_BALLOON_FREE_PAGE_REPORT_CMD_ID_MIN 0x80000000
>>> +#define VIRTIO_BALLOON_FREE_PAGE_HINT_CMD_ID_MIN 0x80000000
>>>
>>>  typedef struct virtio_balloon_stat VirtIOBalloonStat;
>>>
>>> @@ -33,20 +33,20 @@ typedef struct virtio_balloon_stat_modern {
>>>         uint64_t val;
>>>  } VirtIOBalloonStatModern;
>>>
>>> -enum virtio_balloon_free_page_report_status {
>>> -    FREE_PAGE_REPORT_S_STOP = 0,
>>> -    FREE_PAGE_REPORT_S_REQUESTED = 1,
>>> -    FREE_PAGE_REPORT_S_START = 2,
>>> -    FREE_PAGE_REPORT_S_DONE = 3,
>>> +enum virtio_balloon_free_page_hint_status {
>>> +    FREE_PAGE_HINT_S_STOP = 0,
>>> +    FREE_PAGE_HINT_S_REQUESTED = 1,
>>> +    FREE_PAGE_HINT_S_START = 2,
>>> +    FREE_PAGE_HINT_S_DONE = 3,
>>>  };
>>>
>>>  typedef struct VirtIOBalloon {
>>>      VirtIODevice parent_obj;
>>>      VirtQueue *ivq, *dvq, *svq, *free_page_vq;
>>> -    uint32_t free_page_report_status;
>>> +    uint32_t free_page_hint_status;
>>>      uint32_t num_pages;
>>>      uint32_t actual;
>>> -    uint32_t free_page_report_cmd_id;
>>> +    uint32_t free_page_hint_cmd_id;
>>>      uint64_t stats[VIRTIO_BALLOON_S_NR];
>>>      VirtQueueElement *stats_vq_elem;
>>>      size_t stats_vq_offset;
>>> @@ -55,7 +55,7 @@ typedef struct VirtIOBalloon {
>>>      QEMUBH *free_page_bh;
>>>      /*
>>>       * Lock to synchronize threads to access the free page reporting related
>>> -     * fields (e.g. free_page_report_status).
>>> +     * fields (e.g. free_page_hint_status).
>>>       */
>>>      QemuMutex free_page_lock;
>>>      QemuCond  free_page_cond;
>>> @@ -64,7 +64,7 @@ typedef struct VirtIOBalloon {
>>>       * stopped.
>>>       */
>>>      bool block_iothread;
>>> -    NotifierWithReturn free_page_report_notify;
>>> +    NotifierWithReturn free_page_hint_notify;
>>>      int64_t stats_last_update;
>>>      int64_t stats_poll_interval;
>>>      uint32_t host_features;
>>>
>>
>> Maybe split out the change to "free_page_report_cmd_id" in the uapi
>> (meaning: move that to a separate patch). So you can move forward with
>> most of this series (moving patch #1 and the free_page_report_cmd_id
>> change to the very last of this series) without depending on that change
>> to go upstream.
> 
> Okay. I can split it if that is needed. Any specific reason for
> splitting it I should cite in the patch? From what I can tell Michael
> has already accepted the renamed and pushed it to Linus.

Oh, I missed that - forget what I said. I thought this would still be
stuck in -next.

Acked-by: David Hildenbrand <david@redhat.com>

Thanks!

-- 
Thanks,

David / dhildenb


