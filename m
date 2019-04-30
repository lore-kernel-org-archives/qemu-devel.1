Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DEFDC43219
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 09:39:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 515CE2080C
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 09:39:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 515CE2080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42207 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLPES-00069K-JO
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 05:39:24 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56531)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hLPDd-0005nH-O1
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 05:38:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hLPDc-0002Gg-SI
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 05:38:33 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54995)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1hLPDc-0002GP-Lj
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 05:38:32 -0400
Received: by mail-wm1-f65.google.com with SMTP id b10so3004884wmj.4
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 02:38:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=59JbjDYI5xymjZ3d9LyNHf1n44yCwz2431Nx3ymF1S0=;
	b=WsDWqH9ZNXovx5f8CqHxgVtIbML+/disc9arW118f7a/15SzH3SWY/oq9qw89yfpfM
	7i6/SjAYDv8iYcRygmRUVdwfBCOPDXNOH0Sxdt4daxUmSVd0KWmALfGMqOaSs+dXDF9O
	YYyP88yo5R9D1DC1BXz7izXtTm1GfvvN0QhI7s5jGoVpsk96SwqQYY+myjiQeIq1ShfZ
	Ffhe6BJ2S/oipF/ggs5cl0sAkLz21J2I0+315VEeu6m72HIFm3282m/OfZeLiqPiMtw3
	3wZb0TEDelxwMhEd1vCqXfm1rQ9MLyHV5AQ1SHeUV380xtiHvMeCPCK3LL1zg8Dw+uSa
	fwGw==
X-Gm-Message-State: APjAAAUSu613oCxG//S+FLH5xouq7XlOQ6LVMBJZpBGhO7exGdYeYLFw
	IA43JmRSnTtDUvB+Dfwo+CBxtg==
X-Google-Smtp-Source: APXvYqz87j0QcsnK8Vf761yCyri1c88lofxdvTGJ0eKiajvjG+V+gWi3ZUtq0fF9TlZv9A2flfgrvQ==
X-Received: by 2002:a05:600c:211a:: with SMTP id
	u26mr2625978wml.74.1556617111623; 
	Tue, 30 Apr 2019 02:38:31 -0700 (PDT)
Received: from steredhat (host35-203-static.12-87-b.business.telecomitalia.it.
	[87.12.203.35])
	by smtp.gmail.com with ESMTPSA id c9sm9783552wrv.62.2019.04.30.02.38.30
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 30 Apr 2019 02:38:30 -0700 (PDT)
Date: Tue, 30 Apr 2019 11:38:28 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <20190430093828.gu3b7yjyh447qw6j@steredhat>
References: <20190422145838.70903-1-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190422145838.70903-1-vsementsov@virtuozzo.com>
User-Agent: NeoMutt/20180716
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.65
Subject: Re: [Qemu-devel] [PATCH 0/9] block: buffer-based io
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
Cc: kwolf@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org,
	mreitz@redhat.com, stefanha@redhat.com, den@openvz.org, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190430093828.moA83oZJP_m8hCFwnbJaSMSTCPssXoq3qm7MMesqeSs@z>

On Mon, Apr 22, 2019 at 05:58:29PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> Hi all!
> 
> We often need to do read/write with buffer, not qiov. Instead of
> creating qiov in such cases, let's introduce corresponding helpers.
> 
> Vladimir Sementsov-Ogievskiy (9):
>   block: introduce byte-based io helpers
>   block/qcow2: use buffer-based io
>   block/qcow: use buffer-based io
>   block/qed: use buffer-based io
>   block/parallels: use buffer-based io
>   block/backup: use buffer-based io
>   block/commit: use buffer-based io
>   block/stream: use buffer-based io
>   qemu-img: use buffer-based io
> 
>  include/block/block_int.h      | 16 ++++++++++++++++
>  include/sysemu/block-backend.h | 19 +++++++++++++++++++
>  block/backup.c                 | 14 ++++++--------
>  block/commit.c                 |  5 ++---
>  block/parallels.c              | 14 ++++++--------
>  block/qcow.c                   | 19 ++++++-------------
>  block/qcow2.c                  |  9 ++-------
>  block/qed-table.c              | 12 +++++-------
>  block/qed.c                    |  6 ++----
>  block/stream.c                 |  4 +---
>  qemu-img.c                     | 13 ++++---------
>  11 files changed, 69 insertions(+), 62 deletions(-)
> 
> -- 
> 2.18.0
> 

The series LGTM and new helpers could be very useful!

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

Thanks,
Stefano

