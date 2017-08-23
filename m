Received: from eggs.gnu.org ([2001:4830:134:3::10]:35932)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dkUqd-00011Y-F7
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 08:33:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dkUqX-0007GE-L8
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 08:33:27 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55049
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1dkUqX-0007Fy-G5
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 08:33:21 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v7NCSqSh119967
	for <qemu-devel@nongnu.org>; Wed, 23 Aug 2017 08:33:20 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2ch4ker1ay-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 23 Aug 2017 08:33:20 -0400
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Wed, 23 Aug 2017 13:33:18 +0100
References: <1503483383-199649-1-git-send-email-borntraeger@de.ibm.com>
	<20170823143128.7cc7ae68.cohuck@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 23 Aug 2017 14:33:13 +0200
MIME-Version: 1.0
In-Reply-To: <20170823143128.7cc7ae68.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <cc872f31-8ea6-e8ab-8d92-d034f3ff2497@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v3] configure: enable --s390-pgste linker
 option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, Janosch Frank <frankja@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Christian Ehrhardt <christian.ehrhardt@canonical.com>, Dan Horak <dhorak@redhat.com>



On 08/23/2017 02:31 PM, Cornelia Huck wrote:
> On Wed, 23 Aug 2017 12:16:23 +0200
> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> 
>> KVM guests on s390 need a different page table layout than normal
>> processes (2kb page table + 2kb page status extensions vs 2kb page table
>> only). As of today this has to be enabled via the vm.allocate_pgste
>> sysctl.
>>
>> Newer kernels (>= 4.12) on s390 check for an S390_PGSTE program header
>> and enable the pgste page table extensions in that case. This makes the
>> vm.allocate_pgste sysctl unnecessary. We enable this program header for
>> the s390 system emulation (qemu-system-s390x) if we build on s390
>> - for s390 system emulation
>> - the linker supports --s390-pgste (binutils >= 2.29)
>> - KVM is enabled
>>
>> This will allow distributions to disable the global vm.allocate_pgste
>> sysctl, which will improve the page table allocation for non KVM
>> processes as only 2kb chunks are necessary.
>>
>> Cc: Christian Ehrhardt <christian.ehrhardt@canonical.com>
>> Cc: Alexander Graf <agraf@suse.de>
>> Cc: Dan Horak <dhorak@redhat.com>
>> Cc: David Hildenbrand <david@redhat.com>
>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> Acked-by: Janosch Frank <frankja@linux.vnet.ibm.com>
>> ---
>> V1->V2:
>> 	- provide ld_has function
>> 	- use ld_has to replace some open coded variants
>> 	- check target arch and arch for s390
>> 	- check for s390x before calling the linker
>> V2->V3: 
>> 	- fix typos
>>  configure | 21 ++++++++++++++++++++-
>>  1 file changed, 20 insertions(+), 1 deletion(-)
> 
> Looks sane.
> 
> I guess I'll wait for some more Acks or R-bs and then queue it to
> s390-next.

Sure. Looks like I forgot to add Thomas/Davids R-bs, so please add those.
