Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4753BC4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 13:48:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F4182086D
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 13:48:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="ZNdpPzbl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F4182086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60114 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgrF6-00030Q-DD
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 09:48:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46143)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <berto@igalia.com>) id 1hgqS3-0000k8-BY
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 08:58:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berto@igalia.com>) id 1hgqS1-0000q1-L2
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 08:58:03 -0400
Received: from fanzine.igalia.com ([91.117.99.155]:47182)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <berto@igalia.com>)
 id 1hgqS1-0000nf-1R; Fri, 28 Jun 2019 08:58:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=wXVvbiFD7qLv6TXbeFXl1hKqEZXVDJBB98GmB7gk7qs=; 
 b=ZNdpPzbl5T7W3LM+c+xDu1aCuRZ433VB7cXxE1J40hiNxvtLdLB+WonOR8hz4QUrm27DpbNO9UHseKvgKQEyMl2sopgZEAGJBQRCpsefzRwi1GcRtJc1fEfs2G18bJwqXgOKbOCwFWjpXe7NaFPbPDFHpcC0gVN1UEwIK4m/oA19MTgy7eOpOQDwftM5OIVKIbbTDg4OwB2qpsszsBmCD7sZ68JX0OnuFDdKuHUzUw+4h6ft/5Q2t+I7FuyqUroueDFOV9WE+hZdB9d1783pMpN0QNqT6+4otOYqXGIsQSmOZeaA4kDWDrD6DN7hSFghZo5LDbtaJc77UTrrCaduiA==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1hgqRw-0003FY-9K; Fri, 28 Jun 2019 14:57:56 +0200
Received: from berto by mail.igalia.com with local (Exim)
 id 1hgqRw-0008Nx-6S; Fri, 28 Jun 2019 14:57:56 +0200
From: Alberto Garcia <berto@igalia.com>
To: Kevin Wolf <kwolf@redhat.com>
In-Reply-To: <20190627165434.GE5618@localhost.localdomain>
References: <20190627135914.xlzohrdwr6mz2aq3@perseus.local>
 <20190627165434.GE5618@localhost.localdomain>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Fri, 28 Jun 2019 14:57:56 +0200
Message-ID: <w5136jtkgtn.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x (no
 timestamps) [generic] [fuzzy]
X-Received-From: 91.117.99.155
Subject: Re: [Qemu-devel] [RFC] Re-evaluating subcluster allocation for
 qcow2 images
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
Cc: Anton Nefedov <anton.nefedov@virtuozzo.com>,
 "Denis V. Lunev" <den@virtuozzo.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu 27 Jun 2019 06:54:34 PM CEST, Kevin Wolf wrote:
>> |-----------------+----------------+-----------------|
>> |  Cluster size   | subclusters=on | subclusters=off |
>> |-----------------+----------------+-----------------|
>> |   2 MB (256 KB) |   571 IOPS     |  124 IOPS       |
>> |   1 MB (128 KB) |   863 IOPS     |  212 IOPS       |
>> | 512 KB  (64 KB) |  1678 IOPS     |  365 IOPS       |
>> | 256 KB  (32 KB) |  2618 IOPS     |  568 IOPS       |
>> | 128 KB  (16 KB) |  4907 IOPS     |  873 IOPS       |
>> |  64 KB   (8 KB) | 10613 IOPS     | 1680 IOPS       |
>> |  32 KB   (4 KB) | 13038 IOPS     | 2476 IOPS       |
>> |   4 KB (512 B)  |   101 IOPS     |  101 IOPS       |
>> |-----------------+----------------+-----------------|
>
> So at the first sight, if you compare the numbers in the same row,
> subclusters=on is a clear winner.

Yes, as expected.

> But almost more interesting is the observation that at least for large
> cluster sizes, subcluster size X performs almost identical to cluster
> size X without subclusters:

But that's also to be expected, isn't it? The only difference (in terms
of I/O) between allocating a 64KB cluster and a 64KB subcluster is how
the L2 entry is updated. The amount of data that is read and written is
the same.

> Something interesting happens in the part that you didn't benchmark
> between 4 KB and 32 KB (actually, maybe it has already started for the
> 32 KB case): Performance collapses for small cluster sizes, but it
> reaches record highs for small subclusters.

