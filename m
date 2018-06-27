Received: from eggs.gnu.org ([2001:4830:134:3::10]:37617)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fYAxR-0000MQ-7x
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 09:58:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fYAxN-0004cg-RP
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 09:58:05 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38674 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fYAxN-0004bt-MJ
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 09:58:01 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3900440251BD
	for <qemu-devel@nongnu.org>; Wed, 27 Jun 2018 13:58:01 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20180627132246.5576-5-peterx@redhat.com> (Peter Xu's message of
	"Wed, 27 Jun 2018 21:22:46 +0800")
References: <20180627132246.5576-1-peterx@redhat.com>
	<20180627132246.5576-5-peterx@redhat.com>
Reply-To: quintela@redhat.com
Date: Wed, 27 Jun 2018 16:01:29 +0200
Message-ID: <8736x8jpl2.fsf@secure.laptop>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3 4/4] migration: unify incoming processing
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
> This is the 2nd patch to unbreak postcopy recovery.
>
> Let's unify the migration_incoming_process() call at a single place
> rather than calling it in connection setup codes.  This fixes a problem
> that we will go into incoming migration procedure even if we are trying
> to recovery from a paused postcopy migration.
>
> Fixes: 36c2f8be2c ("migration: Delay start of migration main routines")
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>
