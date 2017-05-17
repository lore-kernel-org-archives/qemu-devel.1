Received: from eggs.gnu.org ([2001:4830:134:3::10]:40318)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1dAtHc-0003LK-Fp
	for qemu-devel@nongnu.org; Wed, 17 May 2017 03:22:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1dAtHX-00047Y-Hu
	for qemu-devel@nongnu.org; Wed, 17 May 2017 03:22:08 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53948)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bharata@linux.vnet.ibm.com>)
	id 1dAtHX-000479-8h
	for qemu-devel@nongnu.org; Wed, 17 May 2017 03:22:03 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v4H7Iips118622
	for <qemu-devel@nongnu.org>; Wed, 17 May 2017 03:22:02 -0400
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2agdbe3jr3-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 17 May 2017 03:22:01 -0400
Received: from localhost
	by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bharata@linux.vnet.ibm.com>;
	Wed, 17 May 2017 17:21:59 +1000
Date: Wed, 17 May 2017 12:51:04 +0530
From: Bharata B Rao <bharata@linux.vnet.ibm.com>
Reply-To: bharata@linux.vnet.ibm.com
References: <1494992962-6929-1-git-send-email-bharata@linux.vnet.ibm.com>
	<1494992962-6929-3-git-send-email-bharata@linux.vnet.ibm.com>
	<20170517064544.GK15596@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170517064544.GK15596@umbus.fritz.box>
Message-Id: <20170517072104.GD3446@in.ibm.com>
Subject: Re: [Qemu-devel] [RFC PATCH v1 2/6] migration: Introduce
 unregister_savevm_live()
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

On Wed, May 17, 2017 at 04:45:44PM +1000, David Gibson wrote:
> On Wed, May 17, 2017 at 09:19:18AM +0530, Bharata B Rao wrote:
> > Introduce a new function unregister_savevm_live() to unregister the vmstate
> > handlers registered via register_savevm_live().
> > 
> > register_savevm() allocates SaveVMHandlers while register_savevm_live()
> > gets passed with SaveVMHandlers. During unregistration, we  want to
> > free SaveVMHandlers in the former case but not free in the latter case.
> > Hence this new API is needed to differentiate this.
> > 
> > This new API will be needed by PowerPC to unregister the HTAB savevm
> > handlers.
> > 
> > Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
> 
> It's not my bailiwick, so I don't get final say, but I dislike
> changing the signature of the existing unregister_savevm() interface.
> I think it would be preferable to only add the 'live' paramter to a
> new unregister_savevm_common() (or whatever) function.

Yeah, much better, let me change this in next version.

Regards,
Bharata.
