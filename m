Received: from eggs.gnu.org ([2001:4830:134:3::10]:47068)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fQvz2-0006rL-C0
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 10:33:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fQvz1-0001Vo-LK
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 10:33:48 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42660 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fQvz1-0001VU-9Q
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 10:33:47 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DACFE401EF1F
	for <qemu-devel@nongnu.org>; Thu,  7 Jun 2018 14:33:46 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20180529055755.12404-1-peterx@redhat.com>
	<20180529055755.12404-7-peterx@redhat.com>
Date: Thu, 07 Jun 2018 16:33:45 +0200
In-Reply-To: <20180529055755.12404-7-peterx@redhat.com> (Peter Xu's message of
	"Tue, 29 May 2018 13:57:54 +0800")
Message-ID: <874lieu0mu.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v9 6/7] monitor: move init global earlier
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>

Peter Xu <peterx@redhat.com> writes:

> Before this patch, monitor fd helpers might be called even earlier than
> monitor_init_globals().  This can be problematic.
>
> After previous work, now monitor_init_globals() does not depend on
> accelerator initialization any more.  Call it earlier (before CLI
> parsing; that's where the monitor APIs might be called) to make sure it
> is called before any of the monitor APIs.
>
> Suggested-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Markus Armbruster <armbru@redhat.com>
