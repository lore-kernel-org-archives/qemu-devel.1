Received: from eggs.gnu.org ([2001:4830:134:3::10]:41570)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1ec9c1-0004zW-JJ
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 07:48:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1ec9bx-0006oT-Lx
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 07:48:09 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43472)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1ec9bx-0006o7-CX
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 07:48:05 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w0ICkbDt082593
	for <qemu-devel@nongnu.org>; Thu, 18 Jan 2018 07:48:00 -0500
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2fjtk3v2us-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 18 Jan 2018 07:48:00 -0500
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Thu, 18 Jan 2018 12:47:57 -0000
References: <20180118085628.40798-1-borntraeger@de.ibm.com>
	<20180118125322.252929dc.cohuck@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Thu, 18 Jan 2018 13:47:54 +0100
MIME-Version: 1.0
In-Reply-To: <20180118125322.252929dc.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <06e97f00-710a-c893-101f-0a1c6aaa5575@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v3 0/3] s390x/kvm: implement new
 hardware/firmware features
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>, Alexander Graf <agraf@suse.de>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, Richard Henderson <rth@twiddle.net>, Janosch Frank <frankja@linux.vnet.ibm.com>, Halil Pasic <pasic@linux.vnet.ibm.com>



On 01/18/2018 12:53 PM, Cornelia Huck wrote:
> On Thu, 18 Jan 2018 09:56:25 +0100
> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> 
>> We want to provide more hw features to guests, namely the new bpb
>> control as well as other transparent facilities that might be
>> introduced by firmware updates (e.g. the stfle facility 81).
>>
>> See the kernel discussion for the KVM side
>> https://www.spinics.net/lists/kernel/msg2700551.html
>>
>> v2->v3: - use bool for bpbc
>> 	- sort cpu facilities
>> v1->v2: - style and comment fixes
>> 	- drop transparent facility patch
>> 	- add patch to introduce facility 81
>>
>> Christian Borntraeger (3):
>>   header sync
>>   s390x/kvm: Handle bpb feature
>>   s390x/kvm: provide stfle.81
>>
>>  linux-headers/asm-s390/kvm.h    |  9 ++++-----
>>  linux-headers/linux/kvm.h       |  5 +++--
>>  target/s390x/cpu.c              |  1 +
>>  target/s390x/cpu.h              |  1 +
>>  target/s390x/cpu_features.c     |  2 ++
>>  target/s390x/cpu_features_def.h |  2 ++
>>  target/s390x/gen-features.c     |  2 ++
>>  target/s390x/kvm.c              | 14 ++++++++++++++
>>  target/s390x/machine.c          | 17 +++++++++++++++++
>>  9 files changed, 46 insertions(+), 7 deletions(-)
>>
> 
> Thanks, I've queued this. Once the bpb code lands in Linux, I'll
> replace patch 1 with a proper header sync and push to s390-next.

Have the x86 features been marked as stable? If the answer is yes,
shall we mark these patches for stable as well?
