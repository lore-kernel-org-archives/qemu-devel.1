Received: from eggs.gnu.org ([2001:4830:134:3::10]:57465)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eCKkI-0003OW-El
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 02:25:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eCKkF-0004m2-A4
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 02:25:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57610)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eCKkF-0004lg-43
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 02:25:55 -0500
Date: Wed, 8 Nov 2017 15:25:42 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20171108072542.GA2992@xz-mi>
References: <20171106094643.14881-1-peterx@redhat.com>
	<20171106094643.14881-11-peterx@redhat.com>
	<20171107071131.GN16355@lemon>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171107071131.GN16355@lemon>
Subject: Re: [Qemu-devel] [RFC v3 10/27] monitor: create monitor dedicate
 iothread
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

On Tue, Nov 07, 2017 at 03:11:31PM +0800, Fam Zheng wrote:
> On Mon, 11/06 17:46, Peter Xu wrote:
> > +static GMainContext *monitor_io_context_get(void)
> > +{
> > +    return iothread_get_g_main_context(mon_global.mon_iothread);
> > +}
> > +
> > +static void monitor_iothread_init(void)
> > +{
> > +    mon_global.mon_iothread = iothread_create("monitor_iothread",
> > +                                              &error_abort);
> > +    /*
> > +     * GContext in iothread is using lazy init - the first time we
> > +     * fetch the context we'll have that initialized.
> > +     */
> > +    monitor_io_context_get();
> 
> Why do you need an eager init here?

I thought putting this line with IOThread creation will make it more
clear that the IOThread is using GMainContext polling.  I am not that
strong to keep it, but I would prefer.

-- 
Peter Xu
