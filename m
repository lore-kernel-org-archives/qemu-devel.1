Received: from eggs.gnu.org ([2001:4830:134:3::10]:41103)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1dTQmm-0006U5-OX
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 06:46:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1dTQmk-0002md-TT
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 06:46:56 -0400
Date: Fri, 7 Jul 2017 12:46:41 +0200
From: Kashyap Chamarthy <kchamart@redhat.com>
Message-ID: <20170707104641.c6ichxvkmm3voqpi@eukaryote>
References: <1499351806-3359-1-git-send-email-kchamart@redhat.com>
	<1499351806-3359-3-git-send-email-kchamart@redhat.com>
	<a302521e-e0c6-99f5-e9f0-314a346c1844@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a302521e-e0c6-99f5-e9f0-314a346c1844@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 2/2] live-block-ops.txt: Rename, rewrite,
 and improve it
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, berto@igalia.com, qemu-block@nongnu.org, mreitz@redhat.com, stephen@that.guru

On Thu, Jul 06, 2017 at 06:41:07PM -0400, John Snow wrote:
> On 07/06/2017 10:36 AM, Kashyap Chamarthy wrote:

[...]

> > +disk image chains by merging data from overlays into backing files; live
> > +synchronize data from a disk image chain (including current active disk)
> > +to another target image; point-in-time (and incremental) backups of a
> 
> "and point-in-time" to indicate the conclusion of a list? 1, 2, 3, and 4.

Yes.  Fixed in local v6.  (Must not forget Oxford comma!)

[...]

> > +Disk image backing chain notation
> > +---------------------------------
> > +
> > +A simple disk image chain.  (This can be created live, using QMP
> > +``blockdev-snapshot-sync``, or offline, via ``qemu-img``)::
> 
> "can be created live using QMP ``foo``, or offline via ``bar``"
> 
> I, tend, to, use, too, many, commas, in, my, own, writing, to, mimic, a,
> conversational, tone, but, admittedly, I, go, overboard.

Hehe, I'm painfully aware of my "comma problem".  Sometimes I catch
myself and fix it, other times I miss.  But I promise, I'm working on
it. :-)
 
> Take with a grain of salt. Eric is our ultimate copy-editor...

Noted.  About Eric, noted (in part jest): "Strunk, White, and Blake"

[...]

> > +    .. note:: Once the ``stream`` operation has finished, three things
> > +              to note: (a) QEMU rewrites the backing chain to remove
> > +              reference to the now-streamed and redundant backing file;
> > +              (b) the streamed file *itself* won't be removed by QEMU,
> > +              and must be explicitly discarded by the user; (c) the
> > +              streamed file remains valid -- i.e. further overlays can
> > +              be created based on it.  Refer the ``block-stream``
> > +              section further below for more details.
> 
> Is it possible to listify these three points?

Yes, it's possible (I just tested) -- Sphinx renders the content as rST
itself.  (I briefly considered listifying it while writing, but didn't
bother.)

Listfied in local v6.
 
> > +
> > +(2) ``block-commit``: Live merge of data from overlay files into backing
> > +    files (with the optional goal of removing the overlay file from the
> > +    chain).  Since QEMU 2.0, this includes "active ``block-commit``"
> > +    (i.e. merge the current active layer into the base image).
> > +
> > +    .. note:: Once the ``commit`` operation has finished, here, too,
> 
> You've gone comma-wild!

Indeed, only now I notice the absurdity.  But I'm trying to be conscious
of this comma-madness.

> "Once the ``commit`` operation has finished, there are three things to
> note here <too/as well>:"

Fixed in local v6.

> > +              three things to note: (a) QEMU rewrites the backing chain
> > +              to remove reference to now-redundant overlay images that
> > +              have been commited into a backing file; (b) the commited
> > +              file *itself* won't be removed by QEMU -- it ought to be
> > +              manually removed; (c) however, unlike in the case of
> > +              ``block-stream``, the intermediate images will be rendered
> > +              invalid -- i.e. no more further overlays can be created
> > +              based on them.  Refer the ``block-commit`` section further
> > +              below for more details.

