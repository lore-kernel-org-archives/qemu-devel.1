Received: from eggs.gnu.org ([209.51.188.92]:34923)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gmc7Z-0002dD-MR
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 05:20:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gmc6o-0006Ws-Ho
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 05:19:43 -0500
Date: Thu, 24 Jan 2019 11:19:34 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190124111934.72e7f0f1.cohuck@redhat.com>
In-Reply-To: <42264dd9-86d7-8994-8c25-bc688067725d@linux.ibm.com>
References: <20190121110354.2247-1-cohuck@redhat.com>
	<20190121110354.2247-3-cohuck@redhat.com>
	<20190122193346.4e23e018@oc2783563651>
	<20190123112112.7822b237.cohuck@redhat.com>
	<42264dd9-86d7-8994-8c25-bc688067725d@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 2/5] vfio-ccw: concurrent I/O handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pierre Morel <pmorel@linux.ibm.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, Alex Williamson <alex.williamson@redhat.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org

On Thu, 24 Jan 2019 11:08:02 +0100
Pierre Morel <pmorel@linux.ibm.com> wrote:

> On 23/01/2019 11:21, Cornelia Huck wrote:
> > On Tue, 22 Jan 2019 19:33:46 +0100
> > Halil Pasic <pasic@linux.ibm.com> wrote:
> >   
> >> On Mon, 21 Jan 2019 12:03:51 +0100
> >> Cornelia Huck <cohuck@redhat.com> wrote:
> >>  
> >>> --- a/drivers/s390/cio/vfio_ccw_private.h
> >>> +++ b/drivers/s390/cio/vfio_ccw_private.h
> >>> @@ -28,6 +28,7 @@
> >>>    * @mdev: pointer to the mediated device
> >>>    * @nb: notifier for vfio events
> >>>    * @io_region: MMIO region to input/output I/O arguments/results
> >>> + * @io_mutex: protect against concurrent update of I/O structures  
> >>
> >> We could be a bit more specific about what does this mutex guard.
> >> Is it only io_region, or cp, irb and the new regions a well? ->state does
> >> not seem to be covered, but should need some sort of synchronisation
> >> too, or?  
> > 
> > I'm not sure. IIRC Pierre had some ideas about locking in the fsm?
> >   
> 
> Yes I postponed this work to not collide with your patch series.
> 
> Do you think I should provide a new version of the FSM reworking series 
> based on the last comment I got?
> 
> I would take into account that the asynchronous commands will come with 
> your patch series and only provide the framework changes.

This was more an answer to Halil's concerns around state
synchronization. I would prefer to first get this series (or a
variation) into decent shape, and then address state machine handling
on top of that (when we know more about the transitions involved), just
to avoid confusion.

Does that sound reasonable?
