Received: from eggs.gnu.org ([2001:4830:134:3::10]:37432)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fYAwO-0007ts-DB
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 09:57:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fYAwN-0003Ad-J5
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 09:57:00 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51824 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fYAwN-0003A9-DI
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 09:56:59 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BE5E9814F0B7
	for <qemu-devel@nongnu.org>; Wed, 27 Jun 2018 13:56:58 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20180627132246.5576-4-peterx@redhat.com> (Peter Xu's message of
	"Wed, 27 Jun 2018 21:22:45 +0800")
References: <20180627132246.5576-1-peterx@redhat.com>
	<20180627132246.5576-4-peterx@redhat.com>
Reply-To: quintela@redhat.com
Date: Wed, 27 Jun 2018 16:00:26 +0200
Message-ID: <877emkjpmt.fsf@secure.laptop>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3 3/4] migration: unbreak postcopy recovery
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

Peter Xu <peterx@redhat.com> wrote:
> The whole postcopy recovery logic was accidentally broken.  We need to
> fix it in two steps.
>
> This is the first step that we should do the recovery when needed.  It
> was bypassed before after commit 36c2f8be2c.
>
> Introduce postcopy_try_recovery() helper for the postcopy recovery
> logic.  Call it both in migration_fd_process_incoming() and
> migration_ioc_process_incoming().
>
> Fixes: 36c2f8be2c ("migration: Delay start of migration main routines")
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>
