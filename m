Received: from eggs.gnu.org ([2001:4830:134:3::10]:54476)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eZtEc-0005Li-9J
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 01:54:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eZtEX-0003yx-Bf
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 01:54:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51006)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eZtEX-0003xT-4N
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 01:54:33 -0500
Date: Fri, 12 Jan 2018 14:54:17 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180112065417.GO2551@xz-mi>
References: <20171219084557.9801-1-peterx@redhat.com>
	<20171219084557.9801-26-peterx@redhat.com>
	<20180109145225.GI31400@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180109145225.GI31400@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [RFC v6 25/27] docs: update QMP documents for OOB
 commands
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

On Tue, Jan 09, 2018 at 02:52:25PM +0000, Stefan Hajnoczi wrote:
> On Tue, Dec 19, 2017 at 04:45:55PM +0800, Peter Xu wrote:
> > +To add OOB execution support for a command, we need to make sure the
> > +command handler satisfies at least the following:
> 
> It would help to rephrase this in the imperative mood (telling the
> reader what to do rather than describing what would need to be done):
> 
> "OOB command handlers must satisfy the following conditions:"
> 
> That way it's shorter and easier to read, and it communicates that these
> conditions are absolutely necessary.
> 
> > +
> > +- It executes extremely fast,
> > +- It does not take any lock (or, it can take very small locks, but in
> > +  very predictable ways),
> 
> "it can take very small locks, but in very predictable ways" does not
> explain what is allowed and what isn't.
> 
> I suggest: "it can take very small locks if all critical regions also
> follow the rules for OOB command handler code".
> 
> > +- It does not invoke system calls that may block,
> > +- It does not access guest RAM that may block when userfaultfd is
> > +  enabled for postcopy live migration.
> > +
> > +If someone is unsure about whether a command handler can be run in OOB
> > +way, then it possibly means that it does not suite for OOB execution.
> 
> "If in doubt, do not implement OOB execution support."

All fixed.  Thanks,

-- 
Peter Xu
