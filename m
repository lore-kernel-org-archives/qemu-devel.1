Received: from eggs.gnu.org ([2001:4830:134:3::10]:39935)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gPLx3-0002A3-SP
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 01:25:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gPLx3-000334-24
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 01:25:29 -0500
References: <1542735761-16176-1-git-send-email-thuth@redhat.com>
	<3bfff029-f88a-ef68-846c-1cacd0800d26@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <297db2f1-e817-c155-337e-4d34553061f0@redhat.com>
Date: Wed, 21 Nov 2018 07:25:16 +0100
MIME-Version: 1.0
In-Reply-To: <3bfff029-f88a-ef68-846c-1cacd0800d26@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] MAINTAINERS: Assign some more files in
 the hw/arm/ directory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Jean-Christophe Dubois <jcd@tribudubois.net>

On 2018-11-20 21:23, Philippe Mathieu-Daud=C3=A9 wrote:
> On 20/11/18 18:42, Thomas Huth wrote:
>> I apparently missed some more files and even a complete machine (the
>> "imx25-pdk") in my previous patch... but now we should hopefully have
>> a completely coverage for all available ARM boards.
>>
>> Fixes: 95a5db3ae5698b49c63144610ad02913e780c828
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>> =C2=A0 v2: Dropped smmu* files from this patch
>>
>> =C2=A0 MAINTAINERS | 14 ++++++++++++++
>> =C2=A0 1 file changed, 14 insertions(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 1032406..36ffc01 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -533,6 +533,18 @@ L: qemu-arm@nongnu.org
>> =C2=A0 S: Odd Fixes
>> =C2=A0 F: hw/arm/gumstix.c
>> =C2=A0 +i.MX25 PDK
>> +M: Peter Maydell <peter.maydell@linaro.org>
>> +R: Jean-Christophe Dubois <jcd@tribudubois.net>
>> +L: qemu-arm@nongnu.org
>> +S: Odd Fixes
>> +F: hw/arm/fsl-imx25.c
>> +F: hw/arm/imx25_pdk.c
>> +F: hw/misc/imx25_ccm.c
>> +F: include/hw/arm/fsl-imx25.h
>> +F: include/hw/misc/imx25_ccm.h
>=20
>> +F: tests/ds1338-test.c
>=20
> This last entry is weird alone (at least without the hw/timer/ds1338.c
> device listed).
>=20
> This RTC is also used by the aspeed/realview/versatilepb boards.

You're right. I've added it since the test uses "-machine imx25-pdk",
but the correct way is likely to add a separate section for the timer
device instead. I'll remove this line in v3.

>> +
>> =C2=A0 i.MX31 (kzm)
>> =C2=A0 M: Peter Chubb <peter.chubb@nicta.com.au>
>> =C2=A0 M: Peter Maydell <peter.maydell@linaro.org>
>> @@ -615,6 +627,7 @@ R: Andrew Baumann <Andrew.Baumann@microsoft.com>
>> =C2=A0 R: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>> =C2=A0 L: qemu-arm@nongnu.org
>> =C2=A0 S: Odd Fixes
>> +F: hw/arm/raspi.c
>> =C2=A0 F: hw/arm/raspi_platform.h
>> =C2=A0 F: hw/*/bcm283*
>> =C2=A0 F: include/hw/arm/raspi*
>> @@ -641,6 +654,7 @@ F: hw/arm/z2.c
>> =C2=A0 F: hw/*/pxa2xx*
>> =C2=A0 F: hw/misc/mst_fpga.c
>> =C2=A0 F: include/hw/arm/pxa.h
>> +F: include/hw/arm/sharpsl.h
>=20
> I think hw/gpio/zaurus.c goes there too.

Well spotted. I'll add it in v3.

And I think we should add hw/display/tc6393xb.c here as well.

 Thomas
