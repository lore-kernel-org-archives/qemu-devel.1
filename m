Return-Path: <SRS0=nUPg=U2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57DC1C48BD9
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 17:01:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EA7420659
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 17:01:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EA7420659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52900 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgXls-0004HO-Ck
	for qemu-devel@archiver.kernel.org; Thu, 27 Jun 2019 13:01:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55089)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kwolf@redhat.com>) id 1hgXfh-0007f2-S3
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 12:54:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1hgXff-0004xx-RV
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 12:54:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44492)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1hgXfY-0004oX-NY; Thu, 27 Jun 2019 12:54:44 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D287559466;
 Thu, 27 Jun 2019 16:54:39 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-154.ams2.redhat.com
 [10.36.116.154])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 22F415D719;
 Thu, 27 Jun 2019 16:54:36 +0000 (UTC)
Date: Thu, 27 Jun 2019 18:54:34 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Alberto Garcia <berto@igalia.com>
Message-ID: <20190627165434.GE5618@localhost.localdomain>
References: <20190627135914.xlzohrdwr6mz2aq3@perseus.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190627135914.xlzohrdwr6mz2aq3@perseus.local>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Thu, 27 Jun 2019 16:54:40 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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

Am 27.06.2019 um 15:59 hat Alberto Garcia geschrieben:
> Hi all,
> 
> a couple of years ago I came to the mailing list with a proposal to
> extend the qcow2 format to add subcluster allocation.
> 
> You can read the original message (and the discussion thread that came
> afterwards) here:
> 
>    https://lists.gnu.org/archive/html/qemu-block/2017-04/msg00178.html
> 
> The description of the problem from the original proposal is still
> valid so I won't repeat it here.
> 
> What I have been doing during the past few weeks was to retake the
> code that I wrote in 2017, make it work with the latest QEMU and fix
> many of its bugs. I have again a working prototype which is by no
> means complete but it allows us to have up-to-date information about
> what we can expect from this feature.
> 
> My goal with this message is to retake the discussion and re-evaluate
> whether this is a feature that we'd like for QEMU in light of the test
> results and all the changes that we have had in the past couple of
> years.
> 
> === Test results ===
> 
> I ran these tests with the same hardware configuration as in 2017: an
> SSD drive and random 4KB write requests to an empty 40GB qcow2 image.
> 
> Here are the results when the qcow2 file is backed by a fully
> populated image. There are 8 subclusters per cluster and the
> subcluster size is in brackets:
> 
> |-----------------+----------------+-----------------|
> |  Cluster size   | subclusters=on | subclusters=off |
> |-----------------+----------------+-----------------|
> |   2 MB (256 KB) |   571 IOPS     |  124 IOPS       |
> |   1 MB (128 KB) |   863 IOPS     |  212 IOPS       |
> | 512 KB  (64 KB) |  1678 IOPS     |  365 IOPS       |
> | 256 KB  (32 KB) |  2618 IOPS     |  568 IOPS       |
> | 128 KB  (16 KB) |  4907 IOPS     |  873 IOPS       |
> |  64 KB   (8 KB) | 10613 IOPS     | 1680 IOPS       |
> |  32 KB   (4 KB) | 13038 IOPS     | 2476 IOPS       |
> |   4 KB (512 B)  |   101 IOPS     |  101 IOPS       |
> |-----------------+----------------+-----------------|

So at the first sight, if you compare the numbers in the same row,
subclusters=on is a clear winner.

But almost more interesting is the observation that at least for large
cluster sizes, subcluster size X performs almost identical to cluster
size X without subclusters:

                as subcluster size  as cluster size, subclusters=off
    256 KB      571 IOPS            568 IOPS
    128 KB      863 IOPS            873 IOPS
    64 KB       1678 IOPS           1680 IOPS
    32 KB       2618 IOPS           2476 IOPS
    ...
    4 KB        13038 IOPS          101 IOPS

Something interesting happens in the part that you didn't benchmark
between 4 KB and 32 KB (actually, maybe it has already started for the
32 KB case): Performance collapses for small cluster sizes, but it
reaches record highs for small subclusters. I suspect that this is
because L2 tables are becoming very small with 4 KB clusters, but they
are still 32 KB if 4 KB is only the subcluster size. (By the way, did
the L2 cache cover the whole disk in your benchmarks?)

I think this gives us two completely different motivations why
subclusters could be useful, depending on the cluster size you're using:

1. If you use small cluster sizes like 32 KB/4 KB, then obviously you
   can get IOPS rates during cluster allocation that you couldn't come
   even close to before. I think this is a quite strong argument in
   favour of the feature.

2. With larger cluster sizes, you don't get a significant difference in
   the performance during cluster allocation compared to just using the
   subcluster size as the cluster size without having subclusters. Here,
   the motivation could be something along the lines of avoiding
   fragmentation. This would probably need more benchmarks to check how
   fragmentation affects the performance after the initial write.

   This one could possibly be a valid justification, too, but I think it
   would need more work on demonstrating that the effects are real and
   justify the implementation and long-term maintenance effort required
   for subclusters.

