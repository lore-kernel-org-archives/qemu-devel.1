Received: from eggs.gnu.org ([209.51.188.92]:51644)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hJfOe-0004qA-LT
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 10:30:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hJfOd-0001TA-L4
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 10:30:44 -0400
References: <20190418180057.3593-1-thuth@redhat.com>
	<20190418180057.3593-7-thuth@redhat.com>
	<cf39902b-267a-ea7e-c513-fa0c9abf639c@redhat.com>
	<f362864d-b8f7-687d-1397-03769202cd4f@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <faade53f-595e-e97f-a3af-e867e11e248c@redhat.com>
Date: Thu, 25 Apr 2019 16:29:53 +0200
MIME-Version: 1.0
In-Reply-To: <f362864d-b8f7-687d-1397-03769202cd4f@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-QEMU-4.1 v5 06/29] hw/arm: Express
 dependencies of integratorcp with Kconfig
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

On 25/04/2019 16.22, Philippe Mathieu-Daud=C3=A9 wrote:
> On 4/25/19 4:14 PM, Philippe Mathieu-Daud=C3=A9 wrote:
>> Hi Thomas,
>>
>> On 4/18/19 8:00 PM, Thomas Huth wrote:
>>> This patch is slightly based on earlier work by =C3=81kos Kov=C3=A1cs=
 (i.e.
>>> his "hw/arm/Kconfig: Add ARM Kconfig" patch).
>>>
>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>> ---
>>>  default-configs/arm-softmmu.mak | 8 +-------
>>>  hw/arm/Kconfig                  | 8 ++++++++
>>>  hw/display/Kconfig              | 1 +
>>>  3 files changed, 10 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-so=
ftmmu.mak
>>> index 50a4be3cad..6195b75f48 100644
>>> --- a/default-configs/arm-softmmu.mak
>>> +++ b/default-configs/arm-softmmu.mak
>>> @@ -9,6 +9,7 @@ CONFIG_PCI_TESTDEV=3Dy
>>> =20
>>>  CONFIG_EXYNOS4=3Dy
>>>  CONFIG_HIGHBANK=3Dy
>>> +CONFIG_INTEGRATOR=3Dy
>>> =20
>>>  CONFIG_VGA=3Dy
>>>  CONFIG_NAND=3Dy
>>> @@ -33,7 +34,6 @@ CONFIG_ADS7846=3Dy
>>>  CONFIG_MAX111X=3Dy
>>>  CONFIG_SSI_SD=3Dy
>>>  CONFIG_SSI_M25P80=3Dy
>>> -CONFIG_SMC91C111=3Dy
>>>  CONFIG_ALLWINNER_EMAC=3Dy
>>>  CONFIG_IMX_FEC=3Dy
>>>  CONFIG_FTGMAC100=3Dy
>>> @@ -50,10 +50,7 @@ CONFIG_ARM11MPCORE=3Dy
>>>  CONFIG_NETDUINO2=3Dy
>>> =20
>>>  CONFIG_PL041=3Dy
>>> -CONFIG_PL050=3Dy
>>
>> You remove this device but it is used by the realview/versatile/vexpre=
ss
>> (you add it to these machines later in patch 11).
>=20
> My worry is the unlikely event of someone checking out a new branch
> after this patch and before patch 11, and disable CONFIG_INTEGRATOR,
> then these 3 machines would fail to build.

Yeah, the basic idea in this series is that you can not easily do
partial qemu-system-arm builds anyway as long as not all boards are
converted. So I think this should be ok.

> Since it is very unlikely:
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Thanks!

 Thomas
