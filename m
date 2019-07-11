Return-Path: <SRS0=FHOf=VI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3746BC74A35
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 14:09:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E85C021537
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 14:09:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="jHJK+MLm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E85C021537
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42118 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlZl2-00026l-TI
	for qemu-devel@archiver.kernel.org; Thu, 11 Jul 2019 10:09:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56232)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <berto@igalia.com>) id 1hlZkN-0001c9-BL
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 10:08:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berto@igalia.com>) id 1hlZkM-0003eM-2z
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 10:08:31 -0400
Received: from fanzine.igalia.com ([91.117.99.155]:47357)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <berto@igalia.com>)
 id 1hlZkL-0003Ga-Ex; Thu, 11 Jul 2019 10:08:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=w4p8dMqwbhxZr8dDP55pI6PlbueJqBpWR6pxWY83Qkk=; 
 b=jHJK+MLmSrs8480SsKljOgPmQYBPph6MdaXJz4WdUSKXhZ5HCl0IurU2AZ27aTO9rTjXXCQjVNZG6gMnOGFjVgHnfiNA8nw22iepf+vCJgqeVWTuFl+H05lVETTgiAGlrbV3YMUFcGrJ8gEUgEwnmrUjLv4wPJFHzA3MwSrVYd3neB53QJA0C9IflLo49w+1B+tER61htzJArK2aS8dyOStZDBKXN9c7rOKC01qN7PwDf5LGsK63hPRuwwc/clKqXqwGjG7XZVKs30eiuCmefVHHbOUyeS5l+K5XA+NjBz82MMOIoeo/lJduXuX4eOd5SsJp8CqkEqFOv0EEJx7sRg==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1hlZk0-0001ub-KR; Thu, 11 Jul 2019 16:08:08 +0200
Received: from berto by mail.igalia.com with local (Exim)
 id 1hlZk0-0003gH-Hi; Thu, 11 Jul 2019 16:08:08 +0200
From: Alberto Garcia <berto@igalia.com>
To: Denis Lunev <den@virtuozzo.com>, Kevin Wolf <kwolf@redhat.com>
In-Reply-To: <8ac8776c-f1d7-14eb-1a22-3db12fde7aef@virtuozzo.com>
References: <20190627135914.xlzohrdwr6mz2aq3@perseus.local>
 <20190627165434.GE5618@localhost.localdomain>
 <8ac8776c-f1d7-14eb-1a22-3db12fde7aef@virtuozzo.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Thu, 11 Jul 2019 16:08:08 +0200
Message-ID: <w51zhlkirzr.fsf@maestria.local.igalia.com>
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
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu 27 Jun 2019 07:08:29 PM CEST, Denis Lunev wrote:

> But can we get a link to the repo with actual version of patches.

Hi,

I updated my code to increase the L2 entry size from 64 bits to 128 bits
and thanks to this we now have 32 subclusters per cluster (32 bits for
"subcluster allocated" and 32 for "subcluster is all zeroes").

I also fixed a few bugs on the way and started to clean the code a bit
so it is more readable. You can get it here:

   https://github.com/bertogg/qemu/releases/tag/subcluster-allocation-prototype-20190711

The idea is that you can test it, evaluate the performance and see
whether the general approach makes sense, but this is obviously not
release-quality code so don't focus too much on the coding style,
variable names, hacks, etc. Many things need to change, other things
still need to be implemented, and I'm already on the process of doing
it.

Some questions that are still open:

- It is possible to configure very easily the number of subclusters per
  cluster. It is now hardcoded to 32 in qcow2_do_open() but any power of
  2 would work (just change the number there if you want to test
  it). Would an option for this be worth adding?

- We could also allow the user to choose 64 subclusters per cluster and
  disable the "all zeroes" bits in that case. It is quite simple in
  terms of lines of code but it would make the qcow2 spec a bit more
  complicated.

- We would now have "all zeroes" bits at the cluster and subcluster
  levels, so there's an ambiguity here that we need to solve. In
  particular, what happens if we have a QCOW2_CLUSTER_ZERO_ALLOC cluster
  but some bits from the bitmap are set? Do we ignore them completely?

I also ran some I/O tests using a similar scenario like last time (SSD
drive, 40GB backing image). Here are the results, you can see the
difference between the previous prototype (8 subclusters per cluster)
and the new one (32):

|--------------+----------------+---------------+-----------------|
| Cluster size | 32 subclusters | 8 subclusters | subclusters=off |
|--------------+----------------+---------------+-----------------|
|         4 KB |        80 IOPS |      101 IOPS |         92 IOPS |
|         8 KB |       108 IOPS |      299 IOPS |        417 IOPS |
|        16 KB |      3440 IOPS |     7555 IOPS |       3347 IOPS |
|        32 KB |     10718 IOPS |    13038 IOPS |       2435 IOPS |
|        64 KB |     12569 IOPS |    10613 IOPS |       1622 IOPS |
|       128 KB |     11444 IOPS |     4907 IOPS |        866 IOPS |
|       256 KB |      9335 IOPS |     2618 IOPS |        561 IOPS |
|       512 KB |       185 IOPS |     1678 IOPS |        353 IOPS |
|      1024 KB |      2477 IOPS |      863 IOPS |        212 IOPS |
|      2048 KB |      1536 IOPS |      571 IOPS |        123 IOPS |
|--------------+----------------+---------------+-----------------|

I'm surprised about the 256 KB cluster / 32 subclusters case (I would
expect ~3300 IOPS), but I ran it a few times and the results are always
the same. I still haven't investigated why that happens. The rest of the
results seem more or less normal.

I will now continue working towards having something a complete
solution, but any feedback or comments will be very welcome.

Regards,

Berto

