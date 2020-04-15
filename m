Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A570C2BA19
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 19:12:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3343220768
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 19:12:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="huJS5gNJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3343220768
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54220 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOnS4-0000xT-8c
	for qemu-devel@archiver.kernel.org; Wed, 15 Apr 2020 15:12:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56250)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berto@igalia.com>) id 1jOnRO-0000Tm-Rx
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 15:11:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berto@igalia.com>) id 1jOnRN-0008HT-SW
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 15:11:18 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:40983)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <berto@igalia.com>)
 id 1jOnRN-0008Fh-9N; Wed, 15 Apr 2020 15:11:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=NBEiVHvrfQXWjeN56IEMW0el7B5LI/AnEx3OzhyA2Rs=; 
 b=huJS5gNJjvC5Uf0WwtKvsl0XzfIXOxtxHxaiJRKjroyJJ+WQpgHoQdcmCFimG+dQpCBaJH1CjlB2H7vnq8waHnx3os9RnOL/jPL/Pj3Pp6gBYC2ufZcI2qbnFaGCtc1T4XDIXPI9bbKOs7xk36IG+aDq+JX4W62TPvvH+Mk4zmoztZE9tEjEC2/OxdvmYS0JHId1I0U2UI0qaue0E4P93ryW9m2h46GnsRrmc+QHsJ9LfISBIvmyAVguzaCek8LTEqqYrsSj6yyjN1tGyV1VyE0iTUBs9kTGbzMt4837K1BGmUYowqSPUZ5GO1uFKt3bf9uF8nQy1XsFcWSpvrXI1Q==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1jOnRI-0006Rj-BW; Wed, 15 Apr 2020 21:11:12 +0200
Received: from berto by mail.igalia.com with local (Exim)
 id 1jOnRI-000810-28; Wed, 15 Apr 2020 21:11:12 +0200
From: Alberto Garcia <berto@igalia.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v4 07/30] qcow2: Document the Extended L2 Entries feature
In-Reply-To: <781c734c-e53c-76ae-74de-26d9e827e1a2@virtuozzo.com>
References: <cover.1584468723.git.berto@igalia.com>
 <aa1ac3fbb1d42db67d930b76255c9b7b19c07b42.1584468723.git.berto@igalia.com>
 <8c88b96f-c6f5-e06c-73e1-56001089a7ca@redhat.com>
 <781c734c-e53c-76ae-74de-26d9e827e1a2@virtuozzo.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Wed, 15 Apr 2020 21:11:12 +0200
Message-ID: <w51imi0zhrj.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x (no
 timestamps) [generic] [fuzzy]
X-Received-From: 178.60.130.6
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
Cc: Kevin Wolf <kwolf@redhat.com>, "Denis V . Lunev" <den@openvz.org>,
 Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri 10 Apr 2020 11:29:59 AM CEST, Vladimir Sementsov-Ogievskiy wrote:
>> Should we also document that extended L2 entries are incompatible
>> with raw external files? [...] After all, when raw external file is
>> enabled, the entire image is allocated, at which point subclusters
>> don't make much sense.
>
> It still may cache information about zeroed subclusters: gives more
> detailed block-status.

So shall I forbid extended_l2 + data_file_raw then?

I wonder, if the only problem is that it's just not very useful, does it
make sense to add additional complexity and restrictions to the code
simply to prevent the user from making a sub-optimal choice?

Berto

