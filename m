Received: from eggs.gnu.org ([2001:4830:134:3::10]:44421)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fLlvd-0004A3-Oo
	for qemu-devel@nongnu.org; Thu, 24 May 2018 04:48:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fLlva-0002II-Lv
	for qemu-devel@nongnu.org; Thu, 24 May 2018 04:48:57 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41904 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fLlva-0002Hw-Ek
	for qemu-devel@nongnu.org; Thu, 24 May 2018 04:48:54 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E1C54BB408
	for <qemu-devel@nongnu.org>; Thu, 24 May 2018 08:48:53 +0000 (UTC)
Date: Thu, 24 May 2018 16:48:44 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180524084844.GF12122@xz-mi>
References: <20180524043952.11245-1-peterx@redhat.com>
	<20180524043952.11245-4-peterx@redhat.com>
	<8736yh8mze.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8736yh8mze.fsf@dusky.pond.sub.org>
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
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>

On Thu, May 24, 2018 at 10:41:09AM +0200, Markus Armbruster wrote:
> Regarding the subject: what are "fleids"?

Ouch. :( I meant the word "fields".

> 
> Peter Xu <peterx@redhat.com> writes:
> 
> > Add some explicit comment for both Readline and cpu_set/cpu_get helpers
> > that they do not need the mon_lock protection.
> >
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  monitor.c | 12 +++++++++++-
> >  1 file changed, 11 insertions(+), 1 deletion(-)
> >
> > diff --git a/monitor.c b/monitor.c
> > index d6c3c08932..f01589f945 100644
> > --- a/monitor.c
> > +++ b/monitor.c
> > @@ -207,7 +207,16 @@ struct Monitor {
> >      int suspend_cnt;            /* Needs to be accessed atomically */
> >      bool skip_flush;
> >      bool use_io_thr;
> > +
> > +    /*
> > +     * State used only in the thread "owning" the monitor.
> > +     * If @use_io_thr, this is mon_global.mon_iothread.
> > +     * Else, it's the main thread.
> > +     * These members can be safely accessed without locks.
> > +     */
> >      ReadLineState *rs;
> > +    // other members that aren't shared
> 
> Whoops, misunderstanding!  I meant this line as a placeholder, to
> further illustrate my intent.  It should not be committed.  If we need a
> comment here, it should use /* traditional comment syntax */.

My fault.

Please let me know if you want me to repost...  Thanks,

-- 
Peter Xu
