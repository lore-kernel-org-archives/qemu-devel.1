Received: from eggs.gnu.org ([2001:4830:134:3::10]:46164)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1d3GAb-0006jV-Bs
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 02:11:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1d3GAY-0003LE-26
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 02:11:21 -0400
Received: from 3.mo1.mail-out.ovh.net ([46.105.60.232]:38320)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1d3GAX-0003Jj-Nm
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 02:11:17 -0400
Received: from player691.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo1.mail-out.ovh.net (Postfix) with ESMTP id E986E6E584
	for <qemu-devel@nongnu.org>; Wed, 26 Apr 2017 08:11:15 +0200 (CEST)
References: <20170424015927.8933-1-david@gibson.dropbear.id.au>
	<CAFEAcA-SR5LXw4uw_Xid94JTarDBpVO2nkGb2axRUu2BcX318Q@mail.gmail.com>
	<20170426023843.GJ16882@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <fbf91cf1-53d1-4b75-74b3-fa9abefdd788@kaod.org>
Date: Wed, 26 Apr 2017 08:11:06 +0200
MIME-Version: 1.0
In-Reply-To: <20170426023843.GJ16882@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 00/47] ppc-for-2.10 queue 20170424
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, Peter Maydell <peter.maydell@linaro.org>
Cc: Alexander Graf <agraf@suse.de>, Michael Roth <mdroth@linux.vnet.ibm.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, QEMU Developers <qemu-devel@nongnu.org>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>

On 04/26/2017 04:38 AM, David Gibson wrote:
> On Mon, Apr 24, 2017 at 02:12:19PM +0100, Peter Maydell wrote:
>> On 24 April 2017 at 02:58, David Gibson <david@gibson.dropbear.id.au> wrote:
>>> The following changes since commit 32c7e0ab755745e961f1772e95cac381cc68769d:
>>>
>>>   Merge remote-tracking branch 'remotes/juanquintela/tags/migration/20170421' into staging (2017-04-21 15:59:27 +0100)
>>>
>>> are available in the git repository at:
>>>
>>>   git://github.com/dgibson/qemu.git tags/ppc-for-2.10-20170424
>>>
>>> for you to fetch changes up to 4cab48942a1c5353f0a314fab1aa85a5f0a61461:
>>>
>>>   target/ppc: Style fixes (2017-04-24 08:56:19 +1000)
>>>
>>> ----------------------------------------------------------------
>>> ppc patch queue 2017-04-24
>>>
>>> Here's my first pull request for qemu-2.10, consisting of assorted
>>> patches which have accumulated while qemu-2.9 stabilized.  Highlights
>>> are:
>>>     * Rework / cleanup of the XICS interrupt controller
>>>     * Substantial improvement to the 'powernv' machine type
>>>         - Includes an MMIO XICS version
>>>     * POWER9 support improvements
>>>         - POWER9 guests with KVM
>>>         - Partial support for POWER9 guests with TCG
>>>     * IOMMU and VFIO improvements
>>>     * Assorted minor changes
>>>
>>> There are several IPMI patches here that aren't usually in my area of
>>> maintenance, but there isn't a regular maintainer and these patches
>>> are for the benefit of the powernv machine type.
>>
>>
>> Hi -- I'm afraid this pullreq generates a new clang sanitizer warning
>> running 'make check':
> 
> Drat.  What do I need to do to see these warnings?  Sounds like I
> should add that to my pre-pull-request testing sequence.  Just
> building with clang (on Fedora 25) and running make check doesn't seem
> to be sufficient.

yes. May be we could add this flag : 

	--extra-cflags=-fsanitize=undefined

to the travis builds using clang ? It is reporting a couple of errors on ppc64

