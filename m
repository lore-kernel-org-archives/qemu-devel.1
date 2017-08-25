Received: from eggs.gnu.org ([2001:4830:134:3::10]:46887)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dl7JD-0005Yn-9d
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 01:37:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dl7J8-0004Iv-ES
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 01:37:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57086)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dl7J8-0004IS-8L
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 01:37:26 -0400
Date: Fri, 25 Aug 2017 13:37:18 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170825053718.GF14174@pxdev.xzpeter.org>
References: <1503471071-2233-1-git-send-email-peterx@redhat.com>
	<1503471071-2233-5-git-send-email-peterx@redhat.com>
	<20170823174411.GG2648@work-vm> <20170823233732.GA16947@lemon>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170823233732.GA16947@lemon>
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
To: Fam Zheng <famz@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>

On Thu, Aug 24, 2017 at 07:37:32AM +0800, Fam Zheng wrote:
> On Wed, 08/23 18:44, Dr. David Alan Gilbert wrote:
> > * Peter Xu (peterx@redhat.com) wrote:
> > > Introducing this new parameter for QMP commands in general to mark out
> > > when the command does not need BQL.  Normally QMP command executions are
> > > done with the protection of BQL in QEMU.  However the truth is that not
> > > all the QMP commands require the BQL.
> > > 
> > > This new parameter provides a way to allow QMP commands to run in
> > > parallel when possible, without the contention on the BQL.
> > > 
> > > Since the default value of "without-bql" is still false, so now all QMP
> > > commands are still protected by BQL still.
> > > 
> > > Signed-off-by: Peter Xu <peterx@redhat.com>
> > 
> > We should define what a 'without-bql' command is allowed to do:
> >    'Commands that have without-bql set _may_ be called without the bql
> >    being taken.  They must not take the bql or any other lock that may
> >    become dependent on the bql.'

Sure.

> >    (Do we need to say anything about RCU?)

Could I ask how is RCU related?

> > 
> > Also, 'no-bql' is shorter :-)
> 
> Or rather "need-bql" that defaults to true to avoid double negative (TM) with
> "no-bql = false"?

Ok let me use "need-bql". :)

-- 
Peter Xu
