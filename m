Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D277C4724C
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 03:56:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10BE820735
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 03:56:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=qnap.com header.i=@qnap.com header.b="kUSxTgDT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10BE820735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=qnap.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46768 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWu82-0005aU-8s
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 23:56:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36658)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dereksu@qnap.com>) id 1jWu7L-00057T-F1
 for qemu-devel@nongnu.org; Thu, 07 May 2020 23:56:07 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:45979)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dereksu@qnap.com>) id 1jWu7K-0003Bs-0f
 for qemu-devel@nongnu.org; Thu, 07 May 2020 23:56:07 -0400
Received: by mail-pg1-x542.google.com with SMTP id s18so241012pgl.12
 for <qemu-devel@nongnu.org>; Thu, 07 May 2020 20:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qnap.com; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=X2Dn7bNnuqHGjHdduKehjzI1ZKbit1B5jrC9GMqyM3M=;
 b=kUSxTgDTOJcF79QZrvV2BwQTUm97YFsaOe7/kxGDHHjzgRN4V+uG7b451PH7cjsTT+
 fwBmBQ9k5tFOvhK8WrsCSeRYjUqsSJfUr69cjmRcgGLPuhYne916yz5c4slZO7Dm2LbQ
 tHV6SEmuTZuWOzXwHIuNtowDr5BwHQuTB/jVw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=X2Dn7bNnuqHGjHdduKehjzI1ZKbit1B5jrC9GMqyM3M=;
 b=VjN2zl/XensJ1dt3ricBKhdNp4H7nhL0GLYge1v5ug6GtexXuhSEXMcXGpyoF7uuGh
 I/fAt9O6O2Edmh/Fzt1UI6SzKoDctgcQImhxHwXXHKPrZj168tT68w8eQsmfce24Xeel
 zevJq/vIJv5OBogcZ+zHzJPlydkmkeVsc9mdPTPs2ZvIUPGCdU3UddPfPrD7CyfO/ZVW
 WkZVxC4ti4zNHKuxtswuZHLDKccM3R3smlomKoXHTC7209D9IuBgveNtIpImgjHwSGss
 sZrx9+Ii7sDsxRjE/ffBm2vw9dpPD3wGDpPp9leGk3KA5cINM4N8TDntExMUNlioDPzO
 pJRA==
X-Gm-Message-State: AGi0PuZpcXKZ5zR7OiwnCR/ZDLrvIXECu80F6L8ql0QPsr/YgIihO+Bx
 /egiZfDr64KuMvQX5Ww6ArKbwQ==
X-Google-Smtp-Source: APiQypKFmy5yIzWMbn0W8dSJ7bHjQjTG6SN3I995m0c1oxZ3wCl5tH0fF0gFvpNYEIGjR1Y61yrnNw==
X-Received: by 2002:aa7:8b0d:: with SMTP id f13mr708470pfd.270.1588910163732; 
 Thu, 07 May 2020 20:56:03 -0700 (PDT)
Received: from Jing-Weide-MacBook-Pro-3.local
 (202-39-79-13.HINET-IP.hinet.net. [202.39.79.13])
 by smtp.gmail.com with ESMTPSA id q7sm310980pgs.13.2020.05.07.20.56.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 May 2020 20:56:03 -0700 (PDT)
Subject: Re: [PATCH v4 5/6] net/colo-compare.c, softmmu/vl.c: Check that
 colo-compare is active
To: "Zhang, Chen" <chen.zhang@intel.com>, Lukas Straub <lukasstraub2@web.de>
References: <cover.1588587700.git.lukasstraub2@web.de>
 <f6cbde747d78ff080f680c710e2793867a3cf1fa.1588587700.git.lukasstraub2@web.de>
 <0380e994e53947cd961cc363d46561d3@intel.com> <20200507175421.185b48f8@luklap>
 <59eea784a36643b4b1fe32b0700f57f7@intel.com>
From: Derek Su <dereksu@qnap.com>
Message-ID: <82d9726c-11e5-2090-96d9-4e8617f8f02e@qnap.com>
Date: Fri, 8 May 2020 11:55:59 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <59eea784a36643b4b1fe32b0700f57f7@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::542;
 envelope-from=dereksu@qnap.com; helo=mail-pg1-x542.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Jason Wang <jasowang@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Li Zhijian <lizhijian@cn.fujitsu.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2020/5/8 上午10:26, Zhang, Chen wrote:
