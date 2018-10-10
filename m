Received: from eggs.gnu.org ([2001:4830:134:3::10]:51620)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <akrowiak@linux.ibm.com>) id 1gAFOo-0005Uk-Tv
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 10:23:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <akrowiak@linux.ibm.com>) id 1gAFOl-00052U-H7
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 10:23:42 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36878)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <akrowiak@linux.ibm.com>)
	id 1gAFOl-00051j-67
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 10:23:39 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w9AEKcGS007852
	for <qemu-devel@nongnu.org>; Wed, 10 Oct 2018 10:23:35 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2n1gugyaxf-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 10 Oct 2018 10:23:35 -0400
Received: from localhost
	by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <akrowiak@linux.ibm.com>;
	Wed, 10 Oct 2018 08:23:34 -0600
References: <20181009175226.22138-1-akrowiak@linux.vnet.ibm.com>
	<20181009175226.22138-7-akrowiak@linux.vnet.ibm.com>
	<ea0b09a9-dbbf-fc21-eabf-c0b943665f81@redhat.com>
From: Tony Krowiak <akrowiak@linux.ibm.com>
Date: Wed, 10 Oct 2018 10:23:23 -0400
MIME-Version: 1.0
In-Reply-To: <ea0b09a9-dbbf-fc21-eabf-c0b943665f81@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <13a297ab-4586-5d19-8241-7040733104f0@linux.ibm.com>
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v10 6/6] s390: doc: detailed
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

On 10/10/2018 04:14 AM, Thomas Huth wrote:
> On 2018-10-09 19:52, Tony Krowiak wrote:
>> This patch provides documentation describing the AP architecture and
>> design concepts behind the virtualization of AP devices. It also
>> includes an example of how to configure AP devices for exclusive
>> use of KVM guests.
>>
>> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
>> Reviewed-by: Pierre Morel<pmorel@linux.ibm.com>
>> Tested-by: Pierre Morel<pmorel@linux.ibm.com>
>> ---
>>   MAINTAINERS      |   1 +
>>   docs/vfio-ap.txt | 825 +++++++++++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 826 insertions(+)
>>   create mode 100644 docs/vfio-ap.txt
> [...]
>> +      * Individual bits in the mask can be switched on and off by specifying
>> +        each bit number to be switched in a comma separated list. Each bit
>> +        number string must be prepended with a ('+') or minus ('-') to indicate
>> +        the corresponding bit is to be switched on ('+') or off ('-'). Some
>> +        valid values are:
> 
> Nit: My git complains about a superfluous white space after "are:"

I ran checkpatch and my git did not complain, but I'll make sure there
are no whitespaces at the end of the lines.

> 
> [...]
>> +assign_adapter
>> +   To assign an AP adapter to the mediated matrix device, its APID is written
>> +   to the 'assign_adapter' file. This may be done multiple times to assign more
>> +   than one adapter. The APID may be specified using conventional semantics
>> +   as a decimal, hexidecimal, or octal number. For example, to assign adapters
>> +   4, 5 and 16 to a mediated matrix device in decimal, hexidecimal and octal
>> +   respectively:
> 
> In case you respin: I'd still prefer s/hexidecimal/hexadecimal/g in the
> whole document (but it's just a nit, so no need to respin just because
> of this)

I will be submitting a v11, so I'll go ahead and fix this.

> 
>   Thomas
> 
