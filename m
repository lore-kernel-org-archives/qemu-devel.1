Received: from eggs.gnu.org ([2001:4830:134:3::10]:53146)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1dUq4L-0002Au-9T
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 03:58:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1dUq4K-00027N-8Q
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 03:58:53 -0400
Date: Tue, 11 Jul 2017 09:58:39 +0200
From: Kashyap Chamarthy <kchamart@redhat.com>
Message-ID: <20170711075839.wgp64avrkzyo6d6t@eukaryote>
References: <1499674503-21551-1-git-send-email-kchamart@redhat.com>
	<1499674503-21551-2-git-send-email-kchamart@redhat.com>
	<251c3898-8d5f-a799-318e-5ab0545220a3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <251c3898-8d5f-a799-318e-5ab0545220a3@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v6 1/2] bitmaps.md: Convert to rST;
 move it into 'interop' dir
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, jsnow@redhat.com, berto@igalia.com

On Mon, Jul 10, 2017 at 09:36:50PM -0500, Eric Blake wrote:
> On 07/10/2017 03:15 AM, Kashyap Chamarthy wrote:

[...]

> > Signed-off-by: Kashyap Chamarthy <kchamart@redhat.com>
> > Reviewed-by: John Snow <jsnow@redhat.com>
> > ---
> 
> > ---
> >  docs/devel/bitmaps.md    | 505 ------------------------------------------
> >  docs/interop/bitmaps.rst | 555 +++++++++++++++++++++++++++++++++++++++++++++++
> 
> A shame that git rename detection doesn't see these as the same rough
> contents, but not too bad. 

_Should_ it detect?

> I'll just review the new text; if I point out
> something that was pre-existing in the old text, it may be nicer to
> split the cleanups into a separate followup patch, but I'm also okay if
> they go in as part of this patch.

Indeed -- the things you point out further below were already
pre-existing.  

Asking out of curiosity: You say it is nicer split because we'll retain
the `git-bisect`-ability?  Or just to keep text motion and actual
changes separate?  (I think both.)

> My review is less focused on the choices used in representing things in
> rST and on the final display outcome, and more on the text itself
> (grammar and such).

Noted.

> 
> > +++ b/docs/interop/bitmaps.rst
> > +
> > +-  Dirty bitmaps can be created at any time and attached to any node
> > +   (not just complete drives.)
> 
> Looks a bit nicer with '.' outside the sub-sentence '()'.

Will fix.

> > +
> > +.. contents::
> > +
> > +Dirty Bitmap Names
> > +------------------
> > +
> > +-  A dirty bitmap's name is unique to the node, but bitmaps attached to
> > +   different nodes can share the same name.
> > +
> > +-  Dirty bitmaps created for internal use by QEMU may be anonymous and
> > +   have no name, but any user-created bitmaps may not be. There can be
> 
> s/may not be/must have a name/

Will fix.

> 
> > +
> > +-  This bitmap will have a default granularity that matches the cluster
> > +   size of its associated drive, if available, clamped to between [4KiB,
> 
> s/clamped to/clamped/

Will fix.

> > +   64KiB]. The current default for qcow2 is 64KiB.
> > +
> > +
> 
> 
> > +-  QMP example response, highlighting one success and one failure:
> > +
> > +   -  Acknowledgement that the Transaction was accepted and jobs were
> > +      launched:
> 
> US spelling prefers Acknowledgment, but I think you are okay because of
> UK spelling.

It was John Snow who wrote this document. :-)

I realize that you merely pointed out the difference.  And the QEMU
upstream documentation also says they accept both US and UK spellings:

    http://wiki.qemu.org/Contribute/SpellCheck

> Again, since these are probably pre-existing and just code motion, and
> if you've gotten positive review of your use of rST, I'm fine with adding:
> 
> Reviewed-by: Eric Blake <eblake@redhat.com>

Thank you.

I'll wait for feedback on the other (much longer and completely
overhauled) document -- if there's a need to respin it, I'll address
your feedback from here.

[...]


-- 
/kashyap
