Received: from eggs.gnu.org ([2001:4830:134:3::10]:38316)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1eJJ2F-00036Z-6V
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 08:01:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1eJJ29-0007nG-Pc
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 08:01:19 -0500
Date: Mon, 27 Nov 2017 14:00:26 +0100
From: Kashyap Chamarthy <kchamart@redhat.com>
Message-ID: <20171127130026.i5mwityh5pmny6k6@eukaryote>
References: <20171121115253.14923-1-kchamart@redhat.com>
	<20171127115307.GB4903@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171127115307.GB4903@localhost.localdomain>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v5 for-2.11] QAPI & interop:
 Clarify events emitted by 'block-job-cancel'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, armbru@redhat.com, mreitz@redhat.com

On Mon, Nov 27, 2017 at 12:53:07PM +0100, Kevin Wolf wrote:
> Am 21.11.2017 um 12:52 hat Kashyap Chamarthy geschrieben:

[...]

> > Signed-off-by: Kashyap Chamarthy <kchamart@redhat.com>
> > Reviewed-by: Eric Blake <eblake@redhat.com>
> 
> > +(1) Issuing the command ``block-job-cancel`` (after it emits the event
> > +    ``BLOCK_JOB_COMPLETED``) will create a point-in-time (which is at
> > +    the time of *triggering* the cancel command) copy of the entire disk
> >      image chain (or only the top-most image, depending on the ``sync``
> > -    mode).
> > +    mode), contained in the target image [E]. One use case for this is
> > +    live storage migration.
> 
> As commented on v4, 

You're right, I agree with your comment on v4.

> I dropped the last sentence here for now. Please
> suggest an unambiguous wording if you'd prefer to keep it.

If you can still add, and are happy with it, please go with the less
ambiguous wording: "One use case for this is live VM migration with
non-shared storage".

Just that I feel it immediately gives the use case in context.

> Thanks, applied to the block branch.
> 
> Kevin

-- 
/kashyap
