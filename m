Received: from eggs.gnu.org ([2001:4830:134:3::10]:39095)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dVbpU-0004JG-8n
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 06:58:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dVbpP-0007zi-EX
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 06:58:44 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50964
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1dVbpP-0007zc-8j
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 06:58:39 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6DAmlvX074337
	for <qemu-devel@nongnu.org>; Thu, 13 Jul 2017 06:58:38 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2bp61fkk2s-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 13 Jul 2017 06:58:38 -0400
Received: from localhost
	by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Thu, 13 Jul 2017 06:58:37 -0400
References: <1499942429-55449-1-git-send-email-borntraeger@de.ibm.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Thu, 13 Jul 2017 12:58:31 +0200
MIME-Version: 1.0
In-Reply-To: <1499942429-55449-1-git-send-email-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-IE
Content-Transfer-Encoding: 7bit
Message-Id: <5ae6eccd-274a-3278-1240-42ebe7a23cc1@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH/s390-next 0/3] s390x: remaining pci related
 fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, Cornelia Huck <cohuck@redhat.com>, Yi Min Zhao <zyimin@linux.vnet.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Thomas Huth <thuth@redhat.com>

On 07/13/2017 12:40 PM, Christian Borntraeger wrote:
> here are the remaining PCI patches also enabling AIS via KVM.
> CPU model wise we do not put AIS in a default model for zEC12 and z13
> since almost all distribution kernels do not have ais yet. This would
> break -cpu zEC12 and -cpu z13 if QEMU is updated.
> 
> patches are against previous series.

The current state (including netboot bios) can be found on

https://github.com/borntraeger/qemu/tree/s390-next

> 
> 
> Yi Min Zhao (3):
>   s390x: initialize cpu firstly
>   s390x/cpumodel: add zpci, aen and ais facilities
>   s390x/flic: migrate ais states
> 
>  hw/intc/s390_flic.c             | 23 +++++++++++-
>  hw/intc/s390_flic_kvm.c         | 78 +++++++++++++++++++++++++++++++++++++++--
>  hw/s390x/s390-virtio-ccw.c      |  9 +++--
>  include/hw/s390x/s390_flic.h    |  1 +
>  target/s390x/cpu_features.c     |  3 ++
>  target/s390x/cpu_features_def.h |  3 ++
>  target/s390x/gen-features.c     |  5 +++
>  target/s390x/kvm.c              |  7 ++++
>  8 files changed, 122 insertions(+), 7 deletions(-)
> 
