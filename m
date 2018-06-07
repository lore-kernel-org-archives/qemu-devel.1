Received: from eggs.gnu.org ([2001:4830:134:3::10]:47819)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fQw3j-0001GK-1P
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 10:38:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fQw3f-0003cj-UW
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 10:38:39 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37060 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fQw3f-0003cU-QN
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 10:38:35 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 39317859BA
	for <qemu-devel@nongnu.org>; Thu,  7 Jun 2018 14:38:35 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20180529055755.12404-1-peterx@redhat.com>
	<20180529055755.12404-8-peterx@redhat.com>
Date: Thu, 07 Jun 2018 16:38:33 +0200
In-Reply-To: <20180529055755.12404-8-peterx@redhat.com> (Peter Xu's message of
	"Tue, 29 May 2018 13:57:55 +0800")
Message-ID: <87zi06slue.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v9 7/7] monitor: add lock to protect
 mon_fdsets
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

> Introduce a new global big lock for mon_fdsets.  Take it where needed.
>
> The monitor_fdset_get_fd() handling is a bit tricky: now we need to call
> qemu_mutex_unlock() which might pollute errno, so we need to make sure
> the correct errno be passed up to the callers.  To make things simpler,
> we let monitor_fdset_get_fd() return the -errno directly when error
> happens, then in qemu_open() we move it back into errno.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Markus Armbruster <armbru@redhat.com>
