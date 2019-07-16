Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FA5CC76188
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 07:00:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 569F52145D
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 07:00:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 569F52145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45722 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnHRm-0000Sb-3o
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 03:00:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38691)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hnHRV-0008NH-Ur
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 03:00:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hnHRU-0002iB-FY
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 03:00:05 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36070)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hnHRU-0002hk-8r
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 03:00:04 -0400
Received: by mail-wm1-f67.google.com with SMTP id g67so13333359wme.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2019 00:00:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=T9fEzDYi2TKmBZaPKkglzhaNwbV4Qb5iRkMG/uzXLio=;
 b=aFm2aF2EhLcNphHfHjgOoTpuKZGfhy1zG8pioz9eDWPz8qdkGPCPJQqyD3B2pBWNzg
 KFB7V6gQ+SjXWcn17Ij5orKYwjXWyGPKRq0DNBLFrlv8SGvuosY3JmYtbkHFgM07byDI
 rGuCkEwMZvIFballAWC9xcaAqnOk84svw1t1HkVVQMTZ4gnLr/4GlbN8jTPTDus7IxCS
 3PEfj6y0Ci9yMT6HNVQJiMFuLJV1BX3qfHyttpbPvrPcavpfnyDm7vSPyZIZucTN9wc/
 wIXRRPBJ+h2gsOTDT53UT+z4v/NdGNHPNMwL5DSyWOoFXUaQ19otJJFqm6oa8QSjzHyp
 ixnQ==
X-Gm-Message-State: APjAAAUcATvh1Da0VGu2dGBHX7Hs7WsmifZPIyo5WDXgr00bXnKgDBtE
 RzBpwOTdKq4MsjO1d8CD0VHP1A==
X-Google-Smtp-Source: APXvYqwfgdD2TCMi8Ft4foIYT3Z9rr8XwVS9FPzgHP36FfXOxjUnAbSEJBBb/+a6Kktrk8+Ch8hppQ==
X-Received: by 2002:a7b:c928:: with SMTP id h8mr18761829wml.93.1563260403170; 
 Tue, 16 Jul 2019 00:00:03 -0700 (PDT)
Received: from [192.168.1.37] (62.red-83-42-61.dynamicip.rima-tde.net.
 [83.42.61.62])
 by smtp.gmail.com with ESMTPSA id s3sm19376567wmh.27.2019.07.16.00.00.02
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Tue, 16 Jul 2019 00:00:02 -0700 (PDT)
To: Max Reitz <mreitz@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
References: <20190612220839.1374-1-mreitz@redhat.com>
 <20190612220839.1374-2-mreitz@redhat.com>
 <b110b753-8546-0d34-f6ef-06c5726766ce@virtuozzo.com>
 <c1fbf12a-77af-d939-4266-67b822e5a923@redhat.com>
 <57ae7f82-ae02-a382-74f6-cb96672b2058@virtuozzo.com>
 <00cce102-a1f1-9205-6eb7-1e48d8991b00@redhat.com>
 <32adc55c-c71d-59bf-963b-48d2ae5b3e30@virtuozzo.com>
 <309c0932-a9b4-40a6-8db2-7940171f52e5@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <33ab4c3f-9300-9d8c-cf42-4c1aaf5422fc@redhat.com>