> 
> 
>> -----Original Message-----
>> From: Lukas Straub <lukasstraub2@web.de>
>> Sent: Thursday, May 7, 2020 11:54 PM
>> To: Zhang, Chen <chen.zhang@intel.com>
>> Cc: qemu-devel <qemu-devel@nongnu.org>; Li Zhijian
>> <lizhijian@cn.fujitsu.com>; Jason Wang <jasowang@redhat.com>; Marc-
>> André Lureau <marcandre.lureau@redhat.com>; Paolo Bonzini
>> <pbonzini@redhat.com>
>> Subject: Re: [PATCH v4 5/6] net/colo-compare.c, softmmu/vl.c: Check that
>> colo-compare is active
>>
>> On Thu, 7 May 2020 11:38:04 +0000
>> "Zhang, Chen" <chen.zhang@intel.com> wrote:
>>
>>>> -----Original Message-----
>>>> From: Lukas Straub <lukasstraub2@web.de>
>>>> Sent: Monday, May 4, 2020 6:28 PM
>>>> To: qemu-devel <qemu-devel@nongnu.org>
>>>> Cc: Zhang, Chen <chen.zhang@intel.com>; Li Zhijian
>>>> <lizhijian@cn.fujitsu.com>; Jason Wang <jasowang@redhat.com>; Marc-
>>>> André Lureau <marcandre.lureau@redhat.com>; Paolo Bonzini
>>>> <pbonzini@redhat.com>
>>>> Subject: [PATCH v4 5/6] net/colo-compare.c, softmmu/vl.c: Check that
>>>> colo- compare is active
>>>>
>>>> If the colo-compare object is removed before failover and a
>>>> checkpoint happens, qemu crashes because it tries to lock the
>>>> destroyed event_mtx in colo_notify_compares_event.
>>>>
>>>> Fix this by checking if everything is initialized by introducing a
>>>> new variable colo_compare_active which is protected by a new mutex
>>>> colo_compare_mutex. The new mutex also protects against concurrent
>>>> access of the net_compares list and makes sure that
>>>> colo_notify_compares_event isn't active while we destroy event_mtx
>>>> and event_complete_cond.
>>>>
>>>> With this it also is again possible to use colo without colo-compare
>>>> (periodic
>>>> mode) and to use multiple colo-compare for multiple network interfaces.
>>>>
>>>
>>> Hi Lukas,
>>>
>>> For this case I think we don't need to touch vl.c code, we can solve this
>> issue from another perspective:
>>> How to remove colo-compare?
>>> User will use qemu-monitor or QMP command to disable an object, so we
>>> just need return operation failed When user try to remove colo-compare
>> object while COLO is running.
>>
>> Yeah, but that still leaves the other problem that colo can't be used without
>> colo-compare (qemu crashes then).
> 
> Yes, the COLO-compare is necessary module in COLO original design.
> At most cases, user need it do dynamic sync.
> For rare cases, maybe we can add a new colo-compare parameter to bypass all the network workload.

Hi, Chen

In our application, we only need "periodical mode" because of the 
performance issue, and have internal patch now. Is it OK to send the 
internal patch for review?

Thanks.

Regards,
Derek

