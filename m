Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69497C83004
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 12:54:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3759A208FE
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 12:54:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aY8mKZmc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3759A208FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56650 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTmER-0005RV-9x
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 08:54:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59940)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jTmDq-0004yL-VB
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 08:53:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jTmDp-0000u5-VU
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 08:53:54 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:42004
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jTmDp-0000tx-H7
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 08:53:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588164831;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sr80BAcCGTGsqibYVrusLSQgX2oG9nvyxxo/Ir0COlc=;
 b=aY8mKZmcs+4vRfELUsukzaIIeokWX3re/NacV3EqHxNcEobbJgqCoLqDr+DWg2hHDuvyxs
 gQHDU3TlgyjTE9rII5536M2FfF+3/vIlhrtyxZhacf7guNTAlIg3RZSNMU2sN83oAMkkM7
 lFuOuopTLts4z0W4XkDwmZ3qYwc5F2w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-58-tCOTi3_IMg-eted-sZW-yQ-1; Wed, 29 Apr 2020 08:53:48 -0400
X-MC-Unique: tCOTi3_IMg-eted-sZW-yQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 61666107ACF4;
 Wed, 29 Apr 2020 12:53:44 +0000 (UTC)
Received: from [10.10.116.80] (ovpn-116-80.rdu2.redhat.com [10.10.116.80])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B0FD4648C8;
 Wed, 29 Apr 2020 12:53:33 +0000 (UTC)
Subject: Re: [PATCH v2 01/17] block/throttle-groups:
 throttle_group_co_io_limits_intercept(): 64bit bytes
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20200427082325.10414-1-vsementsov@virtuozzo.com>
 <20200427082325.10414-2-vsementsov@virtuozzo.com>
 <ee14ab9f-023d-b913-7040-d4e0bd1d3104@redhat.com>
 <f62763d5-cd42-41dd-e09d-79087a67e709@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <2770565f-fc59-ed84-a138-d8595761592b@redhat.com>
Date: Wed, 29 Apr 2020 07:53:32 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <f62763d5-cd42-41dd-e09d-79087a67e709@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 00:53:13
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

On 4/29/20 12:05 AM, Vladimir Sementsov-Ogievskiy wrote:
> 29.04.2020 1:09, Eric Blake wrote:
>> On 4/27/20 3:23 AM, Vladimir Sementsov-Ogievskiy wrote:
>>> The function is called from 64bit io handlers, and bytes is just passed
>>> to throttle_account() which is 64bit too (unsigned though). So, let's
>>> convert intermediate argument to 64bit too.
>>
>> My audit for this patch:
>>
>> Caller has 32-bit, this patch now causes widening which is safe:
>> block/block-backend.c: blk_do_preadv() passes 'unsigned int'
>> block/block-backend.c: blk_do_pwritev_part() passes 'unsigned int'
>> block/throttle.c: throttle_co_pwrite_zeroes() passes 'int'
>> block/throttle.c: throttle_co_pdiscard() passes 'int'
>>
>> Caller has 64-bit, this patch fixes potential bug where pre-patch=20
>> could narrow, except it's easy enough to trace that callers are still=20
>> capped at 2G actions:
>> block/throttle.c: throttle_co_preadv() passes 'uint64_t'
>> block/throttle.c: throttle_co_pwritev() passes 'uint64_t'
>>
>> Implementation in question: block/throttle-groups.c=20
>> throttle_group_co_io_limits_intercept() takes 'unsigned int bytes' and=
=20
>> uses it:
>> argument to util/throttle.c throttle_account(uint64_t)
>>
>> All safe: it patches a latent bug, and does not introduce any 64-bit=20
>> gotchas once throttle_co_p{read,write}v are relaxed, and assuming=20
>> throttle_account() is not buggy.
>=20
> Should I add this all to commit message?

It never hurts to provide such rationale ;)

>=20
>>
>>>
>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>> ---
>>> =A0 include/block/throttle-groups.h | 2 +-
>>> =A0 block/throttle-groups.c=A0=A0=A0=A0=A0=A0=A0=A0 | 2 +-
>>> =A0 2 files changed, 2 insertions(+), 2 deletions(-)
>>
>> Reviewed-by: Eric Blake <eblake@redhat.com>
>>
>=20
> Thanks for careful review!
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


