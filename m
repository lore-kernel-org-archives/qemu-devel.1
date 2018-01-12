Received: from eggs.gnu.org ([2001:4830:134:3::10]:60763)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ea2mE-0001Wv-Oy
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 12:06:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ea2m8-0007p2-1N
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 12:05:58 -0500
Received: from mail-ot0-x234.google.com ([2607:f8b0:4003:c0f::234]:46881)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ea2m7-0007oa-Pz
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 12:05:51 -0500
Received: by mail-ot0-x234.google.com with SMTP id f6so5578444oti.13
	for <qemu-devel@nongnu.org>; Fri, 12 Jan 2018 09:05:51 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180111193021.17466-4-f4bug@amsat.org>
References: <20180111193021.17466-1-f4bug@amsat.org>
	<20180111193021.17466-4-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 12 Jan 2018 17:05:30 +0000
Message-ID: <CAFEAcA8UvqmtzxcQrDWF24OQsBek0s2uYPOsoCs5YqH80MpXnw@mail.gmail.com>
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
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Alistair Francis <alistair.francis@xilinx.com>, QEMU Developers <qemu-devel@nongnu.org>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Andrey Smirnov <andrew.smirnov@gmail.com>

On 11 January 2018 at 19:30, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> =
wrote:
> Now both sysbus/pci classes inherit of the 'pending-insert-quirk' propert=
y,
> which is a HCI dependent property (regardless if accessed through a MMIO
> sysbus or a PCI bus).
> So far only the BCM implementation has to use it.
>
> Add sysbus/pci/sdbus comments to have clearer code blocks separation.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>

I'm not sure about this patch, because it means that we now have
no mechanism for having a property which exists on the sysbus
device but not on the PCI device (and as per my comments on the
last patch in this set, we do need to be able to do that).

thanks
-- PMM
