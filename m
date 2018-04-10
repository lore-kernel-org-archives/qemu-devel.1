Received: from eggs.gnu.org ([2001:4830:134:3::10]:53280)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1f5kgz-0006bA-8Z
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 00:15:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1f5kgw-0003qZ-Gf
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 00:15:37 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36956)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bharata@linux.vnet.ibm.com>)
	id 1f5kgw-0003pY-8B
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 00:15:34 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w3A4Anne077385
	for <qemu-devel@nongnu.org>; Tue, 10 Apr 2018 00:15:33 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2h8jp2pqsc-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 10 Apr 2018 00:15:32 -0400
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bharata@linux.vnet.ibm.com>;
	Tue, 10 Apr 2018 05:15:29 +0100
Date: Tue, 10 Apr 2018 09:45:21 +0530
From: Bharata B Rao <bharata@linux.vnet.ibm.com>
Reply-To: bharata@linux.vnet.ibm.com
References: <20180409062538.1095-1-bharata@linux.vnet.ibm.com>
	<20180410030245.GF3361@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180410030245.GF3361@umbus.fritz.box>
Message-Id: <20180410041521.GA14855@in.ibm.com>
Subject: Re: [Qemu-devel] [RFC PATCH v2] spapr: Support ibm,
 dynamic-memory-v2 property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, nfont@linux.vnet.ibm.com, mwb@linux.vnet.ibm.com, imammedo@redhat.com

On Tue, Apr 10, 2018 at 01:02:45PM +1000, David Gibson wrote:
> On Mon, Apr 09, 2018 at 11:55:38AM +0530, Bharata B Rao wrote:
> > The new property ibm,dynamic-memory-v2 allows memory to be represented
> > in a more compact manner in device tree.
> 
> I still need to look at this in more detail, but to start with:
> what's the rationale for this new format?
> 
> It's more compact, but why do we care?  The embedded people always
> whinge about the size of the deivce tree, but I didn't think that was
> really a concern with PAPR.

Here's a real example of how this has affected us earlier:

SLOF's CAS FDT buffer size was initially 32K, was changed to 64k to
support 1TB guest memory and again changed to 2MB to support 16TB guest
memory.

With ibm,dynamic-memory-v2 we are less likely to hit such scenarios.

Also, theoretically it should be more efficient in the guest kernel
to handle LMB-sets than individual LMBs.

We aren't there yet, but I believe grouping of LMBs should eventually
help us do memory hotplug at set (or DIMM) granularity than at individual
LMB granularity (Again theoretical possibility)

Regards,
Bharata.
