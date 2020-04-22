Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E4DCC54FCB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 19:34:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03C4D20767
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 19:34:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y6Z6tjNj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03C4D20767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56644 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRL8m-0005xZ-55
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 15:34:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46812)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jRL7X-0004f4-Mk
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 15:33:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jRL7J-00077M-Lp
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 15:33:19 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:31364
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jRL7J-000753-25
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 15:33:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587583983;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ERxdDVa5oRVkc0/Dwv5Qm8XSe2G6G0g5zcmMIbq09wI=;
 b=Y6Z6tjNjiOQAQefBnUOAS5unK5j6TDCAi7J4qPJbvXrVNTXjjYJrRW/L1hAPu5+OU8YM0u
 u32BMA25in9cqmGdk9w3T1V50dg9WUe2O/8sGXZvMHH5CF9de3kX+8qoJwgUl7W/5lvb1G
 OnB+DC5rvxU7v8pe3KZKMdf+XgHjAuc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-250-PCJoDGBHMeCmNZkHjp-ltA-1; Wed, 22 Apr 2020 15:32:58 -0400
X-MC-Unique: PCJoDGBHMeCmNZkHjp-ltA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4A7B713FE;
 Wed, 22 Apr 2020 19:32:56 +0000 (UTC)
Received: from [10.10.116.80] (ovpn-116-80.rdu2.redhat.com [10.10.116.80])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 37C426084A;
 Wed, 22 Apr 2020 19:32:47 +0000 (UTC)
Subject: Re: [RFC 0/3] 64bit block-layer part I
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20200330141818.31294-1-vsementsov@virtuozzo.com>
 <2f3d6f44-0e1c-0999-7e22-752262f5a735@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <68af8eba-2e1b-5e7d-195f-884ef27dc56e@redhat.com>
Date: Wed, 22 Apr 2020 14:32:47 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <2f3d6f44-0e1c-0999-7e22-752262f5a735@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/22 02:57:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: fam@euphon.net, kwolf@redhat.com, berto@igalia.com, stefanha@redhat.com,
 pavel.dovgaluk@ispras.ru, sw@weilnetz.de, pl@kamp.de, qemu-devel@nongnu.org,
 mreitz@redhat.com, jsnow@redhat.com, ronniesahlberg@gmail.com, den@openvz.org,
 pbonzini@redhat.com, dillaman@redhat.com, ari@tuxera.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/22/20 1:24 PM, Vladimir Sementsov-Ogievskiy wrote:

>> So, I think the simplest way is to add .bdrv_co_pwritev_zeros64 and
>> .bdrv_co_pdiscard64 and update drivers one-by-one. If at some point all
>> drivers updated - drop unused 32bit functions, and then drop "64" suffix
>> from API. If not - we'll live with both APIs.
> 
> Hmm. Or, maybe nothing dangerous if we convert it to 64bit, and add 
> comment,
> that function is not actually prepared for 64bit bytes and depends on
> max_transfer/max_zeroes being <= INT_MAX ?
> 
> Or, maybe better, keep old functions as is and add 64bit wrappers, which
> assert that bytes < INT_MAX, and call old function? This is clean, driver
> maybe updated later on demand, and we don't need extra API. If no 
> objections,
> I'll try this way in the next version.

That approach sounds good; it matches how we added flags and iov 
support, as well as how we transitioned from sector interfaces over to 
byte interfaces: we added a new .bdrv_ callback for the drivers that 
could take advantage of the increased interface, without having to touch 
the older drivers using the old callbacks, then only later finally got 
rid of the old interfaces as we modernized other drivers.  There's still 
the issue of how much we convert in the initial series - even if adding 
a new wrapper makes it easier to patch only one driver at a time, it's 
not nice to leave the job half-done by not visiting all of the drivers 
eventually.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


