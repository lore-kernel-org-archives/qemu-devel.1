Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61E9CC2D0D2
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 22:05:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DB8A2146E
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 22:05:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LYOjuCn+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DB8A2146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34024 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiQOz-0004FZ-CS
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 17:05:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43473)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iiQO1-0003ce-MP
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 17:04:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iiQO0-0005wq-75
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 17:04:41 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:43988
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1iiQO0-0005qy-1G
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 17:04:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576879478;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hnlyTZgOJHAsuOfa5IIIVZoQbVuOJQdF4irQMuSvRUI=;
 b=LYOjuCn+BdMscxUjxuTYOiPWLrc84fa3HeFCryzI6p6ASsIq84/iOSHWZM8Dmd5skAXvXp
 U6wEAlxXUS0z6lNtvKQFrCfCM2AZHbKHdu9bN+lrwYP2qN2fkGAgDJ1R2gggSwUt9czQ1e
 FZF6P2vo94+MO1oFMbwded8IHE8SbqQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-123-WdqA6BXMMmyj-AVouyQswg-1; Fri, 20 Dec 2019 17:04:37 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 344C2107ACC4;
 Fri, 20 Dec 2019 22:04:36 +0000 (UTC)
Received: from [10.3.116.246] (ovpn-116-246.phx2.redhat.com [10.3.116.246])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9E29B5D729;
 Fri, 20 Dec 2019 22:04:35 +0000 (UTC)
Subject: Re: [PATCH] qapi/block: fix nbd-server-add spec
To: Nir Soffer <nsoffer@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
References: <20191219143415.28490-1-vsementsov@virtuozzo.com>
 <CAMRbyyt8Y8DFV5=72+GvHrAWbdUO5Mys5JGn7D8es+w2SVcRMA@mail.gmail.com>
 <c97f28de-c924-bc42-4725-09b633a28674@virtuozzo.com>
 <CAMRbyyv+h7UrR-vPJVMeGQpp-8Di-VuAZJit798L0Wda0BiE7A@mail.gmail.com>
 <0d6ea2fe-2f4f-00d4-2f13-20591b56310d@virtuozzo.com>
 <CAMRbyys6na7S4q00VR81LNhfNvtEXUAFQV=2R1O506+p_U+VKA@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <6a3120ba-fcb1-568c-5e1c-8226623e416b@redhat.com>
Date: Fri, 20 Dec 2019 16:04:35 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAMRbyys6na7S4q00VR81LNhfNvtEXUAFQV=2R1O506+p_U+VKA@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: WdqA6BXMMmyj-AVouyQswg-1
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
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-block <qemu-block@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/19/19 10:14 AM, Nir Soffer wrote:

>>>> 1. Using disk name as a bitmap name is a bad behavior, as they are completely
>>>> different concepts. Especially keeping in mind that user already knows disk name anyway
>>>> and no reason to write this export name inside metadata context of this export.
>>>
>>> The different concept is expressed by the "qemu:dirty-bitmap:" prefix.
>>> "qemu:dirty-bitmap:export-name" means the dirty bitmap for this export.
>>
>> Why do you think so? Did you read NBD specification?
> 
> Yes - the name of the bitmap does not have any meaning.
> But for nbd_server_add we allow only single bitmap for export.

Just because qemu is currently limited to only exposing one bitmap at 
the moment does not mean that a future version can't expose multiple 
bitmaps. It may very well be that we have reason to expose both 
"qemu:dirty-bitmap:timeA" and "qemu:dirty-bitmap:timeB" on the same 
export, for exposing two bitmaps at once.  To get to that point, we'd 
have to refactor the QAPI command to allow attaching more than one 
bitmap at the time of creating the NBD export, but it's not impossible.

> 
>> Metadata context is always owned by some export.
> 
> Of course.
> 
>> Do you mean that there will bemetadata contexts
>>
>> qemu:dirty-bitmap:export-A
>> qemu:dirty-bitmap:export-B
>>
>> both defined for export-A?
> 
> It does not make sense, but it is valid.

If an image has multiple bitmaps, exposing all of those as separate 
contexts at the same time for a single export can indeed make sense.

> 
>>>> 2. It's not directly documented. You assume that NAME == @name. I understand that
>>>> it may be assumed.. But it's not documented.
>>>
>>> But NAME is likely to be understood as the name argument, and unlikely to be the
>>> bitmap name.
>>
>> Yes likely. But it's still bad specification, which should be fixed.
> 
> If we cannot change the current behavior since it will break current users,
> I agree fixing the spec to describe the current behavior is a good idea.

We need the doc fix. Whether we also want an additional fix adding an 
optional parameter allowing user control over the export name is also 
under debate (the fact that the old x-nbd-server-add-bitmap supported it 
shows that it may be useful, but it is not minimal, and as I pointed out 
at the time of removing x-, libvirt can always control what name is 
exposed by creating a temporary bitmap and merging from other bitmaps 
into the temporary).

We also have to think about a future of parallel backup jobs: libvirt 
can create a single temporary bitmap to expose whatever name it wants 
under one job, but if libvirt wants to expose the SAME user-visible name 
to two parallel jobs, it cannot create two bitmaps with the same name, 
so having a way to set the user-visible name of an arbitrary bitmap when 
producing the NBD export makes sense on that front.


>>>
>>>> 3. It's never worked like you write. So if we change the behavior, we'll break
>>>> existing users.
>>>
>>> Do we have existing users? isn't this new feature in 4.2?
>>
>> No, it's since 4.0

As long as altering the exported name is controlled by a new optional 
parameter, it does not hurt older 4.0 clients that do not use the new 
parameter.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


