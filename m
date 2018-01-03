Received: from eggs.gnu.org ([2001:4830:134:3::10]:54289)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eWg8j-0005Vd-Qr
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 05:19:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eWg8g-000457-Ku
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 05:19:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57326)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1eWg8g-00044N-FL
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 05:19:14 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 77BDB49035
	for <qemu-devel@nongnu.org>; Wed,  3 Jan 2018 10:19:13 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20180103054043.25719-11-peterx@redhat.com> (Peter Xu's message
	of "Wed, 3 Jan 2018 13:40:42 +0800")
References: <20180103054043.25719-1-peterx@redhat.com>
	<20180103054043.25719-11-peterx@redhat.com>
Reply-To: quintela@redhat.com
Date: Wed, 03 Jan 2018 11:19:06 +0100
Message-ID: <871sj72qjp.fsf@secure.laptop>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 10/11] migration: major cleanup for migrate
 iterations
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
> The major work for migration iterations are to move RAM/block/... data
> via qemu_savevm_state_iterate().  Generalize those part into a single
> function.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>

I am not fan of having to add yet another state enumeration, but I can
think of a clearer way of doing it, so the reviewed-by.

Thanks, Juan.
