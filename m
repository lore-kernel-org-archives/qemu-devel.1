Received: from eggs.gnu.org ([2001:4830:134:3::10]:44143)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <akrowiak@linux.ibm.com>) id 1gAF2F-0003Qs-6B
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 10:00:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <akrowiak@linux.ibm.com>) id 1gAF27-0004Iz-PF
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 10:00:19 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39912
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <akrowiak@linux.ibm.com>)
	id 1gAF24-0004HQ-63
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 10:00:13 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w9ADwoQO066833
	for <qemu-devel@nongnu.org>; Wed, 10 Oct 2018 10:00:11 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2n1jh5gwxe-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 10 Oct 2018 10:00:11 -0400
Received: from localhost
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <akrowiak@linux.ibm.com>;
	Wed, 10 Oct 2018 08:00:09 -0600
References: <20181009175226.22138-1-akrowiak@linux.vnet.ibm.com>
	<20181009175226.22138-5-akrowiak@linux.vnet.ibm.com>
	<20181010101453.4d1e4add.cohuck@redhat.com>
From: Tony Krowiak <akrowiak@linux.ibm.com>
Date: Wed, 10 Oct 2018 09:59:55 -0400
MIME-Version: 1.0
In-Reply-To: <20181010101453.4d1e4add.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <158900e0-4ac5-5d20-b47d-cb7f7a036e70@linux.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v10 4/6] s390x/ap: base Adjunct Processor
 (AP) object model
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

On 10/10/2018 04:14 AM, Cornelia Huck wrote:
> On Tue,  9 Oct 2018 13:52:24 -0400
> Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:
> 
>> diff --git a/hw/s390x/ap-device.c b/hw/s390x/ap-device.c
>> new file mode 100644
>> index 000000000000..fb6e35024c82
>> --- /dev/null
>> +++ b/hw/s390x/ap-device.c
>> @@ -0,0 +1,39 @@
>> +/*
>> + * Adjunct Processor (AP) matrix device
>> + *
>> + * Copyright 2018 IBM Corp.
>> + * Author(s): Tony Krowiak <akrowiak@linux.vnet.ibm.com>
> 
> Do you also want this to use the vnet-less form instead?
> 
>> + *
>> + * This work is licensed under the terms of the GNU GPL, version 2 or (at
>> + * your option) any later version. See the COPYING file in the top-level
>> + * directory.
>> + */
> 
>> diff --git a/include/hw/s390x/ap-device.h b/include/hw/s390x/ap-device.h
>> new file mode 100644
>> index 000000000000..4fb3c9ab82f2
>> --- /dev/null
>> +++ b/include/hw/s390x/ap-device.h
>> @@ -0,0 +1,23 @@
>> +/*
>> + * Adjunct Processor (AP) matrix device interfaces
>> + *
>> + * Copyright 2018 IBM Corp.
>> + * Author(s): Tony Krowiak <akrowiak@linux.vnet.ibm.com>
> 
> Same here.

Yes. Shall I just submit a v11?

> 
