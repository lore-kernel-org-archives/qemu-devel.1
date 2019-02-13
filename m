Received: from eggs.gnu.org ([209.51.188.92]:55438)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gty7b-0007FL-IT
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 12:14:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gty7a-0002kZ-JF
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 12:14:55 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:34834)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gty7X-0002Wn-Lj
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 12:14:54 -0500
Received: by mail-ot1-x343.google.com with SMTP id z19so5586014otm.2
	for <qemu-devel@nongnu.org>; Wed, 13 Feb 2019 09:14:44 -0800 (PST)
MIME-Version: 1.0
References: <20190212173839.31587-1-chouteau@adacore.com>
	<CAKmqyKOAVDbJQ6avwWgDHP1fHD_EXdZmi+Sjucm05ZqNkQoUog@mail.gmail.com>
In-Reply-To: <CAKmqyKOAVDbJQ6avwWgDHP1fHD_EXdZmi+Sjucm05ZqNkQoUog@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 13 Feb 2019 17:14:32 +0000
Message-ID: <CAFEAcA_5jYqTWVBiTFjumkAHEEwvDkt_f_LHAo=00gkEfoY9sA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] SiFive RISC-V GPIO Device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair23@gmail.com>
Cc: Fabien Chouteau <chouteau@adacore.com>, "open list:RISC-V" <qemu-riscv@nongnu.org>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, "open list:All patches CC here" <qemu-devel@nongnu.org>, Michael Clark <mjc@sifive.com>, Alistair Francis <Alistair.Francis@wdc.com>

On Wed, 13 Feb 2019 at 00:13, Alistair Francis <alistair23@gmail.com> wrote:
> I know the other RISC-V files don't do it, but this should go in the
> hw/gpio directory instead of hw/riscv.

It might be nice to move those existing riscv devices into
their proper places at some point: should be a fairly easy
cleanup patch if somebody wants to take it on. (Advice
on what should live where available on request.)

thanks
-- PMM
