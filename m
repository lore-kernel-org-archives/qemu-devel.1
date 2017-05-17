Received: from eggs.gnu.org ([2001:4830:134:3::10]:49277)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1dAvx7-0005YN-TE
	for qemu-devel@nongnu.org; Wed, 17 May 2017 06:13:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1dAvx3-0005zm-2W
	for qemu-devel@nongnu.org; Wed, 17 May 2017 06:13:09 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52212)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bharata@linux.vnet.ibm.com>)
	id 1dAvx2-0005zY-OE
	for qemu-devel@nongnu.org; Wed, 17 May 2017 06:13:04 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v4HA9sPU000973
	for <qemu-devel@nongnu.org>; Wed, 17 May 2017 06:13:03 -0400
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2agkwvhskn-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 17 May 2017 06:13:02 -0400
Received: from localhost
	by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bharata@linux.vnet.ibm.com>;
	Wed, 17 May 2017 20:13:00 +1000
Date: Wed, 17 May 2017 15:42:04 +0530
From: Bharata B Rao <bharata@linux.vnet.ibm.com>
Reply-To: bharata@linux.vnet.ibm.com
References: <1494992962-6929-1-git-send-email-bharata@linux.vnet.ibm.com>
	<1494992962-6929-2-git-send-email-bharata@linux.vnet.ibm.com>
	<20170517064300.GJ15596@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170517064300.GJ15596@umbus.fritz.box>
Message-Id: <20170517101204.GE3446@in.ibm.com>
Subject: Re: [Qemu-devel] [RFC PATCH v1 1/6] migration: Fix
 unregister_savevm()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, sam.bobroff@au1.ibm.com, rnsastry@linux.vnet.ibm.com

On Wed, May 17, 2017 at 04:43:00PM +1000, David Gibson wrote:
> On Wed, May 17, 2017 at 09:19:17AM +0530, Bharata B Rao wrote:
> > In unregister_savevm(), free se->compat only if it was allocated earlier.
> > 
> > Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
> 
> I don't think this is necessary.  If se->compat was never allocated,
> then it should be NULL (since se is allocated with g_new0()).
> g_free() is explicitly safe to call on NULL, and we already rely on
> that in qemu.

Yeah, this is not necessary, will get rid of this in the next iteration.

Regards.,
Bharata.