> Some comments about the results, after comparing them with those from
> 2017:
> 
> - As expected, 32KB clusters / 4 KB subclusters give the best results
>   because that matches the size of the write request and therefore
>   there's no copy-on-write involved.
> 
> - Allocation is generally faster now in all cases (between 20-90%,
>   depending on the case). We have made several optimizations to the
>   code since last time, and I suppose that the COW changes made in
>   commits b3cf1c7cf8 and ee22a9d869 are probably the main factor
>   behind these improvements.
> 
> - Apart from the 64KB/8KB case (which is much faster), the patters are
>   generally the same: subcluster allocation offers similar performance
>   benefits compared to last time, so there are no surprises in this
>   area.
> 
> Then I ran the tests again using the same environment but without a
> backing image. The goal is to measure the impact of subcluster
> allocation on completely empty images.
> 
> Here we have an important change: since commit c8bb23cbdb empty
> clusters are preallocated and filled with zeroes using an efficient
> operation (typically fallocate() with FALLOC_FL_ZERO_RANGE) instead of
> writing the zeroes with the usual pwrite() call.
> 
> The effects of this are dramatic, so I decided to run two sets of
> tests: one with this optimization and one without it.
> 
> Here are the results:
> 
> |-----------------+----------------+-----------------+----------------+-----------------|
> |                 | Initialization with fallocate()  |  Initialization with pwritev()   |
> |-----------------+----------------+-----------------+----------------+-----------------|
> |  Cluster size   | subclusters=on | subclusters=off | subclusters=on | subclusters=off |
> |-----------------+----------------+-----------------+----------------+-----------------|
> |   2 MB (256 KB) | 14468 IOPS     | 14776 IOPS      |  1181 IOPS     |  260 IOPS       |
> |   1 MB (128 KB) | 13752 IOPS     | 14956 IOPS      |  1916 IOPS     |  358 IOPS       |
> | 512 KB  (64 KB) | 12961 IOPS     | 14776 IOPS      |  4038 IOPS     |  684 IOPS       |
> | 256 KB  (32 KB) | 12790 IOPS     | 14534 IOPS      |  6172 IOPS     | 1213 IOPS       |
> | 128 KB  (16 KB) | 12550 IOPS     | 13967 IOPS      |  8700 IOPS     | 1976 IOPS       |
> |  64 KB   (8 KB) | 12491 IOPS     | 13432 IOPS      | 11735 IOPS     | 4267 IOPS       |
> |  32 KB   (4 KB) | 13203 IOPS     | 11752 IOPS      | 12366 IOPS     | 6306 IOPS       |
> |   4 KB (512 B)  |   103 IOPS     |   101 IOPS      |   101 IOPS     |  101 IOPS       |
> |-----------------+----------------+-----------------+----------------+-----------------|
> 
> Comments:
> 
> - With the old-style allocation method using pwritev() we get similar
>   benefits as we did last time. The comments from the test with a
>   backing image apply to this one as well.
> 
> - However the new allocation method is so efficient that having
>   subclusters does not offer any performance benefit. It even slows
>   down things a bit in most cases, so we'd probably need to fine tune
>   the algorithm in order to get similar results.
> 
> - In light of this numbers I also think that even when there's a
>   backing image we could preallocate the full cluster but only do COW
>   on the affected subclusters. This would the rest of the cluster
>   preallocated on disk but unallocated on the bitmap. This would
>   probably reduce on-disk fragmentation, which was one of the concerns
>   raised during the original discussion.

Yes, especially when we have to do some COW anyway, this would come at
nearly zero cost because we call fallocate() anyway.

I'm not sure whether it's worth doing when we don't have to do COW. We
will at least avoid qcow2 fragmentation because of the large cluster
size. And file systems are a lot cleverer than qcow2 to avoid
fragmentation on the file system level. So it might not actually make a
big difference in practice.

This is pure theory, though. We'd have to benchmark things to give a
definite answer.

> I also ran some tests on a rotating HDD drive. Here having subclusters
> doesn't make a big difference regardless of whether there is a backing
> image or not, so we can ignore this scenario.

Interesting, this is kind of unexpected. Why would avoided COW not make
a difference on rotating HDDs? (All of this is cache=none, right?)

> === Changes to the on-disk format ===
> 
> In my original proposal I described 3 different alternatives for
> storing the subcluster bitmaps. I'm naming them here, but refer to
> that message for more details.
> 
> (1) Storing the bitmap inside the 64-bit entry
> (2) Making L2 entries 128-bit wide.
> (3) Storing the bitmap somewhere else
> 
> I used (1) for this implementation for simplicity, but I think (2) is
> probably the best one.

Which would give us 32 bits for the subclusters, so you'd get 128k/4k or
2M/64k. Or would you intend to use some of these 32 bits for something
different?

I think (3) is the worst because it adds another kind of metadata table
that we have to consider for ordering updates. So it might come with
more frequent cache flushes.

> ===========================
> 
> And I think that's all. As you can see I didn't want to go much into
> the open technical questions (I think the on-disk format would be the
> main one), the first goal should be to decide whether this is still an
> interesting feature or not.
> 
> So, any questions or comments will be much appreciated.

It does like very interesting to me at least for small subcluster sizes.

For the larger ones, I suspect that the Virtuozzo guys might be
interested in performing more benchmarks to see whether it improves the
fragmentation problems that they have talked about a lot. It might end
up being interesting for these cases, too.

Kevin

