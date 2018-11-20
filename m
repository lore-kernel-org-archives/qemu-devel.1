Received: from eggs.gnu.org ([2001:4830:134:3::10]:55268)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1gP45G-0008Eg-Fc
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 06:20:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1gP45F-0000zW-AU
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 06:20:46 -0500
References: <1542657473-9196-1-git-send-email-thuth@redhat.com>
	<CAFEAcA_xhYf0VNaq1gM1OWWCkms5sTpn3kdqSHN0AZ3cH1f8Dw@mail.gmail.com>
	<27dd52ce-1cd6-0a92-635c-20ce1c9d5c2b@redhat.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <62488962-e0bc-e116-cc2d-699c4cd1cbe7@redhat.com>
Date: Tue, 20 Nov 2018 12:20:35 +0100
MIME-Version: 1.0
In-Reply-To: <27dd52ce-1cd6-0a92-635c-20ce1c9d5c2b@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] MAINTAINERS: Assign some more files in the
 hw/arm/ directory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Jean-Christophe Dubois <jcd@tribudubois.net>

Hi Thomas,

On 11/20/18 12:05 PM, Thomas Huth wrote:
> On 2018-11-20 11:19, Peter Maydell wrote:
>> On 19 November 2018 at 19:57, Thomas Huth <thuth@redhat.com> wrote:
>>> I apparently missed some more files and even a complete machine (the
>>> "imx25-pdk") in my previous patch... but now we should hopefully have
>>> a completely coverage for all available ARM boards.
>>
>> Hi; looks like you forgot to cc qemu-devel.
>=20
> Oops, sorry about that.
>=20
>>> Fixes: 95a5db3ae5698b49c63144610ad02913e780c828
>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>> ---
>>>  MAINTAINERS | 16 ++++++++++++++++
>>>  1 file changed, 16 insertions(+)
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index 1032406..ac20dc8 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -533,6 +533,18 @@ L: qemu-arm@nongnu.org
>>>  S: Odd Fixes
>>>  F: hw/arm/gumstix.c
>>>
>>> +i.MX25 PDK
>>> +M: Peter Maydell <peter.maydell@linaro.org>
>>> +R: Jean-Christophe Dubois <jcd@tribudubois.net>
>>> +L: qemu-arm@nongnu.org
>>> +S: Odd Fixes
>>> +F: hw/arm/fsl-imx25.c
>>> +F: hw/arm/imx25_pdk.c
>>> +F: hw/misc/imx25_ccm.c
>>> +F: include/hw/arm/fsl-imx25.h
>>> +F: include/hw/misc/imx25_ccm.h
>>> +F: tests/ds1338-test.c
>>> +
>>>  i.MX31 (kzm)
>>>  M: Peter Chubb <peter.chubb@nicta.com.au>
>>>  M: Peter Maydell <peter.maydell@linaro.org>
>>> @@ -615,6 +627,7 @@ R: Andrew Baumann <Andrew.Baumann@microsoft.com>
>>>  R: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>>>  L: qemu-arm@nongnu.org
>>>  S: Odd Fixes
>>> +F: hw/arm/raspi.c
>>>  F: hw/arm/raspi_platform.h
>>>  F: hw/*/bcm283*
>>>  F: include/hw/arm/raspi*
>>> @@ -641,6 +654,7 @@ F: hw/arm/z2.c
>>>  F: hw/*/pxa2xx*
>>>  F: hw/misc/mst_fpga.c
>>>  F: include/hw/arm/pxa.h
>>> +F: include/hw/arm/sharpsl.h
>>>
>>>  SABRELITE / i.MX6
>>>  M: Peter Maydell <peter.maydell@linaro.org>
>>> @@ -686,7 +700,9 @@ M: Peter Maydell <peter.maydell@linaro.org>
>>>  L: qemu-arm@nongnu.org
>>>  S: Maintained
>>>  F: hw/arm/virt*
>>> +F: hw/arm/smmu*
>>>  F: include/hw/arm/virt.h
>>> +F: include/hw/arm/smmu*
>>
>> The SMMU files aren't part of the virt board, they're
>> the SMMUv3 device model. They should go in a section
>> that lets us mark Eric Auger as their maintainer.
>=20
> Ok, I'll send a v2 without the smmu* files. Eric, could you please take
> care of sending a patch for a new SMMU section?
Yes sure.

Thanks

Eric
>=20
>  Thomas
>=20
