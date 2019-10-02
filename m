Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A035C35280
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 14:02:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F18721A4C
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 14:02:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F18721A4C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55644 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFfDT-0005Xx-6g
	for qemu-devel@archiver.kernel.org; Wed, 02 Oct 2019 10:02:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34337)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iFfC7-0004hW-Er
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 10:01:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iFfC6-0001wd-DE
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 10:01:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:25227)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1iFfC0-0001t0-GU; Wed, 02 Oct 2019 10:01:24 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8B8FE3090FD6;
 Wed,  2 Oct 2019 14:01:22 +0000 (UTC)
Received: from [10.3.117.6] (ovpn-117-6.phx2.redhat.com [10.3.117.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D75375D9D3;
 Wed,  2 Oct 2019 14:00:48 +0000 (UTC)
Subject: Re: [PATCH v4 04/31] error: auto propagated local_err
To: Roman Kagan <rkagan@virtuozzo.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, fam@euphon.net, pburton@wavecomp.com,
 peter.maydell@linaro.org, codyprime@gmail.com, jasowang@redhat.com,
 mark.cave-ayland@ilande.co.uk, mdroth@linux.vnet.ibm.com, kraxel@redhat.com,
 sundeep.lkml@gmail.com, qemu-block@nongnu.org, quintela@redhat.com,
 arikalo@wavecomp.com, mst@redhat.com, armbru@redhat.com,
 pasic@linux.ibm.com, borntraeger@de.ibm.com, joel@jms.id.au,
 marcandre.lureau@redhat.com, rth@twiddle.net, farman@linux.ibm.com,
 ehabkost@redhat.com, sw@weilnetz.de, groug@kaod.org, yuval.shaia@oracle.com,
 dgilbert@redhat.com, alex.williamson@redhat.com, integration@gluster.org,
 clg@kaod.org, stefanha@redhat.com, david@redhat.com, jsnow@redhat.com,
 david@gibson.dropbear.id.au, kwolf@redhat.com, berrange@redhat.com,
 andrew@aj.id.au, cohuck@redhat.com, qemu-s390x@nongnu.org,
 mreitz@redhat.com, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 pbonzini@redhat.com
References: <20191001155319.8066-1-vsementsov@virtuozzo.com>
 <20191001155319.8066-5-vsementsov@virtuozzo.com>
 <20191002101535.GA30896@rkaganb.sw.ru>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <d644082d-2463-a095-146c-1648f65b4dfe@redhat.com>
Date: Wed, 2 Oct 2019 09:00:48 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191002101535.GA30896@rkaganb.sw.ru>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Wed, 02 Oct 2019 14:01:23 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/2/19 5:15 AM, Roman Kagan wrote:
> On Tue, Oct 01, 2019 at 06:52:52PM +0300, Vladimir Sementsov-Ogievskiy wrote:
>> Here is introduced ERRP_AUTO_PROPAGATE macro, to be used at start of
>> functions with errp OUT parameter.
>>
>> It has three goals:
>>
>> 1. Fix issue with error_fatal & error_prepend/error_append_hint: user
>> can't see this additional information, because exit() happens in
>> error_setg earlier than information is added. [Reported by Greg Kurz]
>>

>> +/*
>> + * ERRP_AUTO_PROPAGATE
>> + *

>> +#define ERRP_AUTO_PROPAGATE() \
>> +g_auto(ErrorPropagator) __auto_errp_prop = {.errp = errp}; \
>> +errp = ((errp == NULL || *errp == error_fatal) ? \
>> +    &__auto_errp_prop.local_err : errp)
>> +
> 
> I guess it has been discussed but I couldn't find it, so: what's the
> reason for casting in stone the name of the function parameter, which
> isn't quite so obvious when you see this macro used in the code?  IMO
> if the macro took errp as a parameter that would be easier to follow.

It was discussed.  Forcing a specific name of the 'Error **errp' has 
tradeoffs:

Pro: possible to write a sed script to check for missing spots in the 
macros (in fact, my sed script found spots missed by Coccinelle when not 
using the correct --macro-header option)
Pro: enforces uniform style
Con: misses instances that have typos or otherwise used the wrong name

Allowing the macro to take the name of the parameter:
Pro/Con: More flexible (allows use in more place, but loses consistency)
Pro: Coccinelle can still handle the conversion
Con: using sed to check if Coccinelle missed anything is harder

But opinions on how to paint the bikeshed are still welcome; it's easy 
enough to respin the series with the macro taking an argument if that 
is agreed to indeed be more legible.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org

