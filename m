Received: from eggs.gnu.org ([2001:4830:134:3::10]:37372)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mihajlov@linux.vnet.ibm.com>) id 1ej00t-0006iW-JH
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 04:58:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mihajlov@linux.vnet.ibm.com>) id 1ej00p-0007ny-8G
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 04:58:07 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50688)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mihajlov@linux.vnet.ibm.com>)
	id 1ej00o-0007nU-VH
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 04:58:03 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w169tVFB118738
	for <qemu-devel@nongnu.org>; Tue, 6 Feb 2018 04:58:01 -0500
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2fy96mas3a-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 06 Feb 2018 04:58:01 -0500
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mihajlov@linux.vnet.ibm.com>;
	Tue, 6 Feb 2018 09:57:59 -0000
References: <1517864246-11101-1-git-send-email-walling@linux.vnet.ibm.com>
	<1517864246-11101-6-git-send-email-walling@linux.vnet.ibm.com>
	<3389032a-caf2-8d9a-ccf0-f7ce36b389d6@de.ibm.com>
From: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
Date: Tue, 6 Feb 2018 10:57:50 +0100
MIME-Version: 1.0
In-Reply-To: <3389032a-caf2-8d9a-ccf0-f7ce36b389d6@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Message-Id: <8c7d5b99-bc38-1ed2-ca7c-e6a8fac65b32@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v5 05/12] s390-ccw: move auxiliary IPL data
 to separate location
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, "Collin L. Walling" <walling@linux.vnet.ibm.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: frankja@linux.vnet.ibm.com, cohuck@redhat.com, thuth@redhat.com, david@redhat.com, alifm@linux.vnet.ibm.com, eblake@redhat.com

On 06.02.2018 10:45, Christian Borntraeger wrote:
> On 02/05/2018 09:57 PM, Collin L. Walling wrote:
>> The s390-ccw firmware needs some information in support of the
>> boot process which is not available on the native machine.
>> Examples are the netboot firmware load address and now the
>> boot menu parameters.
>>
>> While storing that data in unused fields of the IPL parameter block
>> works, that approach could create problems if the parameter block
>> definition should change in the future. Because then a guest could
>> overwrite these fields using the set IPLB diagnose.
>>
>> In fact the data in question is of more global nature and not really
>> tied to an IPL device, so separating it is rather logical.
>>
>> This commit introduces a new structure to hold firmware relevant
>> IPL parameters set by QEMU. The data is stored at location 204 (dec)
>> and can contain up to 7 32-bit words. This area is available to
>> programming in the z/Architecture Principles of Operation and
>> can thus safely be used by the firmware until the IPL has completed.
> 
> This content is set by QEMU/the ccw bios on every IPL, so we do not
> have to change anything for migration. Correct?
> 
Hm ... this is true for the netboot start address, but I am not sure
about the boot menu parameters added in a follow on patch. I'll comment
there...
[...]
-- 
Regards,
 Viktor Mihajlovski
