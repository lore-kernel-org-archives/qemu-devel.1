Received: from eggs.gnu.org ([2001:4830:134:3::10]:45527)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eZsdg-0001mK-WB
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 01:16:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eZsdc-0002Fj-25
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 01:16:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39674)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eZsdb-0002EK-S7
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 01:16:23 -0500
Date: Fri, 12 Jan 2018 14:16:10 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180112061610.GL2551@xz-mi>
References: <20171219084557.9801-1-peterx@redhat.com>
	<20171219084557.9801-21-peterx@redhat.com>
	<20180109134528.GE31400@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180109134528.GE31400@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [RFC v6 20/27] qmp: export qmp_dispatch_check_obj
 and allow "id"
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

On Tue, Jan 09, 2018 at 01:45:28PM +0000, Stefan Hajnoczi wrote:
> On Tue, Dec 19, 2017 at 04:45:50PM +0800, Peter Xu wrote:
> > We need this for earlier check for OOB, before reaching
> > do_qmp_dispatch().  Meanwhile, a small touch-up to allow "id" field,
> > after all we allow that for sure in the spec (in any form).
> 
> This change would be better as part of the patch that needs it.  I don't
> understand the commit description and there is no context in this patch
> showing how this change is used.

Maybe I should mention it explicitly that "it'll be used in the
following up patch".

Logically I think this has nothing to do with OOB so I splitted it
out.  I would prefer it to be a separate patch (though I can enrich
the commit message).  Or, I'm also fine if you think squashing this
into next would be nicer.  Thanks,

-- 
Peter Xu
