Received: from eggs.gnu.org ([209.51.188.92]:33739)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1gk9N1-0001RQ-3i
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 10:14:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1gk9N0-0006Cw-Bn
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 10:14:15 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53434)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.ibm.com>) id 1gk9My-0005w0-CP
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 10:14:14 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	x0HF9Zmi146313
	for <qemu-devel@nongnu.org>; Thu, 17 Jan 2019 10:14:06 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2q2tuucdwm-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 17 Jan 2019 10:14:04 -0500
Received: from localhost
	by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.ibm.com>;
	Thu, 17 Jan 2019 15:14:00 -0000
Date: Thu, 17 Jan 2019 16:13:53 +0100
From: Halil Pasic <pasic@linux.ibm.com>
In-Reply-To: <20190116174130.2ffb0713.cohuck@redhat.com>
References: <1547125207-16907-1-git-send-email-pmorel@linux.ibm.com>
	<1547125207-16907-2-git-send-email-pmorel@linux.ibm.com>
	<f6a5491a-1859-8e0a-7357-901d47ee8304@linux.ibm.com>
	<20190116134011.1189b027@oc2783563651>
	<1188d21d-3603-c291-e69b-38d341ae90f4@linux.ibm.com>
	<20190116155011.478db4da@oc2783563651>
	<364e925b-4839-a10d-7a86-6a0bf229f4de@linux.ibm.com>
	<20190116174130.2ffb0713.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20190117161353.25b6e8e6@oc2783563651>
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
To: Cornelia Huck <cohuck@redhat.com>
Cc: Pierre Morel <pmorel@linux.ibm.com>, Collin Walling <walling@linux.ibm.com>, david@redhat.com, qemu-devel@nongnu.org, borntraeger@de.ibm.com, qemu-s390x@nongnu.org, thuth@redhat.com, rth@twiddle.net

On Wed, 16 Jan 2019 17:41:30 +0100
Cornelia Huck <cohuck@redhat.com> wrote:

> On Wed, 16 Jan 2019 16:44:09 +0100
> Pierre Morel <pmorel@linux.ibm.com> wrote:
> 
> > On 16/01/2019 15:50, Halil Pasic wrote:
> 
> > > @Connie, will you add the Fixes tag? Do we need a cc stable (since
> > > broken since 2016-06-19)?
> > > 
> > > @Pierre: So you say it's a bug.
> > > What can go wrong because of this?
> > > For example if we interpret pal as a size, I guess we could end up with
> > > the memory region not fitting the guest memory,  
> > 
> > The memory region will be too large compared with what the guest required.
> 
> Honestly, this does not look like QEMU stable material to me.
> 

Based on Pierre's offline explanation, from which I understood, the
worst thing that can happen is, that a buggy guest can render it's pci
function unusable, I have to agree: not stable material.

My problem is my non-existent understanding of zPCI. My intuition was
this should be much nastier than that. I would have appreciated a better
explanation on why this is not a problem in practice though -- best as
a part of the commit message.

Regards,
Halil
