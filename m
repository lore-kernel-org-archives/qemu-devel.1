Received: from eggs.gnu.org ([208.118.235.92]:53333)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gfRD3-0005Rj-1l
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 10:16:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gfRD1-0006IV-Fa
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 10:16:28 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:36774)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gfRD1-0006GT-AI
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 10:16:27 -0500
Received: by mail-oi1-x242.google.com with SMTP id x23so30602808oix.3
	for <qemu-devel@nongnu.org>; Fri, 04 Jan 2019 07:16:25 -0800 (PST)
MIME-Version: 1.0
References: <20190103144124.18917-1-stefanha@redhat.com>
In-Reply-To: <20190103144124.18917-1-stefanha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 4 Jan 2019 15:16:13 +0000
Message-ID: <CAFEAcA-B_T9E3ezWFXg-wp3RotMjv3-z3qY7hSJZEoqFBqCWnQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] Revert "armv7m: Guard against no -kernel
 argument"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Jim Mussared <jim@groklearning.com>, Julia Suvorova <jusual@mail.ru>, qemu-arm <qemu-arm@nongnu.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Steffen Gortz <qemu.ml@steffen-goertz.de>, Joel Stanley <joel@jms.id.au>

On Thu, 3 Jan 2019 at 14:41, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> This reverts commit 01fd41ab3fb69971c24a69ed49cde96086d81278.
>
> The generic loader device (-device loader,file=kernel.bin) can be used
> to load a kernel instead of the -kernel option.  Some boards have flash
> memory (pflash) that is set via the -pflash or -drive options.
>
> Allow starting QEMU without the -kernel option to accommodate these
> scenarios.
>
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>



Applied to target-arm.next, thanks.

-- PMM
