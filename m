Received: from eggs.gnu.org ([2001:4830:134:3::10]:40272)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dvNh6-0002bj-Js
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 09:08:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dvNh3-0004ds-AZ
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 09:08:36 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49672)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1dvNh3-0004dI-1W
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 09:08:33 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8MD6FHg069736
	for <qemu-devel@nongnu.org>; Fri, 22 Sep 2017 09:08:28 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2d52bquf38-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 22 Sep 2017 09:08:28 -0400
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Fri, 22 Sep 2017 14:08:26 +0100
From: Christian Borntraeger <borntraeger@de.ibm.com>
References: <20170922083855.102341-1-borntraeger@de.ibm.com>
	<c2bb9668-3056-c0bf-a794-878f1e4a058c@de.ibm.com>
Date: Fri, 22 Sep 2017 15:08:22 +0200
MIME-Version: 1.0
In-Reply-To: <c2bb9668-3056-c0bf-a794-878f1e4a058c@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <b86a3d64-6f04-3467-431c-834a24e03375@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH/RFC 0/3] ais fixups for 2.11
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Yi Min Zhao <zyimin@linux.vnet.ibm.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, qemu-devel <qemu-devel@nongnu.org>, David Hildenbrand <david@redhat.com>, "Jason J . Herne" <jjherne@linux.vnet.ibm.com>



On 09/22/2017 01:27 PM, Christian Borntraeger wrote:
> On 09/22/2017 10:38 AM, Christian Borntraeger wrote:
>> Conny, this seem to work on KVM (needs more testing and review).
>> Can you check what happens with TCG?
>>
>> Patch 1 is the known base patch,
>> Patch 2 fixes the ais detection to be based on the flic interfaces
>> Patch 3 disables ais for all compat machines <= 2.10
>>
>>
>>
>> Christian Borntraeger (3):
>>   s390x/ais: disable ais facility as it is broken
>>   s390x/ais: enable ais when migration is available
>>   s390x/ais: disable ais for compat machines
>>
>>  hw/intc/s390_flic.c                | 11 +++++++++--
>>  hw/intc/s390_flic_kvm.c            | 10 +++++++++-
>>  hw/s390x/s390-virtio-ccw.c         | 18 ++++++++++++++++--
>>  include/hw/s390x/s390-virtio-ccw.h |  3 +++
>>  include/hw/s390x/s390_flic.h       |  1 +
>>  target/s390x/cpu_models.c          |  6 ++++++
>>  target/s390x/kvm.c                 |  3 +--
>>  7 files changed, 45 insertions(+), 7 deletions(-)
>>
> 
> FWIW, with patch 1 backported to 2.10 and patches 1,2,3 on top of current master (as 211)
> I started some crossmigration test and successfully tested
> the following combinations with KVM and -cpu host on an 4.13 kernel

This was on the same host migration in a file and back from a file.
On the same host kenrel 4.11.12 (no AIS support in KVM at all)
and 4.12.14  (AIS support, but no migration) also survived the test matrix
for migration into/from file.
