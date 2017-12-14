Received: from eggs.gnu.org ([2001:4830:134:3::10]:58472)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePXnN-0007xm-Vs
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 12:59:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePXnN-0004VE-Ax
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 12:59:46 -0500
MIME-Version: 1.0
Sender: philippe.mathieu.daude@gmail.com
In-Reply-To: <CAKmqyKNSGCndaHmpGPOYGX7jrVbse-ahT=dEdY9XQVm43=AYZg@mail.gmail.com>
References: <20171213195852.30439-1-f4bug@amsat.org>
	<20171213195852.30439-2-f4bug@amsat.org>
	<CAKmqyKNSGCndaHmpGPOYGX7jrVbse-ahT=dEdY9XQVm43=AYZg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 14 Dec 2017 14:59:41 -0300
Message-ID: <CAAdtpL4gPTyMo-a0sNDN0F71wBca3gTfU0NBOr7ZHkmWDXwJow@mail.gmail.com>
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
To: Alistair Francis <alistair.francis@xilinx.com>
Cc: "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Prasad J Pandit <pjp@fedoraproject.org>, Peter Maydell <peter.maydell@linaro.org>, Michael Walle <michael@walle.cc>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, Andrzej Zaborowski <balrogg@gmail.com>, Andrew Baumann <Andrew.Baumann@microsoft.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, Andrey Yurovsky <yurovsky@gmail.com>, Sai Pavan Boddu <saipava@xilinx.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, qemu-arm <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

On Thu, Dec 14, 2017 at 2:50 PM, Alistair Francis
<alistair.francis@xilinx.com> wrote:
> On Wed, Dec 13, 2017 at 11:58 AM, Philippe Mathieu-Daud=C3=A9
> <f4bug@amsat.org> wrote:
>> Now only SD 'producers' are able to use the "sd-internal.h" API,
>> while SD 'consumers' are restricted to the "hw/sd/sd.h" 'public' API.
>>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>
> I don't see what this gets us. Why bother moving this code into an
> internal header?

This helped me to sort out the QOM design, however it is indeed not necessa=
ry.

I later use the registerfields API to add a bunch of other registers
and bitfields, so I prefer to still move the register #defines in
another internal header, else this API header get pretty unreadable.
I'll respin this series without this split.
