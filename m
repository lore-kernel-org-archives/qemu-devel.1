Received: from eggs.gnu.org ([2001:4830:134:3::10]:38515)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ejjaX-0003K6-U9
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 05:38:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ejjaS-0001UW-SA
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 05:37:57 -0500
Date: Thu, 8 Feb 2018 11:37:48 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180208113748.195f7483.cohuck@redhat.com>
In-Reply-To: <ef7d8fbd-42b0-2d28-c3c2-ab96a8e52e5f@de.ibm.com>
References: <1518083288-20410-1-git-send-email-mihajlov@linux.vnet.ibm.com>
	<20180208111633.0e8a6237.cohuck@redhat.com>
	<ef7d8fbd-42b0-2d28-c3c2-ab96a8e52e5f@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] S390: Expose s390-specific CPU info
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, David Hildenbrand <david@redhat.com>, Eric Blake <eblake@redhat.com>

On Thu, 8 Feb 2018 11:24:48 +0100
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> On 02/08/2018 11:16 AM, Cornelia Huck wrote:
> > On Thu,  8 Feb 2018 10:48:08 +0100
> > Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com> wrote:

> >> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> >> index 3807dcb..3e6360e 100644
> >> --- a/hw/s390x/s390-virtio-ccw.c
> >> +++ b/hw/s390x/s390-virtio-ccw.c
> >> @@ -373,7 +373,7 @@ static void s390_machine_reset(void)
> >>  
> >>      /* all cpus are stopped - configure and start the ipl cpu only */
> >>      s390_ipl_prepare_cpu(ipl_cpu);
> >> -    s390_cpu_set_state(CPU_STATE_OPERATING, ipl_cpu);
> >> +    s390_cpu_set_state(CPU_INFOS390_STATE_OPERATING, ipl_cpu);  
> > 
> > Exposing the state as a QAPI enum has the unfortunate side effect of
> > that new name. It feels slightly awkward to me, as it is a state for
> > real decisions and not just for info statements...  
> 
> I asked Viktor to use the qapi enum instead of having two sets of defines that
> we need to keep in sync. (in fact 3, as the kernel kvm mpstate definition is also
> there).

Agreed, using the QAPI enum makes sense.

> 
> But yes, the INFO in that name is somewhat strange. No good idea though.

Can we call the enum CpuS390State instead of CpuInfoS390State (while
keeping the CpuInfoS390 name)? Or does that violate any QAPI rules?
