Received: from eggs.gnu.org ([2001:4830:134:3::10]:45511)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1ePReX-0001PS-Rv
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 06:26:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1ePReV-00016Q-1Y
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 06:26:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60520)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kchamart@redhat.com>) id 1ePReU-00014s-Qb
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 06:26:10 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EDDB1C01BD2D
	for <qemu-devel@nongnu.org>; Thu, 14 Dec 2017 11:26:07 +0000 (UTC)
Date: Thu, 14 Dec 2017 12:26:03 +0100
From: Kashyap Chamarthy <kchamart@redhat.com>
Message-ID: <20171214112603.7gkt3dwgxoioybse@eukaryote>
References: <20171212135600.14965-1-dgilbert@redhat.com>
	<20171212182353.hme665vsaohxdvzv@eukaryote>
	<20171213201145.GB8501@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171213201145.GB8501@work-vm>
Subject: Re: [Qemu-devel] [PATCH] docs: Convert migration.txt to rst
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, quintela@redhat.com, peterx@redhat.com

On Wed, Dec 13, 2017 at 08:11:46PM +0000, Dr. David Alan Gilbert wrote:
> * Kashyap Chamarthy (kchamart@redhat.com) wrote:
> > On Tue, Dec 12, 2017 at 01:56:00PM +0000, Dr. David Alan Gilbert (git) wrote:

[...]

> > A good chunk of changes I suggest are pre-existing, so take it with a
> > grain of salt :-).  I'm ambivalent on whether to keep the conversion to
> > rST and the other rST syntax changes separate.  Maybe we can keep in one
> > change, as this doesn't impact backports in terms of code /
> > functionality.
> 
> I'd like to fix the non-rST fixes some other time; there's plenty wrong
> with the actual contents of this file.

That's fine.

> (I need to pull in a fix from Jay Zhou before resending this actually).
 
[...]

> > Not this patch's problem, but do we have the more information that is to
> > be filled in above?
> 
> Oh yes, plenty!

Okay, I take it that you'd address them as a future patch.

[...]

> > - I think the above is a TODO item; so you can use:
> > 
> >     .. TODO (dgilbert):: talk about how vmstate <-> qdev interact, and
> >     what the instance ids mean.
> > 
> >   As that'll keep it only in the source rST; but not in the rendered
> >   version.
> 
> I'd rather leave the items rendered, otherwise they have even less
> chance of being fixed.

Yeah, I thought about it too; you're correct, a visual reminder works
better.

[...]

> > >  When postcopy starts the source sends the page discard data and then
> > >  forms the 'package' containing:
> > >  
> > > -   Command: 'postcopy listen'
> > > -   The device state
> > 
> > In my local Sphinx-based HTML rendering, the above "The device state"
> > ended up being bold somehow.
> 
> Any idea why? It's fine both in vim and rst2html-3's output.

Don't know yet.  You can see here in the Sphinx-rendered HTML version:

    https://kashyapc.fedorapeople.org/QEMU-Docs/_build/html/docs/migration.html

You can also see in the "Massaging functions" --> "Subsections" --> "For
example;" also turned into bold.

Same for the "Postcopy states".  And a couple of other places, where
text turned into bold.

I'll let you know once I figure it out.

[...]

-- 
/kashyap