> 
> Thanks
> Zhang Chen
> 
>>
>> Regards,
>> Lukas Straub
>>
>>> Thanks
>>> Zhang Chen
>>>
>>>> Signed-off-by: Lukas Straub <lukasstraub2@web.de>
>>>> ---
>>>>   net/colo-compare.c | 35 +++++++++++++++++++++++++++++------
>>>>   net/colo-compare.h |  1 +
>>>>   softmmu/vl.c       |  2 ++
>>>>   3 files changed, 32 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/net/colo-compare.c b/net/colo-compare.c index
>>>> 56db3d3bfc..c7572d75e9 100644
>>>> --- a/net/colo-compare.c
>>>> +++ b/net/colo-compare.c
>>>> @@ -54,6 +54,8 @@ static NotifierList colo_compare_notifiers =
>>>> #define REGULAR_PACKET_CHECK_MS 3000  #define
>> DEFAULT_TIME_OUT_MS
>>>> 3000
>>>>
>>>> +static QemuMutex colo_compare_mutex; static bool
>>>> +colo_compare_active;
>>>>   static QemuMutex event_mtx;
>>>>   static QemuCond event_complete_cond;  static int
>>>> event_unhandled_count; @@ -906,6 +908,12 @@ static void
>>>> check_old_packet_regular(void *opaque) void
>>>> colo_notify_compares_event(void *opaque, int event, Error **errp)  {
>>>>       CompareState *s;
>>>> +    qemu_mutex_lock(&colo_compare_mutex);
>>>> +
>>>> +    if (!colo_compare_active) {
>>>> +        qemu_mutex_unlock(&colo_compare_mutex);
>>>> +        return;
>>>> +    }
>>>>
>>>>       qemu_mutex_lock(&event_mtx);
>>>>       QTAILQ_FOREACH(s, &net_compares, next) { @@ -919,6 +927,7 @@
>>>> void colo_notify_compares_event(void *opaque, int event, Error **errp)
>>>>       }
>>>>
>>>>       qemu_mutex_unlock(&event_mtx);
>>>> +    qemu_mutex_unlock(&colo_compare_mutex);
>>>>   }
>>>>
>>>>   static void colo_compare_timer_init(CompareState *s) @@ -1274,7
>>>> +1283,14 @@ static void colo_compare_complete(UserCreatable *uc,
>> Error **errp)
>>>>                              s->vnet_hdr);
>>>>       }
>>>>
>>>> +    qemu_mutex_lock(&colo_compare_mutex);
>>>> +    if (!colo_compare_active) {
>>>> +        qemu_mutex_init(&event_mtx);
>>>> +        qemu_cond_init(&event_complete_cond);
>>>> +        colo_compare_active = true;
>>>> +    }
>>>>       QTAILQ_INSERT_TAIL(&net_compares, s, next);
>>>> +    qemu_mutex_unlock(&colo_compare_mutex);
>>>>
>>>>       s->out_sendco.s = s;
>>>>       s->out_sendco.chr = &s->chr_out; @@ -1290,9 +1306,6 @@ static
>>>> void colo_compare_complete(UserCreatable
>>>> *uc, Error **errp)
>>>>
>>>>       g_queue_init(&s->conn_list);
>>>>
>>>> -    qemu_mutex_init(&event_mtx);
>>>> -    qemu_cond_init(&event_complete_cond);
>>>> -
>>>>       s->connection_track_table =
>>>> g_hash_table_new_full(connection_key_hash,
>>>>                                                         connection_key_equal,
>>>>                                                         g_free, @@
>>>> -1384,12 +1397,19 @@ static void colo_compare_finalize(Object *obj)
>>>>
>>>>       qemu_bh_delete(s->event_bh);
>>>>
>>>> +    qemu_mutex_lock(&colo_compare_mutex);
>>>>       QTAILQ_FOREACH(tmp, &net_compares, next) {
>>>>           if (tmp == s) {
>>>>               QTAILQ_REMOVE(&net_compares, s, next);
>>>>               break;
>>>>           }
>>>>       }
>>>> +    if (QTAILQ_EMPTY(&net_compares)) {
>>>> +        colo_compare_active = false;
>>>> +        qemu_mutex_destroy(&event_mtx);
>>>> +        qemu_cond_destroy(&event_complete_cond);
>>>> +    }
>>>> +    qemu_mutex_unlock(&colo_compare_mutex);
>>>>
>>>>       AioContext *ctx = iothread_get_aio_context(s->iothread);
>>>>       aio_context_acquire(ctx);
>>>> @@ -1413,15 +1433,18 @@ static void colo_compare_finalize(Object *obj)
>>>>           object_unref(OBJECT(s->iothread));
>>>>       }
>>>>
>>>> -    qemu_mutex_destroy(&event_mtx);
>>>> -    qemu_cond_destroy(&event_complete_cond);
>>>> -
>>>>       g_free(s->pri_indev);
>>>>       g_free(s->sec_indev);
>>>>       g_free(s->outdev);
>>>>       g_free(s->notify_dev);
>>>>   }
>>>>
>>>> +void colo_compare_init_globals(void) {
>>>> +    colo_compare_active = false;
>>>> +    qemu_mutex_init(&colo_compare_mutex);
>>>> +}
>>>> +
>>>>   static const TypeInfo colo_compare_info = {
>>>>       .name = TYPE_COLO_COMPARE,
>>>>       .parent = TYPE_OBJECT,
>>>> diff --git a/net/colo-compare.h b/net/colo-compare.h index
>>>> 22ddd512e2..eb483ac586 100644
>>>> --- a/net/colo-compare.h
>>>> +++ b/net/colo-compare.h
>>>> @@ -17,6 +17,7 @@
>>>>   #ifndef QEMU_COLO_COMPARE_H
>>>>   #define QEMU_COLO_COMPARE_H
>>>>
>>>> +void colo_compare_init_globals(void);
>>>>   void colo_notify_compares_event(void *opaque, int event, Error
>>>> **errp); void colo_compare_register_notifier(Notifier *notify);
>>>> void colo_compare_unregister_notifier(Notifier *notify); diff --git
>>>> a/softmmu/vl.c b/softmmu/vl.c index 32c0047889..a913ed5469 100644
>>>> --- a/softmmu/vl.c
>>>> +++ b/softmmu/vl.c
>>>> @@ -112,6 +112,7 @@
>>>>   #include "qapi/qmp/qerror.h"
>>>>   #include "sysemu/iothread.h"
>>>>   #include "qemu/guest-random.h"
>>>> +#include "net/colo-compare.h"
>>>>
>>>>   #define MAX_VIRTIO_CONSOLES 1
>>>>
>>>> @@ -2906,6 +2907,7 @@ void qemu_init(int argc, char **argv, char
>> **envp)
>>>>       precopy_infrastructure_init();
>>>>       postcopy_infrastructure_init();
>>>>       monitor_init_globals();
>>>> +    colo_compare_init_globals();
>>>>
>>>>       if (qcrypto_init(&err) < 0) {
>>>>           error_reportf_err(err, "cannot initialize crypto: ");
>>>> --
>>>> 2.20.1
>>>
> 


