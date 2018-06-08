Received: from eggs.gnu.org ([2001:4830:134:3::10]:33134)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fRDjA-0006CV-03
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 05:30:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fRDj6-0002cT-ME
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 05:30:35 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50904 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1fRDj6-0002cC-FT
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 05:30:32 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B9368873C2
	for <qemu-devel@nongnu.org>; Fri,  8 Jun 2018 09:30:31 +0000 (UTC)
Date: Fri, 8 Jun 2018 11:30:29 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180608113029.31fd29aa@redhat.com>
In-Reply-To: <20180608081846.GB2671@work-vm>
References: <20180605122636.33654-1-dgilbert@redhat.com>
	<20180605122636.33654-5-dgilbert@redhat.com>
	<20180607084933.GH750@xz-mi> <87muw6wzud.fsf@dusky.pond.sub.org>
	<20180607134529.GL2522@work-vm> <87sh5yr5pv.fsf@dusky.pond.sub.org>
	<20180607152832.GR2522@work-vm> <87sh5xom7g.fsf@dusky.pond.sub.org>
	<20180608081846.GB2671@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 4/6] hmp: Add info commands for preconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>

On Fri, 8 Jun 2018 09:18:46 +0100
"Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:

> * Markus Armbruster (armbru@redhat.com) wrote:
> > "Dr. David Alan Gilbert" <dgilbert@redhat.com> writes:
> >   
> > > * Markus Armbruster (armbru@redhat.com) wrote:  
> > >> "Dr. David Alan Gilbert" <dgilbert@redhat.com> writes:
> > >>   
> > >> > * Markus Armbruster (armbru@redhat.com) wrote:  
> > >> >> Peter Xu <peterx@redhat.com> writes:
> > >> >>   
> > >> >> > On Tue, Jun 05, 2018 at 01:26:34PM +0100, Dr. David Alan Gilbert (git) wrote:  
> > >> >> >> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> > >> >> >> 
> > >> >> >> Allow a bunch of the info commands to be used in preconfig.
> > >> >> >> Could probably add most of them.  
> > >> >> >
> > >> >> > I guess some of them may not work yet during preconfig.  E.g.:
> > >> >> >
> > >> >> > $ ./x86_64-softmmu/qemu-system-x86_64 -preconfig -monitor stdio
> > >> >> > QEMU 2.12.50 monitor - type 'help' for more information
> > >> >> > (qemu) info mtree
> > >> >> > address-space: memory
> > >> >> >   0000000000000000-ffffffffffffffff (prio 0, i/o): system
> > >> >> >
> > >> >> > address-space: I/O
> > >> >> >   0000000000000000-000000000000ffff (prio 0, i/o): io
> > >> >> >
> > >> >> > But it's fine to enable that I guess.
> > >> >> >
> > >> >> > (Which "info" command would you want to use during preconfig?)
> > >> >> >  
> > >> >> >> 
> > >> >> >> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>  
> > >> >> >
> > >> >> > Reviewed-by: Peter Xu <peterx@redhat.com>  
> > >> >> 
> > >> >> The reason for having -preconfig is us despairing of making -S do the
> > >> >> right thing.  We'd have to *understand* the tangled mess that is our
> > >> >> startup, and rearrange it so QMP becomes available early enough for
> > >> >> configuring NUMA (and other things), yet late enough for everything to
> > >> >> work.
> > >> >> 
> > >> >> -preconfig is a cheap hack to avoid this headache, by bypassing almost
> > >> >> all of "everything".
> > >> >> 
> > >> >> Now you bring back some of "everything".  Dangerous.  You better show it
> > >> >> actually works.  Until you do:
> > >> >> 
> > >> >> NAK  
> > >> >
> > >> > Well I did test each command in here to make sure it didn't
> > >> > crash/produce complete junk; but here's the output with the v2 of this
> > >> > patch that Igor R-b:  
> > >> [...]
> > >> 
> > >> For the sake of the argument, let's assume these commands all work in
> > >> preconfig state.  Are their QMP equivalents all available in preconfig
> > >> state?  
> > >
> > > That I don't know; I was happy to fix my list to the ones
> > > Igor recommended.  If you object to some particular entries I'll
> > > be happy to change them.  
> > 
> > HMP must not provide more functionality than QMP.  Specifically, we may
> > provide "info FOO" only when we also provide query-FOO.
> >
> > There are exceptions to this rule.  I don't think they apply here.  I'm
> > prepared to discuss them, of course.  
> 
> No, that's strictly not true;  HMP can provide anything that helps
> a human debug stuff.  The requirement is that if a tool needs it then it
> must be provided in QMP.
> 
> > I wish there was a way to automate "provide command in HMP when its
> > buddy is available in QMP", but since the buddies are only connected by
> > code, that seems infeasible.
> > 
> > Without such automation, the two sets of available commands need to be
> > kept consistent manually.  The larger they are, the more of a bother.
> > 
> > Bother is fine when it provides commensurate value to users.  Options in
> > increasing order of value provided:
> > 
> > (1) HMP becomes ready only after we exit preconfig state (what I
> >     proposed in Message-ID: <87603cxob9.fsf@dusky.pond.sub.org>.
> >
> > (2) HMP provides help, quit, exit-preconfig.
> > 
> > (3) HMP provides (a subset of) the commands QMP provides.
> > 
> > I figure the maintenance cost of (1) and (2) will be negligible, but (3)
> > could be a drag.  Are you sure it's worthwhile?  
>
> 
> I'm not prepared to restrict to (2), and I'm not prepared to restrict
> HMP to a subset of QMP;  As I said previously, if there's a command that
> you think is incorrect/broken that I've enabled then I'm happy to
> remove it.
I'd prefer #3 if we going to expose HMP at all or #1.

#3 would allow testing via HMP for those who can't use qmp-shell.
we can trim HMP list to allowed-preconfig commands or audit respective
QMP variants (they should work without changes) and flag them with
allowed-preconfig. 

> 
> Dave
> 
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> 
