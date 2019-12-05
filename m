Return-Path: <SRS0=YrRb=Z3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8980C43603
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 16:47:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9245522525
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 16:47:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EmoodmHS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9245522525
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57472 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icuI6-0001lg-MX
	for qemu-devel@archiver.kernel.org; Thu, 05 Dec 2019 11:47:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44436)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1icuG5-0000i7-Hb
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 11:45:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1icuFz-0003xs-ON
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 11:45:40 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35719
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1icuFz-0003uy-IH
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 11:45:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575564333;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8I47RwKx8S1kyd+JnWdlEAFJhNofBjWW+X0nq60acBI=;
 b=EmoodmHS4ZQrgBGuR1gEdMP7aPmaXz0IWIgnzHItTjRnqLLkYEmmXkON6n4PvUgGpL9+LD
 hfaVi+7wqFv16aNeeiekoJDaEbzbSFZ57B8JnFjxgPzk7En01hUDc53RSE056fykPkXkjA
 TZAi3YHtXppVUvJkLAocOFIuqxFcwp0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-279-eF4kZ4xdM6-YlRDq1hWaYA-1; Thu, 05 Dec 2019 11:45:30 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BE56B1535E9;
 Thu,  5 Dec 2019 16:45:29 +0000 (UTC)
Received: from [10.3.116.171] (ovpn-116-171.phx2.redhat.com [10.3.116.171])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 985796E3E1;
 Thu,  5 Dec 2019 16:45:26 +0000 (UTC)
Subject: Re: [PATCH v6] hw/core/qdev: cleanup Error ** variables
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Markus Armbruster <armbru@redhat.com>
References: <20191127192025.21594-1-vsementsov@virtuozzo.com>
 <87a78fz045.fsf@dusky.pond.sub.org>
 <6d311ad1-528c-5787-64d0-779d6dcbadef@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <61df02c1-2be4-a2fc-e320-c88666b673fc@redhat.com>
Date: Thu, 5 Dec 2019 10:45:26 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <6d311ad1-528c-5787-64d0-779d6dcbadef@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: eF4kZ4xdM6-YlRDq1hWaYA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/5/19 8:48 AM, Vladimir Sementsov-Ogievskiy wrote:

>>> @@ -918,27 +917,26 @@ static void device_set_realized(Object *obj, bool value, Error **errp)
>>>           }
>>>    
>>>        } else if (!value && dev->realized) {
>>> -        Error **local_errp = NULL;
>>> +        /* We want local_err to track only the first error */
>>>            QLIST_FOREACH(bus, &dev->child_bus, sibling) {
>>> -            local_errp = local_err ? NULL : &local_err;
>>>                object_property_set_bool(OBJECT(bus), false, "realized",
>>> -                                     local_errp);
>>> +                                     local_err ? NULL : &local_err);
>>>            }
>>
>> This is a rather unusual way to keep the first error of several.

It may be unusual, but has the benefit of avoiding error_propagate...

>> qapi/error.h advises:
>>
>>    * Receive and accumulate multiple errors (first one wins):
>>    *     Error *err = NULL, *local_err = NULL;
>>    *     foo(arg, &err);
>>    *     bar(arg, &local_err);
>>    *     error_propagate(&err, local_err);
>>    *     if (err) {
>>    *         handle the error...
>>    *     }
> 
> Hmm, honestly, I like more what I've written:
> 
> 1. less code
> 2. logic is more clean: we store first error to local_err, and after first error
>      pass NULL as a parameter. No propagation or extra error variables.
> 3. more efficient (no propagation, no extra allocation for errors which we'll drop
>      anyway) (I understand that efficiency of error path is not thing to care about,
>      so it's at third place)
> 
> Also, propagation which you propose is also unusual thing (it proposed in comment,
> but who reads it :). I've never seen it before, and I've to go and check that
> error_propagate works correctly when first argument is already set.
> 
> So, I'd prefer to keep now this patch as is, and to convert later if we really need it.
> 
>>
>> If replacing this by the usual way is too troublesome now, we can do it
>> after the ERRP_AUTO_PROPAGATE() conversion.  Your choice.

...and after conversion to use ERRP_AUTO_PROPATATE(), the use of 
error_propagate() should NOT occur in any code _except_ for the macro 
definition (any other use of the function points out a place where we 
failed to use the macro to get rid of boilerplate).

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


