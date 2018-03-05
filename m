Received: from eggs.gnu.org ([2001:4830:134:3::10]:34611)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1espnh-00089E-24
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 08:05:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1espnd-0005b7-8d
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 08:05:09 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55444)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1espnd-0005Zg-0g
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 08:05:05 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w25D0OBH008137
	for <qemu-devel@nongnu.org>; Mon, 5 Mar 2018 08:05:03 -0500
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2gh5djav2y-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 05 Mar 2018 08:05:03 -0500
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Mon, 5 Mar 2018 13:05:01 -0000
References: <20180228195320.165230-1-borntraeger@de.ibm.com>
	<20180305135414.11681139.cohuck@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 5 Mar 2018 14:04:57 +0100
MIME-Version: 1.0
In-Reply-To: <20180305135414.11681139.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <9468bb07-8863-bf2a-80eb-81222afafc27@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 1/1] s390/kvm: implement clearing part of
 IPL clear
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-s390x <qemu-s390x@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>



On 03/05/2018 01:54 PM, Cornelia Huck wrote:
> On Wed, 28 Feb 2018 19:53:20 +0000
> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> 
>> When a guests reboots with diagnose 308 subcode 3 it requests the memory
>> to be cleared. We did not do it so far. This does not only violate the
>> architecture, it also misses the chance to free up that memory on
>> reboot, which would help on host memory over commitment.  By using
>> ram_block_discard_range we can cover both cases.
>>
>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> ---
>>  target/s390x/kvm.c | 19 +++++++++++++++++++
>>  1 file changed, 19 insertions(+)
> 
> So, this needs more thought (and additional kernel changes)? (Trying to
> pick up patches that make sense for 2.12.)

Yes, lets defer this.
