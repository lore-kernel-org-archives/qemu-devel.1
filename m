Received: from eggs.gnu.org ([2001:4830:134:3::10]:38195)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fuUee-0004Br-BI
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 23:26:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fuUeZ-0002Vx-D7
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 23:26:56 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43032 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fuUeZ-0002VR-6C
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 23:26:51 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 98399401EF0F
	for <qemu-devel@nongnu.org>; Tue, 28 Aug 2018 03:26:50 +0000 (UTC)
Date: Tue, 28 Aug 2018 11:26:44 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180828032644.GA4446@xz-x1>
References: <20180815133747.25032-1-peterx@redhat.com>
	<20180815133747.25032-2-peterx@redhat.com>
	<87ftz0ujxi.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87ftz0ujxi.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [PATCH v6 01/13] monitor: simplify
 monitor_qmp_setup_handlers_bh
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>

On Mon, Aug 27, 2018 at 01:29:29PM +0200, Markus Armbruster wrote:
> > @@ -4624,15 +4624,10 @@ static void monitor_qmp_setup_handlers_bh(void *opaque)
> >      Monitor *mon = opaque;
> >      GMainContext *context;
> >  
> > -    if (mon->use_io_thread) {
> > -        /* Use @mon_iothread context */
> > -        context = monitor_get_io_context();
> > -        assert(context);
> > -    } else {
> > -        /* Use default main loop context */
> > -        context = NULL;
> > -    }
> > -
> > +    assert(mon->use_io_thread);
> > +    /* Use @mon_iothread context */
> 
> Mind if I drop this comment?

Yes, please.

> 
> > +    context = monitor_get_io_context();
> > +    assert(context);
> >      qemu_chr_fe_set_handlers(&mon->chr, monitor_can_read, monitor_qmp_read,
> >                               monitor_qmp_event, NULL, mon, context, true);
> >      monitor_list_append(mon);
> 
> R-by stands, of course.

Regards,

-- 
Peter Xu
