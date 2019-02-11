Received: from eggs.gnu.org ([209.51.188.92]:52136)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gtEmi-00080r-ET
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 11:50:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gtEmg-0000oT-Au
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 11:50:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44276)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1gtEmc-0000ex-HE
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 11:50:16 -0500
References: <1549390526-24246-1-git-send-email-pbonzini@redhat.com>
	<CAFEAcA8-Hst3Buax1Qrrm1SVbTtkE-8a_Vj0y3N4TvfPTqR_zw@mail.gmail.com>
	<CAFEAcA9Yh=fCuBT602deTt0OJQux9ZMGXvGX3Bx_iXNiTskNSA@mail.gmail.com>
	<3b62bab9-db61-f40e-da52-561a0cd9ee25@redhat.com>
	<CAFEAcA8=cKCUSshf8URKJWiBj26NEiBb5zEbsGz-faM-41R1Qg@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <90836469-8423-a346-05a9-1b775116cb43@redhat.com>
Date: Mon, 11 Feb 2019 17:50:07 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8=cKCUSshf8URKJWiBj26NEiBb5zEbsGz-faM-41R1Qg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL v2 00/76] misc patches for 2019-02-04
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On 11.02.19 17:33, Peter Maydell wrote:
> On Mon, 11 Feb 2019 at 16:29, David Hildenbrand <david@redhat.com> wrote:
>>
>> On 05.02.19 21:05, Peter Maydell wrote:
>>> This part looks like the usual "foo-softmmu/config-devices.mak isn't updated
>>> if a file that's #included from default-configs/foo-softmmu.mak is
>>> changed" dependency bug -- I guess the fix for that isn't in this
>>> patchset ?  The mips stuff is probably the same.
>>>
>>> I'll delete the config-devices.mak files by hand, which should
>>> suffice to get the build to go through.
>>>
>>
>> ../hw/acpi/piix4.o: In function `piix4_pm_realize':
>> /home/dhildenb/git/qemu/hw/acpi/piix4.c:515: undefined reference to
>> `pm_smbus_init'
>> ../hw/i2c/smbus_ich9.o: In function `ich9_smbus_realize':
>> /home/dhildenb/git/qemu/hw/i2c/smbus_ich9.c:89: undefined reference to
>> `pm_smbus_init'
>> ../hw/pci-host/piix.o: In function `i440fx_update_memory_mappings':
>> /home/dhildenb/git/qemu/hw/pci-host/piix.c:149: undefined reference to
>> `pam_update'
>> ../hw/pci-host/piix.o: In function `i440fx_init':
>> /home/dhildenb/git/qemu/hw/pci-host/piix.c:416: undefined reference to
>> `init_pam'
>> /home/dhildenb/git/qemu/hw/pci-host/piix.c:419: undefined reference to
>> `init_pam'
>> collect2: error: ld returned 1 exit status
>> make[1]: *** [Makefile:207: qemu-system-x86_64] Error 1
>> make: *** [Makefile:432: subdir-x86_64-softmmu] Error 2
>>
>>
>> Even after make clean + configure. Which step am I missing?
> 
> The "delete the config-devices.mak files by hand" step, I expect.
> (This is working around a very long standing bug in our makefiles
> which will be removed in passing by the KConfig work.)

Ah, indeed, I thought this would get fixed by a straight configure. Thanks!

> 
> thanks
> -- PMM
> 


-- 

Thanks,

David / dhildenb
