Return-Path: <SRS0=I56D=SL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E2A4C10F0E
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 13:07:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1257B2084F
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 13:07:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="oqyhrlZ3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1257B2084F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41549 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDqTb-0003sX-8s
	for qemu-devel@archiver.kernel.org; Tue, 09 Apr 2019 09:07:47 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56775)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1hDqSb-0003Wo-Qo
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 09:06:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1hDqSZ-00081w-TH
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 09:06:45 -0400
Received: from fanzine.igalia.com ([91.117.99.155]:43527)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <berto@igalia.com>)
	id 1hDqSV-0007mU-Pd; Tue, 09 Apr 2019 09:06:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; 
	h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
	bh=LecTQRwcqWvzAddp+w0lT8aP2aDAr9cOnwmSuYv9pp0=; 
	b=oqyhrlZ3pbd02xiJ5Sq5dg9655V8a/zgH1IIxf9Gvt0ava4peDFndHRJUPU1k9V8RV4QP3LZyn+huviIIX2/IGkCz2yHRuAwBrVprIf7jzdRxHNamcVBiQB/TjxJ3nJcebpOUMWae0EKM6r6emUILtPFGqoQF9fPrwFqXXh0QdcIDu/M51Ds0qLo9F9Z4jI5JLBLmas9leN4VJpMBz2f4EKD5ibfLcV2d3rAzLkHcvIYYWXBSAcgACNLjNkIo8MeO0i7x4bW/d3VwDjEtGzCWaV/2z0DE0vpgEm6R16ee9pCkyMof4/jSV5LnAWkh+uh6eC8qzEeQB0Od+D0MLK2PA==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
	by fanzine.igalia.com with esmtps 
	(Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
	id 1hDqS9-0007k5-TG; Tue, 09 Apr 2019 15:06:17 +0200
Received: from berto by mail.igalia.com with local (Exim)
	id 1hDqS9-0006j8-Q0; Tue, 09 Apr 2019 15:06:17 +0200
From: Alberto Garcia <berto@igalia.com>
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
	"qemu-devel\@nongnu.org" <qemu-devel@nongnu.org>,
	"qemu-block\@nongnu.org" <qemu-block@nongnu.org>
In-Reply-To: <15f8499f-812d-1bf9-ad22-21971687826a@virtuozzo.com>
References: <1554483379-682051-1-git-send-email-andrey.shinkevich@virtuozzo.com>
	<1554483379-682051-4-git-send-email-andrey.shinkevich@virtuozzo.com>
	<w511s2cy08l.fsf@maestria.local.igalia.com>
	<15f8499f-812d-1bf9-ad22-21971687826a@virtuozzo.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
	(i586-pc-linux-gnu)
Date: Tue, 09 Apr 2019 15:06:17 +0200
Message-ID: <w51ef6b49bq.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x (no
	timestamps) [generic] [fuzzy]
X-Received-From: 91.117.99.155
Subject: Re: [Qemu-devel] [PATCH v3 3/3] block/stream: introduce a bottom
 node
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "fam@euphon.net" <fam@euphon.net>, "kwolf@redhat.com" <kwolf@redhat.com>,
	Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
	Denis Lunev <den@virtuozzo.com>, "mreitz@redhat.com" <mreitz@redhat.com>,
	"stefanha@redhat.com" <stefanha@redhat.com>,
	"jsnow@redhat.com" <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190409130617.3TRLIas2sOKGavJ07vLcAF4N-vfNgpT92X_BDFUZYfs@z>

On Mon 08 Apr 2019 08:17:37 PM CEST, Andrey Shinkevich wrote:
>>> +    for (iter = bs; iter != bottom; iter = backing_bs(iter)) {
>>> +        block_job_add_bdrv(&s->common, "intermediate node", backing_bs(iter),
>>> +                           0, basic_flags, &error_abort);
>>>       }
>> 
>> This stops when iter == bottom, so bottom is not actually blocked.
>
> The bottom is actually blocked because backing_bs(iter) == bottom is
> passed to the block_job_add_bdrv() with the last iteration of the
> loop.

Right, I hadn't noticed that you are passing backing_bs(iter) to
block_job_add_bdrv() now.

Berto

