Received: from eggs.gnu.org ([2001:4830:134:3::10]:58576)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ePADC-0006Rp-1S
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 11:48:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ePADB-0001Su-Ai
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 11:48:50 -0500
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:44376)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ePADB-0001SU-5w
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 11:48:49 -0500
Received: by mail-oi0-x242.google.com with SMTP id l6so1964438oih.11
	for <qemu-devel@nongnu.org>; Wed, 13 Dec 2017 08:48:49 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu-uPf9QLobM1Vqdek_rSPfZcAXV24Ybg83hZvHbH5LqHw@mail.gmail.com>
References: <1512745328-5109-1-git-send-email-peter.maydell@linaro.org>
	<1512745328-5109-4-git-send-email-peter.maydell@linaro.org>
	<5A2F6ED9.5030605@huawei.com>
	<ac182406-8011-9f19-38e7-37328434095b@redhat.com>
	<CAFEAcA8ySsNx-rz__Nfbmd+QM3nKbgRXJtwSYjhRRvqbokt+uQ@mail.gmail.com>
	<0355e1ee-2f48-81ce-55e6-bed7bdeac771@redhat.com>
	<CAKv+Gu-uPf9QLobM1Vqdek_rSPfZcAXV24Ybg83hZvHbH5LqHw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 13 Dec 2017 16:48:27 +0000
Message-ID: <CAFEAcA-P-bmHORpS15nowroWkM0yXgvdP2dmb5sp7RBaT4m_Aw@mail.gmail.com>
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
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Laszlo Ersek <lersek@redhat.com>, Shannon Zhao <zhaoshenglong@huawei.com>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "Jason A . Donenfeld" <Jason@zx2c4.com>, Drew Jones <drjones@redhat.com>, Andrea Bolognani <abologna@redhat.com>

On 13 December 2017 at 16:46, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> The kernel uses the contents of the SPCR table or /chosen/stdout-path
> as the console unless overridden on the kernel command line. This is
> independent of enumeration order.

True, but we don't want to assign ttyAMA0 and ttyAMA1 to the
UARTs arbitrarily -- ttyAMA0 must continue to be the one
at address 0x09000000, or we break commandlines.

thanks
-- PMM
