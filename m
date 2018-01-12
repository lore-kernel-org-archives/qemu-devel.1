Received: from eggs.gnu.org ([2001:4830:134:3::10]:41961)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eZqx6-0004pK-E0
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 23:28:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eZqx3-0003Tb-Az
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 23:28:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38964)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eZqx3-0003Sr-2b
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 23:28:21 -0500
Date: Fri, 12 Jan 2018 12:28:09 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180112042809.GG2551@xz-mi>
References: <20171219084557.9801-1-peterx@redhat.com>
	<20171219084557.9801-12-peterx@redhat.com>
	<f545e9b6-621b-e2e6-505b-f520625c173d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f545e9b6-621b-e2e6-505b-f520625c173d@redhat.com>
Subject: Re: [Qemu-devel] [RFC v6 11/27] qmp: introduce QMPCapability
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

On Thu, Jan 11, 2018 at 05:07:11PM -0600, Eric Blake wrote:
> On 12/19/2017 02:45 AM, Peter Xu wrote:
> > There was no QMP capabilities defined.  Define the first "oob" as
> 
> s/was/were/

Fixed.

Just to confirm: is "There was no QMP capability" also correct?

> 
> > capability to allow out-of-band messages.
> > 
> > Also, touch up qmp-test.c to test the new bits.
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  monitor.c        | 10 ++++++++--
> >  qapi-schema.json | 13 +++++++++++++
> >  tests/qmp-test.c | 10 +++++++++-
> >  3 files changed, 30 insertions(+), 3 deletions(-)
> 
> I'm assuming later patches will document this?
> 
> I'm somewhat a fan of documentation alongside or before implementation,
> as getting the general overview right and then checking that the code
> matches is a bit nicer than random coding then documenting what we ended
> up with.  But I don't know if reordering patches in your series is
> necessary, as long as the end product is properly documented.

Yes, I put the whole document at the end of the series.  I can put it
as the first patch too.

> 
> > +++ b/qapi-schema.json
> > @@ -118,6 +118,19 @@
> >  ##
> >  { 'command': 'qmp_capabilities' }
> 
> The client can't request a particular feature alongside the command?  Or
> is that in later patches?  With just this patch, the enum QMPCapability
> is not introspected, because it is not referenced by any command
> (although introspection is a bit moot, since the client will learn what
> the host advertises from the initial handshake before the client can
> even request introspection).

Yes, client can't if without further patches.

> 
> >  
> > +##
> > +# @QMPCapability:
> > +#
> > +# QMP supported capabilities to be broadcasted to the clients.
> 
> 'broadcast' is one of those weird verbs that doesn't change spelling
> when constructing its past tense (there is no 'broadcasted').  However,
> I think this description is a bit nicer (and avoids the problematic word
> altogether):
> 
> Enumeration of capabilities to be advertised during initial client
> connection, used for agreeing on particular QMP extension behaviors.

I'll take your advise.

> 
> > +#
> > +# @oob:   QMP ability to support Out-Of-Band requests.
> 
> Rather terse (it doesn't say what Out-Of-Band requests are); even a
> pointer to the QMP spec (where OOB is more fully documented) might be
> nice (of course, that means we need a patch to docs/interop/qmp-spec.txt
> somewhere in the series, especially since this patch renders 2.2.1 in
> that document obsolete...)

Sorry for the inconvenience.  Please refer to the last doc patch for
details.

I thought the doc patch would explain itself but obviously I should be
more careful on the ordering next time to ease reviewers.  I'll move
the doc patch to front when repost, and I'll note here to refer to
qmp-spec.txt for more information.

Thanks,

-- 
Peter Xu
