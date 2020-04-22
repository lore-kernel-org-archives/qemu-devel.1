Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DCA9C5518C
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 14:54:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBEC12076E
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 14:54:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CarYwwwc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBEC12076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52158 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRGlJ-0003pa-Vi
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 10:54:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49756)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jRGk4-0002ti-DC
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 10:52:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jRGk3-0006Qv-HQ
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 10:52:47 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60872
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jRGk3-0006Ii-3X
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 10:52:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587567165;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/AacuimZn/7Xau3T9P1rbb3ee6+shF1hyhMDjXrA2ts=;
 b=CarYwwwc0T//eGsJ2EN1UB2SjK4DNrir2nA0mB6HeyfsZMb4iK24DYSwInWmbAD28iqxxK
 3++OY8DXxhlljdoCCRs7GM/dEsOx7YY2O2iNMxTeHnDv9HVnig9zKcqmDaKgOxlnzzAWC/
 miRnaJBpDWIiKKyOYfvBKeOw0tzrLgU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-36-HZ6YKr9hPDyYBM2pF_JqJA-1; Wed, 22 Apr 2020 10:52:40 -0400
X-MC-Unique: HZ6YKr9hPDyYBM2pF_JqJA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 503218017F5;
 Wed, 22 Apr 2020 14:52:38 +0000 (UTC)
Received: from [10.10.116.80] (ovpn-116-80.rdu2.redhat.com [10.10.116.80])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7FF805D714;
 Wed, 22 Apr 2020 14:52:29 +0000 (UTC)
Subject: Re: [RFC 0/3] 64bit block-layer part I
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20200330141818.31294-1-vsementsov@virtuozzo.com>
 <572e78c6-f346-58e8-98cd-1b355e5bb33b@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <a900074d-149a-7311-9da9-600d32c874ee@redhat.com>
Date: Wed, 22 Apr 2020 09:52:28 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <572e78c6-f346-58e8-98cd-1b355e5bb33b@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/22 04:15:03
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: fam@euphon.net, kwolf@redhat.com, berto@igalia.com, stefanha@redhat.com,
 pavel.dovgaluk@ispras.ru, sw@weilnetz.de, pl@kamp.de, qemu-devel@nongnu.org,
 mreitz@redhat.com, jsnow@redhat.com, ronniesahlberg@gmail.com, den@openvz.org,
 pbonzini@redhat.com, dillaman@redhat.com, ari@tuxera.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/22/20 9:29 AM, Vladimir Sementsov-Ogievskiy wrote:
> Any thoughts here? I need to resend to update some more functions as 
> patchew said.
> 
> Is it OK in general? Or should we instead convert everything to uint64_t ?

I definitely prefer int64_t as our base (off_t is signed as well, making 
63 bits an effective limit everywhere).

> 
> 30.03.2020 17:18, Vladimir Sementsov-Ogievskiy wrote:
>> Hi all!
>>
>> There is an idea to make NBD protocol extension to support 64bit
>> write-zero/discard/block-status commands (commands, which doesn't
>> transfer user data). It's needed to increase performance of zeroing
>> large ranges (up to the whole image). Zeroing of the whole image is used
>> as first step of mirror job, qemu-img convert, it should be also used at
>> start of backup actually..
>>
>> We need to support it in block-layer, so we want 64bit write_zeros.
>> Currently driver handler now have int bytes parameter.
>>
>> write_zeros path goes through normal pwritev, so we need 64bit write,
>> and then we need 64bit read for symmetry, and better, let's make all io
>> path work with 64bit bytes parameter.
>>
>> Actually most of block-layer already have 64bit parameters: offset is
>> sometimes int64_t and sometimes uint64_t. bytes parameter is one of
>> int64_t, uint64_t, int, unsigned int...
>>
>> I think we need one type for all of this, and this one type is int64_t.
>> Signed int64_t is a bit better than uint64_t: you can use same variable
>> to get some result (including error < 0) and than reuse it as an
>> argument without any type conversion.
>>
>> So, I propose, as a first step, convert all uint64_t parameters to
>> int64_t.

Makes sense.  I haven't looked at the series closely in part because it 
was 5.1 material while we were still focused on getting 5.0 out the 
door, but it is now raising in my review queue again.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


