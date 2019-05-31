Return-Path: <SRS0=hY9S=T7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 204DFC28CC0
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 02:49:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECAA126246
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 02:49:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECAA126246
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34430 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWXbM-0003d0-77
	for qemu-devel@archiver.kernel.org; Thu, 30 May 2019 22:49:04 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56063)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1hWXaZ-0003MP-J4
	for qemu-devel@nongnu.org; Thu, 30 May 2019 22:48:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1hWXaY-0006jj-Co
	for qemu-devel@nongnu.org; Thu, 30 May 2019 22:48:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54398)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1hWXaX-0006fZ-UR
	for qemu-devel@nongnu.org; Thu, 30 May 2019 22:48:14 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0F9A8308FBA6
	for <qemu-devel@nongnu.org>; Fri, 31 May 2019 02:48:13 +0000 (UTC)
Received: from xz-x1 (dhcp-15-205.nay.redhat.com [10.66.15.205])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 3C3B0608CA;
	Fri, 31 May 2019 02:48:10 +0000 (UTC)
Date: Fri, 31 May 2019 10:48:08 +0800
From: Peter Xu <peterx@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190531024808.GJ28587@xz-x1>
References: <20190530092919.26059-1-peterx@redhat.com>
	<20190530092919.26059-11-peterx@redhat.com>
	<20190530164037.GH2823@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190530164037.GH2823@work-vm>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.43]);
	Fri, 31 May 2019 02:48:13 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 10/12] kvm: Introduce slots lock for
 memory listener
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
	qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, May 30, 2019 at 05:40:38PM +0100, Dr. David Alan Gilbert wrote:
> * Peter Xu (peterx@redhat.com) wrote:
> > Introduce KVMMemoryListener.slots_lock to protect the slots inside the
> > kvm memory listener.  Currently it is close to useless because all the
> > KVM code path now is always protected by the BQL.  But it'll start to
> > make sense in follow up patches where we might do remote dirty bitmap
> > clear and also we'll update the per-slot cached dirty bitmap even
> > without the BQL.  So let's prepare for it.
> > 
> > We can also use per-slot lock for above reason but it seems to be an
> > overkill.  Let's just use this bigger one (which covers all the slots
> > of a single address space) but anyway this lock is still much smaller
> > than the BQL.
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> 
> No one ever frees it? Huh OK, in that case if no one ever frees the
> listener then I guess you don't need to cleanup the lock.

Yeh not the first time I see something keeps forever in QEMU (in most
cases which won't hurt :).

I'll just leave it to the patch where all things are cleaned up.

> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Thanks,

-- 
Peter Xu

