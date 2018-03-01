Received: from eggs.gnu.org ([2001:4830:134:3::10]:53040)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1erNWD-0001e6-D1
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 07:41:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1erNWC-00029i-Lo
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 07:41:05 -0500
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:33958)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1erNWC-00029S-Fb
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 07:41:04 -0500
Received: by mail-oi0-x244.google.com with SMTP id c83so4360718oib.1
	for <qemu-devel@nongnu.org>; Thu, 01 Mar 2018 04:41:04 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4d63ab53-f056-9f86-4317-9565f1d8a792@linaro.org>
References: <20180220180325.29818-1-peter.maydell@linaro.org>
	<20180220180325.29818-7-peter.maydell@linaro.org>
	<4d63ab53-f056-9f86-4317-9565f1d8a792@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 1 Mar 2018 12:40:43 +0000
Message-ID: <CAFEAcA9hDqrRNfMurJb5uJeyqVqyEHhz2cOQ74vZWKbiyoh8Fg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 06/19] target/arm: Define init-svtor
 property for the reset secure VTOR value
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>

On 27 February 2018 at 20:18, Richard Henderson
<richard.henderson@linaro.org> wrote:
> On 02/20/2018 10:03 AM, Peter Maydell wrote:
>> +        env->v7m.vecbase[M_REG_S] = cpu->init_svtor;
>
> Perhaps & ~0x3f here; that part of the field is RES0.
>
> That said, if the only setter of this property is within qemu code, and not
> from the command line, then I suppose it doesn't matter in practice.

Bits 6..0 are RES0, not just 5..0. I've added "& 0xffffff80"
(to match how we do the masking in the VTOR write code path in
armv7m_nvic.c).

thanks
-- PMM
