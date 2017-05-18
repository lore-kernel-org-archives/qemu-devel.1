Received: from eggs.gnu.org ([2001:4830:134:3::10]:45964)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dBIi6-0008NB-JJ
	for qemu-devel@nongnu.org; Thu, 18 May 2017 06:31:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dBIi3-0003fl-HQ
	for qemu-devel@nongnu.org; Thu, 18 May 2017 06:31:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47514)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dBIi3-0003fS-BX
	for qemu-devel@nongnu.org; Thu, 18 May 2017 06:31:07 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8BD9A804F6
	for <qemu-devel@nongnu.org>; Thu, 18 May 2017 10:31:05 +0000 (UTC)
Date: Thu, 18 May 2017 18:31:00 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170518103100.GB24085@pxdev.xzpeter.org>
References: <20170517160804.22245-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170517160804.22245-1-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/2] Make migration/ram.c target independent
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com, lvivier@redhat.com

On Wed, May 17, 2017 at 06:08:02PM +0200, Juan Quintela wrote:
> Hi
> 
> Only reason that ram.c is compiled by target is because it use
> TARGET_PAGE_BITS.  As we already have a function to export
> TARGET_PAGE_SIZE, do the same.
> After this, we can make it target independent.
> 
> Please, review.
> 
> Later, Juan.
> 
> 
> 
> 
> Juan Quintela (2):
>   exec: Create include for target_page_size()
>   migration: Make savevm.c target independent
> 
>  Makefile.target            |  2 +-
>  exec.c                     | 10 ++++++++++
>  include/exec/target_page.h | 22 ++++++++++++++++++++++
>  include/sysemu/sysemu.h    |  1 -
>  migration/Makefile.objs    |  2 +-
>  migration/migration.c      |  1 +
>  migration/postcopy-ram.c   |  1 +
>  migration/savevm.c         | 15 ++++++++-------
>  8 files changed, 44 insertions(+), 10 deletions(-)
>  create mode 100644 include/exec/target_page.h

Though I am not 100% sure of the relationship between TARGET_PAGE_*,
qemu_target_page_*(), and exec/poison.h, but at least we already have
qemu_target_page_size(), and this patch moves savevm.c out of
arch-dependent list, which does make sense. So:

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu
