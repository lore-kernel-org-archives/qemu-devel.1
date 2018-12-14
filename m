Received: from eggs.gnu.org ([2001:4830:134:3::10]:45222)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmorel@linux.ibm.com>) id 1gXq5K-0007sF-Ie
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 11:13:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmorel@linux.ibm.com>) id 1gXq5E-00086t-R7
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 11:13:06 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46642
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pmorel@linux.ibm.com>)
	id 1gXq5A-00083h-QK
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 11:12:58 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	wBEGAbY4049835
	for <qemu-devel@nongnu.org>; Fri, 14 Dec 2018 11:12:53 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2pcf4f29jw-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 14 Dec 2018 11:12:53 -0500
Received: from localhost
	by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pmorel@linux.ibm.com>;
	Fri, 14 Dec 2018 16:12:51 -0000
Reply-To: pmorel@linux.ibm.com
References: <1544796678-12736-1-git-send-email-pmorel@linux.ibm.com>
	<20181214152041.0ba093a0.cohuck@redhat.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Date: Fri, 14 Dec 2018 17:12:46 +0100
MIME-Version: 1.0
In-Reply-To: <20181214152041.0ba093a0.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <71510d2f-5c91-c499-7d2f-ab4694a2d2c2@linux.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3] s390x/pci: add common function
 measurement block
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: walling@linux.ibm.com, borntraeger@de.ibm.com, rth@twiddle.net, david@redhat.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, pasic@linux.ibm.com, thuth@redhat.com

On 14/12/2018 15:20, Cornelia Huck wrote:
> On Fri, 14 Dec 2018 15:11:18 +0100
> Pierre Morel <pmorel@linux.ibm.com> wrote:
>=20
>> From: Yi Min Zhao <zyimin@linux.ibm.com>
>>
>> Common function measurement block is used to report zPCI internal
>> counters of successful pcilg/stg/stb and rpcit instructions to
>> a memory location provided by the program.
>>
>> This patch introduces a new ZpciFmb structure and schedules a timer
>> callback to copy the zPCI measures to the FMB in the guest memory
>> at an interval time set to 4s by default.
>>
>> An error while attemping to update the FMB, would generated an error
>> event to the guest.
>>
>> The pcilg/stg/stb and rpcit interception handlers issue, increase
>> the related counter on success.
>> The guest shall pass a null FMBA (FMB address) in the FIB (Function
>> Information Block) when it issues a Modify PCI Function Control
>> instrcuction to switch off FMB and stop the corresponding timer.
>>
>> Signed-off-by: Yi Min Zhao <zyimin@linux.ibm.com>
>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>> ---
>>   hw/s390x/s390-pci-bus.c  |   4 +-
>>   hw/s390x/s390-pci-bus.h  |  29 ++++++++++
>>   hw/s390x/s390-pci-inst.c | 138 +++++++++++++++++++++++++++++++++++++=
++++++++--
>>   hw/s390x/s390-pci-inst.h |   1 +
>>   4 files changed, 168 insertions(+), 4 deletions(-)
>=20
> Are there any changes in there other than the endianness handling?
>=20

Hum, yes.
Forget this patch, I post a new one with a complete changelog.
I also noticed that I forgot an error report.

Regards,
Pierre


--=20
Pierre Morel
Linux/KVM/QEMU in B=C3=B6blingen - Germany