Date: Tue, 16 Jul 2019 09:00:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <309c0932-a9b4-40a6-8db2-7940171f52e5@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.67
Subject: Re: [Qemu-devel] [PATCH 1/2] vl: Drain before (block) job cancel
 when quitting
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
Cc: Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Denis Plotnikov <dplotnikov@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/19/19 9:40 PM, Max Reitz wrote:
> On 14.06.19 11:22, Vladimir Sementsov-Ogievskiy wrote:
>> 13.06.2019 19:03, Max Reitz wrote:
>>> [re-adding the original CCs, why not]
>>>
>>> On 13.06.19 16:30, Vladimir Sementsov-Ogievskiy wrote:
>>>> 13.06.2019 17:21, Max Reitz wrote:
>>>>> On 13.06.19 16:19, Vladimir Sementsov-Ogievskiy wrote:
>>>>>> 13.06.2019 1:08, Max Reitz wrote:
>>>>>>> If the main loop cancels all block jobs while the block layer is not
>>>>>>> drained, this cancelling may not happen instantaneously.  We can start a
>>>>>>> drained section before vm_shutdown(), which entails another
>>>>>>> bdrv_drain_all(); this nested bdrv_drain_all() will thus be a no-op,
>>>>>>> basically.
>>>>>>>
>>>>>>> We do not have to end the drained section, because we actually do not
>>>>>>> want any requests to happen from this point on.

Your cover description was more helpful to understand the big picture
than this commit description.

>>>>>>>
>>>>>>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>>>>>>> ---
>>>>>>> I don't know whether it actually makes sense to never end this drained
>>>>>>> section.  It makes sense to me.  Please correct me if I'm wrong.
>>>>>>> ---
>>>>>>>     vl.c | 11 +++++++++++
>>>>>>>     1 file changed, 11 insertions(+)
>>>>>>>
>>>>>>> diff --git a/vl.c b/vl.c
>>>>>>> index cd1fbc4cdc..3f8b3f74f5 100644
>>>>>>> --- a/vl.c
>>>>>>> +++ b/vl.c
>>>>>>> @@ -4538,6 +4538,17 @@ int main(int argc, char **argv, char **envp)
>>>>>>>          */
>>>>>>>         migration_shutdown();
>>>>>>>     
>>>>>>> +    /*
>>>>>>> +     * We must cancel all block jobs while the block layer is drained,
>>>>>>> +     * or cancelling will be affected by throttling and thus may block
>>>>>>> +     * for an extended period of time.
>>>>>>> +     * vm_shutdown() will bdrv_drain_all(), so we may as well include
>>>>>>> +     * it in the drained section.
>>>>>>> +     * We do not need to end this section, because we do not want any
>>>>>>> +     * requests happening from here on anyway.
>>>>>>> +     */
>>>>>>> +    bdrv_drain_all_begin();

This change looks sane, but I'm not expert with the 'block layer'.

>>>>>>> +
>>>>>>>         /* No more vcpu or device emulation activity beyond this point */
>>>>>>>         vm_shutdown();
>>>>>>>     
>>>>>>>
>>>>>>
>>>>>> So, actually, the problem is that we may wait for job requests twice:
>>>>>> on drain and then on cancel.
>>>>>
>>>>> We don’t wait on drain.  When the throttle node is drained, it will
>>>>> ignore throttling (as noted in the cover letter).
>>>>>
>>>>> We do wait when cancelling a job while the throttle node isn’t drained,
>>>>> though.  That’s the problem.
>>>>
>>>> Ah, understand now.
>>>>
>>>> Is it safe to drain_begin before stopping cpus? We may finish up then with some queued
>>>> somewhere IO requests..
>>>
>>> Hm...  Aren’t guest devices prohibited from issuing requests to the
>>> block layer while their respective block device is drained?
>>
>> It's at least a buggy place, I remember Denis Plotnikov sent patch to fix it and had a huge
>> discussion with Kevin.
>> And here it is:
>> https://lists.gnu.org/archive/html/qemu-devel/2018-12/msg00732.html
> 
> Ah, I even have that in my inbox...  The latest reply I see came in April:
> 
> https://lists.nongnu.org/archive/html/qemu-block/2019-04/msg00243.html
> 
> Where Kevin asked for an RFC patch in the current state.
> 
> I’m not sure whether I should work around a potential bug here, if we
> can agree that it is a bug, and if it isn’t clear whether this place
> would actually be affected.

Hmmm so what is the outcome of this thread?

Apparently this is not a bug for Max, but a potential one for Vladimir?

Vladimir are you NACKing this patch?

Thanks,

Phil.

> 
> Max
> 

