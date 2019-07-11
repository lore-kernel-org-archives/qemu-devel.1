Return-Path: <SRS0=FHOf=VI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1950C74A4B
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 11:34:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88E8220665
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 11:34:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88E8220665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40682 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlXLa-00017e-RC
	for qemu-devel@archiver.kernel.org; Thu, 11 Jul 2019 07:34:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36225)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgilbert@redhat.com>) id 1hlXL6-0000g7-Cl
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 07:34:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1hlXL5-0002He-3A
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 07:34:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54280)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hlXL2-0002D0-KL
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 07:34:13 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9B882308FC23;
 Thu, 11 Jul 2019 11:34:08 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.40])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2195219C69;
 Thu, 11 Jul 2019 11:34:06 +0000 (UTC)
Date: Thu, 11 Jul 2019 12:34:04 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20190711113404.GK3971@work-vm>
References: <20190711104412.31233-1-quintela@redhat.com>
 <c2bfa537-8a5a-86a1-495c-a6c1d0f85dc5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c2bfa537-8a5a-86a1-495c-a6c1d0f85dc5@redhat.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Thu, 11 Jul 2019 11:34:08 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PULL 00/19] Migration patches
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 kvm@vger.kernel.org, Juan Quintela <quintela@redhat.com>,
 qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Paolo Bonzini (pbonzini@redhat.com) wrote:
> On 11/07/19 12:43, Juan Quintela wrote:
> > The following changes since commit 6df2cdf44a82426f7a59dcb03f0dd2181ed7fdfa:
> > 
> >   Update version for v4.1.0-rc0 release (2019-07-09 17:21:53 +0100)
> > 
> > are available in the Git repository at:
> > 
> >   https://github.com/juanquintela/qemu.git tags/migration-pull-request
> > 
> > for you to fetch changes up to 0b47e79b3d04f500b6f3490628905ec5884133df:
> > 
> >   migration: allow private destination ram with x-ignore-shared (2019-07-11 12:30:40 +0200)
> 
> Aren't we in hard freeze already?

They were all sent and review-by long before the freeze.
This pull got stuck though; the original version of the pull was also
sent before the freeze but some stuff has got added.

Dave

> Paolo
> 
> > ----------------------------------------------------------------
> > Migration pull request
> > 
> > ----------------------------------------------------------------
> > 
> > Juan Quintela (3):
> >   migration: fix multifd_recv event typo
> >   migration-test: rename parameter to parameter_int
> >   migration-test: Add migration multifd test
> > 
> > Peng Tao (1):
> >   migration: allow private destination ram with x-ignore-shared
> > 
> > Peter Xu (10):
> >   migration: No need to take rcu during sync_dirty_bitmap
> >   memory: Don't set migration bitmap when without migration
> >   bitmap: Add bitmap_copy_with_{src|dst}_offset()
> >   memory: Pass mr into snapshot_and_clear_dirty
> >   memory: Introduce memory listener hook log_clear()
> >   kvm: Update comments for sync_dirty_bitmap
> >   kvm: Persistent per kvmslot dirty bitmap
> >   kvm: Introduce slots lock for memory listener
> >   kvm: Support KVM_CLEAR_DIRTY_LOG
> >   migration: Split log_clear() into smaller chunks
> > 
> > Wei Yang (5):
> >   migration/multifd: call multifd_send_sync_main when sending
> >     RAM_SAVE_FLAG_EOS
> >   migration/xbzrle: update cache and current_data in one place
> >   cutils: remove one unnecessary pointer operation
> >   migration/multifd: sync packet_num after all thread are done
> >   migratioin/ram.c: reset complete_round when we gets a queued page
> > 
> >  accel/kvm/kvm-all.c          |  260 +-
> >  accel/kvm/trace-events       |    1 +
> >  exec.c                       |   15 +-
> >  include/exec/memory.h        |   19 +
> >  include/exec/memory.h.rej    |   26 +
> >  include/exec/ram_addr.h      |   92 +-
> >  include/exec/ram_addr.h.orig |  488 ++++
> >  include/qemu/bitmap.h        |    9 +
> >  include/sysemu/kvm_int.h     |    4 +
> >  memory.c                     |   56 +-
> >  memory.c.rej                 |   17 +
> >  migration/migration.c        |    4 +
> >  migration/migration.h        |   27 +
> >  migration/migration.h.orig   |  315 +++
> >  migration/ram.c              |   93 +-
> >  migration/ram.c.orig         | 4599 ++++++++++++++++++++++++++++++++++
> >  migration/ram.c.rej          |   33 +
> >  migration/trace-events       |    3 +-
> >  migration/trace-events.orig  |  297 +++
> >  tests/Makefile.include       |    2 +
> >  tests/migration-test.c       |  103 +-
> >  tests/test-bitmap.c          |   72 +
> >  util/bitmap.c                |   85 +
> >  util/cutils.c                |    8 +-
> >  24 files changed, 6545 insertions(+), 83 deletions(-)
> >  create mode 100644 include/exec/memory.h.rej
> >  create mode 100644 include/exec/ram_addr.h.orig
> >  create mode 100644 memory.c.rej
> >  create mode 100644 migration/migration.h.orig
> >  create mode 100644 migration/ram.c.orig
> >  create mode 100644 migration/ram.c.rej
> >  create mode 100644 migration/trace-events.orig
> >  create mode 100644 tests/test-bitmap.c
> > 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

