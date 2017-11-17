Received: from eggs.gnu.org ([2001:4830:134:3::10]:52382)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1eFcB2-0006zM-UO
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 03:39:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1eFcAz-0000hO-RS
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 03:39:08 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51972
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1eFcAz-0000gp-Li
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 03:39:05 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vAH8clMH133663
	for <qemu-devel@nongnu.org>; Fri, 17 Nov 2017 03:38:58 -0500
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2e9tf5csek-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 17 Nov 2017 03:38:58 -0500
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Fri, 17 Nov 2017 08:38:57 -0000
References: <20171116170526.12643-1-david@redhat.com>
	<20171116182335.7168a489.cohuck@redhat.com>
	<20171117091049.4c584ea5.cohuck@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Fri, 17 Nov 2017 09:38:53 +0100
MIME-Version: 1.0
In-Reply-To: <20171117091049.4c584ea5.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <981d9276-2e8d-46e4-ba6c-821cc120fb35@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v1 for-2.11 0/3] s390x: fixes for SIGP and
 DIAG 308
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>



On 11/17/2017 09:10 AM, Cornelia Huck wrote:
> On Thu, 16 Nov 2017 18:23:35 +0100
> Cornelia Huck <cohuck@redhat.com> wrote:
> 
>> On Thu, 16 Nov 2017 18:05:23 +0100
>> David Hildenbrand <david@redhat.com> wrote:
>>
>>> First one also applies to KVM SIGP handling. The other two only
>>> apply to TCG (allowing to IPL from disk with more than 1 VCPU- I
>>> never tested that before).
>>>
>>> David Hildenbrand (3):
>>>   s390x: fix storing CPU status (again)
>>>   s390x/tcg: fix DIAG 308 with > 1 VCPU (single threaded TCG)
>>>   s390x/tcg: fix DIAG 308 with > 1 VCPU (MTTCG)
>>>
>>>  target/s390x/diag.c        | 4 ----
>>>  target/s390x/helper.c      | 2 +-
>>>  target/s390x/misc_helper.c | 2 ++
>>>  3 files changed, 3 insertions(+), 5 deletions(-)
>>>   
>>
>> Thanks, queued to s390-fixes.
> 
> Patch 2 still needs discussion, I think. I'll dequeue it again and
> leave 1 + 3.

Yes.
Patch1 is certainly good and relevant for 2.11.
Patch2 needs more time as it has potential for adding regression
No opinion on Patch3
