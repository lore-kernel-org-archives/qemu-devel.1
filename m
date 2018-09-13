Received: from eggs.gnu.org ([2001:4830:134:3::10]:40950)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <akrowiak@linux.ibm.com>) id 1g0SDR-0000gr-LH
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 10:03:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <akrowiak@linux.ibm.com>) id 1g0SDN-0001Pz-3d
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 10:03:29 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57035
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <akrowiak@linux.ibm.com>)
	id 1g0SDM-0001PG-SJ
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 10:03:25 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w8DE2jAM009791
	for <qemu-devel@nongnu.org>; Thu, 13 Sep 2018 10:03:23 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2mfs7dgbjm-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 13 Sep 2018 10:03:22 -0400
Received: from localhost
	by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <akrowiak@linux.ibm.com>;
	Thu, 13 Sep 2018 10:03:17 -0400
References: <1536782900-17656-1-git-send-email-akrowiak@linux.vnet.ibm.com>
	<1536782900-17656-7-git-send-email-akrowiak@linux.vnet.ibm.com>
	<386188b7-d6ae-b317-23b9-40c2779386bf@redhat.com>
From: Tony Krowiak <akrowiak@linux.ibm.com>
Date: Thu, 13 Sep 2018 10:03:08 -0400
MIME-Version: 1.0
In-Reply-To: <386188b7-d6ae-b317-23b9-40c2779386bf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Message-Id: <bc7d07f9-2898-d02d-5452-a8aceff55da9@linux.ibm.com>
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v8 6/6] s390: doc: detailed
 specifications for AP virtualization
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Tony Krowiak <akrowiak@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, cohuck@redhat.com, david@redhat.com, pmorel@linux.vnet.ibm.com, fiuczy@linux.ibm.com, eskultet@redhat.com, agraf@suse.de, borntraeger@de.ibm.com, jjherne@linux.vnet.ibm.com, mimu@linux.ibm.com, heiko.carstens@de.ibm.com, eric.auger@redhat.com, alex.williamson@redhat.com, bjsdjshi@linux.vnet.ibm.com, rth@twiddle.net, mjrosato@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, alifm@linux.vnet.ibm.com, qemu-s390x@nongnu.org, schwidefsky@de.ibm.com, pbonzini@redhat.com

On 09/13/2018 02:06 AM, Thomas Huth wrote:
> On 2018-09-12 22:08, Tony Krowiak wrote:
>> This patch provides documentation describing the AP architecture and
>> design concepts behind the virtualization of AP devices. It also
>> includes an example of how to configure AP devices for exclusive
>> use of KVM guests.
>>
>> Signed-off-by: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
>> ---
> [...]
>> +   To assign an AP adapter to the mediated matrix device, its APID is written
>> +   to the 'assign_adapter' file. This may be done multiple times to assign more
>> +   than one adapter. The APID may be specified using conventional semantics
>> +   as a decimal, hexidecimal, or octal number. For example, to assign adapters
>> +   4, 5 and 16 to a mediated matrix device in decimal, hexidecimal and octal
> s/hexidecimal/hexadecimal/g ?
>
> While some websites say that hexi is an alternative spelling, I have to
> admit that I've never seen it before, and there are also not that much
> hits on google when you search for it...
>
> [...]
>> +* Live guest migration is not supported for guests using AP devices.
>> \ No newline at end of file
>>
> Please add a newline at the end of the file.
>
>   Thomas

Okay

>
