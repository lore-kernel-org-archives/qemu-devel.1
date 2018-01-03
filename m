Received: from eggs.gnu.org ([2001:4830:134:3::10]:54554)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eWg9k-00062s-VI
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 05:20:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eWg9h-0004it-Fd
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 05:20:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58162)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1eWg9h-0004iY-8g
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 05:20:17 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 712234903C
	for <qemu-devel@nongnu.org>; Wed,  3 Jan 2018 10:20:16 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20180103054043.25719-12-peterx@redhat.com> (Peter Xu's message
	of "Wed, 3 Jan 2018 13:40:43 +0800")
References: <20180103054043.25719-1-peterx@redhat.com>
	<20180103054043.25719-12-peterx@redhat.com>
Reply-To: quintela@redhat.com
Date: Wed, 03 Jan 2018 11:20:10 +0100
Message-ID: <87wp0z1bxh.fsf@secure.laptop>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 11/11] migration: put the finish part into
 a new function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

Peter Xu <peterx@redhat.com> wrote:
> This patch only moved the last part of migration_thread() into a new
> function migration_iteration_finish() to make it much shorter.  With
> previous works to remove some local variables, now it's fairly easy to
> do that.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>

Thanks, Juan.
