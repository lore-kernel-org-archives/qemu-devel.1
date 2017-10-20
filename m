Received: from eggs.gnu.org ([2001:4830:134:3::10]:43091)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1e5WOf-0007e1-PP
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 08:27:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1e5WOa-0005Jx-Mz
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 08:27:29 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51308)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1e5WOa-0005Jm-EV
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 08:27:24 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9KCQCIB007738
	for <qemu-devel@nongnu.org>; Fri, 20 Oct 2017 08:27:20 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2dqg1mbt8d-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 20 Oct 2017 08:27:20 -0400
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Fri, 20 Oct 2017 13:27:17 +0100
References: <20171020102517.28385-1-borntraeger@de.ibm.com>
	<20171020133100.1dcec567.cohuck@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Fri, 20 Oct 2017 14:27:12 +0200
MIME-Version: 1.0
In-Reply-To: <20171020133100.1dcec567.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <83d262ee-47e8-61c7-77cd-bbfc53d692c5@de.ibm.com>
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
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, Richard Henderson <rth@twiddle.net>, Bjoern Walk <bwalk@linux.vnet.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, "Jason J . Herne" <jjherne@linux.vnet.ibm.com>, "Collin L. Walling" <walling@linux.vnet.ibm.com>



On 10/20/2017 01:31 PM, Cornelia Huck wrote:
> On Fri, 20 Oct 2017 12:25:17 +0200
> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> 
>> From: "Collin L. Walling" <walling@linux.vnet.ibm.com>
>>
>> The sclp console in the s390 bios writes raw data,
>> leading console emulators (such as virsh console) to
>> treat a new line ('\n') as just a new line instead
>> of as a Unix line feed. Because of this, output
>> appears in a "stair case" pattern.
>>
>> Let's print \r\n on every occurrence of a new line
>> in the string passed to write to amend this issue.
>>
>> This is in sync with the guest Linux code in
>> drivers/s390/char/sclp_vt220.c which also does a line feed
>> conversion  in the console part of the driver. 
>>
>> This fixes the s390-ccw and s390-netboot output like
>> $ virsh start test --console
>> Domain test started
>> Connected to domain test
>> Escape character is ^]
>> Network boot starting...
>>                           Using MAC address: 02:01:02:03:04:05
>>                                                                 Requesting information via DHCP:  010
>>
>> Signed-off-by: Collin L. Walling <walling@linux.vnet.ibm.com>
>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> ---
>>  pc-bios/s390-ccw/s390-ccw.h |  3 +++
>>  pc-bios/s390-ccw/sclp.c     | 17 ++++++++++++++---
>>  2 files changed, 17 insertions(+), 3 deletions(-)
> 
> I'd defer that to a second pullreq before softfreeze where we can
> collect the stragglers (currently building a pullreq). And I'd also
> like to delegate that second pullreq to you, as I'll be busy/offline
> after KVM Forum.

Sure I can do that in a 2nd pull req after KVM forum.
