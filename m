Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E30C8C43331
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 13:09:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0AF720772
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 13:09:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hF+kPp8I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0AF720772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jH5mv-0004PT-QD
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 09:09:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51950)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jH5mC-0003uO-Vu
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 09:08:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jH5mB-0006NM-UP
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 09:08:56 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:60691)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jH5mB-0006Mk-Qr
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 09:08:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585141735;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8YONF3k6LFaH1Rama/54mYyw6EYuDZFh6QfIDU0VVDQ=;
 b=hF+kPp8IzE3Iklx81lMj/kJ6DL2VFflDmlAGGtnutEs6jHGzgann6rvWc7yVyamoxjQb5K
 7YWxlMHIqzuPGGA7aftneeNTUG1j/+6KQq2BTrqG7tXSX1YDgDHurP82IuRNOMACpoh/Jq
 0P5lwJtDOyPYKFJE0ZBXLTP1qdxlR1w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-405-A-nNr99ZMfaRuRH1C8gaNw-1; Wed, 25 Mar 2020 09:08:53 -0400
X-MC-Unique: A-nNr99ZMfaRuRH1C8gaNw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 822791005516;
 Wed, 25 Mar 2020 13:08:52 +0000 (UTC)
Received: from [10.3.113.103] (ovpn-113-103.phx2.redhat.com [10.3.113.103])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D83589CA3;
 Wed, 25 Mar 2020 13:08:51 +0000 (UTC)
Subject: Re: [PATCH v2 0/2] Rework iotests finding
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20200325102131.23270-1-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <11877a2e-2815-19d9-603f-b7ea52cc3d6f@redhat.com>
Date: Wed, 25 Mar 2020 08:08:51 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200325102131.23270-1-vsementsov@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: kwolf@redhat.com, den@openvz.org, jsnow@redhat.com, qemu-devel@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/25/20 5:21 AM, Vladimir Sementsov-Ogievskiy wrote:
> Hi all!
> 
> When sending iotests to upstream or do patch porting from one branch
> to another we very often have to resolve conflicts in group file, as
> many absolutely independent features are intersecting by this file.
> These conflicts are simple, but imagine how much time we all have
> already spent on resolving them? Let's finally get rid of group file.
> 
> Next, another thing I don't like about iotests is race for test number
> chosing: you should search through mail box, before chosing test number
> for new test.
> 
> So, I propose to get rid of group file and search for tests another way
> [look at patch 02]. Additionally I propose to move to human-readable
> names for test files, with notation test-* .

I suggest swapping the name: It's easier to write a glob for *-test vs. 
*-test.out than it is to write for test-* but not test-*.out.  (You 
don't want to execute the output files as a test).  That is, I suggest 
that ./check consider all 3-digit files and all files ending in -test as 
tests.

> 
> v1 was one patch "[PATCH] iotests: drop group file"
> 
> Vladimir Sementsov-Ogievskiy (2):
>    iotests: define group in each iotests
>    iotests: rework test finding

Do you plan on an additional patch (or set of patches) to rename some or 
all of the existing 3-digit tests?

Overall, having sensibly named tests makes sense to me.

If we are going to rename files, I'd also suggest that we rename the 
directory: tests/qemu-iotests/ feels redundant, compared to tests/iotests.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


