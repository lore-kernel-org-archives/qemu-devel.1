Received: from eggs.gnu.org ([2001:4830:134:3::10]:43707)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eZsXP-0007Vx-Df
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 01:10:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eZsXK-0005d6-E4
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 01:09:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38654)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eZsXK-0005bG-7x
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 01:09:54 -0500
Date: Fri, 12 Jan 2018 14:09:41 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180112060941.GK2551@xz-mi>
References: <20171219084557.9801-1-peterx@redhat.com>
	<20171219084557.9801-18-peterx@redhat.com>
	<20180109132020.GB31400@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180109132020.GB31400@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [RFC v6 17/27] qmp: add new event "command-dropped"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <shajnocz@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, marcandre.lureau@redhat.com, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Tue, Jan 09, 2018 at 01:20:20PM +0000, Stefan Hajnoczi wrote:
> On Tue, Dec 19, 2017 at 04:45:47PM +0800, Peter Xu wrote:
> > This event will be emitted if one QMP command is dropped.  Along,
> > declare an enum for the reasons.
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  qapi-schema.json | 37 +++++++++++++++++++++++++++++++++++++
> >  1 file changed, 37 insertions(+)
> > 
> > diff --git a/qapi-schema.json b/qapi-schema.json
> > index 531fd4c0db..447ab25572 100644
> > --- a/qapi-schema.json
> > +++ b/qapi-schema.json
> > @@ -3222,3 +3222,40 @@
> >  # Since: 2.11
> >  ##
> >  { 'command': 'watchdog-set-action', 'data' : {'action': 'WatchdogAction'} }
> > +
> > +##
> > +# @CommandDropReason:
> > +#
> > +# Reasons that caused one command to be dropped.
> > +#
> > +# @queue-full: the queue of command is full. This can only occur when
> 
> s/the queue of command is full/the command queue is full/

Fixed.  Thanks,

-- 
Peter Xu
