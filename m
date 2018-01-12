Received: from eggs.gnu.org ([2001:4830:134:3::10]:51240)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eZpwL-0004g1-Pj
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 22:23:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eZpwI-0007Pw-EN
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 22:23:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50876)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eZpwI-0007P3-7P
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 22:23:30 -0500
Date: Fri, 12 Jan 2018 11:23:18 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180112032318.GE2551@xz-mi>
References: <20171219084557.9801-1-peterx@redhat.com>
	<20171219084557.9801-11-peterx@redhat.com>
	<a1c0a439-9458-e7aa-2beb-e21185075c26@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a1c0a439-9458-e7aa-2beb-e21185075c26@redhat.com>
Subject: Re: [Qemu-devel] [RFC v6 10/27] monitor: allow to use IO thread for
 parsing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <shajnocz@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, marcandre.lureau@redhat.com, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Tue, Jan 09, 2018 at 05:37:39PM -0600, Eric Blake wrote:
> On 12/19/2017 02:45 AM, Peter Xu wrote:
> 
> Grammar in the subject:
> 
> "allow to $VERB" is not idiomatic English; correct is either "allow
> ${VERB}ing" or "allow $SUBJECT to $VERB".  Concretely, s/to use/using/
> 
> > For each Monitor, add one field "use_io_thr" to show whether it will be
> > using the dedicated monitor IO thread to handle input/output.  When set,
> > monitor IO parsing work will be offloaded to dedicated monitor IO
> 
> s/to/to the/
> 
> > thread, rather than the original main loop thread.
> > 
> > This only works for QMP.  HMP will always be run on main loop thread.
> 
> s/on/on the/
> 
> > 
> > Currently we're still keeping use_io_thr to off always.  Will turn it on
> 
> s/to off/off/
> 
> > later at some point.
> > 
> > One thing to mention is that we cannot set use_io_thr for every QMP
> > monitors.  The problem is that MUXed typed chardevs may not work well
> 
> s/monitors/monitor/
> 
> > with it now. When MUX is used, frontend of chardev can be the monitor
> > plus something else.  The only thing we know would be safe to be run
> > outside main thread so far is the monitor frontend. All the rest of the
> > frontends should still be run in main thread only.
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  monitor.c | 41 ++++++++++++++++++++++++++++++++---------
> >  1 file changed, 32 insertions(+), 9 deletions(-)
> > 
> I have nothing to add on the code review, but it looks like Stefan had
> valid comments that need addressing.

Yes, will address it with all the grammar fixes above.  Thanks,

-- 
Peter Xu
