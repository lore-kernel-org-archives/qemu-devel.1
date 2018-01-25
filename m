Received: from eggs.gnu.org ([2001:4830:134:3::10]:58489)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1eejmF-0001Gl-NI
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 10:49:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1eejmC-0003Jz-M6
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 10:49:23 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:32814
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <walling@linux.vnet.ibm.com>)
	id 1eejmC-0003JL-HQ
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 10:49:20 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w0PFiSd7127682
	for <qemu-devel@nongnu.org>; Thu, 25 Jan 2018 10:49:19 -0500
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2fqgdn5spv-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 25 Jan 2018 10:49:19 -0500
Received: from localhost
	by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <walling@linux.vnet.ibm.com>;
	Thu, 25 Jan 2018 10:49:18 -0500
References: <1516732013-18272-1-git-send-email-walling@linux.vnet.ibm.com>
	<1516732013-18272-8-git-send-email-walling@linux.vnet.ibm.com>
	<6d81c288-2b93-35b4-fb27-24276342089d@redhat.com>
From: "Collin L. Walling" <walling@linux.vnet.ibm.com>
Date: Thu, 25 Jan 2018 10:49:15 -0500
MIME-Version: 1.0
In-Reply-To: <6d81c288-2b93-35b4-fb27-24276342089d@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Message-Id: <994e3f5e-24e1-834a-5519-775a819d73c8@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v4 07/10] s390-ccw: read
 stage2 boot loader data to find menu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: alifm@linux.vnet.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, david@redhat.com, frankja@linux.vnet.ibm.com

On 01/25/2018 10:25 AM, Thomas Huth wrote:
> On 23.01.2018 19:26, Collin L. Walling wrote:
>> Read the stage2 boot loader data block-by-block. We scan the
>> current block for the string "zIPL" to detect the start of the
>> boot menu banner. We then load the adjacent blocks (previous
>> block and next block) to account for the possibility of menu
>> data spanning multiple blocks.
>>
>> Signed-off-by: Collin L. Walling <walling@linux.vnet.ibm.com>
>> ---
>>   pc-bios/s390-ccw/bootmap.c | 94 +++++++++++++++++++++++++++++++++++++++++++---
>>   pc-bios/s390-ccw/bootmap.h |  1 +
>>   pc-bios/s390-ccw/menu.c    |  5 +++
>>   pc-bios/s390-ccw/menu.h    |  1 +
>>   4 files changed, 96 insertions(+), 5 deletions(-)
> Looks good to me now!
>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
>
Thanks! The only change I plan on is moving the Stage1b struct declaration
to this patch, as per your suggestion on another patch review.

-- 
- Collin L Walling
