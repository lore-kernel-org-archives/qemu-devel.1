Received: from eggs.gnu.org ([2001:4830:134:3::10]:34614)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1clwP5-0008PL-Pa
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 06:38:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1clwP1-0006P1-RS
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 06:38:43 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60202
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1clwP1-0006Oq-Kx
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 06:38:39 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v29Bca74087755
	for <qemu-devel@nongnu.org>; Thu, 9 Mar 2017 06:38:38 -0500
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2932yxh11c-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 09 Mar 2017 06:38:37 -0500
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Thu, 9 Mar 2017 11:38:28 -0000
Date: Thu, 9 Mar 2017 12:38:23 +0100
From: Cornelia Huck <cornelia.huck@de.ibm.com>
In-Reply-To: <5de53ca5-ecd2-033e-17fb-6ecb2875dd5d@redhat.com>
References: <1488876478-6889-1-git-send-email-jasowang@redhat.com>
	<20170307111618.43ffbd13.cornelia.huck@de.ibm.com>
	<cb84b888-4917-162d-31a5-f708f4783444@redhat.com>
	<20170308101922.730b1579.cornelia.huck@de.ibm.com>
	<64df071f-27b0-9ee6-0b76-d8fa7a9cc8ec@redhat.com>
	<20170308111214.591b49fe.cornelia.huck@de.ibm.com>
	<a8f854b2-bbd3-1665-0b09-2abcad928b9d@redhat.com>
	<20170309120734.390a7cda.cornelia.huck@de.ibm.com>
	<5de53ca5-ecd2-033e-17fb-6ecb2875dd5d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20170309123823.5af4d65c.cornelia.huck@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] virtio: destroy region cache during reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org, peterx@redhat.com, mst@redhat.com

On Thu, 9 Mar 2017 12:12:00 +0100
Paolo Bonzini <pbonzini@redhat.com> wrote:

> On 09/03/2017 12:07, Cornelia Huck wrote:
> >>> - Driver #2 uses the device without doing a reset or proper setup
> >> Without this patch, even if driver #2 do a reset, it can still use the 
> >> old map if it don't set queue pfn.
> > 
> > Yes, the cleanup-on-reset is definetly needed.
> 
> It is good to have for defensiveness, but it would still cause a
> segfault so we should also add the checks on vq->vring.desc throughout.

Agreed.
