Received: from eggs.gnu.org ([2001:4830:134:3::10]:54471)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eNKIS-0006Fc-8l
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 10:10:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eNKIR-0005hy-Al
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 10:10:40 -0500
Received: from mail-ot0-x233.google.com ([2607:f8b0:4003:c0f::233]:40899)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eNKIR-0005gc-6e
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 10:10:39 -0500
Received: by mail-ot0-x233.google.com with SMTP id e74so9395111ote.7
	for <qemu-devel@nongnu.org>; Fri, 08 Dec 2017 07:10:39 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1512745328-5109-1-git-send-email-peter.maydell@linaro.org>
References: <1512745328-5109-1-git-send-email-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 8 Dec 2017 15:10:18 +0000
Message-ID: <CAFEAcA9RmXV_Q4VML51422n2VGDewDqsi4BVe+Jb9YE9dCTf2A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 0/3] hw/arm/virt: Add another
 UART
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Cc: "Jason A . Donenfeld" <Jason@zx2c4.com>, Shannon Zhao <zhaoshenglong@huawei.com>

On 8 December 2017 at 15:02, Peter Maydell <peter.maydell@linaro.org> wrote:
> This patchset adds a second UART to the ARM virt board, which
> can be useful in some cases where you'd like a second comms
> channel but don't want have to deal with PCI to get it.
>
> Patch 3 attempts to add it to the ACPI tables, but this is
> entirely untested and pure guesswork, since I don't really
> know anything about ACPI. That patch needs review from
> somebody who does know ACPI :-)
>
> thanks
> -- PMM
>
> Peter Maydell (3):
>   hw/arm/virt: Add virt-2.12 machine type
>   hw/arm/virt: Add another UART to the virt board
>   hw/arm/virt-acpi-build: Add second UART to ACPI tables

Oops, Shannon's linaro email in MAINTAINERS bounces; re-cc'ing
with the huawei one.

thanks
-- PMM
