Received: from eggs.gnu.org ([209.51.188.92]:40104)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hLQBx-0006gy-DW
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 06:40:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hLQBw-00017G-GH
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 06:40:53 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:37200)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hLQBw-000171-A9
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 06:40:52 -0400
Received: by mail-ot1-x341.google.com with SMTP id r20so10305914otg.4
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 03:40:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190330005900.17282-1-richard.henderson@linaro.org>
	<20190330005900.17282-3-richard.henderson@linaro.org>
	<CAFEAcA98_q1yx==QkHO1HiJA8cJqGv8k5OrCU5W=dC3ZWNPY=w@mail.gmail.com>
	<920a0801-ed1d-23e8-9975-43d4d185707e@linaro.org>
In-Reply-To: <920a0801-ed1d-23e8-9975-43d4d185707e@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 Apr 2019 11:40:40 +0100
Message-ID: <CAFEAcA-=JyNF94OTq+rJRVxbfhJ_B6=fLm93s+y0ScX9Uyfngw@mail.gmail.com>
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

On Mon, 29 Apr 2019 at 21:13, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 4/29/19 9:21 AM, Peter Maydell wrote:
> > This looks ok code-wise, but we'd need to hide it behind
> > a defaults-to-off x-something property if we wanted to
> > commit it before the kernel ABI is fixed.
>
> I'm not intending to change the user-level abi, only the
> internal abi within qemu, for handling of the elf notes.

You're changing target_mmap(), which is used by the
guest mmap syscall, though, right?

> You think this should be done differently, so that there's
> zero possibility of a user-level setting the relevant bit?

I think that we shouldn't allow guest binaries written
to the ad-hoc TARGET_PROT_BTI ABI to work without an
explicit x-something command line argument to QEMU, to
indicate that the user knows they're doing something
odd and that these binaries won't always continue to work
in future QEMU versions.

thanks
-- PMM
