Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE2FDC432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 13:36:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C1E52070E
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 13:36:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="DWIp0QW6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C1E52070E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40480 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXmdS-0007pT-KZ
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 08:36:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59480)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berto@igalia.com>) id 1iXmcF-0005xd-Ht
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 08:35:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berto@igalia.com>) id 1iXmcE-0007H1-Hm
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 08:35:23 -0500
Received: from fanzine.igalia.com ([178.60.130.6]:39470)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <berto@igalia.com>)
 id 1iXmcB-0006ww-Gm; Thu, 21 Nov 2019 08:35:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=UqReBMw7OeHRmi5/ybhaFm71giAnRqoUsoJt7VzFABw=; 
 b=DWIp0QW6hT9cQRf4WxxUP11RXqZzXCgWu2miu/Eq7wbLPvdi253ATXnNAqaX1KbfAOYgRtYAEDa1nIML7o2VHJum1e5Egfqc9nEl411wUXnwlgK4f/csKBzpmwsTROVa6SsnMlodi6pGme3ehYQLELLUd6aQlBTIU058HUJTS8j/RARJzeON/vG5Q8KiISXIpx2RoxK/nDJFbw3LXBHICHOooabfX3iL2by0i65OiM9WFW7FAXiwzL/nWghAmR7eWHFozG7kGfnHqGqTh657Bgridt2QLXBG/44/YLC4GrZjnS3PHBj90BQ2dqFOh6h92Ga+VrTWe10BZasOjzsrJA==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1iXmbq-0001He-16; Thu, 21 Nov 2019 14:34:58 +0100
Received: from berto by mail.igalia.com with local (Exim)
 id 1iXmbp-0002G5-UZ; Thu, 21 Nov 2019 14:34:57 +0100
From: Alberto Garcia <berto@igalia.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Subject: Re: [PATCH v2 4/6] iotests: Fix timeout in run_job()
In-Reply-To: <20191120184501.28159-5-kwolf@redhat.com>
References: <20191120184501.28159-1-kwolf@redhat.com>
 <20191120184501.28159-5-kwolf@redhat.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Thu, 21 Nov 2019 14:34:57 +0100
Message-ID: <w51y2w94ake.fsf@maestria.local.igalia.com>
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, qemu-devel@nongnu.org,
 stefanha@redhat.com, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed 20 Nov 2019 07:44:59 PM CET, Kevin Wolf wrote:
> run_job() accepts a wait parameter for a timeout, but it doesn't
> actually use it. The only thing that is missing is passing it to
> events_wait(), so do that now.
>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto

