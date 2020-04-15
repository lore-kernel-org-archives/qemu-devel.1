Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0337FC2BA19
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 21:14:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFF132051A
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 21:14:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b3Q5ToIM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFF132051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55122 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOpMW-0001ty-WA
	for qemu-devel@archiver.kernel.org; Wed, 15 Apr 2020 17:14:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42481)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jOpLl-0001MY-2H
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 17:13:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jOpLk-0002Oq-2h
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 17:13:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39492
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jOpLj-0002Om-W1
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 17:13:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586985215;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TMtWp2gDGLilPtjVfNp/Cp00peq/A8WQOL/noCDI+xQ=;
 b=b3Q5ToIMzlyiESibrN8rGhSHg7dEgNQcZs61HjpWn3KmbgiVD0BTxsmYBJld9F6bQGgTQK
 QN0maivHVJRX8xmKwdR1fV0umwDkbAS2r2inqElkOUaYV4I3A5fADxw325jRUFa1BViPSv
 T3aZokb0ss7fitFxhstO+0iDrXs77OQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-488-3ElCn3rlNuqelXoyVTStSg-1; Wed, 15 Apr 2020 17:13:31 -0400
X-MC-Unique: 3ElCn3rlNuqelXoyVTStSg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9184B107ACC4;
 Wed, 15 Apr 2020 21:13:29 +0000 (UTC)
Received: from [10.3.115.59] (ovpn-115-59.phx2.redhat.com [10.3.115.59])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C2215116D95;
 Wed, 15 Apr 2020 21:13:28 +0000 (UTC)
Subject: Re: [PATCH v4 07/30] qcow2: Document the Extended L2 Entries feature
To: Alberto Garcia <berto@igalia.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
References: <cover.1584468723.git.berto@igalia.com>
 <aa1ac3fbb1d42db67d930b76255c9b7b19c07b42.1584468723.git.berto@igalia.com>
 <8c88b96f-c6f5-e06c-73e1-56001089a7ca@redhat.com>
 <781c734c-e53c-76ae-74de-26d9e827e1a2@virtuozzo.com>
 <w51imi0zhrj.fsf@maestria.local.igalia.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <9b1aabf7-ed8b-28b1-578a-373f1d897c53@redhat.com>
Date: Wed, 15 Apr 2020 16:13:28 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <w51imi0zhrj.fsf@maestria.local.igalia.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Kevin Wolf <kwolf@redhat.com>, "Denis V . Lunev" <den@openvz.org>,
 Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/15/20 2:11 PM, Alberto Garcia wrote:
> On Fri 10 Apr 2020 11:29:59 AM CEST, Vladimir Sementsov-Ogievskiy wrote:
>>> Should we also document that extended L2 entries are incompatible
>>> with raw external files? [...] After all, when raw external file is
>>> enabled, the entire image is allocated, at which point subclusters
>>> don't make much sense.
>>
>> It still may cache information about zeroed subclusters: gives more
>> detailed block-status.

That's a good point about one reason why it might be useful.

> 
> So shall I forbid extended_l2 + data_file_raw then?
> 
> I wonder, if the only problem is that it's just not very useful, does it
> make sense to add additional complexity and restrictions to the code
> simply to prevent the user from making a sub-optimal choice?

At this point, I'm not seeing a technical reason why we have to forbid 
subclusters with data-file-raw.  Mixing may be inefficient compared to 
using raw-data-file without subclusters, but inefficiencies are not 
worth the code bloat to forbid the combination.  If we come up with a 
scenario where the mix would cause data corruption, that's a different 
story, but I'm not seeing such a reason at the moment.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


