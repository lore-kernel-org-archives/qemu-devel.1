Received: from eggs.gnu.org ([209.51.188.92]:34998)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gjoG8-0001Hv-6r
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 11:41:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gjoG6-0008SA-W2
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 11:41:44 -0500
Date: Wed, 16 Jan 2019 17:41:30 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190116174130.2ffb0713.cohuck@redhat.com>
In-Reply-To: <364e925b-4839-a10d-7a86-6a0bf229f4de@linux.ibm.com>
References: <1547125207-16907-1-git-send-email-pmorel@linux.ibm.com>
	<1547125207-16907-2-git-send-email-pmorel@linux.ibm.com>
	<f6a5491a-1859-8e0a-7357-901d47ee8304@linux.ibm.com>
	<20190116134011.1189b027@oc2783563651>
	<1188d21d-3603-c291-e69b-38d341ae90f4@linux.ibm.com>
	<20190116155011.478db4da@oc2783563651>
	<364e925b-4839-a10d-7a86-6a0bf229f4de@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] s390x/pci: Set the iommu region size
 mpcifc request
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pierre Morel <pmorel@linux.ibm.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, Collin Walling <walling@linux.ibm.com>, thuth@redhat.com, david@redhat.com, qemu-devel@nongnu.org, borntraeger@de.ibm.com, qemu-s390x@nongnu.org, rth@twiddle.net

On Wed, 16 Jan 2019 16:44:09 +0100
Pierre Morel <pmorel@linux.ibm.com> wrote:

> On 16/01/2019 15:50, Halil Pasic wrote:

> > @Connie, will you add the Fixes tag? Do we need a cc stable (since
> > broken since 2016-06-19)?
> > 
> > @Pierre: So you say it's a bug.
> > What can go wrong because of this?
> > For example if we interpret pal as a size, I guess we could end up with
> > the memory region not fitting the guest memory,  
> 
> The memory region will be too large compared with what the guest required.

Honestly, this does not look like QEMU stable material to me.
