Return-Path: <SRS0=FHOf=VI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2D76C74A56
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 14:33:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8ED2F2166E
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 14:33:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8ED2F2166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42264 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hla8P-0008Cp-Ik
	for qemu-devel@archiver.kernel.org; Thu, 11 Jul 2019 10:33:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35052)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kwolf@redhat.com>) id 1hla7u-0007js-NG
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 10:32:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1hla7t-000678-7F
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 10:32:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54033)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1hla7n-0005hs-6b; Thu, 11 Jul 2019 10:32:43 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8323B4E92A;
 Thu, 11 Jul 2019 14:32:39 +0000 (UTC)
Received: from linux.fritz.box (ovpn-117-214.ams2.redhat.com [10.36.117.214])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0FBD85D71A;
 Thu, 11 Jul 2019 14:32:35 +0000 (UTC)
Date: Thu, 11 Jul 2019 16:32:34 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Alberto Garcia <berto@igalia.com>
Message-ID: <20190711143234.GB6594@linux.fritz.box>
References: <20190627135914.xlzohrdwr6mz2aq3@perseus.local>
 <20190627165434.GE5618@localhost.localdomain>
 <8ac8776c-f1d7-14eb-1a22-3db12fde7aef@virtuozzo.com>
 <w51zhlkirzr.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <w51zhlkirzr.fsf@maestria.local.igalia.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.38]); Thu, 11 Jul 2019 14:32:39 +0000 (UTC)
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
 Denis Lunev <den@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 11.07.2019 um 16:08 hat Alberto Garcia geschrieben:
> Some questions that are still open:
> 
> - It is possible to configure very easily the number of subclusters per
>   cluster. It is now hardcoded to 32 in qcow2_do_open() but any power of
>   2 would work (just change the number there if you want to test
>   it). Would an option for this be worth adding?

I think for testing we can just change the constant. Once th feature is
merged and used in production, I don't think there is any reason to
leave bits unused.

> - We could also allow the user to choose 64 subclusters per cluster and
>   disable the "all zeroes" bits in that case. It is quite simple in
>   terms of lines of code but it would make the qcow2 spec a bit more
>   complicated.
> 
> - We would now have "all zeroes" bits at the cluster and subcluster
>   levels, so there's an ambiguity here that we need to solve. In
>   particular, what happens if we have a QCOW2_CLUSTER_ZERO_ALLOC cluster
>   but some bits from the bitmap are set? Do we ignore them completely?

The (super)cluster zero bit should probably always be clear if
subclusters are used. If it's set, we have a corrupted image.

> I also ran some I/O tests using a similar scenario like last time (SSD
> drive, 40GB backing image). Here are the results, you can see the
> difference between the previous prototype (8 subclusters per cluster)
> and the new one (32):

Is the 8 subclusters test run with the old version (64 bit L2 entries)
or the new version (128 bit L2 entries) with bits left unused?

> |--------------+----------------+---------------+-----------------|
> | Cluster size | 32 subclusters | 8 subclusters | subclusters=off |
> |--------------+----------------+---------------+-----------------|
> |         4 KB |        80 IOPS |      101 IOPS |         92 IOPS |
> |         8 KB |       108 IOPS |      299 IOPS |        417 IOPS |
> |        16 KB |      3440 IOPS |     7555 IOPS |       3347 IOPS |
> |        32 KB |     10718 IOPS |    13038 IOPS |       2435 IOPS |
> |        64 KB |     12569 IOPS |    10613 IOPS |       1622 IOPS |
> |       128 KB |     11444 IOPS |     4907 IOPS |        866 IOPS |
> |       256 KB |      9335 IOPS |     2618 IOPS |        561 IOPS |
> |       512 KB |       185 IOPS |     1678 IOPS |        353 IOPS |
> |      1024 KB |      2477 IOPS |      863 IOPS |        212 IOPS |
> |      2048 KB |      1536 IOPS |      571 IOPS |        123 IOPS |
> |--------------+----------------+---------------+-----------------|
> 
> I'm surprised about the 256 KB cluster / 32 subclusters case (I would
> expect ~3300 IOPS), but I ran it a few times and the results are always
> the same. I still haven't investigated why that happens. The rest of the
> results seem more or less normal.

Shouldn't 256k/8k perform similarly to 64k/8k, or maybe a bit better?
Why did you expect ~3300 IOPS?

I found other results more surprising. In particular:

* Why does 64k/2k perform better than 128k/4k when the block size for
  your requests is 4k?

* Why is the maximum for 8 subclusters higher than for 32 subclusters?
  I guess this does make some sense if the 8 subclusters case actually
  used 64 bit L2 entries. If you did use 128 bit entries for both 32 and
  8 subclusters, I don't see why 8 subclusters should perform better in
  any case.

* What causes the minimum at 512k with 32 subclusters? The other two
  setups have a maximum and performance decreases monotonically to both
  sides. This one has a minimum at 512k and larger cluster sizes improve
  performance again.

  In fact, 512k performs really bad compared even to subclusters=off.

Kevin

