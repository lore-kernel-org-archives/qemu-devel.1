Received: from eggs.gnu.org ([2001:4830:134:3::10]:55902)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fNBeS-0002RD-SQ
	for qemu-devel@nongnu.org; Mon, 28 May 2018 02:29:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fNBeP-0008Av-Of
	for qemu-devel@nongnu.org; Mon, 28 May 2018 02:29:04 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44978 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fNBeP-0008AX-Kg
	for qemu-devel@nongnu.org; Mon, 28 May 2018 02:29:01 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 31ABA818BAF2
	for <qemu-devel@nongnu.org>; Mon, 28 May 2018 06:29:00 +0000 (UTC)
Date: Mon, 28 May 2018 14:28:54 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180528062854.GC2584@xz-mi>
References: <20180524043952.11245-1-peterx@redhat.com>
	<20180524043952.11245-4-peterx@redhat.com>
	<8736yh8mze.fsf@dusky.pond.sub.org> <20180524084844.GF12122@xz-mi>
	<87bmd55mo4.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87bmd55mo4.fsf@dusky.pond.sub.org>
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
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Thu, May 24, 2018 at 01:16:11PM +0200, Markus Armbruster wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Thu, May 24, 2018 at 10:41:09AM +0200, Markus Armbruster wrote:
> >> Regarding the subject: what are "fleids"?
> >
> > Ouch. :( I meant the word "fields".
> 
> Can touch that up in my tree.

[...]

> >> > +    /*
> >> > +     * State used only in the thread "owning" the monitor.
> >> > +     * If @use_io_thr, this is mon_global.mon_iothread.
> >> > +     * Else, it's the main thread.
> >> > +     * These members can be safely accessed without locks.
> >> > +     */
> >> >      ReadLineState *rs;
> >> > +    // other members that aren't shared
> >> 
> >> Whoops, misunderstanding!  I meant this line as a placeholder, to
> >> further illustrate my intent.  It should not be committed.  If we need a
> >> comment here, it should use /* traditional comment syntax */.
> >
> > My fault.
> >
> > Please let me know if you want me to repost...  Thanks,
> 
> Can touch that up, too.  No respin needed unless something more complex
> comes up.

I'll modify these two parts in my next post.

Regards,

-- 
Peter Xu
