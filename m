Received: from eggs.gnu.org ([2001:4830:134:3::10]:60501)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1gAXm1-0001c5-8Q
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 06:00:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1gAXly-0004JI-59
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 06:00:53 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43544)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1gAXlx-0004IA-GR
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 06:00:49 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w9B9uYSg039683
	for <qemu-devel@nongnu.org>; Thu, 11 Oct 2018 06:00:48 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2n22t1m6ca-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 11 Oct 2018 06:00:47 -0400
Received: from localhost
	by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Thu, 11 Oct 2018 11:00:44 +0100
References: <20181010170309.12045-1-akrowiak@linux.ibm.com>
	<ceeafd70-b1d3-9e80-d357-65740dd125cd@de.ibm.com>
	<20181011114845.75275acd.cohuck@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Thu, 11 Oct 2018 12:00:32 +0200
MIME-Version: 1.0
In-Reply-To: <20181011114845.75275acd.cohuck@redhat.com>
Content-Language: en-US
Message-Id: <85bc92db-56f9-fcca-e4c6-205f767d5c8e@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v11 0/6] s390x: vfio-ap: guest dedicated
 crypto adapters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Tony Krowiak <akrowiak@linux.ibm.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, david@redhat.com, bjsdjshi@linux.vnet.ibm.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, eskultet@redhat.com, berrange@redhat.com, alex.williamson@redhat.com, eric.auger@redhat.com, pbonzini@redhat.com, peter.maydell@linaro.org, agraf@suse.de, rth@twiddle.net, akrowiak@linux.vnet.ibm.com, fiuczy@linux.ibm.com, mimu@linux.ibm.com



On 10/11/2018 11:48 AM, Cornelia Huck wrote:
> On Wed, 10 Oct 2018 20:15:55 +0200
> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> 
>> On 10/10/2018 07:03 PM, Tony Krowiak wrote:
>>> This patch series is the QEMU counterpart to the KVM/kernel support for 
>>> guest dedicated crypto adapters. The KVM/kernel model is built on the 
>>> VFIO mediated device framework and provides the infrastructure for 
>>> granting exclusive guest access to crypto devices installed on the linux 
>>> host. This patch series introduces a new QEMU command line option, QEMU 
>>> object model and CPU model features to exploit the KVM/kernel model.
>>>
>>> See the detailed specifications for AP virtualization provided by this 
>>> patch set in docs/vfio-ap.txt for a more complete discussion of the 
>>> design introduced by this patch series.
>>>
>>> v10 => v11 Change log:  
>>
>>
>>
>> Series seems to work fine.
>>
>> Christian
> 
> Is that a Tested-by:, or just 'looks sane'?

It was limited to some cases, but lets make it a tested-by. 
