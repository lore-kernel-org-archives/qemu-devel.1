Received: from eggs.gnu.org ([2001:4830:134:3::10]:33257)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eZBqL-0002ne-N9
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 03:34:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eZBqH-0005ly-Lc
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 03:34:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35038)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eZBqH-0005km-GJ
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 03:34:37 -0500
Date: Wed, 10 Jan 2018 16:34:24 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180110083424.GI5984@xz-mi>
References: <20171219084557.9801-1-peterx@redhat.com>
	<20171219084557.9801-10-peterx@redhat.com>
	<1b06d767-0529-12e5-8eaa-f9f56f72b111@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1b06d767-0529-12e5-8eaa-f9f56f72b111@redhat.com>
Subject: Re: [Qemu-devel] [RFC v6 09/27] monitor: create monitor dedicate
 iothread
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

On Tue, Jan 09, 2018 at 05:31:18PM -0600, Eric Blake wrote:
> On 12/19/2017 02:45 AM, Peter Xu wrote:
> 
> Grammar in the subject:
> 
> s/monitor dedicate/a dedicated monitor/
> 
> > Create one IOThread for the monitors, prepared to handle all the
> > input/output IOs using existing iothread framework.
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  monitor.c | 29 +++++++++++++++++++++++++++++
> >  1 file changed, 29 insertions(+)
> > 
> 
> > @@ -207,6 +208,11 @@ struct Monitor {
> >      QTAILQ_ENTRY(Monitor) entry;
> >  };
> >  
> > +/* Let's add monitor global variables to this struct. */
> 
> Is this comment a placeholder for future additions in later patches of
> the series?  If so, a temporary TODO or FIXME might make it easier to
> track that this patch is part of a series; if not, you could delete the
> comment altogether.

mon_iothread is the first element of struct already so IMHO it's not
really a TODO.  The series will add some more things inside though
(and hoping that it can be a good place to unify global monitor stuff
in the future).  Actually the comment is a suggestion from Stefan and
either with/without it works for me.

> 
> > +static struct {
> > +    IOThread *mon_iothread;
> > +} mon_global;
> > +
> 
> Up to you what to do about the comment; tweaking it (or leaving it
> unchanged) is not a semantic change, so I'm fine with:
> 
> Reviewed-by: Eric Blake <eblake@redhat.com>

So I'm taking the R-b if you won't disagree and keep everything
untouched.  Thanks,

-- 
Peter Xu