I dind't measure that initially because I thought that having
subclusters < 4KB was not very useful. The 512b case was just to see how
it would perform on the extreme case. I anyway decided to get the rest
of the numbers too, so here's the complete table with the missing rows:

|---------+------------+----------------+-----------------|
| Cluster | Subcluster | subclusters=on | subclusters=off |
|---------+------------+----------------+-----------------|
|    2048 |        256 |            571 |             124 |
|    1024 |        128 |            863 |             212 |
|     512 |         64 |           1678 |             365 |
|     256 |         32 |           2618 |             568 |
|     128 |         16 |           4907 |             873 |
|      64 |          8 |          10613 |            1680 |
|      32 |          4 |          13038 |            2476 |
|      16 |          2 |           7555 |            3389 |
|       8 |          1 |            299 |             420 |
|       4 |       512b |            101 |             101 |
|---------+------------+----------------+-----------------|

> I suspect that this is because L2 tables are becoming very small with
> 4 KB clusters, but they are still 32 KB if 4 KB is only the subcluster
> size.

Yes, I explained that in my original proposal from 2017. I didn't
actually investigate further, but my take is that 4KB clusters require
constant allocations and refcount updates, plus L2 tables fill up very
quickly.

> (By the way, did the L2 cache cover the whole disk in your
> benchmarks?)

Yes, in all cases (I forgot to mention that, sorry).

> I think this gives us two completely different motivations why
> subclusters could be useful, depending on the cluster size you're
> using:
>
> 1. If you use small cluster sizes like 32 KB/4 KB, then obviously you
>    can get IOPS rates during cluster allocation that you couldn't come
>    even close to before. I think this is a quite strong argument in
>    favour of the feature.

Yes, indeed. You would need to select the subcluster size so it matches
the size of guest I/O requests (the size of the filesystem block is
probably the best choice).

> 2. With larger cluster sizes, you don't get a significant difference
>    in the performance during cluster allocation compared to just using
>    the subcluster size as the cluster size without having
>    subclusters. Here, the motivation could be something along the
>    lines of avoiding fragmentation. This would probably need more
>    benchmarks to check how fragmentation affects the performance after
>    the initial write.
>
>    This one could possibly be a valid justification, too, but I think it
>    would need more work on demonstrating that the effects are real and
>    justify the implementation and long-term maintenance effort required
>    for subclusters.

I agree. However another benefit of large cluster sizes is that you
reduce the amount of metadata, so you get the same performance with a
smaller L2 cache.

>> I also ran some tests on a rotating HDD drive. Here having
>> subclusters doesn't make a big difference regardless of whether there
>> is a backing image or not, so we can ignore this scenario.
>
> Interesting, this is kind of unexpected. Why would avoided COW not
> make a difference on rotating HDDs? (All of this is cache=none,
> right?)

, the 32K/4K with no COW is obviously much faster 

>
>> === Changes to the on-disk format ===
>> 
>> In my original proposal I described 3 different alternatives for
>> storing the subcluster bitmaps. I'm naming them here, but refer to
>> that message for more details.
>> 
>> (1) Storing the bitmap inside the 64-bit entry
>> (2) Making L2 entries 128-bit wide.
>> (3) Storing the bitmap somewhere else
>> 
>> I used (1) for this implementation for simplicity, but I think (2) is
>> probably the best one.
>
> Which would give us 32 bits for the subclusters, so you'd get 128k/4k or
> 2M/64k. Or would you intend to use some of these 32 bits for something
> different?
>
> I think (3) is the worst because it adds another kind of metadata table
> that we have to consider for ordering updates. So it might come with
> more frequent cache flushes.
>
>> ===========================
>> 
>> And I think that's all. As you can see I didn't want to go much into
>> the open technical questions (I think the on-disk format would be the
>> main one), the first goal should be to decide whether this is still an
>> interesting feature or not.
>> 
>> So, any questions or comments will be much appreciated.
>
> It does like very interesting to me at least for small subcluster sizes.
>
> For the larger ones, I suspect that the Virtuozzo guys might be
> interested in performing more benchmarks to see whether it improves the
> fragmentation problems that they have talked about a lot. It might end
> up being interesting for these cases, too.
>
> Kevin

