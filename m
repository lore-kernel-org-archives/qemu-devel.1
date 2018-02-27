Received: from eggs.gnu.org ([2001:4830:134:3::10]:50557)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eqcVy-0001sM-7B
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 05:29:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eqcVx-0004Os-DU
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 05:29:42 -0500
Received: from mail-ot0-x243.google.com ([2607:f8b0:4003:c0f::243]:44431)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eqcVx-0004OS-8m
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 05:29:41 -0500
Received: by mail-ot0-x243.google.com with SMTP id 79so3299089oth.11
	for <qemu-devel@nongnu.org>; Tue, 27 Feb 2018 02:29:41 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_bZ-w7WWUtr8RE6rU8ELLbZpBmeuDnwZ=rLreXgJ6fRg@mail.gmail.com>
References: <20180217140051.22731-1-linus.walleij@linaro.org>
	<20180217140051.22731-2-linus.walleij@linaro.org>
	<eff4f015-38ad-60e1-e1de-886bb4f93328@amsat.org>
	<CACRpkdZLwbVr2O5__GpHt+y0pqpk3-j_AXD_qv5JQc3JZNRm7A@mail.gmail.com>
	<CAFEAcA-jqgBxoEprjTPed0k_vZFGrAVd87Gj5nAfFysau4WrSw@mail.gmail.com>
	<CACRpkdZuNUmZbHnYwUQFJkBNQWADd5tXfc9PYv8amosbO=zn4Q@mail.gmail.com>
	<CAFEAcA_bZ-w7WWUtr8RE6rU8ELLbZpBmeuDnwZ=rLreXgJ6fRg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Feb 2018 10:29:20 +0000
Message-ID: <CAFEAcA_X7cjFmJMSFsCZYR9weJeBFJqdWj=Chpp3-4afqgbo1A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 2/3] hw/sii9022: Add support for
 Silicon Image SII9022
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 27 February 2018 at 10:24, Peter Maydell <peter.maydell@linaro.org> wrote:
> docs/devel/tracing.txt describes them, but basically:
>  * include "trace.h"
>  * define trace events with a line for each in the trace-events
>    file for the subdirectory (basically a function prototype-ish
>    thing followed by a printf-style format string)
>  * call them like normal function calls with a trace_ prefix
>
> commit 1b640aa9292bc00beb441e97d862ba322a7ba18d is a recent one
> which converted some DRINTFs in hw/sd/sd.c to trace events.

...and you can test them most conveniently with the QEMU
-d argument: "-d trace:sii9022*" will enable tracing to stderr
of all trace events with names that begin 'sii9022'.

thanks
-- PMM
