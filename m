Received: from eggs.gnu.org ([209.51.188.92]:43838)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <walling@linux.ibm.com>) id 1gqnC8-0007vi-4h
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 17:58:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <walling@linux.ibm.com>) id 1gqnC5-0004cl-SZ
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 17:58:27 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56470)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <walling@linux.ibm.com>)
	id 1gqnC5-0004ay-AN
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 17:58:25 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x14MnKtN015192
	for <qemu-devel@nongnu.org>; Mon, 4 Feb 2019 17:58:23 -0500
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2qexa4gn8c-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 04 Feb 2019 17:58:22 -0500
Received: from localhost
	by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <walling@linux.ibm.com>;
	Mon, 4 Feb 2019 22:58:21 -0000
References: <20190130155733.32742-1-david@redhat.com>
	<20190130155733.32742-2-david@redhat.com>
From: Collin Walling <walling@linux.ibm.com>
Date: Mon, 4 Feb 2019 17:58:18 -0500
MIME-Version: 1.0
In-Reply-To: <20190130155733.32742-2-david@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <191e8d6f-31a7-93bd-376c-783a9dde90ba@linux.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/6] s390x/pci: Fix primary bus number
 for PCI bridges
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Pierre Morel <pmorel@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, Richard Henderson <rth@twiddle.net>

On 1/30/19 10:57 AM, David Hildenbrand wrote:
> The primary bus number corresponds always to the bus number of the
> bus the bridge is attached to.
> 
> Right now, if we have two bridges attached to the same bus (e.g. root
> bus) this is however not the case. The first bridge will have primary
> bus 0, the second bridge primary bus 1, which is wrong. Fix the assignment.
> 
> While at it, drop setting the PCI_SUBORDINATE_BUS temporarily to 0xff.
> Setting it temporarily to that value (as discussed e.g. in [1]), is
> only relevant for a running system that probes the buses. The value is
> effectively unused for us just doing a DFS.
> 
> Also add a comment why we have to reassign during every reset (which I
> found to be surprising.
> 
> Please note that hotplugging of bridges is in general still broken, will
> be fixed next.
> 
> [1] http://www.science.unitn.it/~fiorella/guidelinux/tlk/node76.html
> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---

Reviewed-by: Collin Walling <walling@linux.ibm.com>
