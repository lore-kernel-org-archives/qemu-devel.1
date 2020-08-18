Return-Path: <SRS0=kYy5=B4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 824DAC433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 13:43:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 471E92087D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 13:43:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RNq0Dl48"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 471E92087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k81tY-0008F0-Jj
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 09:43:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53242)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1k81t0-0007h7-63
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 09:42:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57824
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1k81sy-0003ne-G6
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 09:42:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597758163;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vzm1P267oX2OIl4KdxZaWEn9KMb88kWlhbExy+mYOz8=;
 b=RNq0Dl48/O4CLgd9cXHJm+wypsWNE6jPcdcbWj4y3pGXRKHkoFFLZiQOKlz5XVa9i/Eabf
 HIehsLK16LEUdyIDgW/dp7AbrK2THGHNhlV3gpWERfT9p5yaXxNMhl0rpybH9tyQr/wT5p
 am1g+rWjKLKxmuyQ4U9Uj58SX1+cs5o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-484-RJTf6a7HMla8DuRxjcrtvQ-1; Tue, 18 Aug 2020 09:42:39 -0400
X-MC-Unique: RJTf6a7HMla8DuRxjcrtvQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 793461009443;
 Tue, 18 Aug 2020 13:42:38 +0000 (UTC)
Received: from [10.36.113.93] (ovpn-113-93.ams2.redhat.com [10.36.113.93])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A782726192;
 Tue, 18 Aug 2020 13:42:30 +0000 (UTC)
Subject: Re: [PATCH 07/11] vfio/platform: Remove dead assignment in
 vfio_intp_interrupt()
To: Stefan Hajnoczi <stefanha@redhat.com>
References: <20200813073712.4001404-1-kuhn.chenqun@huawei.com>
 <20200813073712.4001404-8-kuhn.chenqun@huawei.com>
 <20200813105911.2312adb5@x1.home>
 <681519bf-92ca-6247-490a-e9193b0bd385@redhat.com>
 <20200813131530.09ad0a4c@x1.home>
 <8e096d15-1700-f399-045d-1ba73eb6c1c1@redhat.com>
 <20200818125446.GC36102@stefanha-x1.localdomain>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <20ee54db-e36c-fc45-aa5c-14bf6433602b@redhat.com>
Date: Tue, 18 Aug 2020 15:42:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200818125446.GC36102@stefanha-x1.localdomain>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eric.auger@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/18 03:19:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: zhang.zhanghailiang@huawei.com, qemu-trivial@nongnu.org,
 pannengyuan@huawei.com, qemu-devel@nongnu.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Euler Robot <euler.robot@huawei.com>, Chen Qun <kuhn.chenqun@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Stefan,

On 8/18/20 2:54 PM, Stefan Hajnoczi wrote:
> On Thu, Aug 13, 2020 at 09:18:59PM +0200, Auger Eric wrote:
>> Hi Alex,
>>
>> On 8/13/20 9:15 PM, Alex Williamson wrote:
>>> On Thu, 13 Aug 2020 20:02:45 +0200
>>> Auger Eric <eric.auger@redhat.com> wrote:
>>>
>>>> Hi Alex,
>>>>
>>>> On 8/13/20 6:59 PM, Alex Williamson wrote:
>>>>> On Thu, 13 Aug 2020 15:37:08 +0800
>>>>> Chen Qun <kuhn.chenqun@huawei.com> wrote:
>>>>>   
>>>>>> Clang static code analyzer show warning:
>>>>>> hw/vfio/platform.c:239:9: warning: Value stored to 'ret' is never read
>>>>>>         ret = event_notifier_test_and_clear(intp->interrupt);
>>>>>>         ^     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>>>>
>>>>>> Reported-by: Euler Robot <euler.robot@huawei.com>
>>>>>> Signed-off-by: Chen Qun <kuhn.chenqun@huawei.com>
>>>>>> ---
>>>>>> Cc: Alex Williamson <alex.williamson@redhat.com>
>>>>>> Cc: Eric Auger <eric.auger@redhat.com>
>>>>>> ---
>>>>>>  hw/vfio/platform.c | 2 +-
>>>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/hw/vfio/platform.c b/hw/vfio/platform.c
>>>>>> index ac2cefc9b1..869ed2c39d 100644
>>>>>> --- a/hw/vfio/platform.c
>>>>>> +++ b/hw/vfio/platform.c
>>>>>> @@ -236,7 +236,7 @@ static void vfio_intp_interrupt(VFIOINTp *intp)
>>>>>>          trace_vfio_intp_interrupt_set_pending(intp->pin);
>>>>>>          QSIMPLEQ_INSERT_TAIL(&vdev->pending_intp_queue,
>>>>>>                               intp, pqnext);
>>>>>> -        ret = event_notifier_test_and_clear(intp->interrupt);
>>>>>> +        event_notifier_test_and_clear(intp->interrupt);
>>>>>>          return;
>>>>>>      }  
>>>>>
>>>>> Testing that an event is pending in our notifier is generally a
>>>>> prerequisite to doing anything in the interrupt handler, I don't
>>>>> understand why we're just consuming it and ignoring the return value.
>>>>> The above is in the delayed handling branch of the function, but the
>>>>> normal non-delayed path would only go on to error_report() if the
>>>>> notifier is not pending and then inject an interrupt anyway.  This all
>>>>> seems rather suspicious and it's a unique pattern among the vfio
>>>>> callers of this function.  Is there a more fundamental bug that this
>>>>> function should perform this test once and return without doing
>>>>> anything if it's called spuriously, ie. without a notifier pending?
>>>>> Thanks,  
>>>>
>>>> Hum that's correct that other VFIO call sites do the check. My
>>>> understanding was that this could not fail in this case as, if we
>>>> entered the handler there was something to be cleared. In which
>>>> situation can this fail?
>>>
>>> I'm not sure what the right answer is, I see examples either way
>>> looking outside of vfio code.  On one hand, maybe we never get called
>>> spuriously, on the other if it's the callee's responsibility to drain
>>> events from the fd and we have it readily accessible whether there were
>>> any events pending, why would we inject an interrupt if the result that
>>> we have in hand shows no pending events?  The overhead of returning
>>> based on that result is minuscule.
>>
>> I agree
>>>
>>> qemu_set_fd_handler() is a wrapper for aio_set_fd_handler().  Stefan is
>>> a possible defacto maintainer of some of the aio code.  Stefan, do you
>>> have thoughts on whether callbacks from event notifier fds should
>>> consider spurious events?  Thanks,
>>
>> Indeed I saw that for instance block/nvme.c nvme_handle_event is not
>> checking the result.
>>
>> Let's wait for Stefan's answer ...
> 
> vfio_intp_interrupt() will always read a non-zero eventfd value, based
> on these assumptions:
> 
> intp->interrupt is "readable" since vfio_intp_interrupt() is called by
> the AioContext (event loop). "readable" does not guarantee that data can
> actually be read because it also includes error events:
> 
>   new_node->pfd.events = (io_read ? G_IO_IN | G_IO_HUP | G_IO_ERR : 0);
> 
> However, I think we can exclude the error case for the VFIO interrupt
> eventfds because there are no error cases for eventfds (unlike socket
> disconnection, for example).
> 
> The other important assumption is that only one thread on the host is
> monitoring the eventfd for activity.

Thank for your the confirmation. So this patch should be safe.

Best Regards

Eric
> 
> Stefan
> 


