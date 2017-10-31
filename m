Received: from eggs.gnu.org ([2001:4830:134:3::10]:37961)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e9Zub-00038Y-Ju
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 13:01:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e9ZuW-0004ZH-0d
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 13:01:13 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:44044)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e9ZuV-0004Xn-PJ
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 13:01:07 -0400
Received: by mail-wr0-x244.google.com with SMTP id z55so16613241wrz.1
	for <qemu-devel@nongnu.org>; Tue, 31 Oct 2017 10:01:07 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171031154407.4184-1-michael.nawrocki@gtri.gatech.edu>
References: <20171031154407.4184-1-michael.nawrocki@gtri.gatech.edu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 31 Oct 2017 17:00:45 +0000
Message-ID: <CAFEAcA8Cv1+E9v3dSqPkUDd7s9zp=V+UJ1V7oXJBWzwnQdzFSg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 0/2] Add 8-byte wide AMD flash support,
 partial interleaving
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mike Nawrocki <michael.nawrocki@gtri.gatech.edu>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Magnus Damm <magnus.damm@gmail.com>, Alistair Francis <alistair.francis@xilinx.com>, Michael Walle <michael@walle.cc>, Jan Kiszka <jan.kiszka@web.de>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Max Reitz <mreitz@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

On 31 October 2017 at 15:44, Mike Nawrocki
<michael.nawrocki@gtri.gatech.edu> wrote:
> This patch set does a few things. First, it switches the AMD CFI flash MMIO
> operations from the old MMIO API to the new one. Second, it enables 8-byte
> wide flash arrays. Finally, it supports rudimentary interleaving of notional
> flash "chips". It is expected that commands will be sent to all "chips"
> simultaneously. See the example in the second patch for more details. This
> behavior is used by drivers for the PPMC7400 PowerPC evaluation board.

I'm confused by the interleaving part. Can you explain how this
differs from the interleaving we already support in pflash_cfi01.c
via setting width, device-width and max-device-width ? (see the comment
in the pflash_cfi01_properties[] array about how those settings
interact). If it is the same thing, we should really implement it
in the same way for both kinds of flash device.

thanks
-- PMM
