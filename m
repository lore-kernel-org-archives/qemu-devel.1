Received: from eggs.gnu.org ([2001:4830:134:3::10]:54999)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dIf9c-0004ql-8p
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 13:54:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dIf9Y-0007j3-7x
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 13:54:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48996)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dIf9Y-0007ho-2J
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 13:53:56 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DC4C43D95C
	for <qemu-devel@nongnu.org>; Wed,  7 Jun 2017 17:53:54 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170601221552.30628-1-quintela@redhat.com> (Juan Quintela's
	message of "Fri, 2 Jun 2017 00:15:47 +0200")
References: <20170601221552.30628-1-quintela@redhat.com>
Reply-To: quintela@redhat.com
Date: Wed, 07 Jun 2017 19:53:48 +0200
Message-ID: <8737bbd6qb.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 0/5] Create setup/cleanup methods for
 migration incoming side
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>

Juan Quintela <quintela@redhat.com> wrote:
> Hi

Hi Kevin and Stefan, I intended to cc you on this series.

Is this what you were asking for block layer migration?

Do you need anything else?

Thanks, Juan.


> This series make:
> - use of cleanup/save methods generic, not only for save_live methods
> - create the equivalent methods for the load side (load_setup/cleanup)
> - Make ram use this methods to see how/when they are used.
>
> Stefan, Kevin, this were the methods that you asked for the block.c
> migration, right?  Please, comment if they are enough for you.
>
> This are on top of the ramstate_dynamic series that I just posted.
>
> Please, review.
>
> Later, Juan.
>
> Juan Quintela (5):
>   migration: Rename save_live_setup() to save_setup()
>   migration: Rename cleanup() to save_cleanup()
>   migration: Create load_setup()/cleanup() methods
>   migration: Convert ram to use new load_setup()/load_cleanup()
>   migration: Make compression_threads use save/load_setup/cleanup()
>
>  hw/ppc/spapr.c               |  4 +--
>  include/migration/register.h |  6 ++--
>  migration/block.c            |  4 +--
>  migration/migration.c        |  8 ------
>  migration/ram.c              | 66 ++++++++++++++++++++++++++++++--------------
>  migration/ram.h              |  6 ----
>  migration/savevm.c           | 41 +++++++++++++++++++++++----
>  7 files changed, 89 insertions(+), 46 deletions(-)
