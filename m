Received: from eggs.gnu.org ([2001:4830:134:3::10]:39481)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1gA9cQ-0000IK-PZ
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 04:13:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1gA9cL-0000SQ-On
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 04:13:22 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49778
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1gA9cL-0000Ro-DY
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 04:13:17 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w9A89ghW005433
	for <qemu-devel@nongnu.org>; Wed, 10 Oct 2018 04:13:15 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2n1bxpchw9-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 10 Oct 2018 04:13:15 -0400
Received: from localhost
	by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Wed, 10 Oct 2018 09:13:12 +0100
References: <20181009175226.22138-1-akrowiak@linux.vnet.ibm.com>
	<20181009175226.22138-3-akrowiak@linux.vnet.ibm.com>
	<20181010101129.409d6e48.cohuck@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 10 Oct 2018 10:12:58 +0200
MIME-Version: 1.0
In-Reply-To: <20181010101129.409d6e48.cohuck@redhat.com>
Content-Language: en-US
Message-Id: <6fcd52a8-10db-d539-f723-5ada88a625ea@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v10 2/6] s390x/cpumodel: Set
 up CPU model for AP device support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Cc: peter.maydell@linaro.org, fiuczy@linux.ibm.com, david@redhat.com, pmorel@linux.vnet.ibm.com, qemu-devel@nongnu.org, eskultet@redhat.com, agraf@suse.de, jjherne@linux.vnet.ibm.com, mimu@linux.ibm.com, Tony Krowiak <akrowiak@linux.ibm.com>, heiko.carstens@de.ibm.com, eric.auger@redhat.com, alex.williamson@redhat.com, bjsdjshi@linux.vnet.ibm.com, rth@twiddle.net, mjrosato@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, alifm@linux.vnet.ibm.com, qemu-s390x@nongnu.org, schwidefsky@de.ibm.com, pbonzini@redhat.com



On 10/10/2018 10:11 AM, Cornelia Huck wrote:
> On Tue,  9 Oct 2018 13:52:22 -0400
> Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:
> 
> (...)
> 
>> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
> 
> This patch (and the others) have a mismatch between the author (address
> with vnet), and the s-o-b (address without vnet). While these are
> obviously the same person, the addresses really should match.
> 
> Should I fix up the author to use the vnet-less address?

yes please.

> 
>> Tested-by: Pierre Morel<pmorel@linux.ibm.com>
>> ---
>>  target/s390x/cpu_features.c     | 3 +++
>>  target/s390x/cpu_features_def.h | 3 +++
>>  target/s390x/cpu_models.c       | 2 ++
>>  target/s390x/gen-features.c     | 3 +++
>>  4 files changed, 11 insertions(+)
> 
