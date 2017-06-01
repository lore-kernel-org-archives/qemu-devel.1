Received: from eggs.gnu.org ([2001:4830:134:3::10]:39219)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dGN3h-0001bi-JQ
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 06:10:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dGN3e-000050-EE
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 06:10:25 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46081
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1dGN3e-0008WJ-8d
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 06:10:22 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v51A8s39068687
	for <qemu-devel@nongnu.org>; Thu, 1 Jun 2017 06:10:21 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2atfhpceq7-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 01 Jun 2017 06:10:21 -0400
Received: from localhost
	by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Thu, 1 Jun 2017 06:10:20 -0400
References: <20170531193434.6918-1-david@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Thu, 1 Jun 2017 12:10:15 +0200
MIME-Version: 1.0
In-Reply-To: <20170531193434.6918-1-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-IE
Content-Transfer-Encoding: 7bit
Message-Id: <b6efd549-0cab-ed67-c39c-b62b833cfef8@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v1 0/2] s390x cpu model improvements for KVM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: rth@twiddle.net, Aurelien Jarno <aurelien@aurel32.net>, thuth@redhat.com, Cornelia Huck <cornelia.huck@de.ibm.com>, "Jason J . Herne" <jjherne@linux.vnet.ibm.com>

On 05/31/2017 09:34 PM, David Hildenbrand wrote:
> We should properly forward the CPUID format bit. CPU model
> detection on systems without IBC might select a model with a wrong
> CPU type (esp. selecting the business class (BC) model on an enterprise
> class (EC) machine). So let's improve that, too.
> 
> I am also preparing a patch to properly indicate the correct cpu type
> to the guest via STORE CPU ID and STORE HYPERVISOR INFORMATION for the
> TCG case, but will send that separately after I tested it (want to write a
> kvm-unit-test for STORE CPU ID).
> 
> David Hildenbrand (2):
>   s390x/cpumodel: take care of the cpuid format bit for KVM
>   s390x/cpumodel: improve defintion search without an IBC
> 
>  target/s390x/cpu_models.c | 10 ++++++++++
>  target/s390x/cpu_models.h | 10 +++++++---
>  target/s390x/kvm.c        |  1 +
>  3 files changed, 18 insertions(+), 3 deletions(-)
> 

I like both patches in terms of "yes, its the right thing to do".
Jason can you have a look? I might need some days to catch up
with other things before I can look into the patches.
