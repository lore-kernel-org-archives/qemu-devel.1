Received: from eggs.gnu.org ([2001:4830:134:3::10]:44711)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fLlwH-0004ZC-I0
	for qemu-devel@nongnu.org; Thu, 24 May 2018 04:49:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fLlwD-0002r0-Ki
	for qemu-devel@nongnu.org; Thu, 24 May 2018 04:49:37 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40228 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fLlwD-0002qf-GS
	for qemu-devel@nongnu.org; Thu, 24 May 2018 04:49:33 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0901D40267A0
	for <qemu-devel@nongnu.org>; Thu, 24 May 2018 08:49:33 +0000 (UTC)
Date: Thu, 24 May 2018 16:49:23 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180524084923.GG12122@xz-mi>
References: <20180524043952.11245-1-peterx@redhat.com>
	<20180524043952.11245-4-peterx@redhat.com>
	<20180524080804.GC20733@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180524080804.GC20733@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [PATCH v7 3/4] monitor: more comments on lock-free
 fleids/funcs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Thu, May 24, 2018 at 09:08:04AM +0100, Stefan Hajnoczi wrote:
> On Thu, May 24, 2018 at 12:39:51PM +0800, Peter Xu wrote:
> > Add some explicit comment for both Readline and cpu_set/cpu_get helpers
> > that they do not need the mon_lock protection.
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  monitor.c | 12 +++++++++++-
> >  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> Aside from the checkpatch.pl error that needs to be fixed (I like to use
> a git hook to check automatically, see
> http://blog.vmsplice.net/2011/03/how-to-automatically-run-checkpatchpl.html):
> 
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

Thanks Stefan.  I start to use it now!

-- 
Peter Xu
