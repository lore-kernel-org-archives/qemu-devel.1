Received: from eggs.gnu.org ([2001:4830:134:3::10]:37141)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <akrowiak@linux.vnet.ibm.com>) id 1fGP9d-00069N-5H
	for qemu-devel@nongnu.org; Wed, 09 May 2018 09:29:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <akrowiak@linux.vnet.ibm.com>) id 1fGP9Y-0006O4-75
	for qemu-devel@nongnu.org; Wed, 09 May 2018 09:29:13 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39648)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <akrowiak@linux.vnet.ibm.com>)
	id 1fGP9X-0006Jg-Sv
	for qemu-devel@nongnu.org; Wed, 09 May 2018 09:29:08 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w49DRbk8091853
	for <qemu-devel@nongnu.org>; Wed, 9 May 2018 09:29:05 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2hv1qnrh9t-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 09 May 2018 09:29:04 -0400
Received: from localhost
	by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <akrowiak@linux.vnet.ibm.com>;
	Wed, 9 May 2018 07:29:04 -0600
References: <1525782303-16940-1-git-send-email-akrowiak@linux.vnet.ibm.com>
	<1525782303-16940-7-git-send-email-akrowiak@linux.vnet.ibm.com>
	<20180508144608.4c4e8180.cohuck@redhat.com>
From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Date: Wed, 9 May 2018 09:28:13 -0400
MIME-Version: 1.0
In-Reply-To: <20180508144608.4c4e8180.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Message-Id: <037620fe-5f35-6db7-b5d2-e48aadf2651e@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v5 6/6] MAINTAINERS: add entries for AP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, david@redhat.com, bjsdjshi@linux.vnet.ibm.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, eskultet@redhat.com, berrange@redhat.com, alex.williamson@redhat.com, eric.auger@redhat.com, pbonzini@redhat.com, peter.maydell@linaro.org, agraf@suse.de, rth@twiddle.net

On 05/08/2018 08:46 AM, Cornelia Huck wrote:
> On Tue,  8 May 2018 08:25:03 -0400
> Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:
>
>> Added entries for the s390 adjunct processor (AP) support.
>>
>> Signed-off-by: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
>> ---
>>   MAINTAINERS |   14 ++++++++++++++
>>   1 files changed, 14 insertions(+), 0 deletions(-)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 459e359..c9e8d7b 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -82,6 +82,7 @@ S390
>>   M: Cornelia Huck <cohuck@redhat.com>
>>   S: Supported
>>   F: default-configs/s390x-softmmu.mak
>> +F: docs/vfio-ap.txt
>>   F: gdb-xml/s390*.xml
>>   F: hw/char/sclp*.[hc]
>>   F: hw/char/terminal3270.c
>> @@ -89,6 +90,7 @@ F: hw/intc/s390_flic.c
>>   F: hw/intc/s390_flic_kvm.c
>>   F: hw/s390x/
>>   F: hw/vfio/ccw.c
>> +F: hw/vfio/ap.c
>>   F: hw/watchdog/wdt_diag288.c
>>   F: include/hw/s390x/
>>   F: include/hw/watchdog/wdt_diag288.h
>> @@ -1152,6 +1154,18 @@ F: include/hw/s390x/s390-ccw.h
>>   T: git git://github.com/cohuck/qemu.git s390-next
>>   L: qemu-s390x@nongnu.org
>>   
>> +vfio-ap
>> +M: Christian Borntraeger <borntraeger@de.ibm.com>
>> +M: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
>> +M: Halil Pasic <pasic@linux.vnet.ibm.com>
>> +M: Pierre Morel <pmorel@linux.vnet.ibm.com>
> Dumb question: Aren't you folks dropping the 'vnet' part in the future?

I hadn't heard that, but that doesn't necessarily mean it is not the case.

>
>> +S: Maintained
>> +F: hw/vfio/ap.c
>> +F: hw/s390x/ap-device.c
>> +F: include/hw/s390x/ap-device.h
>> +F: docs/vfio-ap.txt
>> +L: qemu-s390x@nongnu.org
>> +
>>   vhost
>>   M: Michael S. Tsirkin <mst@redhat.com>
>>   S: Supported
