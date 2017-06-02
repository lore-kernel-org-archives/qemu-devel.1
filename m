Received: from eggs.gnu.org ([2001:4830:134:3::10]:32910)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jjherne@linux.vnet.ibm.com>) id 1dGnwp-00051A-0b
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 10:53:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jjherne@linux.vnet.ibm.com>) id 1dGnwk-0006wp-5Q
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 10:53:07 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34183
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jjherne@linux.vnet.ibm.com>)
	id 1dGnwj-0006wa-Un
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 10:53:02 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v52EmcXo077858
	for <qemu-devel@nongnu.org>; Fri, 2 Jun 2017 10:53:00 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2au9cj25f5-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 02 Jun 2017 10:53:00 -0400
Received: from localhost
	by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <jjherne@linux.vnet.ibm.com>;
	Fri, 2 Jun 2017 10:52:59 -0400
Reply-To: jjherne@linux.vnet.ibm.com
References: <20170531193434.6918-1-david@redhat.com>
	<b6efd549-0cab-ed67-c39c-b62b833cfef8@de.ibm.com>
From: "Jason J. Herne" <jjherne@linux.vnet.ibm.com>
Date: Fri, 2 Jun 2017 10:52:55 -0400
MIME-Version: 1.0
In-Reply-To: <b6efd549-0cab-ed67-c39c-b62b833cfef8@de.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Message-Id: <d913696a-6a37-5880-f267-17f0d46ba690@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v1 0/2] s390x cpu model improvements for KVM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: rth@twiddle.net, Aurelien Jarno <aurelien@aurel32.net>, thuth@redhat.com, Cornelia Huck <cornelia.huck@de.ibm.com>

On 06/01/2017 06:10 AM, Christian Borntraeger wrote:
> On 05/31/2017 09:34 PM, David Hildenbrand wrote:
>> We should properly forward the CPUID format bit. CPU model
>> detection on systems without IBC might select a model with a wrong
>> CPU type (esp. selecting the business class (BC) model on an enterprise
>> class (EC) machine). So let's improve that, too.
>>
>> I am also preparing a patch to properly indicate the correct cpu type
>> to the guest via STORE CPU ID and STORE HYPERVISOR INFORMATION for the
>> TCG case, but will send that separately after I tested it (want to write a
>> kvm-unit-test for STORE CPU ID).
>>
>> David Hildenbrand (2):
>>   s390x/cpumodel: take care of the cpuid format bit for KVM
>>   s390x/cpumodel: improve defintion search without an IBC
>>
>>  target/s390x/cpu_models.c | 10 ++++++++++
>>  target/s390x/cpu_models.h | 10 +++++++---
>>  target/s390x/kvm.c        |  1 +
>>  3 files changed, 18 insertions(+), 3 deletions(-)
>>
>
> I like both patches in terms of "yes, its the right thing to do".
> Jason can you have a look? I might need some days to catch up
> with other things before I can look into the patches.
>

David answered the one question I had. So, as far as I can see, this
is ok.

Acked-by: Jason J. Herne <jjherne@linux.vnet.ibm.com>

-- 
-- Jason J. Herne (jjherne@linux.vnet.ibm.com)
