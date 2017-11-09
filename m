Received: from eggs.gnu.org ([2001:4830:134:3::10]:40678)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1eCoaG-0001Ty-6R
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 10:17:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1eCoaC-00045R-7i
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 10:17:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59422)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1eCoaB-00043t-VI
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 10:17:32 -0500
References: <151023266893.360.2441014157612423993@bafd83ae6430>
	<775f71a5-4975-da5f-1e42-c4dfe8f589ef@redhat.com>
	<d7a34a10-ae75-2d75-95b8-581b814b3e22@redhat.com>
	<707e2aa1-5e01-ec98-33f0-0a014bcd0623@amsat.org>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <0431e372-f2a2-3f11-02d8-41571b7523aa@redhat.com>
Date: Thu, 9 Nov 2017 17:17:18 +0200
MIME-Version: 1.0
In-Reply-To: <707e2aa1-5e01-ec98-33f0-0a014bcd0623@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH V4] hw/pcie-pci-bridge: restrict to X86 and
 ARM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: cohuck@redhat.com, famz@redhat.com, zuban32s@gmail.com, mst@redhat.com

On 09/11/2017 16:29, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi Marcel,
>=20
> On 11/09/2017 11:10 AM, Marcel Apfelbaum wrote:
>> On 09/11/2017 16:03, Thomas Huth wrote:
>>> On 09.11.2017 14:04, no-reply@patchew.org wrote:
>>>> Hi,
>>>>
>>>> This series failed automatic build test. Please find the testing
>>>> commands and
>>>> their output below. If you have docker installed, you can probably
>>>> reproduce it
>>>> locally.
>>> [...]
>>>>  =C2=A0=C2=A0 CC=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 aarch64-softmmu/hw/sc=
si/virtio-scsi.o
>>>>  =C2=A0=C2=A0 CC=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 aarch64-softmmu/hw/sc=
si/virtio-scsi-dataplane.o
>>>> make[1]: *** No rule to make target
>>>> `../hw/pci-bridge/pcie_pci_bridge.o', needed by
>>>> `qemu-system-x86_64'.=C2=A0 Stop.
>>>> make[1]: *** Waiting for unfinished jobs....
>>>>  =C2=A0=C2=A0 CC=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 aarch64-softmmu/hw/sc=
si/vhost-scsi-common.o
>>>>  =C2=A0=C2=A0 CC=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 aarch64-softmmu/hw/sc=
si/vhost-scsi.o
>>>>  =C2=A0=C2=A0 CC=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 aarch64-softmmu/hw/sc=
si/vhost-user-scsi.o
>>>>  =C2=A0=C2=A0 CC=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 aarch64-softmmu/hw/sd=
/omap_mmc.o
>>>>  =C2=A0=C2=A0 CC=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 aarch64-softmmu/hw/sd=
/pxa2xx_mmci.o
>>>>  =C2=A0=C2=A0 CC=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 aarch64-softmmu/hw/sd=
/bcm2835_sdhost.o
>>>> make: *** [subdir-x86_64-softmmu] Error 2
>>>> make: *** Waiting for unfinished jobs....
>>>>  =C2=A0=C2=A0 CC=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 aarch64-softmmu/hw/ss=
i/omap_spi.o
>>>>  =C2=A0=C2=A0 CC=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 aarch64-softmmu/hw/ss=
i/imx_spi.o
>>>>  =C2=A0=C2=A0 CC=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 aarch64-softmmu/hw/ti=
mer/exynos4210_mct.o
>>>>  =C2=A0=C2=A0 CC=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 aarch64-softmmu/hw/ti=
mer/exynos4210_pwm.o
>>> [...]
>>>>  =C2=A0=C2=A0 CC=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 aarch64-softmmu/hw/ti=
mer/exynos4210_rtc.o
>>>>  =C2=A0=C2=A0 CC=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 aarch64-softmmu/targe=
t/arm/translate-a64.o
>>>> make[1]: *** No rule to make target
>>>> `../hw/pci-bridge/pcie_pci_bridge.o', needed by
>>>> `qemu-system-aarch64'.=C2=A0 Stop.
>>>> make[1]: *** Waiting for unfinished
>>>> jobs..../tmp/qemu-test/src/target/arm/translate-a64.c: In function
>>>> 'handle_shri_with_rndacc':
>>>
>>> Hmm, looks like this was not working as expected?
>>>
>>
>> In my workstation works just fine (clean and compiled all archs),
>> I sent a mail to Fam.
>=20
> Applying your patch on v2.11.0-rc0 I also get this:
>=20
> make[1]: *** No rule to make target
> '../hw/pci-bridge/pcie_pci_bridge.o', needed by 'qemu-system-aarch64'.
> Stop.
> Makefile:383: recipe for target 'subdir-aarch64-softmmu' failed
> make: *** [subdir-aarch64-softmmu] Error 2
>=20
> $ fgrep CONFIG_PCIE config-all-devices.mak
> CONFIG_PCIE_PCI_BRIDGE:=3D$(findstring
> y,$(CONFIG_PCIE_PCI_BRIDGE)$(CONFIG_PCIE_PORT))
> CONFIG_PCIE_PORT:=3D$(findstring y,$(CONFIG_PCIE_PORT)y)
>=20
> $ make subdir-aarch64-softmmu --debug=3Dv 2>/dev/null | fgrep -i
> pcie_pci_bridge
> Reading makefile '../hw/pci-bridge/pcie_pci_bridge.d' (search path)
> (don't care) (no ~ expansion)...
>      Considering target file '../hw/pci-bridge/pcie_pci_bridge.o'.
>       File '../hw/pci-bridge/pcie_pci_bridge.o' does not exist.
>       Finished prerequisites of target file
> '../hw/pci-bridge/pcie_pci_bridge.o'.
>      Must remake target '../hw/pci-bridge/pcie_pci_bridge.o'.
>=20

Hi Philippe,
Thanks for trying it! I succeeded to reproduce with an out of tree build.
For some reason the make system doesn't work as I would want to.

I'll resend a working version,
Thanks,
Marcel
