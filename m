Received: from eggs.gnu.org ([2001:4830:134:3::10]:34370)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1elzMc-0004Pj-Jy
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 10:52:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1elzMa-0007Jf-8C
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 10:52:54 -0500
Date: Wed, 14 Feb 2018 16:26:12 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180214162612.70506465.cohuck@redhat.com>
In-Reply-To: <a6135d66-6673-a49d-01fa-9fa4d55b3aa1@redhat.com>
References: <1518542328-25741-1-git-send-email-mihajlov@linux.vnet.ibm.com>
	<20180214115725.34ba0008.cohuck@redhat.com>
	<a6135d66-6673-a49d-01fa-9fa4d55b3aa1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCHv2 0/3] add query-cpu-fast and related s390
 changes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>, qemu-devel@nongnu.org, agraf@suse.de, ehabkost@redhat.com, armbru@redhat.com, david@redhat.com, dgilbert@redhat.com, borntraeger@de.ibm.com, qemu-s390x@nongnu.org, pbonzini@redhat.com, rth@twiddle.net

On Wed, 14 Feb 2018 09:16:15 -0600
Eric Blake <eblake@redhat.com> wrote:

> On 02/14/2018 04:57 AM, Cornelia Huck wrote:
> > On Tue, 13 Feb 2018 18:18:45 +0100
> > Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com> wrote:
> >   
> 
> >> Patch 1/3:
> >>    Adds architecture specific data to the QMP CpuInfo type, exposing
> >>    the existing s390 cpu-state in QMP. The cpu-state is a representation
> >>    more adequate than the ambiguous 'halted' condition.
> >>
> >> Patch 2/3:
> >>    Adds a new QMP function query-cpus-fast, which will only retrieve
> >>    vCPU information that can be obtained without interrupting the
> >>    vCPUs of a running VM. It introduces a new return type CpuInfoFast
> >>    with the subset of fields meeting this condition. Specifically, the
> >>    halted state is not part of CpuInfoFast. QMP clients like libvirt
> >>    are encouraged to switch to the new API for vCPU information.
> >>
> >> Patch 3/3:
> >>    Adds the s390-specific cpu state to CpuInfoFast, allowing management
> >>    apps to find out whether a vCPU is in the stopped state. This extension
> >>    leads to a partial duplication of field definitions from CpuInfo
> >>    to CpuInfoFast. This should be tolerable if CpuInfo is deprecated and
> >>    eventually removed.  
> > 
> > How shall we proceed with this series? Patch 3 depends upon patch 1, so
> > I think it makes sense to merge this in one go.
> > 
> > I can give my R-b on patch 1 and Someone(tm) can merge this, or I can
> > take the whole series through the s390 tree (with some further
> > reviews/acks on patches 2/3).  
> 
> I'd still like to give a thorough QMP review; it's on my list to get to 
> today.
> 

Sure, no need to hurry.
