Received: from eggs.gnu.org ([2001:4830:134:3::10]:41706)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1e84Cc-0007N4-RH
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 08:57:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1e84CZ-0006ei-PP
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 08:57:34 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36314
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1e84CZ-0006eQ-Iu
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 08:57:31 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9RCtIxH097334
	for <qemu-devel@nongnu.org>; Fri, 27 Oct 2017 08:57:28 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2dv4g1ahtu-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 27 Oct 2017 08:57:27 -0400
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Fri, 27 Oct 2017 13:57:25 +0100
From: Christian Borntraeger <borntraeger@de.ibm.com>
References: <20171020145437.18549-1-borntraeger@de.ibm.com>
	<c76678f3-70df-e963-12b8-208c5c2a1578@linux.vnet.ibm.com>
	<b40f75d4-2280-fc66-b92f-34717b51ed47@linux.vnet.ibm.com>
	<d7a16f29-1420-d723-4a42-ac549e3f4f52@de.ibm.com>
Date: Fri, 27 Oct 2017 14:57:22 +0200
MIME-Version: 1.0
In-Reply-To: <d7a16f29-1420-d723-4a42-ac549e3f4f52@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <03b0c516-7044-d71e-1b1f-c3bef84ac812@de.ibm.com>
Subject: Re: [Qemu-devel] [libvirt] [PATCH/QEMU] s390x/kvm: use
 cpu_model_available for guarded storage on compat machines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>, jjherne@linux.vnet.ibm.com, Marc Hartmayer <mhartmay@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: libvir-list@redhat.com, Jiri Denemark <jdenemar@redhat.com>, qemu-devel@nongnu.org



On 10/27/2017 02:45 PM, Christian Borntraeger wrote:
> 
> 
> On 10/27/2017 02:31 PM, Halil Pasic wrote:
> gs is explicitly disabled.
>>
>> Now that I think about it, maybe the 2.9 binary is going to reject
>> the explicit gs flag altogether, because it's unknown.
>>
>> Isn't this a problem? 
> 
> No. This is exactly the _solution_ and not the problem. The target will reject
> unknown cpu features and migration will be aborted. This is exactly what the CPU
> model is for.
FWIW, I think in your particular case the QEMU will reject the z14 cpu and not even come
to checking the gs. 
