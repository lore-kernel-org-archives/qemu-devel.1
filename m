Return-Path: <SRS0=FHOf=VI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 791CCC74A35
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 14:57:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40F1F21537
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 14:57:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="FswclY6X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40F1F21537
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42458 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlaVi-00066Q-Bd
	for qemu-devel@archiver.kernel.org; Thu, 11 Jul 2019 10:57:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42476)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <berto@igalia.com>) id 1hlaUm-0004nT-IN
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 10:56:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berto@igalia.com>) id 1hlaUg-0002Ts-5J
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 10:56:26 -0400
Received: from fanzine.igalia.com ([91.117.99.155]:57939)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <berto@igalia.com>)
 id 1hlaUf-0002Mu-HY; Thu, 11 Jul 2019 10:56:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=yye29f6xK49eD9UvJ7wA5NU0QBqheid5qo6T2CCPY0o=; 
 b=FswclY6XC0Eugw9iyUCkEv6qyh8xC/quBrbpzABDbzoRrtwW7gJ6SJ8ThfQK7eHd9HeuEu8ci2+CGAuTsGuLDnNisi0GXi/NyM/2mCDtKRTr3ZKW2WKfS+Sv+hK8/1HHKEO9Ysh3/SDtbXfmBqTmXh7si3IhquYfa3BjRqxVTsgMaVJSh7B1bX0jy+N7YKsWIw7MiuKpvPIiHdlWNq2LNedLnFWT/F8LQ/DxdcyCxgBBeQJR3nroLLK+AboUOXhAJkpaXhFW343NWIKsEWphYjJW+Smg5m00YNzRDny3Msv6EE8Cm634oL95h1QTg1IoIoXzdfQEPEifYotA3kDXAw==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1hlaUY-0001Bv-7W; Thu, 11 Jul 2019 16:56:14 +0200
Received: from berto by mail.igalia.com with local (Exim)
 id 1hlaUY-00008v-4k; Thu, 11 Jul 2019 16:56:14 +0200
From: Alberto Garcia <berto@igalia.com>
To: Kevin Wolf <kwolf@redhat.com>
In-Reply-To: <20190711143234.GB6594@linux.fritz.box>
References: <20190627135914.xlzohrdwr6mz2aq3@perseus.local>
 <20190627165434.GE5618@localhost.localdomain>
 <8ac8776c-f1d7-14eb-1a22-3db12fde7aef@virtuozzo.com>
 <w51zhlkirzr.fsf@maestria.local.igalia.com>
 <20190711143234.GB6594@linux.fritz.box>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Thu, 11 Jul 2019 16:56:14 +0200
Message-ID: <w51v9w8iprl.fsf@maestria.local.igalia.com>
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
 Denis Lunev <den@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu 11 Jul 2019 04:32:34 PM CEST, Kevin Wolf wrote:

>> - It is possible to configure very easily the number of subclusters per
>>   cluster. It is now hardcoded to 32 in qcow2_do_open() but any power of
>>   2 would work (just change the number there if you want to test
>>   it). Would an option for this be worth adding?
>
> I think for testing we can just change the constant. Once th feature
> is merged and used in production, I don't think there is any reason to
> leave bits unused.

Me neither unless we want to allow the 64 subclusters scenario that I
mentioned.

>> - We would now have "all zeroes" bits at the cluster and subcluster
>> levels, so there's an ambiguity here that we need to solve. In
>> particular, what happens if we have a QCOW2_CLUSTER_ZERO_ALLOC
>> cluster but some bits from the bitmap are set? Do we ignore them
>> completely?
>
> The (super)cluster zero bit should probably always be clear if
> subclusters are used. If it's set, we have a corrupted image.

I mentioned in an earlier e-mail that one possibility is to leave that
bit as it is now and use the bitmap only for the allocation status (so
we'd have 64 subclusters). If QCOW_OFLAG_ZERO is set and the subcluster
is not allocated then it's all zeroes.

With this we'd double the amount of subclusters but we'd lose the
possibility to have zero and unallocated subclusters at the same time.

>> I also ran some I/O tests using a similar scenario like last time
>> (SSD drive, 40GB backing image). Here are the results, you can see
>> the difference between the previous prototype (8 subclusters per
>> cluster) and the new one (32):
>
> Is the 8 subclusters test run with the old version (64 bit L2 entries)
> or the new version (128 bit L2 entries) with bits left unused?

It's the old version of the code (I copied & pasted the numbers from the
previous table).

>> |--------------+----------------+---------------+-----------------|
>> | Cluster size | 32 subclusters | 8 subclusters | subclusters=off |
>> |--------------+----------------+---------------+-----------------|
>> |         4 KB |        80 IOPS |      101 IOPS |         92 IOPS |
>> |         8 KB |       108 IOPS |      299 IOPS |        417 IOPS |
>> |        16 KB |      3440 IOPS |     7555 IOPS |       3347 IOPS |
>> |        32 KB |     10718 IOPS |    13038 IOPS |       2435 IOPS |
>> |        64 KB |     12569 IOPS |    10613 IOPS |       1622 IOPS |
>> |       128 KB |     11444 IOPS |     4907 IOPS |        866 IOPS |
>> |       256 KB |      9335 IOPS |     2618 IOPS |        561 IOPS |
>> |       512 KB |       185 IOPS |     1678 IOPS |        353 IOPS |
>> |      1024 KB |      2477 IOPS |      863 IOPS |        212 IOPS |
>> |      2048 KB |      1536 IOPS |      571 IOPS |        123 IOPS |
>> |--------------+----------------+---------------+-----------------|
>> 
>> I'm surprised about the 256 KB cluster / 32 subclusters case (I would
>> expect ~3300 IOPS), but I ran it a few times and the results are always
>> the same. I still haven't investigated why that happens. The rest of the
>> results seem more or less normal.
>
> Shouldn't 256k/8k perform similarly to 64k/8k, or maybe a bit better?
> Why did you expect ~3300 IOPS?

Sorry I meant the 512k/16k case, which is obviously the outlier there.
 
> I found other results more surprising. In particular:
>
> * Why does 64k/2k perform better than 128k/4k when the block size for
>   your requests is 4k?

They should perform similar because the only difference in practice is
that in the former case you set two bits on the bitmap and in the latter
only one. The difference is not too big, I could run the tests again and
if the results are consistent I can investigate what's going on.

But yes, I would expect 128k/4k to be the fastest of them all.

> * Why is the maximum for 8 subclusters higher than for 32 subclusters?
>   I guess this does make some sense if the 8 subclusters case actually
>   used 64 bit L2 entries. If you did use 128 bit entries for both 32 and
>   8 subclusters, I don't see why 8 subclusters should perform better in
>   any case.

I used 64-bit entries for the 8 subcluster case. I can try with the new
code and see what happens.

> * What causes the minimum at 512k with 32 subclusters?

That's the case that I meant earlier, and I still don't have a good
hypothesis of why that happens. I'll need to debug it.

Berto

