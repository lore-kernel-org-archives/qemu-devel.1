Received: from eggs.gnu.org ([2001:4830:134:3::10]:49961)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dIEjP-0001oM-K9
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 09:41:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dIEjK-0006Td-MN
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 09:41:11 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44509)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1dIEjK-0006Sj-Cc
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 09:41:06 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v56DclIl007692
	for <qemu-devel@nongnu.org>; Tue, 6 Jun 2017 09:41:04 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2awvq4b8p4-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 06 Jun 2017 09:41:03 -0400
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Tue, 6 Jun 2017 14:41:01 +0100
References: <20170531193434.6918-1-david@redhat.com>
	<20170531193434.6918-3-david@redhat.com>
	<e70d08bd-bf75-4997-df7b-e64710046fc3@linux.vnet.ibm.com>
	<f1a8957a-9d13-efce-c0c4-b010ae4b6cd8@redhat.com>
	<e7465d88-84b3-8287-1e42-c5b60b514ef6@linux.vnet.ibm.com>
	<50081e98-fdbc-ac3b-3600-5fc1686f6eb7@redhat.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Tue, 6 Jun 2017 15:40:58 +0200
MIME-Version: 1.0
In-Reply-To: <50081e98-fdbc-ac3b-3600-5fc1686f6eb7@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <908c2a79-6cc6-9ab0-e95d-5e4b18f4ec94@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v1 2/2] s390x/cpumodel: improve defintion
 search without an IBC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, jjherne@linux.vnet.ibm.com, qemu-devel@nongnu.org
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, thuth@redhat.com, Aurelien Jarno <aurelien@aurel32.net>, rth@twiddle.net



On 06/06/2017 10:57 AM, David Hildenbrand wrote:
>> Let me add one meta comment too. IMHO what makes the function hard to
>> understand, is that we have a bunch of optional parameters, and that
>> although this seems to be some sort of approximation problem (find the
>> best good enough), the metric ain't obvious for somebody not to familiar
>> with the problem domain (like me). AFAIU you are fixing the following
>> problem domain (me). Seems that the metric implemented was sub-optimal:
>> if parameters present {type}, absent {ec_ga} maybe present {gen,
>> features}, then type is not honored appropriately.  One can probably
>> figure out what's intended by understanding all the usages (which makes
>> reviewing it demanding). For instance, you also refer to a particular
>> usage in your title/subject (that is "model->def =
>> s390_find_cpu_def(cpu_type, ibc_gen(unblocked_ibc),
>> ibc_ec_ga(unblocked_ibc), NULL);" in target/s390x/kvm.c).
> Actually, I thought that all relevant z/VM systems would properly
> forward the IBC. By relevant, I am speaking about zEC12+. So I never saw
> this while working on the CPU model.
> 
> We could split this function into multiple: find by (cpuid),
> (cpuid,gen,ec_ga), (features), (gen,ec_ga,features). All without
> optional parameters. But I doubt that this will result in better code,
> especially on the caller side.
> 
> If you have an idea how to improve that piece of code, feel free to send
> a cleanup.

I prefer leaving it as-is. My understanding ain't complete enough anyways.
Making the caller side needlessly complicated is definitely not what we
want. One approach to make understanding/reviewing the function easier 
(especially in isolation) would be adding a comment describing it's
pre- and postcondition (akin to Hoare logic but in natural language).
If that can be one easily, then I do not think we have a problem.
My problem is that I can't (that's what I mean by the 'metric'
is not obvious).

> 
> Thanks for having a look!
> 

yw

Halil
