Received: from eggs.gnu.org ([2001:4830:134:3::10]:38774)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1evErd-000574-4P
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 00:15:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1evErY-0001mM-6Y
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 00:15:09 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36008 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1evErY-0001mG-21
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 00:15:04 -0400
Date: Mon, 12 Mar 2018 12:14:46 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180312041446.GE5234@xz-mi>
References: <20180309090006.10018-1-peterx@redhat.com>
	<c0b6d582-743b-f2c1-5eef-a1577e73ae80@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c0b6d582-743b-f2c1-5eef-a1577e73ae80@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v8 00/23] QMP: out-of-band (OOB) execution
 support
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

On Sat, Mar 10, 2018 at 08:59:38PM -0600, Eric Blake wrote:
> On 03/09/2018 02:59 AM, Peter Xu wrote:
> > Based-on: <20180306053320.15401-1-peterx@redhat.com>
> > 
> > The series is based on the following series:
> > 
> >    [PATCH v2 0/9] chardev: qio related non-default context support
> >    (actually patch 9 is based on version 2.1, Dan's version)

[1]

> > 
> > This version only contains some trivial changes, most of the work is
> > posted separately in either the QIO or CHARDEV series.
> > 
> > Four days until soft freeze.  Hmm...
> > 
> > Please review.  Thanks,
> > 
> > v8:
> > - fix up doc patch as suggested [Eric]
> > - rename functions in form of X_get_Y() or X_bh() [Stefan]
> > - English fixes [Stefan]
> > - make sure to kick iothread after suspend count update [Stefan]
> > - remove the hack to remove fd in monitor_init(), since now we have
> >    the QIO/CHARDEV series to solve the root problem.
> 
> Still a lot that I had to clean up (in part due to conflicts with other
> pending patches that also touch qapi), but given the utility of this
> feature, and the impending deadline for freeze, I've gone ahead and done the
> cleanup work.  Your patches are now stages on my QAPI tree.
> 
> git://repo.or.cz/qemu/ericb.git qapi
> http://repo.or.cz/qemu/ericb.git/shortlog/refs/heads/qapi
> 
> Note that I had some ideas for followup patches (mainly strengthening the
> testsuite, which is typically safe early on in freeze because it is not
> introducing features but strengthening the quality of the release).

I really appreciate very much on your work and time on the series.

I've noted down all the review comments, including the test
enhancements (which I'll do in a proper way soon).  I'll avoid
replying to every review comments since all of them are sane.

Note that this series will depend on the chardev fixes ([1] above) in
Paolo's tree. They'll possibly not be needed for compilation, but
might be needed for further tests.  Hope that won't be a big problem.

Thanks again!

-- 
Peter Xu
