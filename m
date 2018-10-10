Received: from eggs.gnu.org ([2001:4830:134:3::10]:48423)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <akrowiak@linux.ibm.com>) id 1gAGkD-00047R-6K
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 11:49:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <akrowiak@linux.ibm.com>) id 1gAGkA-0001t1-1K
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 11:49:53 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58194)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <akrowiak@linux.ibm.com>)
	id 1gAGk9-0001sR-NX
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 11:49:49 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w9AFnc8o060977
	for <qemu-devel@nongnu.org>; Wed, 10 Oct 2018 11:49:48 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2n1jwxvm3u-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 10 Oct 2018 11:49:48 -0400
Received: from localhost
	by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <akrowiak@linux.ibm.com>;
	Wed, 10 Oct 2018 09:49:47 -0600
References: <20181009175226.22138-1-akrowiak@linux.vnet.ibm.com>
	<20181009175226.22138-6-akrowiak@linux.vnet.ibm.com>
	<20181010112124.415a2011.cohuck@redhat.com>
From: Tony Krowiak <akrowiak@linux.ibm.com>
Date: Wed, 10 Oct 2018 11:49:35 -0400
MIME-Version: 1.0
In-Reply-To: <20181010112124.415a2011.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <33d4aa3a-cd41-13f2-a90b-56d0b4f186bd@linux.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v10 5/6] s390x/vfio: ap: Introduce VFIO AP
 device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, david@redhat.com, bjsdjshi@linux.vnet.ibm.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, eskultet@redhat.com, berrange@redhat.com, alex.williamson@redhat.com, eric.auger@redhat.com, pbonzini@redhat.com, peter.maydell@linaro.org, agraf@suse.de, rth@twiddle.net, fiuczy@linux.ibm.com, mimu@linux.ibm.com

On 10/10/2018 05:21 AM, Cornelia Huck wrote:
> On Tue,  9 Oct 2018 13:52:25 -0400
> Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:
> 
> 
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 97e8ed808bc0..29041da69237 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -1209,6 +1209,7 @@ F: hw/s390x/ap-device.c
>>   F: hw/s390x/ap-bridge.c
>>   F: include/hw/s390x/ap-device.h
>>   F: include/hw/s390x/ap-bridge.h
>> +F: hw/vfio/ap.c
>>   L: qemu-s390x@nongnu.org
>>   
>>   vhost
> 
> Can you please also add hw/vfio/ap.c to the overall s390 architecture
> section in MAINTAINERS? The existing pattern does not catch it (but it
> does catch the files added in the last patch, so that's ok.)

Yes I can.

> 
