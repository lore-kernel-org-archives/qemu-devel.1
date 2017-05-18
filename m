Received: from eggs.gnu.org ([2001:4830:134:3::10]:39542)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dBIHw-00010t-0k
	for qemu-devel@nongnu.org; Thu, 18 May 2017 06:04:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dBIHs-0003ya-Qz
	for qemu-devel@nongnu.org; Thu, 18 May 2017 06:04:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54664)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dBIHs-0003yP-M9
	for qemu-devel@nongnu.org; Thu, 18 May 2017 06:04:04 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AD500804F8
	for <qemu-devel@nongnu.org>; Thu, 18 May 2017 10:04:03 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170517160804.22245-1-quintela@redhat.com> (Juan Quintela's
	message of "Wed, 17 May 2017 18:08:02 +0200")
References: <20170517160804.22245-1-quintela@redhat.com>
Reply-To: quintela@redhat.com
Date: Thu, 18 May 2017 12:04:00 +0200
Message-ID: <87zieaa3cf.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 0/2] Make migration/ram.c target independent
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com

Juan Quintela <quintela@redhat.com> wrote:
> Hi

Hi

And I got it wrong subject.

What got target independent is savevm.c

ram.c needs to "cleanup" first include/exec/ram_addr.h

Sorry, Juan.

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
