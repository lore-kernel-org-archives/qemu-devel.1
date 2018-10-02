Received: from eggs.gnu.org ([2001:4830:134:3::10]:43426)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g7IMu-0006z3-Uq
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 06:57:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g7IMu-0006Hx-42
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 06:57:32 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:43667)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1g7IMt-0006Hq-Sf
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 06:57:31 -0400
Received: by mail-ot1-x341.google.com with SMTP id e21-v6so1403622otk.10
	for <qemu-devel@nongnu.org>; Tue, 02 Oct 2018 03:57:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <539cfb28-e4bc-f7d4-6ed9-881bc0cab8bc@kaod.org>
References: <20180921161939.822-1-clg@kaod.org>
	<CAFEAcA_Nm7qX1w16spsW-VgsMOebW=tNo9VT0paws7+9YH+zZQ@mail.gmail.com>
	<539cfb28-e4bc-f7d4-6ed9-881bc0cab8bc@kaod.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 2 Oct 2018 11:57:10 +0100
Message-ID: <CAFEAcA-X7QdyjU9_aM9RAm-GZZWezyx-toEdT5vf-1P=XkdX-Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 00/11] aspeed: misc fixes and
 enhancements (SMC)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>, Alistair Francis <alistair@alistair23.me>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>

On 25 September 2018 at 15:10, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
> On 9/25/18 2:20 PM, Peter Maydell wrote:
>> On 21 September 2018 at 17:19, C=C3=A9dric Le Goater <clg@kaod.org> wrot=
e:
>>> Hello,
>>>
>>> This series adds a couple of cleanups and two main features to the
>>> SMC controller of the Aspeed machines :
>>>
>>>  - a 'execute-in-place' property to boot directly from a memory region
>>>    alias of the FMC flash module using MMIO execution. This is not
>>>    activated by default because boot time needs to be improved on
>>>    recent firmwares. It also breaks migration compatibility.
>>>
>>>  - support for DMA to access the flash modules. Our primary need is
>>>    the checksum calculation which is used to evaluate the best clock
>>>    settings for reads.
>>
>> I've picked out the easy parts of this series and added
>> them to target-arm.next:
>>
>>>   aspeed/timer: fix compile breakage with clang 3.4.2
>>>   hw/arm/aspeed: change the FMC flash model of the AST2500 evb
>>>   hw/arm/aspeed: Add an Aspeed machine class
>>>   aspeed/smc: fix some alignment issues
>>
>> and left the rest for the moment (I've still got this series
>> on my to-review list).
>
> I will wait for your comments on the DMA part before resending.

I've now commented on that patch. I think I'm done with review on
this version, unless there's something specific you want more
input on ?

thanks
-- PMM
