Received: from eggs.gnu.org ([2001:4830:134:3::10]:53565)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1e84yu-0006I4-Sb
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 09:47:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1e84yr-00031P-Qb
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 09:47:28 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57750
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1e84yr-00030g-L8
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 09:47:25 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9RDl4W0136772
	for <qemu-devel@nongnu.org>; Fri, 27 Oct 2017 09:47:22 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2dv4g1d784-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 27 Oct 2017 09:47:20 -0400
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Fri, 27 Oct 2017 14:47:19 +0100
References: <20171020145437.18549-1-borntraeger@de.ibm.com>
	<c76678f3-70df-e963-12b8-208c5c2a1578@linux.vnet.ibm.com>
	<b40f75d4-2280-fc66-b92f-34717b51ed47@linux.vnet.ibm.com>
	<b76b2832-8e14-43fe-ea9b-23e6bf330bf6@de.ibm.com>
	<20171027153136.5e5eeb62.cohuck@redhat.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Fri, 27 Oct 2017 15:47:15 +0200
MIME-Version: 1.0
In-Reply-To: <20171027153136.5e5eeb62.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <6512d234-aa69-007e-3623-3807750b9a00@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH/QEMU] s390x/kvm: use cpu_model_available
 for guarded storage on compat machines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: jjherne@linux.vnet.ibm.com, Marc Hartmayer <mhartmay@linux.vnet.ibm.com>, libvir-list@redhat.com, Jiri Denemark <jdenemar@redhat.com>, Boris Fiuczynski <fiuczy@linux.vnet.ibm.com>, qemu-devel@nongnu.org, Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>



On 10/27/2017 03:31 PM, Cornelia Huck wrote:
> On Fri, 27 Oct 2017 14:42:57 +0200
> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> 
>> Yes, we should also replace that with
>>
>>  return s390_has_feat(S390_FEAT_GUARDED_STORAGE)
>>
>> I can fixup my patch or provide a 2nd one.
>>
> 
> Consider a fixed up patch acked by me.
> 

+1 You can keep my ack too. I will try to find some time and read
the v2 though.
