Received: from eggs.gnu.org ([2001:4830:134:3::10]:39836)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fWJ22-0005uZ-OW
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 06:11:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fWJ1z-0002gB-HE
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 06:11:06 -0400
References: <20180621170143.113370-1-borntraeger@de.ibm.com>
	<d27919d1-6017-3b57-815d-0bdeb96dea6e@redhat.com>
	<c4ce8f0c-ccbb-3d79-459f-bb771a68685a@de.ibm.com>
	<20180622114659.7858fe00.cohuck@redhat.com>
	<56c5193d-b116-93ae-af96-509fab9e1381@redhat.com>
	<a2ea9d73-3ed1-3296-f87d-19488eabb465@de.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <fc9c0e43-aff6-925c-30f7-8f0db9ee3d69@redhat.com>
Date: Fri, 22 Jun 2018 12:10:59 +0200
MIME-Version: 1.0
In-Reply-To: <a2ea9d73-3ed1-3296-f87d-19488eabb465@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 1/1] s390/ipl: fix ipl with -no-reboot
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>, Thomas Huth <thuth@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>

On 22.06.2018 12:10, Christian Borntraeger wrote:
> 
> 
> On 06/22/2018 11:59 AM, Paolo Bonzini wrote:
>> On 22/06/2018 11:46, Cornelia Huck wrote:
>>>>> Ok, then my suggestion made even more sense. :)  No other objections
>>>>> apart from the name of the constant.
>>>>>
>>>>> Paolo  
>>>> SHUTDOWN_CAUSE_S390_PARTIAL ?
>>> Don't like that one much.
>>>
>>>> SHUTDOWN_CAUSE_S390_SUBSYS_RESET?
>>> Either that, or drop the 'S390' (is it conceivable that other
>>> architectures have something similar)?
>>>
>>
>> I don't know exactly what is going on here, so I'm not very suited to
>> answer this.  The difference just from reading the C code seems to be
>> that it calls s390_cpu_load_normal instead of s390_ipl_prepare_cpu, and
>> that it calls subsystem_reset instead of qemu_devices_reset.
>>
>> For a more generic name I'd go with SHUTDOWN_CAUSE_OS_BOOT (or
>> OS_BOOTING, or BOOT_OS), but an s390-specific name is of course fine as
>> well, especially if you have a specific moniker for the "thing that IPL
> 
> It is not a BOOT, it is in fact an reset just to the devices.
> Right now I favor
> 
> SHUTDOWN_CAUSE_SUBSYSTEM_RESET
> 

+1

-- 

Thanks,

David / dhildenb
