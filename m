Received: from eggs.gnu.org ([2001:4830:134:3::10]:45533)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dl7HL-0004WQ-C8
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 01:35:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dl7HI-0002nA-73
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 01:35:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42678)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dl7HI-0002lD-0X
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 01:35:32 -0400
Date: Fri, 25 Aug 2017 13:35:26 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170825053526.GE14174@pxdev.xzpeter.org>
References: <1503471071-2233-1-git-send-email-peterx@redhat.com>
	<1503471071-2233-5-git-send-email-peterx@redhat.com>
	<20170823174411.GG2648@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170823174411.GG2648@work-vm>
Subject: Re: [Qemu-devel] [RFC v2 4/8] QAPI: new QMP command option
 "without-bql"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>

On Wed, Aug 23, 2017 at 06:44:12PM +0100, Dr. David Alan Gilbert wrote:

[...]

> > +Most of the commands require the Big QEMU Lock (BQL) be held during
> > +execution.  However, there is a small subset of the commands that may
> > +not really need BQL at all.  To mark out this kind of commands, we can
> > +specify "without-bql" to "true".  This parameter is only a hint for
> > +internal QMP implementation to provide possiblility to allow commands
> > +be run in parallel, or reduce the contention of the lock.  Users of QMP
> > +should not really be aware of such information.
> 
> Well, I think users of these commands might select them specifically
> because they know that they won't block.  Those who care about latency might
> look to use commands that don't take the lock because of a reduced
> effect on the performance as well.

What would be the best way to tell user?  I think again this should
mostly for HMP only, right?

Maybe we can add a new command to list these lock-free commands.  Or,
I can dump something in "help" and "help info" like:

(qemu) help migrate_incoming
migrate_incoming uri -- Continue an incoming migration from an -incoming defer (BQL-less)

-- 
Peter Xu
