Received: from eggs.gnu.org ([2001:4830:134:3::10]:40493)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fLlcp-0005TS-OQ
	for qemu-devel@nongnu.org; Thu, 24 May 2018 04:29:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fLlcm-0006Un-He
	for qemu-devel@nongnu.org; Thu, 24 May 2018 04:29:31 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47628 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fLlcm-0006Ud-DV
	for qemu-devel@nongnu.org; Thu, 24 May 2018 04:29:28 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F3EA9805A52F
	for <qemu-devel@nongnu.org>; Thu, 24 May 2018 08:29:27 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20180524043952.11245-1-peterx@redhat.com>
	<20180524043952.11245-2-peterx@redhat.com>
Date: Thu, 24 May 2018 10:29:20 +0200
In-Reply-To: <20180524043952.11245-2-peterx@redhat.com> (Peter Xu's message of
	"Thu, 24 May 2018 12:39:49 +0800")
Message-ID: <877ent8nj3.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v7 1/4] monitor: rename out_lock to mon_lock
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

> The out_lock is protecting a few Monitor fields.  In the future the
> monitor code will start to run in multiple threads.  We are going to
> turn it into a bigger lock to protect not only the out buffer but also
> all the rest.

Hmm, not sure about "all the rest": PATCH 3 marks a member as not
needing protection.  Shall I change this to "most of the rest" when I
apply?

>
> Since at it, rearrange the Monitor struct a bit.
>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
