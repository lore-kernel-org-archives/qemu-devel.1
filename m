Received: from eggs.gnu.org ([2001:4830:134:3::10]:54926)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1eFkQ2-0003Gh-PQ
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 12:27:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1eFkQ0-00028H-5o
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 12:27:10 -0500
Date: Fri, 17 Nov 2017 18:26:54 +0100
From: Kashyap Chamarthy <kchamart@redhat.com>
Message-ID: <20171117172654.ucimuik2ixcu2qfw@eukaryote>
References: <20171117162536.23225-1-kchamart@redhat.com>
	<78f4339b-bbe5-18d1-6555-b2c3196a6f7c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78f4339b-bbe5-18d1-6555-b2c3196a6f7c@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 for-2.11] QAPI & interop: Clarify events
 emitted by 'block-job-cancel'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com, armbru@redhat.com, jsnow@redhat.com

On Fri, Nov 17, 2017 at 11:07:41AM -0600, Eric Blake wrote:
> On 11/17/2017 10:25 AM, Kashyap Chamarthy wrote:

[...]

> Sorry for not wordsmithing on earlier versions:

That's fine.  Always appreciate your wordsmithing :-)

> > +    'mirror' job *after* it has indicated (by emitting the event
> > +    ``BLOCK_JOB_READY``) that the source and target now remain
> > +    synchronized, then ``block-job-cancel`` will emit the event
> 
> Might read slightly nicer as:
> 
> the source and target have reached synchronization,

Ah, that sounds nicer indeed.  Will fix.

[...]

> > +# Note that the 'block-job-cancel' command will emit the event
> > +# BLOCK_JOB_COMPLETED if you issue it ('block-job-cancel') after 'drive-mirror'
> > +# has indicated (by emitting the event BLOCK_JOB_READY) that the source and
> > +# destination remain synchronized.  In this case, the BLOCK_JOB_COMPLETED
> > +# event indicates that synchronization (from 'drive-mirror') has successfully
> > +# ended and the destination now has a point-in-time copy, which is at the time
> > +# of cancel.
> 
> 
> Accurate, but a bit hard to follow the flow of the sentence.

Yeah, I wasn't satisfied with my phrasing too.  I sat on it for nearly
half an hour, and still it came out super clunky.

> Might read nicer as:
> 
> Note that if you issue 'block-job-cancel' after 'drive-mirror' has
> indicated (via the event BLOCK_JOB_READY) that the source and
> destination are synchronized, then the event triggered by this command
> changes to BLOCK_JOB_COMPLETED, to indicate that the mirroring has
> ended and the destination now has a point-in-time copy tied to the
> time of the cancellation.

Thanks, yours reads much nicer.

> Documentation is worth of inclusion in 2.11.  Whether you keep your
> wording, or incorporate mine in a v4, you can add:
> Reviewed-by: Eric Blake <eblake@redhat.com>

I'll definitely incorporate in v4.  

I'll also make similar wording adjustment in live-block-operations.rst.

Thanks for the quick review.

-- 
/kashyap
