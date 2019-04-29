Received: from eggs.gnu.org ([209.51.188.92]:54990)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL921-0007JS-Qe
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 12:21:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL920-0004P5-QI
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 12:21:29 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:43184)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hL920-0004OW-LK
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 12:21:28 -0400
Received: by mail-oi1-x244.google.com with SMTP id t81so8764829oig.10
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 09:21:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190330005900.17282-1-richard.henderson@linaro.org>
	<20190330005900.17282-3-richard.henderson@linaro.org>
In-Reply-To: <20190330005900.17282-3-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Apr 2019 17:21:16 +0100
Message-ID: <CAFEAcA98_q1yx==QkHO1HiJA8cJqGv8k5OrCU5W=dC3ZWNPY=w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v4 2/4] linux-user: Set PAGE_TARGET_1 for
 TARGET_PROT_BTI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>

On Sat, 30 Mar 2019 at 00:59, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> There is agreement that there will be a mmap/mprotect bit,
> although no word yet on the value or the name.   Invent a
> name to make forward progress.
>
> The PAGE_TARGET_1 bit, is qemu internal, and allows the
> target something to query from the guest page tables.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

This looks ok code-wise, but we'd need to hide it behind
a defaults-to-off x-something property if we wanted to
commit it before the kernel ABI is fixed.

Do we also need to handle this in mprotect() ?

thanks
-- PMM
