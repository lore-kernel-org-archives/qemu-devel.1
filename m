Received: from eggs.gnu.org ([209.51.188.92]:44931)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLCeJ-000737-NT
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 16:13:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLCeG-000054-Bk
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 16:13:13 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:34155)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hLCeC-0008Tt-VU
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 16:13:10 -0400
Received: by mail-pf1-x444.google.com with SMTP id b3so5888460pfd.1
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 13:13:07 -0700 (PDT)
References: <20190330005900.17282-1-richard.henderson@linaro.org>
	<20190330005900.17282-3-richard.henderson@linaro.org>
	<CAFEAcA98_q1yx==QkHO1HiJA8cJqGv8k5OrCU5W=dC3ZWNPY=w@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <920a0801-ed1d-23e8-9975-43d4d185707e@linaro.org>
Date: Mon, 29 Apr 2019 13:12:59 -0700
MIME-Version: 1.0
In-Reply-To: <CAFEAcA98_q1yx==QkHO1HiJA8cJqGv8k5OrCU5W=dC3ZWNPY=w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>

On 4/29/19 9:21 AM, Peter Maydell wrote:
> This looks ok code-wise, but we'd need to hide it behind
> a defaults-to-off x-something property if we wanted to
> commit it before the kernel ABI is fixed.

I'm not intending to change the user-level abi, only the
internal abi within qemu, for handling of the elf notes.

You think this should be done differently, so that there's
zero possibility of a user-level setting the relevant bit?

> Do we also need to handle this in mprotect() ?

Not until there's a kernel abi.


r~
