Received: from eggs.gnu.org ([2001:4830:134:3::10]:47916)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sam.bobroff@au1.ibm.com>) id 1diBbM-0006a6-88
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 23:36:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sam.bobroff@au1.ibm.com>) id 1diBbI-0002NN-4m
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 23:36:08 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33243
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sam.bobroff@au1.ibm.com>)
	id 1diBbH-0002Jy-Uy
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 23:36:04 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v7H3XmIe014058
	for <qemu-devel@nongnu.org>; Wed, 16 Aug 2017 23:36:02 -0400
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ccth4t1xw-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 16 Aug 2017 23:36:02 -0400
Received: from localhost
	by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <sam.bobroff@au1.ibm.com>;
	Thu, 17 Aug 2017 13:35:59 +1000
Date: Thu, 17 Aug 2017 13:35:54 +1000
From: Sam Bobroff <sam.bobroff@au1.ibm.com>
References: <150287457293.9760.17827532208744487789.stgit@aravinda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <150287457293.9760.17827532208744487789.stgit@aravinda>
Message-Id: <20170817033554.ip36jmv6kwf7bpbp@tungsten.ozlabs.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v3 0/5] target-ppc/spapr: Add FWNMI support
 in QEMU for PowerKVM guests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, david@gibson.dropbear.id.au, aik@ozlabs.ru, mahesh@linux.vnet.ibm.com, benh@au1.ibm.com, paulus@samba.org

On Wed, Aug 16, 2017 at 02:41:59PM +0530, Aravinda Prasad wrote:
> This series of patches adds support for FWNMI in PowerKVM guests.
> 
> Memory error such as bit flips that cannot be corrected
> by hardware is passed on to the kernel for handling
> by raising machine check exception (an NMI). Upon such
> machine check exception, if the address in error belongs
> to guest then KVM causes a guest exit with KVM_EXIT_NMI
> exit reason.
> 
> This patch series adds functionality to pass on such
> machine check exception to the guest kernel by suitably
> handling KVM_EXIT_NMI exit and building the error log.
> 
> The KVM changes are now part of the upstream kernel
> (commit e20bbd3d). This series contain QEMU changes.

[snip]

Hi,

I'm concerned that this implementation may introduce a problem with
kexec. If a VM registers an NMI handler, then kexecs to a new kernel
and an NMI is received before the new kernel has registered it's
handler, won't QEMU cause the guest to jump to the old, now invalid,
handler address? Is this worth worrying about?

Cheers,
Sam.
