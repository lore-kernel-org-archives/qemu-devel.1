Received: from eggs.gnu.org ([2001:4830:134:3::10]:34868)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <linuxram@us.ibm.com>) id 1dmOEp-0003W9-0P
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 13:54:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <linuxram@us.ibm.com>) id 1dmOEk-0004y2-1u
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 13:54:15 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54785)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <linuxram@us.ibm.com>) id 1dmOEj-0004xg-PE
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 13:54:09 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v7SHrwuv110576
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 13:54:08 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2cmng5hqp6-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 13:54:08 -0400
Received: from localhost
	by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <linuxram@us.ibm.com>;
	Mon, 28 Aug 2017 13:54:07 -0400
Date: Mon, 28 Aug 2017 10:53:56 -0700
From: Ram Pai <linuxram@us.ibm.com>
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <20170821200036.15036-1-bauerman@linux.vnet.ibm.com>
	<20170824025448.GA27401@fergus.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170824025448.GA27401@fergus.ozlabs.ibm.com>
Message-Id: <20170828175356.GB26893@ram.oc3035372033.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] spapr: Add ibm,
 processor-storage-keys property to CPU DT node
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paul Mackerras <paulus@ozlabs.org>
Cc: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, Michael Ellerman <mpe@ellerman.id.au>

On Thu, Aug 24, 2017 at 12:54:48PM +1000, Paul Mackerras wrote:
> 
> We could either have two u16 fields for the number of keys for data
> and instruction, or we could have a u32 field for the number of keys
> and a separate bit in the flags field to indicate that instruction
> keys are supported.  Which would be preferable?

the second choice is more confusion-proof; to me atleast.

The first choice gives a illusion that there are 'x' number of data keys
and 'y' number of instruction keys; which is not exactly true.

RP
