Received: from eggs.gnu.org ([2001:4830:134:3::10]:58490)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eCOL8-0000n4-N8
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 06:16:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eCOL5-0001XW-Gv
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 06:16:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40022)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1eCOL5-0001We-9u
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 06:16:11 -0500
Date: Wed, 8 Nov 2017 19:16:03 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20171108111603.GC2834@lemon>
References: <20171106094643.14881-1-peterx@redhat.com>
	<20171106094643.14881-24-peterx@redhat.com>
	<20171107075708.GR16355@lemon> <20171108073111.GB2992@xz-mi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171108073111.GB2992@xz-mi>
Subject: Re: [Qemu-devel] [RFC v3 23/27] qmp: isolate responses into io
 thread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: Laurent Vivier <lvivier@redhat.com>, Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com, Stefan Hajnoczi <shajnocz@redhat.com>, marcandre.lureau@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, Jiri Denemark <jdenemar@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Wed, 11/08 15:31, Peter Xu wrote:
> On Tue, Nov 07, 2017 at 03:57:08PM +0800, Fam Zheng wrote:
> > On Mon, 11/06 17:46, Peter Xu wrote:
> > > @@ -4294,6 +4366,11 @@ static GMainContext *monitor_io_context_get(void)
> > >      return iothread_get_g_main_context(mon_global.mon_iothread);
> > >  }
> > >  
> > > +static AioContext *monitor_aio_context_get(void)
> > > +{
> > > +    return iothread_get_aio_context(mon_global.mon_iothread);
> > > +}
> > > +
> > 
> > This hunk fits better in patch 10, I think?
> 
> This function is only used in current patch, so I think it's fine to
> put it here.  But sure I can move it into patch 10 as well.

OK, so it's static and you want to keep the compiler happy. That's fine then.

Fam