Also listified the above.  Fixed in local v6.

[...]

> > +.. note::
> > +    In the event we have to repeat a certain QMP command, we will: for
> > +    the first occurrence of it, show the the ``qmp-shell`` invocation,
> > +    *and* the corresponding raw JSON QMP syntax; but for subsequent
> > +    invocations, present just the ``qmp-shell`` syntax, and omit the
> > +    equivalent JSON output.
> > +
> 
> It's like I'm reading a university textbook. Very nice!

:-)  Also fixed locally the double "the" in the above note.

[...]

> > +Where [A] is the original base image; [B] and [C] are intermediate
> > +overlay images; image [D] is the active layer -- i.e. live QEMU is
> > +writing to it.  (The rule of thumb is: live QEMU will always be pointing
> > +to the rightmost image in a disk image chain.)
> > +
> > +The above image chain can be created by invoking
> > +``blockdev-snapshot-sync`` command as following (which shows the
> 
> command_s_ as following? We're starting from a single image and we need
> to create several snapshots.

I see you're suggesting plural to indicate the multiple invocations.  I
thought using singular for "command" is correct because it's multiple
invocations of a _single_ command.  And using plural can give the
impression that there are different kinds of commands, but probably it's
just my brain.  

But I'll take your word as a native speaker and a fellow relisher (?) of
language.  Fixed it in local v6.

> > +Here, "node-A" is the name QEMU internally uses to refer to the base
> > +image [A] -- it is the backing file, based on which the overlay image,
> > +[B], is created.
> > +
> > +To create the rest of the two overlay images, [C], and [D] (omitted the
> 
> "rest of the two" strikes me as peculiar. Either "rest of the images" or
> "The last/final/other two"

Fixed in local v6 as "rest of the overlay images".  (Didn't notice the
peculiarity.  A quick look up of the phrase "rest of the two" got barely
6 results.)

> > +(1) Merge everything into the active layer: I.e. copy all contents from
> > +    the base image, [A], and overlay images, [B] and [C], into [D],
> > +    _while_ the guest is running.  The resulting chain will be a
> 
> is _while_ meant to apply formatting in this case?

Oops, good catch.  It's what I use on e-mail / plain text, so it just
bled into rST.  To get italics in rST, it is either: *foo*, or `foo`.

Fixed in local v6.

[...]

> > +commit" (i.e. it is possible to merge the "active layer", the right-most
> > +image in a disk image chain where live QEMU will be writing to, into the
> > +base image).  This is analogous to ``block-stream``, but in opposite
> > +direction.
> 
> "in the opposite direction"

Fixed in local v6.

[...]

> > +QMP invocation for ``block-commit``
> > +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > +
> > +For `block-commit_Case-1`_, to merge contents only from
> 
> This sort of bleeds the anchor names into the rendered document, is that
> intentional? It looks awkward in the final product.

I see what you mean, I find it ugly, too.  I reluctantly created these
anchors, as I didn't think of a cleaner solution.

But I've got good news (thanks: Stephen Finucane on IRC for reminding me
of the use of ":ref:")!  So the `diff` will be:

    - For `block-commit_Case-1`_ [...]
    + For :ref:`Case-1 <block-commit-case-1>` [...]

And the rendered document will just see the following (where "Case-1"
will hyperlink to appropriate location):

    "For Case-1, to merge contents only from image [...]"

Fixed in local v6.

> > +image [B] into image [A], the invocation is as following::
> > +
> > +    (QEMU) block-commit device=node-D base=a.qcow2 top=b.qcow2 job-id=job0
> 
> code block highlighting in the rendered document does weird things to
> job-id, which may be beyond your control.

You're right, I noticed it.  But I can't see a way to fix it.

[...]

> > +..note::
> > +    The intermediate image [B] is invalid (as in: no more further
> > +    overlays based on it can be created) and, therefore, should be
> > +    dropped.
> > +
> 
> Note syntax is malformed.

