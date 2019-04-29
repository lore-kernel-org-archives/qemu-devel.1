Received: from eggs.gnu.org ([209.51.188.92]:50119)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hL8t3-000294-6E
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 12:12:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hL8t1-0005Ko-7k
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 12:12:13 -0400
References: <20190418180057.3593-1-thuth@redhat.com>
	<20190418180057.3593-23-thuth@redhat.com>
	<b042daff-8b05-08e7-5386-1b89f05ad984@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <7559b0e3-f752-09a5-2e8d-a40d0ade23e1@redhat.com>
Date: Mon, 29 Apr 2019 18:11:02 +0200
MIME-Version: 1.0
In-Reply-To: <b042daff-8b05-08e7-5386-1b89f05ad984@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-QEMU-4.1 v5 22/29] hw/arm: Express
 dependencies of sabrelite with Kconfig
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

On 25/04/2019 18.43, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi Thomas,
>=20
> On 4/18/19 8:00 PM, Thomas Huth wrote:
>> Add Kconfig dependencies for the Sabrelite / iMX6 machine.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  default-configs/arm-softmmu.mak | 4 +---
>>  hw/arm/Kconfig                  | 7 +++++++
>>  hw/arm/Makefile.objs            | 3 ++-
>>  3 files changed, 10 insertions(+), 4 deletions(-)
>>
>> diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-sof=
tmmu.mak
>> index 76508e3910..ef7dd7156a 100644
>> --- a/default-configs/arm-softmmu.mak
>> +++ b/default-configs/arm-softmmu.mak
>> @@ -33,6 +33,7 @@ CONFIG_NETDUINO2=3Dy
>>  CONFIG_MPS2=3Dy
>>  CONFIG_RASPI=3Dy
>>  CONFIG_DIGIC=3Dy
>> +CONFIG_SABRELITE=3Dy
>> =20
>>  CONFIG_VGA=3Dy
>>  CONFIG_SSI_M25P80=3Dy
>> @@ -40,13 +41,10 @@ CONFIG_IMX_FEC=3Dy
>> =20
>>  CONFIG_NRF51_SOC=3Dy
>> =20
>> -CONFIG_FSL_IMX6=3Dy
>>  CONFIG_FSL_IMX25=3Dy
>>  CONFIG_FSL_IMX7=3Dy
>>  CONFIG_FSL_IMX6UL=3Dy
>> =20
>> -CONFIG_IMX_I2C=3Dy
>> -
>>  CONFIG_PCIE_PORT=3Dy
>>  CONFIG_XIO3130=3Dy
>>  CONFIG_IOH3420=3Dy
>> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
>> index 059fb8282c..065c7acf1b 100644
>> --- a/hw/arm/Kconfig
>> +++ b/hw/arm/Kconfig
>> @@ -177,6 +177,10 @@ config REALVIEW
>>      select DS1338 # I2C RTC+NVRAM
>>      select USB_OHCI
>> =20
>> +config SABRELITE
>> +    bool
>> +    select FSL_IMX6
>=20
> This one crashes:
>=20
> $ qemu-system-aarch64 -display none -M sabrelite
> ERROR:/source/qemu/qom/object.c:454:object_initialize_with_type:
> assertion failed: (type !=3D NULL)
> Aborted (core dumped)

Weird, I was pretty sure to have tested all boards individually ... I
must accidentally have skipped this one. Thanks a lot for testing, I'll
fix it in v6.

 Thomas
