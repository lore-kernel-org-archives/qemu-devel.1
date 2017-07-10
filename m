Received: from eggs.gnu.org ([2001:4830:134:3::10]:42101)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1dUTVt-00076Y-Ce
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 03:53:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1dUTVs-0007zn-5j
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 03:53:49 -0400
Date: Mon, 10 Jul 2017 09:53:35 +0200
From: Kashyap Chamarthy <kchamart@redhat.com>
Message-ID: <20170710075335.pnfpixfeyhoyiioj@eukaryote>
References: <1499351806-3359-1-git-send-email-kchamart@redhat.com>
	<1499351806-3359-3-git-send-email-kchamart@redhat.com>
	<bf8b230f-15be-9468-20d2-09f8f9ae12fa@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf8b230f-15be-9468-20d2-09f8f9ae12fa@redhat.com>
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
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, berto@igalia.com, qemu-block@nongnu.org, mreitz@redhat.com

On Fri, Jul 07, 2017 at 06:25:24PM -0400, John Snow wrote:
> Last time, on DRAGON BALL Q:

Didn't know of this before; just learnt the reference.

> On 07/06/2017 10:36 AM, Kashyap Chamarthy wrote:
> 
> [A lot of good documentation]
> 
> > +
> > +So, the following is the flow for `block-commit_Case-3`_ -- to convert a
> > +disk image chain such as this::
> > +
> 
> Maybe drop the "So, "
>
> "The following is the flow for 'Block Commit Case 3' to convert a disk
> image chain such as this:"

Fixed in v6.

> > +    [A] <-- [B] <-- [C] <-- [D]
> > +
> > +Into (where content from all the subsequent overlays, [B], and [C],
> > +including the active layer, [D], is committed back to [A] -- which is
> > +where live QEMU is performing all its current writes)::
> > +
> 
> "Into: "
> 
> > +    [A]
> > +
> 
> "Where content from all [...] its current writes."

Fixed in v6.

[...]

> > +Then, (optionally) query for the status of the active block operations
> > +(we can see the 'commit' job is now ready to be completed, as indicated
> > +by the line *"ready": true*)::
> > +
> 
> Then, optionally query for the status of the active block operations. We
> can see the 'commit' job is now ready to be completed, as indicated by
> the line *"ready": true*.

Fixed in v6.

[...]

> > +.. note::
> > +    The invocation for rest of the cases (2, 4, and 5), discussed in the
> > +    previous section, is omitted for brevity.
> > +
> 
> As a joke I almost want to write "The invocation for cases 2, 4, and 5
> are left as an exercise to the reader."

Heh, I considered that, too.  Maybe I should do it.  But somehow I can't
bring myself to. :-)

> > +(1) Issuing the command ``block-job-cancel``, after it emits the event
> 
> nix the comma

Nixed in v6.

[...]

> > +(2) Issuing the command ``block-job-complete``, after it emits the event
> 
> nix the comma

In v6.

[...]

> > +A note on synchronization modes -- determines *what* part of the disk
> > +image chain must be copied to the target.  Currently, there are four
> > +different kinds:
> > +
> 
> You've got a note here, followed by a note box. Maybe just:
> 
> "About synchronization modes: The synchronization mode determines
> *which* part of the disk image chain will be copied to the target.
> Currently, there are four different kinds:"

Yep, fixed as such in v6.  (And I also see that two occurences of
"synchronization mode" is OK in this instance.)

[...]

> > +    .. note:: In the case of ``drive-backup`` (or ``blockdev-backup``),
> > +              the behavior of ``none`` sychronization mode is different.
> > +              Normally, a ``backup`` job consists of two parts: Anything
> > +              that is overwritten by the guest is first copied out to
> > +              the backup, and in the background the whole image is
> > +              copied from start to end. With ``sync=none``, it's only
> > +              the first part.

[...]

> > +(5) Gracefully complete the 'mirror' block device job, and observe for
> > +    the event ``BLOCK_JOB_COMPLETED``
> > +
> 
> "observe for the event" is slightly awkward

Replaced it with "notice the event" (fixed 5 occurences throughout
the doc).

> > +(6) Shutdown the guest, by issuing the QMP ``quit`` command, so that
> > +    caches are flushed
> > +
> 
> nix both commas

Nixed in v6.

[...]

> > +QMP invocation for ``blockdev-backup``
> > +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > +
> > +Given, a disk image chain of depth 1, where image [B] is the active
> > +overlay (live QEMU is writing to it)::
> > +
> 
> Given a disk image chain of depth 1 where image [B] is the active
> overlay (live QEMU is writing it)

Fixed in v6.
 
> > +    [A] <-- [B]
> > +
> > +The following is the procedure to copy the content from the entire chain
> > +to a target image (say, [E]), which has the full content from [A] and
> > +[B].
> > +
> > +Create the overlay, [B]::
> 
> the overlay [B]

Likewise :-)

> > +Create a target image, that will contain the copy::
> 
> sans comma

Yep.

> > +
> > +    $ qemu-img create -f qcow2 e.qcow2 39M
> > +
> > +Then, add it to QEMU via ``blockdev-add``::
> > +
> 
> and one more time

Sure. </embarassed>

> > +
> > +Then, invoke ``blockdev-backup``, to copy the contents from the entire
> > +image chain, consisting of images [A], and [B], to the target image
> > +'e.qcow2'::
> > +
> 
> Then invoke bd-b to copy the contents from the entire image chain,
> consisting of images [A] and [B] to the target image e.qcow2:

Comma-wildness again.  Fixed in v6.

> > +Once the above 'backup' operation has completed, an event,
> > +``BLOCK_JOB_COMPLETED``, will be emitted, signalling successful
> > +completion.
> > +
> 
> "the event BLOCK_JOB_COMPLETED will be emitted, signalling"

Fixed in v6.

[...]

> > +The end result will be, the image 'e.qcow2' containing a
> 
> Goodbye sweet comma, savor the void

:-)  Yep, v6 savors a lot of void.

> > +point-in-time backup of the disk image chain -- i.e. contents from
> > +images [A], and [B] at the time the ``blockdev-backup`` command was
> > +initiated.
> > +
> 
> images [A] and [B]

Yep.

> > +One way to confirm the backup disk image contains the identical content
> > +with the disk image chain is to compare the backup, and the contents of
> 
> Could kill this comma too.

Killed in v6.

[...]

> That's all I got for now. It's looking very good, thank you for your
> time. Please consider all of my suggestions are just that. There is a
> reason I am not an English professor :)

They are useful suggestions. :-)  I'm a stickler for English, and I like
to get it right.  Appreciate the patience!

-- 
/kashyap
