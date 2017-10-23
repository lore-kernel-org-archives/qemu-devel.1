Received: from eggs.gnu.org ([2001:4830:134:3::10]:39508)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Jason@zx2c4.com>) id 1e6dUq-00083E-SJ
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 10:14:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Jason@zx2c4.com>) id 1e6dUq-0006dZ-11
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 10:14:28 -0400
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_PM5Fjx2Pk58h75p9vaZwFcusQdXuwy9tbDtc=EaoOJg@mail.gmail.com>
References: <20171023122719.17199-1-Jason@zx2c4.com>
	<CAFEAcA_PM5Fjx2Pk58h75p9vaZwFcusQdXuwy9tbDtc=EaoOJg@mail.gmail.com>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Mon, 23 Oct 2017 16:14:14 +0200
Message-ID: <CAHmME9oMPg1LS6tB6RDUPxrXzTxdp+ZsVsbT9pLSd9QvX5S0vQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH] hw/arm/virt: support 4 serial
 ports
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>

Hey Peter,

I really do need more serial ports. Two, actually. I'm using qemu on
build.wireguard.com for CI. I have normal output come on ttyS0
(ttyAMA0) and then if it's successful, the final step is writing
"success" into ttyS1 (ttyAMA1), so that I can confirm with certainty
that the tests succeeded. In other words, one channel for text output
and one channel for control messages. (And I really really don't want
to use virtio or PCI-based stuff for this.)

So I'm extending the CI on build.wireguard.com now to support ARM and
MIPS, and things are not very smooth in the ARM world.

Jason
