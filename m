Received: from eggs.gnu.org ([2001:4830:134:3::10]:49674)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dmEJV-0007qG-Mu
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 03:18:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dmEJS-0005G3-DO
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 03:18:25 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57046
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1dmEJS-0005DR-5m
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 03:18:22 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v7S7FGwU141035
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 03:18:19 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2cmcct58yb-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 03:18:19 -0400
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Mon, 28 Aug 2017 08:18:17 +0100
References: <e2a1b182-83a9-2259-27f9-68b61b5061d5@linux.vnet.ibm.com>
	<20170824171355.29d1ec32.cohuck@redhat.com>
	<30333b41-508d-f9a3-ac2d-4830a7791475@redhat.com>
	<34f0f307-d16f-7c76-1589-fa06252f6d09@linux.vnet.ibm.com>
	<ad0ef5a7-c0e0-9e54-a417-858c4b32a80e@redhat.com>
	<c9a6a1ec-eb7c-08a6-82ad-87ad5412ad19@linux.vnet.ibm.com>
	<CAFEAcA-oE=E3ydugLdVnPS2Tquqkou=BEhsB_DALqZxbVD0GDA@mail.gmail.com>
	<e24316e0-3b6f-ef1c-7c4b-66e7b302e5b4@linux.vnet.ibm.com>
	<97b35c4d-e897-c18a-525f-1fa1a7560776@de.ibm.com>
	<20170825092008.12484e6a.cohuck@redhat.com>
	<d3e9d032-fd2e-6126-1774-cb8a86a219f4@de.ibm.com>
	<20170825102950.736647be.cohuck@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 28 Aug 2017 09:18:14 +0200
MIME-Version: 1.0
In-Reply-To: <20170825102950.736647be.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <2fdd5a70-6339-c4ec-c13c-d6f96d7abfc9@de.ibm.com>
Subject: Re: [Qemu-devel] S390 bios breaks in qemu 2.10.rc3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Farhan Ali <alifm@linux.vnet.ibm.com>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, QEMU Developers <qemu-devel@nongnu.org>, "Collin L. Walling" <walling@linux.vnet.ibm.com>



On 08/25/2017 10:29 AM, Cornelia Huck wrote:
> On Fri, 25 Aug 2017 10:21:58 +0200
> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> 
>> On 08/25/2017 09:20 AM, Cornelia Huck wrote:
> 
>>> OK, to recap:
>>>
>>> - the current pre-built bios seems fine
>>> - rebuilding the bios may yield a version that fails on some systems
>>>   (different compiler?)
>>> - adding aligned(8) looks like the right thing to do
>>> - it seems to fix the problem, but on at least one system something
>>>   still seems off (under investigation)  
>>
>> Yes. I am out of office today, so for any aligned(8) patch
>> Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> even for 2.10.
> 
> I fear the 2.10 train has already left the station, but any aligned(8)
> patch should be cc:stable.

I think this could be a topic for QEMU summit. Our process of not allowing
fixes in rcx without requiring an rc(x+1) seems a bit odd. The Linux kernel
style (there are fixes between the last rc and release) seems more balanced
as long as we establish some safety nets.
