Received: from eggs.gnu.org ([2001:4830:134:3::10]:55696)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fTqoo-0006v4-T2
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 11:39:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fTqoo-0006LQ-8E
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 11:39:18 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:38007)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fTqoo-0006Kw-1J
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 11:39:18 -0400
Received: by mail-oi0-x243.google.com with SMTP id d5-v6so9174886oib.5
	for <qemu-devel@nongnu.org>; Fri, 15 Jun 2018 08:39:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180614054857.26248-1-suratiamol@gmail.com>
References: <20180614054857.26248-1-suratiamol@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 15 Jun 2018 16:38:56 +0100
Message-ID: <CAFEAcA-3q0BvAz7xgm96QDkm10gESwN0k7WzTgZRSkktXyRNZA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] hw/intc/arm_gicv3: fix an extra left-shift
 when reading IPRIORITYR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Amol Surati <suratiamol@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 14 June 2018 at 06:48, Amol Surati <suratiamol@gmail.com> wrote:
> When either GICD_IPRIORITYR or GICR_IPRIORITYR is read as a 32-bit
> register, the post left-shift operator in the for loop causes an
> extra shift after the least significant byte has been placed.
>
> The 32-bit value actually returned is therefore the expected value
> shifted left by 8 bits.
>
> Signed-off-by: Amol Surati <suratiamol@gmail.com>

Oops; thanks for the bugfix.

Applied to target-arm.next, thanks.

-- PMM
