Received: from eggs.gnu.org ([2001:4830:134:3::10]:56485)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1erQT6-00023R-E7
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 10:50:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1erQT2-0007PV-DK
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 10:50:04 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53724)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1erQT2-0007JJ-4b
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 10:50:00 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w21FllLZ132990
	for <qemu-devel@nongnu.org>; Thu, 1 Mar 2018 10:49:57 -0500
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2gek7emfgh-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 01 Mar 2018 10:49:56 -0500
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Thu, 1 Mar 2018 15:49:54 -0000
References: <1519746259-27710-1-git-send-email-akrowiak@linux.vnet.ibm.com>
	<1519746259-27710-6-git-send-email-akrowiak@linux.vnet.ibm.com>
	<00b392ee-c928-3b22-4caf-33e7ce04f7f7@redhat.com>
	<e0b24000-0d2a-46f5-c880-89bf6a394bbb@linux.vnet.ibm.com>
	<bf963413-21ad-9b33-bd6c-e096e5686c59@redhat.com>
	<20180228124058.6166d957.cohuck@redhat.com>
	<b60e70b9-f076-8cc9-7c29-2887954b1404@linux.vnet.ibm.com>
	<c739f2ad-8e9a-1fa0-4277-3c4447c6ef15@redhat.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Thu, 1 Mar 2018 16:49:48 +0100
MIME-Version: 1.0
In-Reply-To: <c739f2ad-8e9a-1fa0-4277-3c4447c6ef15@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <f9054d43-f6ea-4477-ff98-7c1fc9e6dd4e@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2 5/5] s390x/cpumodel: Set up CPU model
 for AP device support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: mjrosato@linux.vnet.ibm.com, alex.williamson@redhat.com, Tony Krowiak <akrowiak@linux.vnet.ibm.com>, eskultet@redhat.com, peter.maydell@linaro.org, alifm@linux.vnet.ibm.com, heiko.carstens@de.ibm.com, qemu-devel@nongnu.org, agraf@suse.de, borntraeger@de.ibm.com, qemu-s390x@nongnu.org, jjherne@linux.vnet.ibm.com, schwidefsky@de.ibm.com, pbonzini@redhat.com, bjsdjshi@linux.vnet.ibm.com, eric.auger@redhat.com, rth@twiddle.net



On 03/01/2018 03:36 PM, David Hildenbrand wrote:
>> I have a concern with this proposition and with the original code:
> Very good, this is exactly what I talked to Conny about yesterday.
> 
> Short version: CPU model is guest ABI, everything else is configuration.
> 

Nod.

> 
> So I think for now we are fine. Later, this might be tricky to check but
> not impossible.
>

I think we are all in agreement on the important stuff. I think, we also all
agree, that certain things need to be improved. E.g. the KVM code
manipulating ECA.28, -cpu xxx,ap=on needs to imply no Operation Exception when
guest executes an AP instruction (this is currently not the case as
we can have a vm a vfio-ap device -- so open won't get called -- but with ap=on).

Hope Tony will address these in the next version.

Regards,
Halil
