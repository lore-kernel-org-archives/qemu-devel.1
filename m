Received: from eggs.gnu.org ([209.51.188.92]:33472)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hL8J3-0000yL-PS
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 11:35:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hL8J2-0004la-Oq
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 11:35:01 -0400
References: <20190418180057.3593-1-thuth@redhat.com>
	<20190418180057.3593-17-thuth@redhat.com>
	<98855a34-ff5a-896f-7959-480b89d62833@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <b78d5517-5f23-6028-6726-b60f916f22fd@redhat.com>
Date: Mon, 29 Apr 2019 17:34:26 +0200
MIME-Version: 1.0
In-Reply-To: <98855a34-ff5a-896f-7959-480b89d62833@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-QEMU-4.1 v5 16/29] hw/arm: Express
 dependencies of the virt machine with Kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, yang.zhong@intel.com, Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, pbonzini@redhat.com
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, "Edgar E . Iglesias" <edgar.iglesias@gmail.com>, Jean-Christophe Dubois <jcd@tribudubois.net>, Rob Herring <robh@kernel.org>, qemu-block@nongnu.org, Andrey Smirnov <andrew.smirnov@gmail.com>, Joel Stanley <joel@jms.id.au>, Antony Pavlov <antonynpavlov@gmail.com>, Alistair Francis <alistair@alistair23.me>, Beniamino Galvani <b.galvani@gmail.com>, qemu-arm@nongnu.org, Peter Chubb <peter.chubb@nicta.com.au>, Cedric Le Goater <clg@kaod.org>, John Snow <jsnow@redhat.com>, Andrew Jeffery <andrew@aj.id.au>, Philippe Mathieu-Daude <f4bug@amsat.org>, Subbaraya Sundeep <sundeep.lkml@gmail.com>, Igor Mitsyanko <i.mitsyanko@gmail.com>, Jan Kiszka <jan.kiszka@web.de>

On 25/04/2019 17.53, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi Thomas,
>=20
> On 4/18/19 8:00 PM, Thomas Huth wrote:
>> Dependencies have been determined by looking at hw/arm/virt.c
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  default-configs/arm-softmmu.mak | 11 +----------
>>  hw/arm/Kconfig                  | 19 +++++++++++++++++++
>>  hw/arm/Makefile.objs            |  3 ++-
>>  3 files changed, 22 insertions(+), 11 deletions(-)
>>
>> diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-sof=
tmmu.mak
>> index 2580584281..f440a2b1cd 100644
>> --- a/default-configs/arm-softmmu.mak
>> +++ b/default-configs/arm-softmmu.mak
>> @@ -6,6 +6,7 @@ CONFIG_ARM_V7M=3Dy
>>  # CONFIG_PCI_DEVICES=3Dn
>>  # CONFIG_TEST_DEVICES=3Dn
>> =20
>> +CONFIG_ARM_VIRT=3Dy
>>  CONFIG_EXYNOS4=3Dy
>>  CONFIG_HIGHBANK=3Dy
>>  CONFIG_INTEGRATOR=3Dy
>> @@ -32,8 +33,6 @@ CONFIG_VGA=3Dy
>>  CONFIG_SSI_M25P80=3Dy
>>  CONFIG_ALLWINNER_EMAC=3Dy
>>  CONFIG_IMX_FEC=3Dy
>> -CONFIG_PLATFORM_BUS=3Dy
>> -CONFIG_VIRTIO_MMIO=3Dy
>> =20
>>  CONFIG_NETDUINO2=3Dy
>> =20
>> @@ -68,9 +67,6 @@ CONFIG_IOTKIT_SYSINFO=3Dy
>>  CONFIG_ARMSSE_CPUID=3Dy
>>  CONFIG_ARMSSE_MHU=3Dy
>> =20
>> -CONFIG_PCI_EXPRESS=3Dy
>> -CONFIG_PCI_EXPRESS_GENERIC_BRIDGE=3Dy
>> -
>>  CONFIG_ALLWINNER_A10_PIT=3Dy
>>  CONFIG_ALLWINNER_A10_PIC=3Dy
>>  CONFIG_ALLWINNER_A10=3Dy
>> @@ -86,10 +82,5 @@ CONFIG_PCIE_PORT=3Dy
>>  CONFIG_XIO3130=3Dy
>>  CONFIG_IOH3420=3Dy
>>  CONFIG_I82801B11=3Dy
>> -CONFIG_ACPI=3Dy
>> -CONFIG_ARM_VIRT=3Dy
>> -CONFIG_SMBIOS=3Dy
>> -CONFIG_GPIO_KEY=3Dy
>>  CONFIG_MSF2=3Dy
>> -CONFIG_FW_CFG_DMA=3Dy
>>  CONFIG_PCI_EXPRESS_DESIGNWARE=3Dy
>> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
>> index abeaa54d88..4d0febf644 100644
>> --- a/hw/arm/Kconfig
>> +++ b/hw/arm/Kconfig
>> @@ -1,6 +1,24 @@
>>  config ARM_VIRT
>>      bool
>> +    imply PCI_DEVICES
>=20
> Without -nodefaults I get:
> qemu-system-aarch64: Unsupported NIC model: virtio-net-pci
> This is expected.

Yes, it should still work with "-nic none" or "-nodefaults".

>> +    imply TEST_DEVICES
>> +    imply VFIO_AMD_XGBE
>>      imply VFIO_PLATFORM
>> +    imply VFIO_XGMAC
>> +    select A15MPCORE
>> +    select ACPI
>> +    select ARM_SMMUV3
>=20
> You forgot to remove ARM_SMMUV3 from default-configs/aarch64-softmmu.ma=
k.

Good catch! Will fix it in v6.

> With it removed:
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Thanks!

 Thomas
