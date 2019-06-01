Return-Path: <SRS0=gcBw=UA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33956C04AB6
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Jun 2019 02:50:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F37C1270C2
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Jun 2019 02:50:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F37C1270C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51871 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWu63-00055Y-U3
	for qemu-devel@archiver.kernel.org; Fri, 31 May 2019 22:50:15 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46103)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1hWu5G-0004lb-NC
	for qemu-devel@nongnu.org; Fri, 31 May 2019 22:49:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1hWtxY-0004N5-25
	for qemu-devel@nongnu.org; Fri, 31 May 2019 22:41:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37414)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1hWtxX-0004MC-TN
	for qemu-devel@nongnu.org; Fri, 31 May 2019 22:41:28 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A4FC43179B49
	for <qemu-devel@nongnu.org>; Sat,  1 Jun 2019 02:41:25 +0000 (UTC)
Received: from xz-x1 (ovpn-12-71.pek2.redhat.com [10.72.12.71])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 47BBC19C69;
	Sat,  1 Jun 2019 02:41:21 +0000 (UTC)
Date: Sat, 1 Jun 2019 10:41:15 +0800
From: Peter Xu <peterx@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Message-ID: <20190601024115.GA4958@xz-x1>
References: <20190530092919.26059-1-peterx@redhat.com>
	<20190530092919.26059-5-peterx@redhat.com>
	<87a7f2ok0m.fsf@trasno.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87a7f2ok0m.fsf@trasno.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.41]);
	Sat, 01 Jun 2019 02:41:25 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 04/12] memory: Don't set migration
 bitmap when without migration
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
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
	qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, May 31, 2019 at 03:01:29PM +0200, Juan Quintela wrote:
> Peter Xu <peterx@redhat.com> wrote:
> > Similar to 9460dee4b2 ("memory: do not touch code dirty bitmap unless
> > TCG is enabled", 2015-06-05) but for the migration bitmap - we can
> > skip the MIGRATION bitmap update if migration not enabled.
> >
> > Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> 
> Reviewed-by: Juan Quintela <quintela@redhat.com>
> 
> But if we ever decide to _not_ dirty all the bitmap at start (only used
> pages) we need to fix this.

Right, but IMHO we can never avoid doing it, because kvm (and also the
per-ramblock dirty bitmaps) will only capture "dirtied pages" after
log sync has started.  One example is what if one page P is never been
touched after log_sync?  Then in kvm dirty log it'll never be set, and
the only way to make sure we will still migrate that page P (that
could be touched before log_sync so it might still contain valid data
rather than a zero page) is to dirty all the pages at the start of
migration (for now, it's ram_list_init_bitmaps).

Thanks for the review!

-- 
Peter Xu

