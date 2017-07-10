Received: from eggs.gnu.org ([2001:4830:134:3::10]:53494)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dUgqx-0002g4-Rh
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 18:08:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dUgqt-0003l2-Rx
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 18:08:27 -0400
Received: from mail-wr0-f170.google.com ([209.85.128.170]:33340)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dUgqt-0003km-KX
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 18:08:23 -0400
Received: by mail-wr0-f170.google.com with SMTP id r103so157552140wrb.0
	for <qemu-devel@nongnu.org>; Mon, 10 Jul 2017 15:08:23 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <9d34052b-57db-9a71-b8a9-e1bbe1a9fae1@twiddle.net>
References: <20170710192128.9048-1-alex.bennee@linaro.org>
	<20170710192128.9048-6-alex.bennee@linaro.org>
	<9d34052b-57db-9a71-b8a9-e1bbe1a9fae1@twiddle.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 10 Jul 2017 23:07:01 +0100
Message-ID: <CAFEAcA_wAjD387bee4dkxrRkAnDV=TQNTwYznHd=TcF0g1x+Hw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 5/5] target/arm: use DISAS_EXIT for eret
 handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, "Emilio G. Cota" <cota@braap.org>, QEMU Developers <qemu-devel@nongnu.org>, Etienne Carriere <etienne.carriere@linaro.org>, Joakim Bech <joakim.bech@linaro.org>, "open list:ARM" <qemu-arm@nongnu.org>

On 10 July 2017 at 20:58, Richard Henderson <rth@twiddle.net> wrote:
> As an aside, I presume we don't have support for armv7ve?  I was expecting
> there to be an eret insn in the aa32 translator and had to dig up previous
> manuals to see when that insn was introduced.

We don't yet fully support 32-bit EL2, no. We've been adding bits
and pieces but still haven't filled it all in. Edgar might have
a patch to add ARM A32 ERET to the decoder in the xilinx tree?

thanks
-- PMM
