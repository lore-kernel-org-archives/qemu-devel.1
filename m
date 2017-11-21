Received: from eggs.gnu.org ([2001:4830:134:3::10]:48528)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1eH5KX-0002Yb-3H
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 04:59:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1eH5KW-0008KB-C8
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 04:59:01 -0500
Date: Tue, 21 Nov 2017 10:58:48 +0100
From: Kashyap Chamarthy <kchamart@redhat.com>
Message-ID: <20171121095848.3wblgmlnubhtdfad@eukaryote>
References: <20171117185444.4947-1-kchamart@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171117185444.4947-1-kchamart@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 for-2.11] QAPI & interop: Clarify events
 emitted by 'block-job-cancel'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: jsnow@redhat.com, armbru@redhat.com, mreitz@redhat.com, dgilbert@redhat.com

On Fri, Nov 17, 2017 at 07:54:44PM +0100, Kashyap Chamarthy wrote:

[...]

> +So there are two possible actions to take, after a 'mirror' job has
> +emitted the event ``BLOCK_JOB_READY``, indicating that the source and
> +target have reached synchronization:
> +
> +(1) Issuing the command ``block-job-cancel`` (after it emits the event
> +    ``BLOCK_JOB_COMPLETED``) will create a point-in-time (which is at
> +    the time of *triggering* the cancel command) copy of the entire disk
>      image chain (or only the top-most image, depending on the ``sync``
> -    mode).
> +    mode), contained in the target image [E].
>  
> -(2) Issuing the command ``block-job-complete`` after it emits the event
> -    ``BLOCK_JOB_COMPLETED``: will, after completing synchronization of
> -    the content, adjust the guest device (i.e. live QEMU) to point to
> -    the target image, and, causing all the new writes from this point on
> -    to happen there.  One use case for this is live storage migration.
> +(2) Issuing the command ``block-job-complete`` (after it emits the event
> +    ``BLOCK_JOB_COMPLETED``) will adjust the guest device (i.e. live
> +    QEMU) to point to the target image, [E], causing all the new writes
> +    from this point on to happen there.  One use case for this is live
> +    storage migration.

Dave Gilbert pointed out on IRC that last sentence ("One use case for
this is live storage migration") should apply to point (1) above.  He's
right, I'll send a v5 with that (and the commit message tweak I noted
earlier) fix.

[...]


-- 
/kashyap
