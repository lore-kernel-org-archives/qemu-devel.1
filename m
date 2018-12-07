Received: from eggs.gnu.org ([2001:4830:134:3::10]:34221)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1gVFIv-0005jK-Ua
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 07:32:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1gVFIr-0006DF-SK
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 07:32:25 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40690
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1gVFIr-0006CV-Kz
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 07:32:21 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	wB7AxChv104667
	for <qemu-devel@nongnu.org>; Fri, 7 Dec 2018 07:32:21 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2p7qkb3tnr-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 07 Dec 2018 07:32:20 -0500
Received: from localhost
	by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Fri, 7 Dec 2018 12:32:19 -0000
References: <20181205145131.28467-1-cohuck@redhat.com>
	<5d274f2c-23a2-0c4f-9f2d-07cbe529c5ac@de.ibm.com>
	<20181207132946.00df1f5a.cohuck@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Fri, 7 Dec 2018 13:32:14 +0100
MIME-Version: 1.0
In-Reply-To: <20181207132946.00df1f5a.cohuck@redhat.com>
Content-Language: en-US
Message-Id: <7e03f504-807d-12d4-368d-ed3b069b351e@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH RFC] vfio-ap: flag as compatible with
 balloon
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Tony Krowiak <akrowiak@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>, Alex Williamson <alex.williamson@redhat.com>, David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org



On 07.12.2018 13:29, Cornelia Huck wrote:
> On Fri, 7 Dec 2018 13:17:02 +0100
> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> 
>> On 05.12.2018 15:51, Cornelia Huck wrote:
>>> vfio-ap devices do not pin any pages in the host. Therefore, they
>>> are belived to be compatible with memory ballooning.
>>>
>>> Flag them as compatible, so both vfio-ap and a balloon can be
>>> used simultaneously.
>>>
>>> Signed-off-by: Cornelia Huck <cohuck@redhat.com>  
>>
>> Does it make sense to add cc stable for 3.1?
> 
> Can do that, given that s390x systems really rely on the ballooner in
> general.

Well, not relying is the wrong word. It is just strange that things like

  <memory unit='GiB'>2</memory>
  <currentMemory unit='GiB'>1</currentMemory>

do work 
but suddenly no longer work when an AP device is added.
