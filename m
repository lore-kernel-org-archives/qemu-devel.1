Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C46FFC47404
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 21:52:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 959F02084C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 21:52:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 959F02084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57430 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJ2qG-0004V5-O1
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 17:52:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58011)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iJ2m6-0007BO-Dg
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 17:48:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iJ2m5-0007ed-93
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 17:48:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53654)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1iJ2m2-0007bh-Dj; Fri, 11 Oct 2019 17:48:34 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 80E3C368DA;
 Fri, 11 Oct 2019 21:48:31 +0000 (UTC)
Received: from [10.3.116.168] (ovpn-116-168.phx2.redhat.com [10.3.116.168])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CC18D10016EB;
 Fri, 11 Oct 2019 21:48:23 +0000 (UTC)
Subject: Re: [PULL 01/19] util/hbitmap: strict hbitmap_reset
To: John Snow <jsnow@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org
References: <20191011212550.27269-1-jsnow@redhat.com>
 <20191011212550.27269-2-jsnow@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <15c20480-0240-bdd2-2cc2-60c388022e86@redhat.com>
Date: Fri, 11 Oct 2019 16:48:22 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191011212550.27269-2-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Fri, 11 Oct 2019 21:48:31 +0000 (UTC)
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org,
 Juan Quintela <quintela@redhat.com>, libvir-list@redhat.com,
 Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/11/19 4:25 PM, John Snow wrote:
> From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> 
> hbitmap_reset has an unobvious property: it rounds requested region up.
> It may provoke bugs, like in recently fixed write-blocking mode of
> mirror: user calls reset on unaligned region, not keeping in mind that
> there are possible unrelated dirty bytes, covered by rounded-up region
> and information of this unrelated "dirtiness" will be lost.
> 
> Make hbitmap_reset strict: assert that arguments are aligned, allowing
> only one exception when @start + @count == hb->orig_size. It's needed
> to comfort users of hbitmap_next_dirty_area, which cares about
> hb->orig_size.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Reviewed-by: Max Reitz <mreitz@redhat.com>
> Message-Id: <20190806152611.280389-1-vsementsov@virtuozzo.com>
> [Maintainer edit: Max's suggestions from on-list. --js]
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>   include/qemu/hbitmap.h | 5 +++++
>   tests/test-hbitmap.c   | 2 +-
>   util/hbitmap.c         | 4 ++++
>   3 files changed, 10 insertions(+), 1 deletion(-)
> 

> +++ b/util/hbitmap.c
> @@ -476,6 +476,10 @@ void hbitmap_reset(HBitmap *hb, uint64_t start, uint64_t count)
>       /* Compute range in the last layer.  */
>       uint64_t first;
>       uint64_t last = start + count - 1;
> +    uint64_t gran = 1ULL << hb->granularity;
> +
> +    assert(!(start & (gran - 1)));
> +    assert(!(count & (gran - 1)) || (start + count == hb->orig_size));

I know I'm replying a bit late (since this is now a pull request), but 
would it be worth using the dedicated macro:

assert(QEMU_IS_ALIGNED(start, gran));
assert(QEMU_IS_ALIGNED(count, gran) || start + count == hb->orig_size);

instead of open-coding it?  (I would also drop the extra () around the 
right half of ||). If we want it, that would now be a followup patch.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org

