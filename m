Received: from eggs.gnu.org ([2001:4830:134:3::10]:54397)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1fkRfv-0004ar-Vy
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 06:14:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1fkRfr-0000Ba-0S
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 06:14:43 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59950)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1fkRfq-0000B7-IP
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 06:14:38 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w6VA9tKV106945
	for <qemu-devel@nongnu.org>; Tue, 31 Jul 2018 06:14:36 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2kjkqxwj9e-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 31 Jul 2018 06:14:36 -0400
Received: from localhost
	by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Tue, 31 Jul 2018 11:14:33 +0100
References: <20180731090448.36662-1-borntraeger@de.ibm.com>
	<20180731090448.36662-3-borntraeger@de.ibm.com>
	<20180731114438.594dd18b.cohuck@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 31 Jul 2018 12:14:28 +0200
MIME-Version: 1.0
In-Reply-To: <20180731114438.594dd18b.cohuck@redhat.com>
Content-Language: en-US
Message-Id: <e47ecf52-04a0-6724-0d47-6172628ad845@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 2/2] s390x/kvm: add etoken facility
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>, David Hildenbrand <david@redhat.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, Janosch Frank <frankja@linux.vnet.ibm.com>



On 07/31/2018 11:44 AM, Cornelia Huck wrote:
> On Tue, 31 Jul 2018 11:04:48 +0200
> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> 
>> Provide the etoken facility. We need to handle cpu model, migration and
>> clear reset.
>   ^^^^^^^^^^^

Clear reset is the "strong one". Here we do a memset of the env structure.
So this should be cleared along with the other registers.
> 
> Hm, anything special for that? I don't see it in the patch.
> 
>>
>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> Acked-by: Janosch Frank <frankja@linux.ibm.com>
>> ---
>>  target/s390x/cpu.h              |  3 +++
>>  target/s390x/cpu_features.c     |  3 ++-
>>  target/s390x/cpu_features_def.h |  3 ++-
>>  target/s390x/gen-features.c     |  3 ++-
>>  target/s390x/kvm.c              | 11 +++++++++++
>>  target/s390x/machine.c          | 20 +++++++++++++++++++-
>>  6 files changed, 39 insertions(+), 4 deletions(-)
> 
