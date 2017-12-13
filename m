Received: from eggs.gnu.org ([2001:4830:134:3::10]:47950)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eP7Ws-0000Hz-Jx
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 08:56:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eP7Wr-00040B-RR
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 08:56:58 -0500
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:40232)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eP7Wr-0003zu-Lz
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 08:56:57 -0500
Received: by mail-oi0-x243.google.com with SMTP id w125so1579921oie.7
	for <qemu-devel@nongnu.org>; Wed, 13 Dec 2017 05:56:57 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <ac182406-8011-9f19-38e7-37328434095b@redhat.com>
References: <1512745328-5109-1-git-send-email-peter.maydell@linaro.org>
	<1512745328-5109-4-git-send-email-peter.maydell@linaro.org>
	<5A2F6ED9.5030605@huawei.com>
	<ac182406-8011-9f19-38e7-37328434095b@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 13 Dec 2017 13:56:36 +0000
Message-ID: <CAFEAcA8ySsNx-rz__Nfbmd+QM3nKbgRXJtwSYjhRRvqbokt+uQ@mail.gmail.com>
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

I have now tested this, and annoyingly UEFI and the kernel seem
to disagree about enumeration order. That is, if QEMU creates
them in the code in the order 0x09050000 (uart 2), 0x09000000 (uart 1),
then they appear in the dtb with uart 1 first, and the kernel enumerates
them as ttyAMA0 being uart 1 and ttyAMA1 being uart 2, but UEFI
outputs to uart 2...

thanks
-- PMM
