Received: from eggs.gnu.org ([2001:4830:134:3::10]:50721)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1ePmh3-00015M-R6
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 04:54:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1ePmgy-0004Ko-Al
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 04:54:13 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50522
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1ePmgy-0004KU-5T
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 04:54:08 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vBF9oWUR059220
	for <qemu-devel@nongnu.org>; Fri, 15 Dec 2017 04:54:05 -0500
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2ev8nr0mrf-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 15 Dec 2017 04:54:05 -0500
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Fri, 15 Dec 2017 09:54:03 -0000
References: <20171214171004.25058-1-cohuck@redhat.com>
	<CAFEAcA8tY9=jtsw-MtjWTceLizvpH8oui_+6xf7V6K5o5BLf-A@mail.gmail.com>
	<cf44ca76-d581-8d96-3e2b-78c698dda446@de.ibm.com>
	<1a45723d-3731-17e9-98af-8d52312915e2@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Fri, 15 Dec 2017 10:53:59 +0100
MIME-Version: 1.0
In-Reply-To: <1a45723d-3731-17e9-98af-8d52312915e2@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <e5f8d9d6-82e2-a59f-eedd-dc93526195d2@de.ibm.com>
Subject: Re: [Qemu-devel] [qemu-s390x] [PULL 00/46] First batch of s390x
 patches for 2.12
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Cornelia Huck <cohuck@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, Alexander Graf <agraf@suse.de>, QEMU Developers <qemu-devel@nongnu.org>, qemu-s390x@nongnu.org, Richard Henderson <rth@twiddle.net>



On 12/15/2017 10:53 AM, David Hildenbrand wrote:
> 
>> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
>> index 80e753a5ef..9abb8de9f9 100644
>> --- a/hw/s390x/s390-virtio-ccw.c
>> +++ b/hw/s390x/s390-virtio-ccw.c
>> @@ -172,9 +172,10 @@ static void s390_memory_init(ram_addr_t mem_size)
>>      name = g_strdup_printf("s390.ram");
>>      while (mem_size) {
>>          MemoryRegion *ram = g_new(MemoryRegion, 1);
>> +       unsigned long long size = mem_size;
>>  
>>          /* KVM does not allow memslots >= 8 TB */
>> -        chunk = MIN(mem_size, KVM_SLOT_MAX_BYTES);
>> +        chunk = MIN(size, KVM_SLOT_MAX_BYTES);
> 
> directly cast inline?
As I said, this still triggers the warning. gcc 7 is too clever.
