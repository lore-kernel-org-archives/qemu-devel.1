Received: from eggs.gnu.org ([2001:4830:134:3::10]:58107)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eCKpa-0004Gw-Un
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 02:31:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eCKpX-0007Fy-Rb
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 02:31:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42748)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eCKpX-0007ER-L1
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 02:31:23 -0500
Date: Wed, 8 Nov 2017 15:31:11 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20171108073111.GB2992@xz-mi>
References: <20171106094643.14881-1-peterx@redhat.com>
	<20171106094643.14881-24-peterx@redhat.com>
	<20171107075708.GR16355@lemon>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171107075708.GR16355@lemon>
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
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <shajnocz@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Jiri Denemark <jdenemar@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, marcandre.lureau@redhat.com, Markus Armbruster <armbru@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Tue, Nov 07, 2017 at 03:57:08PM +0800, Fam Zheng wrote:
> On Mon, 11/06 17:46, Peter Xu wrote:
> > @@ -4294,6 +4366,11 @@ static GMainContext *monitor_io_context_get(void)
> >      return iothread_get_g_main_context(mon_global.mon_iothread);
> >  }
> >  
> > +static AioContext *monitor_aio_context_get(void)
> > +{
> > +    return iothread_get_aio_context(mon_global.mon_iothread);
> > +}
> > +
> 
> This hunk fits better in patch 10, I think?

This function is only used in current patch, so I think it's fine to
put it here.  But sure I can move it into patch 10 as well.

Thanks,

> 
> >  static void monitor_iothread_init(void)
> >  {
> >      mon_global.mon_iothread = iothread_create("monitor_iothread",
> 
> Fam

-- 
Peter Xu
