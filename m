Received: from eggs.gnu.org ([2001:4830:134:3::10]:45034)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fgBii-0007XZ-Up
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 12:24:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fgBii-0003P1-7u
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 12:24:00 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:37031)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fgBih-0003ON-Qv
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 12:24:00 -0400
Received: by mail-oi0-x244.google.com with SMTP id k81-v6so16039220oib.4
	for <qemu-devel@nongnu.org>; Thu, 19 Jul 2018 09:23:59 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180718095628.26442-1-jusual@mail.ru>
References: <20180718095628.26442-1-jusual@mail.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 19 Jul 2018 17:23:38 +0100
Message-ID: <CAFEAcA_YsV4MYw55y8dwg2FAT40=He0NvYqJQ3mvdxS8czJJkw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2] arm: Add ARMv6-M programmer's model
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Julia Suvorova <jusual@mail.ru>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, =?UTF-8?Q?Steffen_G=C3=B6rtz?= <mail@steffen-goertz.de>

On 18 July 2018 at 10:56, Julia Suvorova <jusual@mail.ru> wrote:
> Forbid stack alignment change. (CCR)
> Reserve FAULTMASK, BASEPRI registers.
> Report any fault as a HardFault. Disable MemManage, BusFault and
> UsageFault, so they always escalated to HardFault. (SHCSR)
>
> Signed-off-by: Julia Suvorova <jusual@mail.ru>
> ---
> v2:
>     * Changed CCR reset value

Applied to target-arm.for-3.1, thanks.

-- PMM
