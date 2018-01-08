Received: from eggs.gnu.org ([2001:4830:134:3::10]:39189)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eYWFK-0001ly-23
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 07:09:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eYWFJ-00069g-8Y
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 07:09:42 -0500
Received: from mail-ot0-x243.google.com ([2607:f8b0:4003:c0f::243]:34908)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eYWFJ-00069C-4I
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 07:09:41 -0500
Received: by mail-ot0-x243.google.com with SMTP id q5so9035346oth.2
	for <qemu-devel@nongnu.org>; Mon, 08 Jan 2018 04:09:41 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171230225622.97409-1-michael.weiser@gmx.de>
References: <20171230225622.97409-1-michael.weiser@gmx.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 8 Jan 2018 12:09:20 +0000
Message-ID: <CAFEAcA8GgbFnbr0yNkVyrBK6TciTMEk_EZuw4_gvfZ+eEii3Qw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2] target/arm: Fix stlxp for aarch64_be
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Weiser <michael.weiser@gmx.de>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 30 December 2017 at 22:56, Michael Weiser <michael.weiser@gmx.de> wrote:
> ldxp loads two consecutive doublewords from memory regardless of CPU
> endianness. On store, stlxp currently assumes to work with a 128bit
> value and consequently switches order in big-endian mode. With this
> change it packs the doublewords in reverse order in anticipation of the
> 128bit big-endian store operation interposing them so they end up in
> memory in the right order. This makes it work for both MTTCG and !MTTCG.
> It effectively implements the ARM ARM STLXP operation pseudo-code:
>
> data = if BigEndian() then el1:el2 else el2:el1;
>
> With this change an aarch64_be Linux 4.14.4 kernel succeeds to boot up
> in system emulation mode.
>
> Signed-off-by: Michael Weiser <michael.weiser@gmx.de>

Thanks, applied to target-arm.next (with the typo rth pointed out
fixed).

-- PMM
