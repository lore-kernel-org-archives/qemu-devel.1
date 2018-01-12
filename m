Received: from eggs.gnu.org ([2001:4830:134:3::10]:39158)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ea30c-0002D2-DJ
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 12:20:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ea30b-0004Qy-F0
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 12:20:50 -0500
Received: from mail-io0-x242.google.com ([2607:f8b0:4001:c06::242]:34182)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ea30b-0004QH-Ae
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 12:20:49 -0500
Received: by mail-io0-x242.google.com with SMTP id c17so6621111iod.1
	for <qemu-devel@nongnu.org>; Fri, 12 Jan 2018 09:20:49 -0800 (PST)
MIME-Version: 1.0
Sender: philippe.mathieu.daude@gmail.com
In-Reply-To: <CAFEAcA8UvqmtzxcQrDWF24OQsBek0s2uYPOsoCs5YqH80MpXnw@mail.gmail.com>
References: <20180111193021.17466-1-f4bug@amsat.org>
	<20180111193021.17466-4-f4bug@amsat.org>
	<CAFEAcA8UvqmtzxcQrDWF24OQsBek0s2uYPOsoCs5YqH80MpXnw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Fri, 12 Jan 2018 14:20:48 -0300
Message-ID: <CAAdtpL7Dz3kQyVYZy9iUvy-iFRZMD-+3o0Gsfb=HOzpMgDTkhw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 03/13] sdhci: refactor same sysbus/pci
 properties into a common one
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, Alistair Francis <alistair.francis@xilinx.com>

On Fri, Jan 12, 2018 at 2:05 PM, Peter Maydell <peter.maydell@linaro.org> w=
rote:
> On 11 January 2018 at 19:30, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org=
> wrote:
>> Now both sysbus/pci classes inherit of the 'pending-insert-quirk' proper=
ty,
>> which is a HCI dependent property (regardless if accessed through a MMIO
>> sysbus or a PCI bus).
>> So far only the BCM implementation has to use it.
>>
>> Add sysbus/pci/sdbus comments to have clearer code blocks separation.
>>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>> Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
>
> I'm not sure about this patch, because it means that we now have
> no mechanism for having a property which exists on the sysbus
> device but not on the PCI device (and as per my comments on the
> last patch in this set, we do need to be able to do that).

This might be what Alistair tried to explain me in his previous reviews...

I'll respin, thanks!

Phil.
