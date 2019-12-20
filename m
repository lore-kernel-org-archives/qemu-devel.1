Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9769C43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 22:00:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACEE62082E
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 22:00:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M3DdkaCr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACEE62082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33944 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiQJV-00027D-M8
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 17:00:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36117)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iiQIM-0000no-LB
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 16:59:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iiQI1-000099-6A
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 16:58:48 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23819
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1iiQI0-0008Uf-RJ
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 16:58:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576879107;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CXgcWYExOz2HeuQSzSPZEw7iwzRIvdSCDl54l+JjxB4=;
 b=M3DdkaCrg9DJU3ix8OQuT7+hNOzmaaWf5H/qvHzbqeIXMpn6AzAKtwTQB1AjVmN21aGd7U
 +I9GaLFF90iPe7QqqDPBrs7i2x45RE8NIvm3yKGDcPzTWCiwjwa65vnbI1JweuMZKtYdHN
 47eyVJzfhPffljsGLwHBJVXRtkm4bOI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-126-GYD1a1gaMBK38ZeS0HNAyg-1; Fri, 20 Dec 2019 16:58:24 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F22582EE3;
 Fri, 20 Dec 2019 21:58:22 +0000 (UTC)
Received: from [10.3.116.246] (ovpn-116-246.phx2.redhat.com [10.3.116.246])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4067619C68;
 Fri, 20 Dec 2019 21:58:22 +0000 (UTC)
Subject: Re: [PATCH] qapi/block: fix nbd-server-add spec
To: Nir Soffer <nsoffer@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
References: <20191219143415.28490-1-vsementsov@virtuozzo.com>
 <CAMRbyyt8Y8DFV5=72+GvHrAWbdUO5Mys5JGn7D8es+w2SVcRMA@mail.gmail.com>
 <c97f28de-c924-bc42-4725-09b633a28674@virtuozzo.com>
 <CAMRbyyv+h7UrR-vPJVMeGQpp-8Di-VuAZJit798L0Wda0BiE7A@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <dce85cb2-7ade-879f-52eb-82157048e0e0@redhat.com>
Date: Fri, 20 Dec 2019 15:58:21 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAMRbyyv+h7UrR-vPJVMeGQpp-8Di-VuAZJit798L0Wda0BiE7A@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: GYD1a1gaMBK38ZeS0HNAyg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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

On 12/19/19 9:08 AM, Nir Soffer wrote:

>>>> Let's just fix qapi spec now.
>>>
>>> But qapi documents a better behavior for users. We should fix the code instead
>>> to mach the docs.
>>
>> 1. Using disk name as a bitmap name is a bad behavior, as they are completely
>> different concepts. Especially keeping in mind that user already knows disk name anyway
>> and no reason to write this export name inside metadata context of this export.
> 
> The different concept is expressed by the "qemu:dirty-bitmap:" prefix.
> "qemu:dirty-bitmap:export-name" means the dirty bitmap for this export.
> 
>> 2. It's not directly documented. You assume that NAME == @name. I understand that
>> it may be assumed.. But it's not documented.
> 
> But NAME is likely to be understood as the name argument, and unlikely to be the
> bitmap name.

That's a misunderstanding due to poor docs.  The bitmap name has always 
been what was exposed, ever since we promoted things to stable by 
getting rid of x-.

> 
>> 3. It's never worked like you write. So if we change the behavior, we'll break
>> existing users.
> 
> Do we have existing users? isn't this new feature in 4.2?

No, the feature stems back to 4.0, when we got rid of x-.  There are 
other reasons that dirty bitmaps aren't really usable for incremental 
backups without qemu 4.2, but qemu 4.0 was the first time we exposed a 
stable interface for a bitmap over an NBD export, and that release used 
the bitmap name (and not the export name), so at this point, a code 
change would break expectations of any 4.0 client using bitmaps for 
other reasons.  Libvirt currently has absolute control over the bitmap 
name (my initial code in libvirt created a temporary bitmap with my 
desired name, then merged the contents from the permanent bitmaps 
corresponding to the actual libvirt Checkpoint objects into the 
temporary, so that it could then call nbd-export-add with the temporary 
bitmap name).  But, as you point out...

> 
> Before we had experimental x-block-dirty-bitmap APIs, which are stable, so users
> could not depend on them.

The unstable x-block-dirty-bitmap APIs _did_ have a way to export a 
user-controlled name SEPARATE from the bitmap name.  At the time I was 
removing the x- prefix, I asked if anyone had a strong use case for 
keeping that functionality.  No one spoke up in favor of keeping it 
(Nikolay mentioned using the old interface, but not being stumped by its 
removal), so we nuked it at the time.  We can always add it back (now 
that it sounds like you have a use case where it may be more 
compelling), but it was easier to stabilize less and add more later as 
needed, than to stabilize too much and regret that we had to support the 
flexibility that no one needed.
https://lists.gnu.org/archive/html/qemu-devel/2019-01/msg02373.html
https://lists.gnu.org/archive/html/qemu-devel/2019-01/msg01970.html

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


