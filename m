Received: from eggs.gnu.org ([2001:4830:134:3::10]:39403)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1e7EfE-0004qS-RU
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 01:55:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1e7EfB-0001ac-NB
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 01:55:40 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39510
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1e7EfB-0001X1-IY
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 01:55:37 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9P5sxXp143677
	for <qemu-devel@nongnu.org>; Wed, 25 Oct 2017 01:55:31 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2dtk1nf4pf-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 25 Oct 2017 01:55:31 -0400
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Wed, 25 Oct 2017 06:55:29 +0100
References: <20171020102517.28385-1-borntraeger@de.ibm.com>
	<67132f0e-cc4d-312f-140a-1966f0d877c6@suse.de>
	<7a65ad71-9c6d-ee0a-851c-ab6bd9806180@de.ibm.com>
	<b4a828b6-b563-55f0-2952-8a3447a8a30a@de.ibm.com>
	<9292cbd5-49b5-c9da-cc34-33466818a02e@linux.vnet.ibm.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 25 Oct 2017 07:55:25 +0200
MIME-Version: 1.0
In-Reply-To: <9292cbd5-49b5-c9da-cc34-33466818a02e@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <551b7d82-e0da-4dfd-f14f-96df98cae392@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] s390-ccw: print carriage return with new
 lines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Farhan Ali <alifm@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cohuck@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, Bjoern Walk <bwalk@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel <qemu-devel@nongnu.org>, Halil Pasic <pasic@linux.vnet.ibm.com>, "Jason J . Herne" <jjherne@linux.vnet.ibm.com>, "Collin L. Walling" <walling@linux.vnet.ibm.com>, Richard Henderson <rth@twiddle.net>

Collin,

can you take care of the comments and send out a new version?

On 10/20/2017 03:48 PM, Farhan Ali wrote:
> 
> 
> On 10/20/2017 07:02 AM, Christian Borntraeger wrote:
>> --- a/pc-bios/s390-ccw/sclp.c
>> +++ b/pc-bios/s390-ccw/sclp.c
>> @@ -83,7 +83,7 @@ long write(int fd, const void *str, size_t len)
>>          return -EIO;
>>      }
>>
>> -    for (p = str; *p; ++p) {
>> +    for (p = str; len ; ++p, len--) {
>>          if (data_len > SCCB_DATA_LEN - 1) {
>>              return -EFBIG;
>>          }
>>
>>
>>
> The write function returns len, wouldn't this change make write return 0?
