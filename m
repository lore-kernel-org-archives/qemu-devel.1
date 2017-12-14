Received: from eggs.gnu.org ([2001:4830:134:3::10]:55721)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1ePZGt-00051U-VN
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 14:34:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1ePZGs-0005En-Uj
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 14:34:19 -0500
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <CAAdtpL4gPTyMo-a0sNDN0F71wBca3gTfU0NBOr7ZHkmWDXwJow@mail.gmail.com>
References: <20171213195852.30439-1-f4bug@amsat.org>
	<20171213195852.30439-2-f4bug@amsat.org>
	<CAKmqyKNSGCndaHmpGPOYGX7jrVbse-ahT=dEdY9XQVm43=AYZg@mail.gmail.com>
	<CAAdtpL4gPTyMo-a0sNDN0F71wBca3gTfU0NBOr7ZHkmWDXwJow@mail.gmail.com>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Thu, 14 Dec 2017 11:33:47 -0800
Message-ID: <CAKmqyKPPC4Q1+ccPKw0fYxpXTrT+ui5DE-bVxiRanRhLpYof9A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 01/14] sd: split "sd-internal.h" of
 "hw/sd/sd.h"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Alistair Francis <alistair.francis@xilinx.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Prasad J Pandit <pjp@fedoraproject.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Andrew Baumann <Andrew.Baumann@microsoft.com>, Sai Pavan Boddu <saipava@xilinx.com>, Michael Walle <michael@walle.cc>, qemu-arm <qemu-arm@nongnu.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, Andrey Yurovsky <yurovsky@gmail.com>

On Thu, Dec 14, 2017 at 9:59 AM, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg> wrote:
> On Thu, Dec 14, 2017 at 2:50 PM, Alistair Francis
> <alistair.francis@xilinx.com> wrote:
>> On Wed, Dec 13, 2017 at 11:58 AM, Philippe Mathieu-Daud=C3=A9
>> <f4bug@amsat.org> wrote:
>>> Now only SD 'producers' are able to use the "sd-internal.h" API,
>>> while SD 'consumers' are restricted to the "hw/sd/sd.h" 'public' API.
>>>
>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>>
>> I don't see what this gets us. Why bother moving this code into an
>> internal header?
>
> This helped me to sort out the QOM design, however it is indeed not neces=
sary.

If it makes development easier that is a good reason. I just don't see
in this series how it helps.

>
> I later use the registerfields API to add a bunch of other registers
> and bitfields, so I prefer to still move the register #defines in
> another internal header, else this API header get pretty unreadable.

Ah, that makes some more sense.

Alistair

> I'll respin this series without this split.
>
