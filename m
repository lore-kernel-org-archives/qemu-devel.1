Received: from eggs.gnu.org ([2001:4830:134:3::10]:58587)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1csrEG-0001cU-Kr
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 09:32:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1csrEB-0002SH-On
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 09:32:08 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50301
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1csrEB-0002Ro-IV
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 09:32:03 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v2SDRnfD016472
	for <qemu-devel@nongnu.org>; Tue, 28 Mar 2017 09:32:01 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0a-001b2d01.pphosted.com with ESMTP id 29frr0g9d1-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 28 Mar 2017 09:32:01 -0400
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Tue, 28 Mar 2017 14:31:59 +0100
Date: Tue, 28 Mar 2017 15:31:52 +0200
From: Cornelia Huck <cornelia.huck@de.ibm.com>
In-Reply-To: <ad83f499-cc12-688e-f455-50a28c1f2ea0@de.ibm.com>
References: <20170317031743.40128-1-bjsdjshi@linux.vnet.ibm.com>
	<20170328102016.4926f21d.cornelia.huck@de.ibm.com>
	<ad83f499-cc12-688e-f455-50a28c1f2ea0@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20170328153152.16ddb794.cornelia.huck@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v4 00/16] basic vfio-ccw infrastructure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, qemu-devel@nongnu.org, renxiaof@linux.vnet.ibm.com, agraf@suse.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, Martin Schwidefsky <schwidefsky@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>

On Tue, 28 Mar 2017 10:39:40 +0200
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> On 03/28/2017 10:20 AM, Cornelia Huck wrote:

> > Patch set looks good to me, and I think we should target it for the
> > next merge window (the interface looks fine, and we can iron out any
> > other things later.)
> > 
> > Question: Which tree should this go through? Vfio or kvm/s390?
> 
> Reading todays MAINTAINERS file this would go via Martins tree, after the last
> patch it will be separate. I can certainly carry that via the kvms390 tree,
> but Alex is certainly the final maintainer. 
> So what about having a new repository under 
> https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/
> e.g. vfio.git that will then queue the patches for Alex to take?

Whatever we decide:

Patches with collected acks pushed out to

https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/vfio-ccw.git vfio-ccw-v0
