Received: from eggs.gnu.org ([2001:4830:134:3::10]:39318)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eOiTb-0001Hu-Cb
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 06:11:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eOiTa-0008FZ-Jt
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 06:11:55 -0500
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:44647)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eOiTa-0008FD-E8
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 06:11:54 -0500
Received: by mail-oi0-x242.google.com with SMTP id l6so13720840oih.11
	for <qemu-devel@nongnu.org>; Tue, 12 Dec 2017 03:11:54 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <ac182406-8011-9f19-38e7-37328434095b@redhat.com>
References: <1512745328-5109-1-git-send-email-peter.maydell@linaro.org>
	<1512745328-5109-4-git-send-email-peter.maydell@linaro.org>
	<5A2F6ED9.5030605@huawei.com>
	<ac182406-8011-9f19-38e7-37328434095b@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 12 Dec 2017 11:11:33 +0000
Message-ID: <CAFEAcA_9pee99KpL4zwVS5jJuiv2MCGp79crufpU1kH1Okg-Hg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 3/3] hw/arm/virt-acpi-build: Add second
 UART to ACPI tables
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: Shannon Zhao <zhaoshenglong@huawei.com>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "Jason A . Donenfeld" <Jason@zx2c4.com>, Drew Jones <drjones@redhat.com>, Andrea Bolognani <abologna@redhat.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>

On 12 December 2017 at 11:06, Laszlo Ersek <lersek@redhat.com> wrote:
> BTW, has anyone tested this with the ArmVirtQemu firmware? As far as I
> can see from the firmware code, the firmware will use the PL011 whose
> description comes first in the DTB (and ignore the other PL011), in an
> fdt_next_node() traversal. Is that OK for the intended use case?
> (Perhaps I should have asked this under the second patch, which updates
> the DTB generator.)

I haven't tested, since I don't have a working setup for that to hand.
(Do you have instructions somewhere for getting it working?)

The behaviour we would want would be for the firmware to keep using
the PL011 at 0x09000000. (In an ideal world the firmware would
prefer the UART marked in the 'stdout-path' in the DTB /chosen node,
as the kernel does, I guess.)

thanks
-- PMM
