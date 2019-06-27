Return-Path: <SRS0=nUPg=U2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A430C48BD6
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 16:17:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB0CF20659
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 16:17:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="V7XpoJiU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB0CF20659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52238 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgX5L-0003U8-5X
	for qemu-devel@archiver.kernel.org; Thu, 27 Jun 2019 12:17:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37002)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <berto@igalia.com>) id 1hgWUM-00009t-Ew
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 11:39:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berto@igalia.com>) id 1hgWUK-00044k-El
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 11:39:06 -0400
Received: from fanzine.igalia.com ([91.117.99.155]:54139)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <berto@igalia.com>)
 id 1hgWUI-0003zP-Qe; Thu, 27 Jun 2019 11:39:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=fDFEB5hiZyJlf6ooIQWUPnmUBsWvg4OuPTQx4MpHJoI=; 
 b=V7XpoJiUN9lkoFb+2ViVA9UEn5ZqjBp9/KUsLXNV62U0yrvnme0z52gh0sn8IGgh4Yietul94BO0VRWgw5bGnWW8QMHKZFgB4ni968tX5gM5B7C4JeZ1syUhnOm2uVXoBLrtgu29ZB+kePBKCIulyfsPkmsrm+CNqC9JrnSqq6SUWgbNQzLvekLWtj/VzzaHGcqc+FkDyFbfEZcxJbUjW6CCi2/NsdWkhtDLHPmvuCj1WKwIE9g2OAmu9TNM6XMIl4Xok32cJs0MHMr0YSqegBZkPJYDG56UifZRgQZa4TpIFzcANhavt6DHtoK4DY6zvRCVFt60eOK8172OYN8XhA==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1hgWUC-0005GG-JB; Thu, 27 Jun 2019 17:38:56 +0200
Received: from berto by mail.igalia.com with local (Exim)
 id 1hgWUC-0003IB-GQ; Thu, 27 Jun 2019 17:38:56 +0200
From: Alberto Garcia <berto@igalia.com>
To: Denis Lunev <den@virtuozzo.com>,
 "qemu-devel\@nongnu.org" <qemu-devel@nongnu.org>
In-Reply-To: <4453cfc4-cff7-c004-1f4c-7cab462e4661@virtuozzo.com>
References: <20190627135914.xlzohrdwr6mz2aq3@perseus.local>
 <4453cfc4-cff7-c004-1f4c-7cab462e4661@virtuozzo.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Thu, 27 Jun 2019 17:38:56 +0200
Message-ID: <w51a7e3domn.fsf@maestria.local.igalia.com>
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
Cc: Kevin Wolf <kwolf@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu 27 Jun 2019 04:19:25 PM CEST, Denis Lunev wrote:

> Right now QCOW2 is not very efficient with default cluster size (64k)
> for fast performance with big disks. Nowadays ppl uses really BIG
> images and 1-2-3-8 Tb disks are really common. Unfortunately ppl want
> to get random IO fast too.  Thus metadata cache should be in memory as
> in the any other case we will get IOPSes halved (1 operation for
> metadata cache read and one operation for real read). For 8 Tb image
> this results in 1 Gb RAM for that. For 1 Mb cluster we get 64 Mb which
> is much more reasonable.

Correct, the L2 metadata size is a well-known problem that has been
discussed extensively, and that has received plenty of attention.

> Though with 1 Mb cluster the reclaim process becomes much-much
> worse. I can not give exact number, unfortunately.  AFAIR the image
> occupies 30-50% more space. Guys, I would appreciate if you will
> correct me here with real numbers.

Correct, because the cluster size is the smallest unit of allocation, so
a 16KB write on an empty area of the image will always allocate a
complete 1MB cluster.

> Thus in respect to this patterns subclusters could give us benefits of
> fast random IO and good reclaim rate.

Exactly, but that fast random I/O would only happen when allocating new
clusters. Once the clusters are allocated it doesn't provide any
additional performance benefit.

> I would consider 64k cluster/8k subcluster as too extreme for me.  In
> reality we would end up with completely fragmented image very soon.

You mean because of the 64k cluster size, or because of the 8k
subcluster size? If it's the former, yes. If it's the latter, it can be
solved by preallocating the cluster with fallocate(). But then you would
lose the benefit of the good reclaim rate.

Berto