target/ppc/translate.c:980:56: runtime error: left shift of negative value -32768
target/ppc/translate.c:983:56: runtime error: left shift of negative value -16
hw/usb/hcd-ohci.c:1122:9: runtime error: left shift of 15 by 28 places cannot be represented in type 'int'
hw/usb/hcd-ohci.c:1122:9: runtime error: left shift of 15 by 28 places cannot be represented in type 'int'
hw/usb/hcd-ohci.c:1179:12: runtime error: left shift of 15 by 28 places cannot be represented in type 'int'
target/ppc/translate.c:980:56: runtime error: left shift of negative value -32768
target/ppc/translate.c:983:56: runtime error: left shift of negative value -16
target/ppc/translate.c:983:56: runtime error: left shift of negative value -1
target/ppc/translate.c:980:56: runtime error: left shift of negative value -28672
target/ppc/translate.c:980:56: runtime error: left shift of negative value -28672
target/ppc/translate.c:980:56: runtime error: left shift of negative value -28672
target/ppc/translate.c:980:56: runtime error: left shift of negative value -28672
target/ppc/translate.c:983:56: runtime error: left shift of negative value -1
target/ppc/translate.c:980:56: runtime error: left shift of negative value -1
hw/usb/hcd-xhci.c:3005:19: runtime error: left shift of 1 by 31 places cannot be represented in type 'int'
hw/usb/hcd-xhci.c:2417:29: runtime error: left shift of 1 by 31 places cannot be represented in type 'int'
hw/usb/hcd-xhci.c:2420:29: runtime error: left shift of 1 by 31 places cannot be represented in type 'int'
hw/usb/hcd-xhci.c:2447:38: runtime error: left shift of 31 by 27 places cannot be represented in type 'int'
hw/usb/hcd-xhci.c:2449:48: runtime error: left shift of 31 by 27 places cannot be represented in type 'int'
hw/usb/hcd-xhci.c:2450:62: runtime error: left shift of 31 by 27 places cannot be represented in type 'int'
/target/ppc/translate.c:980:56: runtime error: left shift of negative value -1
/target/ppc/mmu_helper.c:2599:38: runtime error: left shift of 1 by 31 places cannot be represented in type 'int'
/target/ppc/mmu_helper.c:2599:53: runtime error: left shift of 1 by 31 places cannot be represented in type 'int'
/target/ppc/translate.c:983:56: runtime error: left shift of negative value -240
/target/ppc/translate.c:980:56: runtime error: left shift of negative value -128
/target/ppc/translate.c:983:56: runtime error: left shift of negative value -32768
target/ppc/translate.c:983:56: runtime error: left shift of negative value -1
target/ppc/translate.c:980:56: runtime error: left shift of negative value -28672
target/ppc/translate.c:983:56: runtime error: left shift of negative value -1
target/ppc/translate.c:983:56: runtime error: left shift of negative value -1
target/ppc/translate.c:980:56: runtime error: left shift of negative value -13108
target/ppc/translate.c:983:56: runtime error: left shift of negative value -1
target/ppc/translate.c:980:56: runtime error: left shift of negative value -32768


Thanks,

C. 


>> /home/petmay01/linaro/qemu-for-merges/hw/core/loader.c:67:15: runtime
>> error: null pointer passed as argument 1, which is declared to never
>> be null
>>
>> It looks like we try to call open(NULL, ...).
>>
>> Affected tests are in check-qtest-i386:
>> tests/bios-tables-test
>>   /i386/acpi/piix4/ipmi
>>   /i386/acpi/q35/ipmi
>> tests/ipmi-kcs-test
>>
>> Here's a backtrace:
>>
>> #0  0x00005555567e6197 in get_image_size (filename=0x0) at
>> /home/petmay01/linaro/qemu-for-merges/hw/core/loader.c:67
>> #1  0x00005555568ead3c in ipmi_fru_init (fru=0x55555ab98588)
>>     at /home/petmay01/linaro/qemu-for-merges/hw/ipmi/ipmi_bmc_sim.c:1902
>> #2  0x00005555568e91ac in ipmi_sim_realize (dev=<optimised out>,
>> errp=<optimised out>)
>>     at /home/petmay01/linaro/qemu-for-merges/hw/ipmi/ipmi_bmc_sim.c:1943
>> #3  0x00005555567d6df6 in device_set_realized (obj=<optimised out>,
>> value=<optimised out>, errp=<optimised out>)
>>     at /home/petmay01/linaro/qemu-for-merges/hw/core/qdev.c:905
>> #4  0x0000555556d7b1f8 in property_set_bool (obj=0x55555ab93c90,
>> v=<optimised out>, name=<optimised out>, opaque=<optimised out>,
>> errp=0x7fffffffde90) at
>> /home/petmay01/linaro/qemu-for-merges/qom/object.c:1860
>> #5  0x0000555556d7dd1d in object_property_set_qobject (obj=0x0,
>> value=<optimised out>, name=0x58fdf801 <error: Cannot access memory at
>> address 0x58fdf801>, errp=0x1) at
>> /home/petmay01/linaro/qemu-for-merges/qom/qom-qobject.c:27
>> #6  0x0000555556d78cb2 in object_property_set_bool
>> (obj=0x55555ab93c90, value=<optimised out>, name=0x55555710e087
>> "realized", errp=0x7fffffffde90) at
>> /home/petmay01/linaro/qemu-for-merges/qom/object.c:1163
>> #7  0x000055555661d80d in qdev_device_add (opts=<optimised out>,
>> errp=<optimised out>)
>>     at /home/petmay01/linaro/qemu-for-merges/qdev-monitor.c:630
>> #8  0x00005555566374cb in device_init_func (opaque=<optimised out>,
>> opts=0x0, errp=0x58fdf801)
>>     at /home/petmay01/linaro/qemu-for-merges/vl.c:2305
>> #9  0x000055555701dc81 in qemu_opts_foreach (list=<optimised out>,
>> func=<optimised out>, opaque=<optimised out>, errp=<optimised out>) at
>> /home/petmay01/linaro/qemu-for-merges/util/qemu-option.c:1114
>> #10 0x0000555556633289 in main (argc=<optimised out>, argv=<optimised
>> out>, envp=<optimised out>)
>>     at /home/petmay01/linaro/qemu-for-merges/vl.c:4583
>>
>> It looks like the device doesn't handle not having its fru.filename
>> property set -- this should either cause an error in realize or the
>> rest of the device code should handle NULL.
>>
>> thanks
>> -- PMM
>>
> 
