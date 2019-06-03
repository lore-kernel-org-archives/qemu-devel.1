Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABD91C28CC5
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 02:36:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83712279E5
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 02:36:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83712279E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56642 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXcpo-0005aL-Q8
	for qemu-devel@archiver.kernel.org; Sun, 02 Jun 2019 22:36:28 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43662)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1hXcp1-00056r-1I
	for qemu-devel@nongnu.org; Sun, 02 Jun 2019 22:35:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1hXcov-0000Ai-VK
	for qemu-devel@nongnu.org; Sun, 02 Jun 2019 22:35:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58892)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1hXcov-00009u-Pd
	for qemu-devel@nongnu.org; Sun, 02 Jun 2019 22:35:33 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DC42780F6D;
	Mon,  3 Jun 2019 02:35:31 +0000 (UTC)
Received: from xz-x1 (dhcp-15-205.nay.redhat.com [10.66.15.205])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 4726754389;
	Mon,  3 Jun 2019 02:35:29 +0000 (UTC)
Date: Mon, 3 Jun 2019 10:35:27 +0800
From: Peter Xu <peterx@redhat.com>
To: Wei Yang <richardw.yang@linux.intel.com>
Message-ID: <20190603023527.GD4958@xz-x1>
References: <20190507031703.856-1-richardw.yang@linux.intel.com>
	<20190531164337.GK3169@work-vm> <20190601033441.GB4958@xz-x1>
	<20190603013305.GA7784@richard>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190603013305.GA7784@richard>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.27]);
	Mon, 03 Jun 2019 02:35:31 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] migratioin/ram: leave RAMBlock->bmap blank
 on allocating
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
Cc: qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
	quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jun 03, 2019 at 09:33:05AM +0800, Wei Yang wrote:
> On Sat, Jun 01, 2019 at 11:34:41AM +0800, Peter Xu wrote:
> >On Fri, May 31, 2019 at 05:43:37PM +0100, Dr. David Alan Gilbert wrote:
> >> * Wei Yang (richardw.yang@linux.intel.com) wrote:
> >> > During migration, we would sync bitmap from ram_list.dirty_memory to
> >> > RAMBlock.bmap in cpu_physical_memory_sync_dirty_bitmap().
> >> > 
> >> > Since we set RAMBlock.bmap and ram_list.dirty_memory both to all 1, this
> >> > means at the first round this sync is meaningless and is a duplicated
> >> > work.
> >> > 
> >> > Leaving RAMBlock->bmap blank on allocating would have a side effect on
> >> > migration_dirty_pages, since it is calculated from the result of
> >> > cpu_physical_memory_sync_dirty_bitmap(). To keep it right, we need to
> >> > set migration_dirty_pages to 0 in ram_state_init().
> >> > 
> >> > Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
> >> 
> >> I've looked at this for a while, and I think it's OK, so
> >> 
> >> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> >> 
> >> Peter, Juan: Can you just see if there's arny reason this would be bad,
> >> but I think it's actually more sensible than what we have.
> >
> >I really suspect it will work in all cases...  Wei, have you done any
> >test (or better, thorough tests) with this change?  My reasoning of
> >why we should need the bitmap all set is here:
> >
> 
> I have done some migration cases, like migrate a linux guest through tcp.

When did you start the migration?  Have you tried to migrate during
some workload?

> 
> Other cases suggested to do?

Could you also help answer the question I raised below in the link?

Thanks,

> >https://lists.gnu.org/archive/html/qemu-devel/2019-05/msg07361.html

-- 
Peter Xu

