Received: from eggs.gnu.org ([2001:4830:134:3::10]:50779)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fj33H-0000vh-69
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 09:45:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fj33C-0003O1-6V
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 09:45:03 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53618 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fj33C-0003Np-0p
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 09:44:58 -0400
Date: Fri, 27 Jul 2018 14:44:54 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180727134453.GB2498@work-vm>
References: <20180727123112.13707-1-dgilbert@redhat.com>
	<d09b7607-a23b-7c05-9faf-7ec0000684af@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d09b7607-a23b-7c05-9faf-7ec0000684af@ilande.co.uk>
Subject: Re: [Qemu-devel] [PATCH] macio/pmu: Fix missing vmsd terminator
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org, agraf@suse.de, lvivier@redhat.com

* Mark Cave-Ayland (mark.cave-ayland@ilande.co.uk) wrote:
> On 27/07/18 13:31, Dr. David Alan Gilbert (git) wrote:
> 
> > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> > 
> > Fix missing terminator in VMStateDescription
> > 
> > Fixes: d811d61fbc6ca5f2be2185fd7cfa916e7ba613ce
> > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > ---
> >   hw/misc/macio/pmu.c | 1 +
> >   1 file changed, 1 insertion(+)
> > 
> > diff --git a/hw/misc/macio/pmu.c b/hw/misc/macio/pmu.c
> > index e246b0fd41..27dfaf8a74 100644
> > --- a/hw/misc/macio/pmu.c
> > +++ b/hw/misc/macio/pmu.c
> > @@ -686,6 +686,7 @@ static const VMStateDescription vmstate_pmu_adb = {
> >           VMSTATE_TIMER_PTR(adb_poll_timer, PMUState),
> >           VMSTATE_UINT8(adb_reply_size, PMUState),
> >           VMSTATE_BUFFER(adb_reply, PMUState),
> > +        VMSTATE_END_OF_LIST()
> >       }
> >   };
> 
> Gah, yes indeed it certainly looks like I missed this whilst working on the
> PMU code :(
> 
> Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> 
> Just out of interest does a savevm/loadvm migration still succeed once this
> has been added?

Have you got a suggested command line to test it with?

Dave

> 
> ATB,
> 
> Mark.
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
