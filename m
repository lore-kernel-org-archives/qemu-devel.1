Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98660C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 19:19:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B5B720774
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 19:19:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z70Kky5n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B5B720774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54814 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6IlV-0002C2-Gp
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 15:19:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48534)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1k6Iks-0001mi-Gv
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 15:19:14 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:25843
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1k6Ikq-0006BX-UW
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 15:19:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597346351;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9CBt2Iwb2TXIK6XFd0KLuM1IefDxbodeUzdYsuAM4Kk=;
 b=Z70Kky5ng3JLIdwChWd/c6hUIsv2iUxEnFoksC3Wd/Rj2ItcAbej9tQ+5aYCmJl+XuWSr8
 nLnXum1Rn/9rVaDDqZo3CsNcuusHzghJMPA6S8h97tcEuF+22MfHCPammCSZk7xgcv1bx+
 dEpyoz/SRc8DnXQIPZNxgkX6aTpDegc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-85-fQ3lLi2UPO6OeQA0CSDxsQ-1; Thu, 13 Aug 2020 15:19:10 -0400
X-MC-Unique: fQ3lLi2UPO6OeQA0CSDxsQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A38FE1DDE1;
 Thu, 13 Aug 2020 19:19:08 +0000 (UTC)
Received: from [10.36.113.93] (ovpn-113-93.ams2.redhat.com [10.36.113.93])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D10FD6FDB3;
 Thu, 13 Aug 2020 19:19:00 +0000 (UTC)
Subject: Re: [PATCH 07/11] vfio/platform: Remove dead assignment in
 vfio_intp_interrupt()
To: Alex Williamson <alex.williamson@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
References: <20200813073712.4001404-1-kuhn.chenqun@huawei.com>
 <20200813073712.4001404-8-kuhn.chenqun@huawei.com>
 <20200813105911.2312adb5@x1.home>
 <681519bf-92ca-6247-490a-e9193b0bd385@redhat.com>
 <20200813131530.09ad0a4c@x1.home>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <8e096d15-1700-f399-045d-1ba73eb6c1c1@redhat.com>
Date: Thu, 13 Aug 2020 21:18:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200813131530.09ad0a4c@x1.home>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eric.auger@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=eric.auger@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/13 02:03:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: zhang.zhanghailiang@huawei.com, qemu-trivial@nongnu.org,
 pannengyuan@huawei.com, qemu-devel@nongnu.org,
 Euler Robot <euler.robot@huawei.com>, Chen Qun <kuhn.chenqun@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Alex,

On 8/13/20 9:15 PM, Alex Williamson wrote:
> On Thu, 13 Aug 2020 20:02:45 +0200
> Auger Eric <eric.auger@redhat.com> wrote:
> 
>> Hi Alex,
>>
>> On 8/13/20 6:59 PM, Alex Williamson wrote:
>>> On Thu, 13 Aug 2020 15:37:08 +0800
>>> Chen Qun <kuhn.chenqun@huawei.com> wrote:
>>>   
>>>> Clang static code analyzer show warning:
>>>> hw/vfio/platform.c:239:9: warning: Value stored to 'ret' is never read
>>>>         ret = event_notifier_test_and_clear(intp->interrupt);
>>>>         ^     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>>
>>>> Reported-by: Euler Robot <euler.robot@huawei.com>
>>>> Signed-off-by: Chen Qun <kuhn.chenqun@huawei.com>
>>>> ---
>>>> Cc: Alex Williamson <alex.williamson@redhat.com>
>>>> Cc: Eric Auger <eric.auger@redhat.com>
>>>> ---
>>>>  hw/vfio/platform.c | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/hw/vfio/platform.c b/hw/vfio/platform.c
>>>> index ac2cefc9b1..869ed2c39d 100644
>>>> --- a/hw/vfio/platform.c
>>>> +++ b/hw/vfio/platform.c
>>>> @@ -236,7 +236,7 @@ static void vfio_intp_interrupt(VFIOINTp *intp)
>>>>          trace_vfio_intp_interrupt_set_pending(intp->pin);
>>>>          QSIMPLEQ_INSERT_TAIL(&vdev->pending_intp_queue,
>>>>                               intp, pqnext);
>>>> -        ret = event_notifier_test_and_clear(intp->interrupt);
>>>> +        event_notifier_test_and_clear(intp->interrupt);
>>>>          return;
>>>>      }  
>>>
>>> Testing that an event is pending in our notifier is generally a
>>> prerequisite to doing anything in the interrupt handler, I don't
>>> understand why we're just consuming it and ignoring the return value.
>>> The above is in the delayed handling branch of the function, but the
>>> normal non-delayed path would only go on to error_report() if the
>>> notifier is not pending and then inject an interrupt anyway.  This all
>>> seems rather suspicious and it's a unique pattern among the vfio
>>> callers of this function.  Is there a more fundamental bug that this
>>> function should perform this test once and return without doing
>>> anything if it's called spuriously, ie. without a notifier pending?
>>> Thanks,  
>>
>> Hum that's correct that other VFIO call sites do the check. My
>> understanding was that this could not fail in this case as, if we
>> entered the handler there was something to be cleared. In which
>> situation can this fail?
> 
> I'm not sure what the right answer is, I see examples either way
> looking outside of vfio code.  On one hand, maybe we never get called
> spuriously, on the other if it's the callee's responsibility to drain
> events from the fd and we have it readily accessible whether there were
> any events pending, why would we inject an interrupt if the result that
> we have in hand shows no pending events?  The overhead of returning
> based on that result is minuscule.

I agree
> 
> qemu_set_fd_handler() is a wrapper for aio_set_fd_handler().  Stefan is
> a possible defacto maintainer of some of the aio code.  Stefan, do you
> have thoughts on whether callbacks from event notifier fds should
> consider spurious events?  Thanks,

Indeed I saw that for instance block/nvme.c nvme_handle_event is not
checking the result.

Let's wait for Stefan's answer ...

Thanks

Eric
> 
> Alex
> 


