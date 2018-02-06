Received: from eggs.gnu.org ([2001:4830:134:3::10]:46401)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ej2Gz-0001iu-Fd
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 07:22:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ej2Gu-0006kd-5S
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 07:22:53 -0500
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:37753)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ej2Gt-0006kW-Sn
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 07:22:48 -0500
Received: by mail-qt0-x242.google.com with SMTP id s27so1886907qts.4
	for <qemu-devel@nongnu.org>; Tue, 06 Feb 2018 04:22:47 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180123020820.1288-1-f4bug@amsat.org>
	<0090cd85-3277-3c8c-5399-0681bbe2ab86@amsat.org>
	<CAKmqyKMA9RteZfQruGj9zhtOe_Sm4XnL7U-CtkXW4Pjd7pRVRQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <6a429aa1-4f12-20a1-8d37-834998e5dce5@amsat.org>
Date: Tue, 6 Feb 2018 09:22:40 -0300
MIME-Version: 1.0
In-Reply-To: <CAKmqyKMA9RteZfQruGj9zhtOe_Sm4XnL7U-CtkXW4Pjd7pRVRQ@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="SBWo8s5cCr3JvVyYOBDxmyAX9g7GORtgg"
Subject: Re: [Qemu-devel] [PATCH v9 00/16] SDHCI: clean v1/v2 Specs (part 2)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Krzysztof Kozlowski <krzk@kernel.org>, Kevin O'Connor <kevin@koconnor.net>, Marcel Apfelbaum <marcel@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--SBWo8s5cCr3JvVyYOBDxmyAX9g7GORtgg
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
To: Alistair Francis <alistair.francis@xilinx.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Krzysztof Kozlowski <krzk@kernel.org>, Kevin O'Connor <kevin@koconnor.net>,
 Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <6a429aa1-4f12-20a1-8d37-834998e5dce5@amsat.org>
Subject: Re: [Qemu-devel] [PATCH v9 00/16] SDHCI: clean v1/v2 Specs (part 2)
References: <20180123020820.1288-1-f4bug@amsat.org>
 <0090cd85-3277-3c8c-5399-0681bbe2ab86@amsat.org>
 <CAKmqyKMA9RteZfQruGj9zhtOe_Sm4XnL7U-CtkXW4Pjd7pRVRQ@mail.gmail.com>
In-Reply-To: <CAKmqyKMA9RteZfQruGj9zhtOe_Sm4XnL7U-CtkXW4Pjd7pRVRQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/31/2018 01:26 PM, Alistair Francis wrote:
> On Wed, Jan 31, 2018 at 6:09 AM, Philippe Mathieu-Daud=C3=A9 <f4bug@ams=
at.org> wrote:
>> ping?
>>
>> Patches missing review: 2 (PCI qtesting),11,13,15
>=20
> Sorry about the slowness. Besides 2 they should be all reviewed now,
> let me know if anything else needs to be done.

Thanks for reviewing the whole series!

> As for 2 I don't have much experience with Qtest, I'll try to go over
> it, but ideally someone who knows Qtest should look at it.

Yes. This patch is provided for completeness but is not
required/blocking. I can split it away for later and respin.

Paolo/Stefan do you mind reviewing patch #2?
It uses the qpci API to access the SDHCI via PCI, as suggested
2 months ago when I started SDHCI qtesting.

Thanks,

Phil.

>> On 01/22/2018 11:08 PM, Philippe Mathieu-Daud=C3=A9 wrote:
>>> Since v8:
>>> - we keep the 'capareg' property, this simplify a lot the series
>>> - the Zynq 7000 uses the datasheet CAPAREG
>>> - reset R-b/A-b
>>>
>>> Since v7:
>>> - use error_propagate()
>>>
>>> Since v6:
>>> - rebased on upstream to use DEFINE_SDHCI_COMMON_PROPERTIES
>>> - included qtests back
>>> - add PCI qtests
>>> - series was getting big, splitting again; next one is "implement Spe=
c v3"
>>> - following Alistair advice, new properties default to current
>>>   SDHC_CAPAB_REG_DEFAULT (probably 'default' for historical reason, b=
eing
>>>   the first capabilities set). This leads to weird properties imho, i=
=2Ee.
>>>   defaulting 'max-frequency' to 52 MHz, the Exynos SoC has to set thi=
s
>>>   property to 0.
>>> - addressed Alistair reviews
>>> - confirmed the Exynos4210 specs after chatting on IRC with Krzysztof=