Eagle eyes.  Fixed in local v6.

> "And therefore should be dropped." reads just as nicely.

Yes, dropped it.

> It may be worth explaining precisely in what ways that 'stream' does not
> invalidate intermediate images, but 'commit' does. It's not necessarily
> immediately intuitive.

Agreed.  Fixed in local v6.

> The core concept:
> 
> - An intermediate image after 'stream' still represents that old
> point-in-time, and may be valid in that context.
> - An intermediate image after 'commit' no longer represents any point in
> time, and is invalid in any context.

Yes, I incorported the above text as-is, and the ".. note::" admonition
is now:

    .. note::
        The intermediate image [B] is invalid (as in: no more further
        overlays based on it can be created).
    
        Reasoning: An intermediate image after a ``stream`` operation
        still represents that old point-in-time, and may be valid in
        that context.  However, an intermediate image after a ``commit``
        operation no longer represents any point-in-time, and is invalid
        in any context.

Fixed in local v6.
 
> > +However, `block-commit_Case-3`_ (also called: "active ``block-commit``")
> 
> Anchor name bleeding again.

Fixed in local v6 by using the ":ref:", the end result will just be
"Case-3" in the rendered document.

> Can the link be re-titled "Case 3" or something more human readable?

Probably you missed to notice that "Case-{1,2,3}" anchors were already
taken for the `block-stream` section.

But now, thanks to the ":ref:" usage, we can use the more human-readable
"Case-3", and link to the _correct_ section.

> > +is a *two-phase* operation: in the first phase, the content from the
> > +active overlay, along with the intermediate overlays, is copied into the
> > +backing file (also called, the base image); in the second phase, adjust
> 
> "also called the base image" reads just as well. In general I think
> you've got too many commas.

Fixed in local v6.  Thanks for patiently pointing them out.
 
> > +the said backing file as the current active image -- possible via
> > +issuing the command ``block-job-complete``.  [Optionally, the
> > +``block-commit`` operation can be cancelled, by issuing the command
> > +``block-job-cancel``, but be careful when doing this.]
> 
> Stick to one set of parentheses, use ().

Done.

> Or maybe rewrite this paragraph. It's got an em dash, three
> parentheticals, seven commas, a colon and a semicolon. It's a busy
> paragraph syntactically!

Noted.  Slightly better?  It's now reduced to one em dash, two
parentheticals, five commas, and a colon:

    However, :ref:`Case-3 <block-commit_Case-3>` (also called: "active
    ``block-commit``") is a *two-phase* operation: In the first phase,
    the content from the active overlay, along with the intermediate
    overlays, is copied into the backing file (also called the base
    image).  In the second phase, adjust the said backing file as the
    current active image -- possible via issuing the command
    ``block-job-complete``.  Optionally, the ``block-commit`` operation
    can be cancelled by issuing the command ``block-job-cancel``, but be
    careful when doing this.

Rephrasings welcome.

> > +Once the 'commit' operation (started by ``block-commit``) has completed,
> 
> You could omit the parentheses here and it reads just as well.

Fixed in local v6.

> > +the event ``BLOCK_JOB_READY`` is emitted, signalling the synchronization
> > +has finished, and the job can be gracefully completed, by issuing
> > +``block-job-complete``.  (Until such a command is issued, the 'commit'
> > +operation remains active.)
> 
> Bit of a run-on.

Oops, indeed.  Rewrote it as following:

    Once the ``block-commit`` operation has completed, the event
    ``BLOCK_JOB_READY`` will be emitted, signalling that the
    synchronization has finished.  Now the job can be gracefully
    completed by issuing the command ``block-job-complete`` -- until
    such a command is issued, the 'commit' operation remains active.

> I guess I should stop reviewing this from a style perspective for now.
> I'll come back and review the rest later, sorry!

Thanks for your patience in review.  Much appreciated (including the
grammar corrections)! 

I'll wait for the rest of your comments before I spin a v6.

[...]

-- 
/kashyap
