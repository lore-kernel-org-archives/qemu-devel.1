Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31266C83000
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 22:13:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F066A206D9
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 22:13:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FxDoPvGl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F066A206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52638 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTYU7-0006bC-4B
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 18:13:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53404)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jTYSo-0005rA-Nm
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 18:12:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jTYQQ-0003Ze-DR
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 18:12:26 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:32534
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jTYQQ-0003ZM-0i
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 18:09:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588111796;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ev7pbIMvG/uvawCVJ+C1GviDhzA5QJRKbUnX2lqfpjQ=;
 b=FxDoPvGl9PHVBWjeBEMKUy5bAavrrl05Ttt4L80uzJ3DAICLTDB8PFU1deCvEn8tagNvK0
 QKGvJKAFpU5TbYp9Nt7V4Uw4NQXLgWKDNSfxAIGA4d1B8/wVYZj3XOQUM6iT1q/2ZdVMHg
 7GbqACEYf5oY6uTDwGBmAi8BQiR8/jQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-510-CsOvgQFBPqaO9L1NQAf-8g-1; Tue, 28 Apr 2020 18:09:50 -0400
X-MC-Unique: CsOvgQFBPqaO9L1NQAf-8g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C94B8462;
 Tue, 28 Apr 2020 22:09:47 +0000 (UTC)
Received: from [10.10.116.80] (ovpn-116-80.rdu2.redhat.com [10.10.116.80])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 289455D715;
 Tue, 28 Apr 2020 22:09:38 +0000 (UTC)
Subject: Re: [PATCH v2 01/17] block/throttle-groups:
 throttle_group_co_io_limits_intercept(): 64bit bytes
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20200427082325.10414-1-vsementsov@virtuozzo.com>
 <20200427082325.10414-2-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <ee14ab9f-023d-b913-7040-d4e0bd1d3104@redhat.com>
Date: Tue, 28 Apr 2020 17:09:38 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200427082325.10414-2-vsementsov@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/28 02:06:42
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
Cc: kwolf@redhat.com, fam@euphon.net, integration@gluster.org, berto@igalia.com,
 pavel.dovgaluk@ispras.ru, qemu-devel@nongnu.org, dillaman@redhat.com,
 pl@kamp.de, ronniesahlberg@gmail.com, mreitz@redhat.com, den@openvz.org,
 sheepdog@lists.wpkg.org, stefanha@redhat.com, namei.unix@gmail.com,
 pbonzini@redhat.com, sw@weilnetz.de, jsnow@redhat.com, ari@tuxera.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/27/20 3:23 AM, Vladimir Sementsov-Ogievskiy wrote:
> The function is called from 64bit io handlers, and bytes is just passed
> to throttle_account() which is 64bit too (unsigned though). So, let's
> convert intermediate argument to 64bit too.

My audit for this patch:

Caller has 32-bit, this patch now causes widening which is safe:
block/block-backend.c: blk_do_preadv() passes 'unsigned int'
block/block-backend.c: blk_do_pwritev_part() passes 'unsigned int'
block/throttle.c: throttle_co_pwrite_zeroes() passes 'int'
block/throttle.c: throttle_co_pdiscard() passes 'int'

Caller has 64-bit, this patch fixes potential bug where pre-patch could 
narrow, except it's easy enough to trace that callers are still capped 
at 2G actions:
block/throttle.c: throttle_co_preadv() passes 'uint64_t'
block/throttle.c: throttle_co_pwritev() passes 'uint64_t'

Implementation in question: block/throttle-groups.c 
throttle_group_co_io_limits_intercept() takes 'unsigned int bytes' and 
uses it:
argument to util/throttle.c throttle_account(uint64_t)

All safe: it patches a latent bug, and does not introduce any 64-bit 
gotchas once throttle_co_p{read,write}v are relaxed, and assuming 
throttle_account() is not buggy.

> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   include/block/throttle-groups.h | 2 +-
>   block/throttle-groups.c         | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


