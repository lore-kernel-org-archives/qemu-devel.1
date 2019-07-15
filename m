Return-Path: <SRS0=IjNW=VM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C28A6C76190
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 09:50:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D63120868
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 09:50:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D63120868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36409 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hmxdB-0006b7-K5
	for qemu-devel@archiver.kernel.org; Mon, 15 Jul 2019 05:50:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56511)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgilbert@redhat.com>) id 1hmxcw-0005pG-4N
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 05:50:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1hmxcs-0007Rc-4J
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 05:50:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44226)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hmxco-0007O3-Dw
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 05:50:28 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 87838307D88C;
 Mon, 15 Jul 2019 09:50:25 +0000 (UTC)
Received: from work-vm (ovpn-117-181.ams2.redhat.com [10.36.117.181])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 879CA1001B16;
 Mon, 15 Jul 2019 09:50:24 +0000 (UTC)
Date: Mon, 15 Jul 2019 10:50:22 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Peter Xu <zhexu@redhat.com>
Message-ID: <20190715095022.GE2689@work-vm>
References: <1563115879-2715-1-git-send-email-ivanren@tencent.com>
 <20190715014729.GA9050@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190715014729.GA9050@xz-x1>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Mon, 15 Jul 2019 09:50:25 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] migration: always initial RAMBlock.bmap to
 1 for new migration
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
Cc: qemu-devel@nongnu.org, Ivan Ren <renyime@gmail.com>, quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Peter Xu (zhexu@redhat.com) wrote:
> On Sun, Jul 14, 2019 at 10:51:19PM +0800, Ivan Ren wrote:
> > Reproduce the problem:
> > migrate
> > migrate_cancel
> > migrate
> > 
> > Error happen for memory migration
> 
> Can mention "this mostly revert 0315851938 but with comments kept"
> when merge...
> 
> > 
> > The reason as follows:
> > 1. qemu start, ram_list.dirty_memory[DIRTY_MEMORY_MIGRATION] all set to
> >    1 by a series of cpu_physical_memory_set_dirty_range
> > 2. migration start:ram_init_bitmaps
> >    - memory_global_dirty_log_start: begin log diry
> >    - memory_global_dirty_log_sync: sync dirty bitmap to
> >      ram_list.dirty_memory[DIRTY_MEMORY_MIGRATION]
> >    - migration_bitmap_sync_range: sync ram_list.
> >      dirty_memory[DIRTY_MEMORY_MIGRATION] to RAMBlock.bmap
> >      and ram_list.dirty_memory[DIRTY_MEMORY_MIGRATION] is set to zero
> > 3. migration data...
> > 4. migrate_cancel, will stop log dirty
> > 5. migration start:ram_init_bitmaps
> >    - memory_global_dirty_log_start: begin log diry
> >    - memory_global_dirty_log_sync: sync dirty bitmap to
> >      ram_list.dirty_memory[DIRTY_MEMORY_MIGRATION]
> >    - migration_bitmap_sync_range: sync ram_list.
> >      dirty_memory[DIRTY_MEMORY_MIGRATION] to RAMBlock.bmap
> >      and ram_list.dirty_memory[DIRTY_MEMORY_MIGRATION] is set to zero
> > 
> >    Here RAMBlock.bmap only have new logged dirty pages, don't contain
> >    the whole guest pages.
> 
> Fixes: 03158519384f158
> 
> > 
> > Signed-off-by: Ivan Ren <ivanren@tencent.com>
> 
> Reviewed-by: Peter Xu <peterx@redhat.com>
> 
> I think this is a bit severe and should be rc2 material.  Dave/Juan?

Yes agreed; I've added it to the planning/4.1 page.

> Thanks,
> 
> -- 
> Peter Xu
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