>>>   Kozlowski who kindly verified in the datasheet.
>>>
>>> Since v5:
>>> - addressed Alistair reviews
>>> - dropped "abstract generic-sdhci"
>>> - dropped Linux Device Tree names
>>> - split qtests in another series
>>> - change the bcm2835 minimum blocksize to 1KB (Andrew Baumann)
>>> - added Alistair R-b
>>> - based on Alistair work:
>>>   - add SD tunning sequence via Host Control 2 to use UHS-I cards
>>>   - add CMD/DAT[] fields in the Present State (used in next series
>>>     to switch card voltage)
>>>
>>> based on Alistair work:
>>> - add SD tunning sequence via Host Control 2 to use UHS-I cards
>>> - add CMD/DAT[] fields in the Present State (used in next series
>>>   to switch card voltage)
>>>
>>> Since v4 ("SDHCI: add qtests and fix few issues"):
>>> - spec_version default to v2 (current behaviour)
>>> - addressed Alistair review (no v1, tell user about valid version)
>>>
>>> Since v3:
>>> - no change, but split back in 2 series, 1st part is "SDHCI: housekee=
ping v5",
>>>
>>> Since v2:
>>> - more detailed 'capabilities', all boards converted to use these pro=
perties
>>> - since all qtests pass, removed the previous 'capareg' property
>>> - added Stefan/Alistair R-b
>>> - corrected 'access' LED behavior (Alistair's review)
>>> - more uses of the registerfields API
>>> - remove some dead code
>>> - cosmetix:
>>>   - added more comments
>>>   - renamed a pair of registers
>>>   - reordered few struct members
>>>
>>> Since v1:
>>> - addressed Alistair Francis review comments, added some R-b
>>> - only move register defines to "sd-internal.h"
>>> - fixed deposit64() arguments
>>> - dropped unuseful s->fifo_buffer =3D NULL
>>> - use a qemu_irq for the LED, restrict the logging to ON/OFF
>>> - fixed a trace format string error
>>> - included Andrey Smirnov ACMD12ERRSTS write patch
>>> - dropped few unuseful patches, and separate the Python polemical one=
s for later
>>>
>>> From the "SDHCI housekeeping" series:
>>> - 1: we restrict part of "sd/sd.h" into local "sd-internal.h",
>>> - 2,3: we somehow beautiful the code, no logical changes,
>>> - 4-7: we refactor the common sysbus/pci qdev code,
>>> - 8-10: we add plenty of trace events which will result useful later,=

>>> - 11: we finally expose a "dma-memory" property.
>>> From the "SDHCI: add a qtest and fix few issues" series:
>>> - 12,13: fix registers
>>> - 14,15: boards can specify which SDHCI Spec to use (v2 and v3 so far=
)
>>> - 15-20: HCI qtest
>>>
>>> Regards,
>>>
>>> Phil.
>>>
>>> $ git backport-diff with v8
>>> 001/16:[----] [--] 'sdhci: use error_propagate(local_err) in realize(=
)'
>>> 002/16:[0004] [FC] 'sdhci: add qtest to check the SD capabilities reg=
ister'
>>> 003/16:[----] [--] 'sdhci: add check_capab_readonly() qtest'
>>> 004/16:[----] [--] 'sdhci: add a check_capab_baseclock() qtest'
>>> 005/16:[----] [--] 'sdhci: add a check_capab_sdma() qtest'
>>> 006/16:[----] [--] 'sdhci: add qtest to check the SD Spec version'
>>> 007/16:[0022] [FC] 'sdhci: add a 'spec_version property' (default to =
v2)'
>>> 008/16:[down] 'sdhci: use a numeric value for the default CAPAB regis=
ter'
>>> 009/16:[down] 'sdhci: simplify sdhci_get_fifolen()'
>>> 010/16:[down] 'sdhci: check the Spec v1 capabilities correctness'
>>> 011/16:[----] [--] 'sdhci: add BLOCK_SIZE_MASK for DMA'
>>> 012/16:[----] [--] 'sdhci: Fix 64-bit ADMA2'
>>> 013/16:[down] 'sdhci: check Spec v2 capabilities (DMA and 64-bit bus)=
'
>>> 014/16:[down] 'hw/arm/exynos4210: access the 64-bit capareg with qdev=
_prop_set_uint64()'
>>> 015/16:[down] 'hw/arm/exynos4210: add a comment about a very similar =
SDHCI (Spec. v2)'
>>> 016/16:[down] 'hw/arm/xilinx_zynq: fix the capabilities register to m=
atch the datasheet'
>>>
>>> Philippe Mathieu-Daud=C3=A9 (15):
>>>   sdhci: use error_propagate(local_err) in realize()
>>>   sdhci: add qtest to check the SD capabilities register
>>>   sdhci: add check_capab_readonly() qtest
>>>   sdhci: add a check_capab_baseclock() qtest
>>>   sdhci: add a check_capab_sdma() qtest
>>>   sdhci: add qtest to check the SD Spec version
>>>   sdhci: add a 'spec_version property' (default to v2)
>>>   sdhci: use a numeric value for the default CAPAB register
>>>   sdhci: simplify sdhci_get_fifolen()
>>>   sdhci: check the Spec v1 capabilities correctness
>>>   sdhci: add BLOCK_SIZE_MASK for DMA
>>>   sdhci: check Spec v2 capabilities (DMA and 64-bit bus)
>>>   hw/arm/exynos4210: access the 64-bit capareg with qdev_prop_set_uin=
t64()
>>>   hw/arm/exynos4210: add a comment about a very similar SDHCI (Spec. =
v2)
>>>   hw/arm/xilinx_zynq: fix the capabilities register to match the data=
sheet
>>>
>>> Sai Pavan Boddu (1):
>>>   sdhci: Fix 64-bit ADMA2
>>>
>>>  include/hw/sd/sdhci.h  |   2 +
>>>  hw/sd/sdhci-internal.h |  43 ++++++---
>>>  hw/arm/exynos4210.c    |  14 ++-
>>>  hw/arm/xilinx_zynq.c   |  53 +++++-----
>>>  hw/sd/sdhci.c          | 257 ++++++++++++++++++++++++++++++++-------=
----------
>>>  tests/sdhci-test.c     | 216 +++++++++++++++++++++++++++++++++++++++=
++
>>>  hw/sd/trace-events     |   1 +
>>>  tests/Makefile.include |   3 +
>>>  8 files changed, 464 insertions(+), 125 deletions(-)
>>>  create mode 100644 tests/sdhci-test.c
>>>
>>


