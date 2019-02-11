Received: from eggs.gnu.org ([209.51.188.92]:40645)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gtESN-0000PH-16
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 11:29:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gtESM-0000ni-2O
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 11:29:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48220)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1gtESL-0000n9-Qe
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 11:29:18 -0500
References: <1549390526-24246-1-git-send-email-pbonzini@redhat.com>
	<CAFEAcA8-Hst3Buax1Qrrm1SVbTtkE-8a_Vj0y3N4TvfPTqR_zw@mail.gmail.com>
	<CAFEAcA9Yh=fCuBT602deTt0OJQux9ZMGXvGX3Bx_iXNiTskNSA@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <3b62bab9-db61-f40e-da52-561a0cd9ee25@redhat.com>
Date: Mon, 11 Feb 2019 17:29:11 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9Yh=fCuBT602deTt0OJQux9ZMGXvGX3Bx_iXNiTskNSA@mail.gmail.com>
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
To: Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 05.02.19 21:05, Peter Maydell wrote:
> On Tue, 5 Feb 2019 at 20:01, Peter Maydell <peter.maydell@linaro.org> wrote:
>>
>> On Tue, 5 Feb 2019 at 18:18, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>>
>>> The following changes since commit 1c3d45df5e94042d5fb2bb31416072563ab30e49:
>>>
>>>   Merge remote-tracking branch 'remotes/ericb/tags/pull-nbd-2019-02-04' into staging (2019-02-05 12:46:18 +0000)
>>>
>>> are available in the git repository at:
>>>
>>>
>>>   git://github.com/bonzini/qemu.git tags/for-upstream
>>>
>>> for you to fetch changes up to 5ed76a4c63db9295c6c5d67895925810050d4a46:
>>>
>>>   queue: fix QTAILQ_FOREACH_REVERSE_SAFE (2019-02-05 16:50:21 +0100)
>>>
>>> ----------------------------------------------------------------
>>> * cpu-exec fixes (Emilio, Laurent)
>>> * TCG bugfix in queue.h (Paolo)
>>> * high address load for linuxboot (Zhijian)
>>> * PVH support (Liam, Stefano)
>>> * misc i386 changes (Paolo, Robert, Doug)
>>> * configure tweak for openpty (Thomas)
>>> * elf2dmp port to Windows (Viktor)
>>> * initial improvements to Makefile infrastructure (Yang + GSoC 2013)
>>>
>>> ----------------------------------------------------------------
>>
>> The build tree where I do 'make clean' then 'make' failed when
>> linking:
> 
>> and
>>   LINK    aarch64-softmmu/qemu-system-aarch64
>> hw/arm/aspeed.o: In function `palmetto_bmc_i2c_init':
>> /home/petmay01/linaro/qemu-for-merges/hw/arm/aspeed.c:249: undefined
>> reference to `smbus_eeprom_init_one'
>> hw/arm/aspeed.o: In function `ast2500_evb_i2c_init':
>> /home/petmay01/linaro/qemu-for-merges/hw/arm/aspeed.c:266: undefined
>> reference to `smbus_eeprom_init_one'
>> hw/arm/aspeed.o: In function `witherspoon_bmc_i2c_init':
>> /home/petmay01/linaro/qemu-for-merges/hw/arm/aspeed.c:303: undefined
>> reference to `smbus_eeprom_init_one'
>> collect2: error: ld returned 1 exit status
> 
> This part looks like the usual "foo-softmmu/config-devices.mak isn't updated
> if a file that's #included from default-configs/foo-softmmu.mak is
> changed" dependency bug -- I guess the fix for that isn't in this
> patchset ?  The mips stuff is probably the same.
> 
> I'll delete the config-devices.mak files by hand, which should
> suffice to get the build to go through.
> 

../hw/acpi/piix4.o: In function `piix4_pm_realize':
/home/dhildenb/git/qemu/hw/acpi/piix4.c:515: undefined reference to
`pm_smbus_init'
../hw/i2c/smbus_ich9.o: In function `ich9_smbus_realize':
/home/dhildenb/git/qemu/hw/i2c/smbus_ich9.c:89: undefined reference to
`pm_smbus_init'
../hw/pci-host/piix.o: In function `i440fx_update_memory_mappings':
/home/dhildenb/git/qemu/hw/pci-host/piix.c:149: undefined reference to
`pam_update'
../hw/pci-host/piix.o: In function `i440fx_init':
/home/dhildenb/git/qemu/hw/pci-host/piix.c:416: undefined reference to
`init_pam'
/home/dhildenb/git/qemu/hw/pci-host/piix.c:419: undefined reference to
`init_pam'
collect2: error: ld returned 1 exit status
make[1]: *** [Makefile:207: qemu-system-x86_64] Error 1
make: *** [Makefile:432: subdir-x86_64-softmmu] Error 2


Even after make clean + configure. Which step am I missing?

-- 

Thanks,

David / dhildenb
