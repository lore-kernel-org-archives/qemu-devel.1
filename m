Return-Path: <SRS0=qKtL=YC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 368EDC47404
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 20:28:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B841206BB
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 20:28:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B841206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56922 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIIZb-0004AQ-Lj
	for qemu-devel@archiver.kernel.org; Wed, 09 Oct 2019 16:28:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50758)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iIHLx-0002vx-Ol
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 15:10:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iIHLs-0002lr-Gz
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 15:10:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58042)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>)
 id 1iIHLk-0002hU-40; Wed, 09 Oct 2019 15:10:16 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E3E12769E1;
 Wed,  9 Oct 2019 19:10:13 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.36.118.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 291CC60167;
 Wed,  9 Oct 2019 19:09:56 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6B58F1138619; Wed,  9 Oct 2019 21:09:39 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH v4 04/31] error: auto propagated local_err
References: <20191001155319.8066-1-vsementsov@virtuozzo.com>
 <20191001155319.8066-5-vsementsov@virtuozzo.com>
 <87r23m8hvb.fsf@dusky.pond.sub.org>
 <b330f111-4e71-c3a6-4484-22dd25906b55@virtuozzo.com>
Date: Wed, 09 Oct 2019 21:09:39 +0200
In-Reply-To: <b330f111-4e71-c3a6-4484-22dd25906b55@virtuozzo.com> (Vladimir
 Sementsov-Ogievskiy's message of "Wed, 9 Oct 2019 08:17:44 +0000")
Message-ID: <87a7a9zqfg.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Wed, 09 Oct 2019 19:10:14 +0000 (UTC)
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
Cc: "fam@euphon.net" <fam@euphon.net>,
 "pburton@wavecomp.com" <pburton@wavecomp.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "codyprime@gmail.com" <codyprime@gmail.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "mark.cave-ayland@ilande.co.uk" <mark.cave-ayland@ilande.co.uk>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "kraxel@redhat.com" <kraxel@redhat.com>,
 "sundeep.lkml@gmail.com" <sundeep.lkml@gmail.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "quintela@redhat.com" <quintela@redhat.com>,
 "arikalo@wavecomp.com" <arikalo@wavecomp.com>,
 "mst@redhat.com" <mst@redhat.com>,
 "mdroth@linux.vnet.ibm.com" <mdroth@linux.vnet.ibm.com>,
 "pasic@linux.ibm.com" <pasic@linux.ibm.com>,
 "borntraeger@de.ibm.com" <borntraeger@de.ibm.com>,
 "joel@jms.id.au" <joel@jms.id.au>,
 "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>,
 "rth@twiddle.net" <rth@twiddle.net>,
 "farman@linux.ibm.com" <farman@linux.ibm.com>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>, "sw@weilnetz.de" <sw@weilnetz.de>,
 "groug@kaod.org" <groug@kaod.org>,
 "yuval.shaia@oracle.com" <yuval.shaia@oracle.com>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "clg@kaod.org" <clg@kaod.org>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "david@redhat.com" <david@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>,
 "david@gibson.dropbear.id.au" <david@gibson.dropbear.id.au>,
 "kwolf@redhat.com" <kwolf@redhat.com>,
 "integration@gluster.org" <integration@gluster.org>,
 "berrange@redhat.com" <berrange@redhat.com>,
 "andrew@aj.id.au" <andrew@aj.id.au>, "cohuck@redhat.com" <cohuck@redhat.com>,
 "qemu-s390x@nongnu.org" <qemu-s390x@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:

> 09.10.2019 11:04, Markus Armbruster wrote:
>> Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:
>> 
>>> Here is introduced ERRP_AUTO_PROPAGATE macro, to be used at start of
>>> functions with errp OUT parameter.
>>>
>>> It has three goals:
>>>
>>> 1. Fix issue with error_fatal & error_prepend/error_append_hint: user
>>> can't see this additional information, because exit() happens in
>>> error_setg earlier than information is added. [Reported by Greg Kurz]
>> 
>> Done in PATCH 07-31.
>> 
>>> 2. Fix issue with error_abort & error_propagate: when we wrap
>>> error_abort by local_err+error_propagate, resulting coredump will
>>> refer to error_propagate and not to the place where error happened.
>>> (the macro itself doesn't fix the issue, but it allows to [3.] drop all
>>> local_err+error_propagate pattern, which will definitely fix the issue)
>>> [Reported by Kevin Wolf]
>>>
>>> 3. Drop local_err+error_propagate pattern, which is used to workaround
>>> void functions with errp parameter, when caller wants to know resulting
>>> status. (Note: actually these functions could be merely updated to
>>> return int error code).
>> 
>> Not done.  Can you prototype this part?  A few manually done examples
>> would give us an idea how the complete solution would look like.  A
>> (semi-)automated complete conversion of a subsystem would additionally
>> give us an idea how to actually do the conversion.
>> 
>> We can discuss applying ERRP_AUTO_PROPAGATE() as a bug fix for 1., and
>> leave 2. and 3. for later.  Feels like a half-done job to me.  We've got
>> too many of those in the tree already.  Dunno.
>> 
>
> If update everything it's about 90-140 patches.
>
> The whole thing was done in "[RFC v2 0/9] error: auto propagated local_err"
> <20190923161231.22028-1-vsementsov@virtuozzo.com>
> https://lists.gnu.org/archive/html/qemu-devel/2019-09/msg05157.html
>
> - it was so huge, that I decided to postpone 2 and 3...

Suggest to post unsplit patches as RFC.  This lets us see how the macro
gets used, and can also help us decide on a sensible split.  The
automatic split isn't quite right in places, and feels excessively
fine-grained to me.