--SBWo8s5cCr3JvVyYOBDxmyAX9g7GORtgg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+qvnXhKRciHc/Wuy4+MsLN6twN4FAlp5nhAACgkQ4+MsLN6t
wN4b6BAApQ4ecIFkDjHMDlVpd/O28UONb87D4r4+5laKxMoC9KsQpshUstkxASQk
wZcY8fG4d1pr0a4EwvwsVUyHr/vyTNj3RdpU1h99oW6Mn/HqX6kv8kwl2CzYeSwK
9BPy4xu2Zq+s7JjvGliZ2ChFSeQQg/elHmXdzSwsgm8RrWQEXEPRF2aqGCG3+AO9
LHpvA6y9GhEcD0goSqt+KoqcF1QBuRj/Lfi+KYv5RaQAySYjpdkSxPUD/y9dYZhL
KwL4VqXrN65f3XuThwE8XhzYWORJrJHy4Ftf2VrvyBoR5CQSYs0yUaxPlt3SWiAQ
8yT9SHBgWsywGMT1TFlojvGYSDAtNKGwnOFidP0iqhk/zNcTaqJATecNfLPXIeLY
Ss6kIMAzvlUoYwMps4P3SBZoGyQzdh1wKFC2J5PMx/XRMiF2zIezsU1m/3GN+NV/
RwDoaxP26s5OBYC//HqlFjX/+UZiwd3ei1yX3tXYbtggBB7CP4OCIISw14N1JSuK
qGx+Xn53abOXo92FXtGYni8evmllkymYDl2RSlrpaDquQUSJSB80XKUFfWIVg/gg
sR0S8qiOElvdQDuXiQbMw7brf0/3QieEkvu4p412nyUNCtE1X5P4nqngZtBzgeVQ
EOHarvR/jK9stzNfKoHwXyLLSYsR31Labfh4naEn6tjtArVlJdY=
=6Y+8
-----END PGP SIGNATURE-----

--SBWo8s5cCr3JvVyYOBDxmyAX9g7GORtgg--
