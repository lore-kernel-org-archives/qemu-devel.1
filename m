Received: from eggs.gnu.org ([2001:4830:134:3::10]:33874)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ePl4k-0001LO-21
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 03:10:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ePl4i-00050v-U8
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 03:10:33 -0500
References: <20171213195852.30439-1-f4bug@amsat.org>
	<20171213195852.30439-7-f4bug@amsat.org>
	<CAKmqyKOSn_iVVuqF=By8g2wFYG_PeiisepJhYMrK7imETGeE7A@mail.gmail.com>
	<CAAdtpL7npoa8Qs5hARn_da39Ctf5eLZ28CMmV=prh63AxCOvYg@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2c00f0cf-f91b-69e1-38ec-c44148a7e488@redhat.com>
Date: Fri, 15 Dec 2017 09:10:17 +0100
MIME-Version: 1.0
In-Reply-To: <CAAdtpL7npoa8Qs5hARn_da39Ctf5eLZ28CMmV=prh63AxCOvYg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 06/14] sdhci: refactor same sysbus/pci
 properties into a common one
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Alistair Francis <alistair.francis@xilinx.com>, Kevin O'Connor <kevin@koconnor.net>, Gerd Hoffmann <kraxel@redhat.com>
Cc: "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Prasad J Pandit <pjp@fedoraproject.org>, Peter Maydell <peter.maydell@linaro.org>, Andrew Baumann <Andrew.Baumann@microsoft.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, Andrey Yurovsky <yurovsky@gmail.com>, Sai Pavan Boddu <saipava@xilinx.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, "open list:Block layer core" <qemu-block@nongnu.org>

On 14/12/2017 19:40, Philippe Mathieu-Daud=C3=A9 wrote:
>>> +    DEFINE_PROP_BOOL("pending-insert-quirk", SDHCIState, pending_ins=
ert_quirk,
>>> +                     false),
>> I like the reduction of code in this patch, but aren't we now going to
>> have device properties that aren't actually connected to anything?
> I'm not sure I understand, ar you worried about the PCI_SDHCI will now
> have this property but not use it?
>=20
> I couldn't find any machine using SDHCI via PCI and was tempted to
> just remove this code,

PCI devices can be created with -device, they don't have to be added by
boards.

Paolo
