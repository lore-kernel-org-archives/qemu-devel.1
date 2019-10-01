Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 954BFC352AA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 17:11:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 669422086A
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 17:11:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 669422086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45426 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFLfv-0006yr-Il
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 13:10:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60123)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iFLeK-0005aI-8g
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 13:09:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iFLeJ-0002eU-73
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 13:09:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60910)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1iFLeD-0002b3-8p; Tue, 01 Oct 2019 13:09:13 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id BD9B0898111;
 Tue,  1 Oct 2019 17:09:11 +0000 (UTC)
Received: from [10.3.116.201] (ovpn-116-201.phx2.redhat.com [10.3.116.201])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6FE0E6012C;
 Tue,  1 Oct 2019 17:08:51 +0000 (UTC)
Subject: Re: [PATCH v4 05/31] scripts: add script to fix
 error_append_hint/error_prepend usage
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
References: <20191001155319.8066-1-vsementsov@virtuozzo.com>
 <20191001155319.8066-6-vsementsov@virtuozzo.com>
 <5c4788f0-0ba9-94bb-b677-d7d34f064cde@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <11bc4202-2230-52ad-eac2-663649429072@redhat.com>
Date: Tue, 1 Oct 2019 12:08:50 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <5c4788f0-0ba9-94bb-b677-d7d34f064cde@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.67]); Tue, 01 Oct 2019 17:09:12 +0000 (UTC)
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
Cc: fam@euphon.net, pburton@wavecomp.com, peter.maydell@linaro.org,
 jasowang@redhat.com, mark.cave-ayland@ilande.co.uk, mdroth@linux.vnet.ibm.com,
 kraxel@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org,
 quintela@redhat.com, arikalo@wavecomp.com, mst@redhat.com, armbru@redhat.com,
 pasic@linux.ibm.com, borntraeger@de.ibm.com, joel@jms.id.au,
 marcandre.lureau@redhat.com, david@gibson.dropbear.id.au, ehabkost@redhat.com,
 sw@weilnetz.de, groug@kaod.org, yuval.shaia@oracle.com, dgilbert@redhat.com,
 alex.williamson@redhat.com, qemu-arm@nongnu.org, clg@kaod.org,
 stefanha@redhat.com, david@redhat.com, rth@twiddle.net, kwolf@redhat.com,
 integration@gluster.org, berrange@redhat.com, andrew@aj.id.au,
 cohuck@redhat.com, qemu-s390x@nongnu.org, sundeep.lkml@gmail.com,
 qemu-ppc@nongnu.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/1/19 11:50 AM, Eric Blake wrote:
> On 10/1/19 10:52 AM, Vladimir Sementsov-Ogievskiy wrote:
>> error_append_hint and error_prepend will not work, if errp ==
>> &fatal_error, as program will exit before error_append_hint or
>> error_prepend call. Fix this by use of special macro
>> ERRP_AUTO_PROPAGATE.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>
> 
>> +++ b/scripts/coccinelle/fix-error-add-info.cocci
>> @@ -0,0 +1,28 @@
>> +@rule0@
>> +// Add invocation to errp-functions
>> +identifier fn;

Adding:

symbol errp;

to this section appears to be the correct solution for...

>> +@@
>> +
>> + fn(..., Error **errp, ...)
>> + {
> 
> When running this script, I get lots of warnings:
> 
> init_defs_builtins: /usr/lib64/coccinelle/standard.h
> warning: line 6: should errp be a metavariable?
> warning: line 11: should errp be a metavariable?
> warning: line 13: should errp be a metavariable?
> HANDLING: include/block/nbd.h
> 

silencing these warnings.  But it's still not enough to fix the issue 
I'm pointing out in patch 23 being incomplete.


-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org

