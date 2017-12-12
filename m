Received: from eggs.gnu.org ([2001:4830:134:3::10]:55178)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eOjLx-0004dX-KC
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 07:08:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eOjLs-0003uM-0s
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 07:08:05 -0500
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:41141)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eOjLr-0003tx-SA
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 07:07:59 -0500
Received: by mail-oi0-x241.google.com with SMTP id t78so13823734oie.8
	for <qemu-devel@nongnu.org>; Tue, 12 Dec 2017 04:07:59 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <5e3798f7-e280-b6c3-1504-828283617c52@redhat.com>
References: <1512745328-5109-1-git-send-email-peter.maydell@linaro.org>
	<1512745328-5109-4-git-send-email-peter.maydell@linaro.org>
	<5A2F6ED9.5030605@huawei.com>
	<ac182406-8011-9f19-38e7-37328434095b@redhat.com>
	<CAFEAcA_9pee99KpL4zwVS5jJuiv2MCGp79crufpU1kH1Okg-Hg@mail.gmail.com>
	<6b4b6351-eeb4-a4d3-8ddf-5401516671ae@redhat.com>
	<CAKv+Gu-Ugm1g8twoKwgXAPtDfETvXntk2h4WzMVuUTDF7GhMvA@mail.gmail.com>
	<5e3798f7-e280-b6c3-1504-828283617c52@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 12 Dec 2017 12:07:38 +0000
Message-ID: <CAFEAcA_+NnpeP9Le7bp9yrYQDwtuP79pt8GpVzJ4RBDMx1iomA@mail.gmail.com>
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
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>, Shannon Zhao <zhaoshenglong@huawei.com>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "Jason A . Donenfeld" <Jason@zx2c4.com>, Drew Jones <drjones@redhat.com>, Andrea Bolognani <abologna@redhat.com>

On 12 December 2017 at 11:59, Laszlo Ersek <lersek@redhat.com> wrote:
> Peter, what is the intended use of the second UART?

Per the commit message:
# there are some
# use cases where having a second UART would be useful (like
# bare-metal testing where you don't really want to have to
# probe and set up a PCI device just to have a second comms
# channel).

>From QEMU's point of view this is just "some people would like
more than one UART, x86 provides more than one UART, it's
easy to provide an extra UART and it's up to the guest what
it would like to do with it". If there's utility for the
OVMF firmware in having 2 UARTs that's doubly good reason
to have it.

thanks
-- PMM
