Received: from eggs.gnu.org ([2001:4830:134:3::10]:53146)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1djofg-0001gZ-Bq
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 11:31:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1djofd-0005ON-62
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 11:31:20 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56360)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1djofc-0005Ma-Tp
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 11:31:17 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v7LFUEqB066231
	for <qemu-devel@nongnu.org>; Mon, 21 Aug 2017 11:31:15 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2cfttw8e80-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 21 Aug 2017 11:31:14 -0400
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Mon, 21 Aug 2017 16:31:04 +0100
References: <20170821091614.28251-1-cohuck@redhat.com>
	<20170821091614.28251-10-cohuck@redhat.com>
	<feebff17-e4b8-2e00-9775-126055172564@linux.vnet.ibm.com>
	<20170821141353.32a1242c.cohuck@redhat.com>
	<aa499e7a-2692-d3b8-d3f5-c8bc1d5783d2@linux.vnet.ibm.com>
	<91e5cbdf-9d91-fc7f-3fb5-3727d73b1419@redhat.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Mon, 21 Aug 2017 17:30:58 +0200
MIME-Version: 1.0
In-Reply-To: <91e5cbdf-9d91-fc7f-3fb5-3727d73b1419@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <f24dde77-5fd0-8827-7b93-d0e390f392da@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v4 09/10] s390x/kvm: msi route fixup for
 non-pci
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>
Cc: zyimin@linux.vnet.ibm.com, david@redhat.com, pmorel@linux.vnet.ibm.com, agraf@suse.de, qemu-devel@nongnu.org, borntraeger@de.ibm.com



On 08/21/2017 05:17 PM, Thomas Huth wrote:
> On 21.08.2017 17:10, Halil Pasic wrote:
> [...]
>> The situation is just complicated by the fact that there is code which
>> relies on assert(true) asserting for correctness (e.g. virtio goes so far
>> to make builds with normal asserts disabled fail). Thus for me it's hard
>> to assume that the assertion is guaranteed to be disabled in production.
> 
> FYI: https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg03608.html
> 
>  Thomas
> 

Thanks, I've missed that. With that assumed it becomes either
assert(false) or return -ENODEV but not both.

Regards,
Halil 
