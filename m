Received: from eggs.gnu.org ([2001:4830:134:3::10]:43715)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eLtLD-0004dK-0w
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 11:11:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eLtL8-00075O-P8
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 11:11:34 -0500
Date: Mon, 4 Dec 2017 17:11:24 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171204171124.4d877b22.cohuck@redhat.com>
In-Reply-To: <1108d0e7-318b-354f-31da-95d5efb8193c@linux.vnet.ibm.com>
References: <20171201143136.62497-1-pasic@linux.vnet.ibm.com>
	<20171201143136.62497-4-pasic@linux.vnet.ibm.com>
	<20171204122859.1a4fcd21.cohuck@redhat.com>
	<1108d0e7-318b-354f-31da-95d5efb8193c@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/3] s390x: deprecate s390-squash-mcss
 machine prop
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: Boris Fiuczynski <fiuczy@linux.vnet.ibm.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Shalini Chellathurai Saroja <shalini@linux.vnet.ibm.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org

On Mon, 4 Dec 2017 16:32:16 +0100
Halil Pasic <pasic@linux.vnet.ibm.com> wrote:

> On 12/04/2017 12:28 PM, Cornelia Huck wrote:
> > On Fri,  1 Dec 2017 15:31:36 +0100
> > Halil Pasic <pasic@linux.vnet.ibm.com> wrote:

> >> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> >> index 4d65a50334..3796f666e6 100644
> >> --- a/hw/s390x/s390-virtio-ccw.c
> >> +++ b/hw/s390x/s390-virtio-ccw.c
> >> @@ -553,6 +553,10 @@ static inline void machine_set_squash_mcss(Object *obj, bool value,
> >>      S390CcwMachineState *ms = S390_CCW_MACHINE(obj);
> >>  
> >>      ms->s390_squash_mcss = value;
> >> +    if (ms->s390_squash_mcss) {
> >> +        warn_report("The machine property 's390-squash-mcss' is deprecated"
> >> +                    " (obsoleted by lifting the cssid restrictions).");  
> > 
> > Too bad that we can't warn when this is explicitly set to false - OTOH
> > I don't really expect anyone doing that.
> >   
> 
> I did not really dig deep. It may be possible, but I had other priorities,
> and was not sure if it's worth (as I also don't expect it being set to false
> explicit in the wild).

It's not worth spending any more time on this.

> 
> >> +    }
> >>  }
> >>  
> >>  static inline void s390_machine_initfn(Object *obj)

(...)

> > Looks sane. We should put a note into the 2.12 changelog as well.
> >   
> 
> I agree. Who would be responsible for updating the changelog. I'm not
> familiar with that process yet. To be honest, I wouldn't mind having
> the changelog notice in your writing style. Guess would be better for
> everyone ;).

Just a one-liner once we have the 2.12 changelog page.

> 
> There are also other things we identified as TODOs:
> * Updating https://wiki.qemu.org/Features/Channel_I/O_Passthrough
> (@Dong Jia, could you take this one)
> * In tree and/or on wiki documentation which is up-to-date and
> more verbose than commit messages are supposed to be (and Dong
> Jia's write-up could be incorporated to). I see this one as
> lower prio though. Any volunteers?

Long-ish things with links etc. should probably go into the wiki.

Anyway, feel free to go ahead (it's a wiki :) We can always change
things later on.
