Return-Path: <SRS0=FCxk=BI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8BCCC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 17:00:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94FEA2075F
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 17:00:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wto8yWay"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94FEA2075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0pRW-00007F-St
	for qemu-devel@archiver.kernel.org; Wed, 29 Jul 2020 13:00:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39924)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1k0pPL-00070m-Kz
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 12:58:23 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38186
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1k0pPJ-0000Dr-36
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 12:58:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596041898;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WWWVSFPYUW9dZUervXWwIw2IcqUeBz7JtQDFLUfHZdk=;
 b=Wto8yWayBHgfwiBwqRn2bga/U9LRbJC30R5sTxIs3TWbPnG+3JFOwrIWi6mc5So9Am30kS
 f9zHKaptW2n5zwMC00ArQlOWloAkTvZBzGQefV1o9pN+W2MoXGcQuJg4WcziBjHAkXNXHT
 vib1yyCaRf6VerJBmVriX9aFiZHRSZQ=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-319-A5RrBJYXNKCeUZQ8qjeoCQ-1; Wed, 29 Jul 2020 12:58:13 -0400
X-MC-Unique: A5RrBJYXNKCeUZQ8qjeoCQ-1
Received: by mail-qk1-f200.google.com with SMTP id c202so10882804qkg.12
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2020 09:58:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=WWWVSFPYUW9dZUervXWwIw2IcqUeBz7JtQDFLUfHZdk=;
 b=rs/koZnEb0xLHhszBqMFOn5JzmAJhtLVIR2aSe7ETy8vG3lvOwuYjEIEyAoEahJsJV
 U+lIrk1xzAHVzqB4Pu6UEJTDbZP3DS3BCL8RFIN6o2OkOtpXa3MisM4o/SvxMMJ9TWvd
 Nthj7uXe62OMPwa9ky2p08CCsC9S1301IE+dX94dWaFyL8GpfG8ZMRsmp6DnTSo2Zl0z
 0RHhO3HQNMTG5USiWUa0jiiRxjAQq6/5Qzv+Rl+Jzy9uKD7S6sR6JU09yky37hu0R/sU
 g7uOeNq+VMGts0rm2LdGm3PFPBeRKkp0Nn3qLhqJit2KsZeg43x4TcCZhMxMmhxOzAxe
 2mQg==
X-Gm-Message-State: AOAM5306rd+xl7dFzAXrob3HSs7U8CVvofDPiS51ua45hIBYPFiOhsef
 bJ2WkUVOR37qfMkcX8VI9uuyfHc0TBR6wSIkwo3mAFFqttvMIqWcx6NF4qZlwBX+ZpJi84mk0FN
 Jwhn1qqPGs9XFKfs=
X-Received: by 2002:ac8:4558:: with SMTP id z24mr8393642qtn.241.1596041892997; 
 Wed, 29 Jul 2020 09:58:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz3zNc87lDhwXglKxeRiM5ylkbIxNEH/NBf/uo613Jjo01ThxGAsp2ZK8SmHS08gEk1RGYduQ==
X-Received: by 2002:ac8:4558:: with SMTP id z24mr8393614qtn.241.1596041892685; 
 Wed, 29 Jul 2020 09:58:12 -0700 (PDT)
Received: from xz-x1.hitronhub.home ([2607:9880:19c8:6f::1f4f])
 by smtp.gmail.com with ESMTPSA id w32sm261307qtw.66.2020.07.29.09.58.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2020 09:58:10 -0700 (PDT)
Date: Wed, 29 Jul 2020 12:58:07 -0400
From: Peter Xu <peterx@redhat.com>
To: Denis Plotnikov <dplotnikov@virtuozzo.com>
Subject: Re: [PATCH v0 3/4] migration: add background snapshot
Message-ID: <20200729165807.GC89946@xz-x1.hitronhub.home>
References: <20200722081133.29926-1-dplotnikov@virtuozzo.com>
 <20200722081133.29926-4-dplotnikov@virtuozzo.com>
 <20200724000826.GA865413@xz-x1>
 <f025a2c9-fe4e-5d0d-5fb8-bed35da77952@virtuozzo.com>
MIME-Version: 1.0
In-Reply-To: <f025a2c9-fe4e-5d0d-5fb8-bed35da77952@virtuozzo.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=peterx@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/29 09:27:47
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: den_plotnic@mail.ru, quintela@redhat.com, armbru@redhat.com,
 qemu-devel@nongnu.org, pbonzini@redhat.com, den@openvz.org,
 dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jul 29, 2020 at 03:54:46PM +0300, Denis Plotnikov wrote:
> > Besides current solution, do you think we can make it simpler by only deliver
> > the fault request to the background thread?  We can let the background thread
> > to do all the rests and IIUC we can drop all the complicated sync bitmaps and
> > so on by doing so.  The process can look like:
> > 
> >    - background thread runs the general precopy migration, and,
> > 
> >      - it only does the ram_bulk_stage, which is the first loop, because for
> >        snapshot no reason to send a page twice..
> > 
> >      - After copy one page, do ram_set_rw() always, so accessing of this page
> >        will never trigger write-protect page fault again,
> > 
> >      - take requests from the unqueue_page() just like what's done in this
> >        series, but instead of copying the page, the page request should look
> >        exactly like the postcopy one.  We don't need copy_page because the page
> >        won't be changed before we unprotect it, so it shiould be safe.  These
> >        pages will still be with high priority because when queued it means vcpu
> >        writed to this protected page and fault in userfaultfd.  We need to
> >        migrate these pages first to unblock them.
> > 
> >    - the fault handler thread only needs to do:
> > 
> >      - when get a uffd-wp message, translate into a postcopy-like request
> >        (calculate ramblock and offset), then queue it.  That's all.
> > 
> > I believe we can avoid the copy_page parameter that was passed around, and we
> > can also save the two extra bitmaps and the complicated synchronizations.
> > 
> > Do you think this would work?
> 
> Yes, it would. This scheme is much simpler. I like it, in general.
> 
> I use such a complicated approach to reduce all possible vCPU delays:
> if the storage where the snapshot is being saved is quite slow, it could
> lead
> to vCPU freezing until the page is fully written to the storage.
> So, with the current approach, if not take into account a number of page
> copies limitation,
> the worst case is all VM's ram is copied and then written to the storage.
> Other words, the current scheme provides minimal vCPU delays and thus
> minimal VM cpu
> performance slowdown with the cost of host's memory consumption.
> The new scheme is simple, doesn't consume extra host memory but can freeze
> vCPUs for
> longer time r because:
> * usually memory page coping is faster then memory page writing to a storage
> (think of HDD disk)
> * writing page to a disk depends on disk performance and current disk load
> 
> So it seems that we have two different strategies:
> 1. lower CPU delays
> 2. lower memory usage
> 
> To be honest I would start from the yours scheme as it much simler and the
> other if needed in the future.
> 
> What do you think?

Looks good to me.

Btw, IIUC scheme 1 can also be seen as a way to buffer the duplicated pages in
RAM.  If that's the case, another implementation (even if we want to implement
that in the future, but I still doubt it...) is to grant tuables to the current
migration channel to take more pages in the buffer cache.  Currently, the
migration channel does buffering in QEMUFile.buf[IO_BUF_SIZE], where
IO_BUF_SIZE is 32K as constant.

Anyway, we can start with the simple scheme.

Thanks!

-- 
Peter Xu


