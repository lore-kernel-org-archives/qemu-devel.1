Received: from eggs.gnu.org ([209.51.188.92]:60470)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1hLZyd-0006W6-Ex
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 17:07:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1hLZyb-0004Wa-J4
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 17:07:47 -0400
Received: from mail-yw1-xc44.google.com ([2607:f8b0:4864:20::c44]:36959)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1hLZyb-0004Vs-6u
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 17:07:45 -0400
Received: by mail-yw1-xc44.google.com with SMTP id a62so6997313ywa.4
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 14:07:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190403034358.21999-1-richard.henderson@linaro.org>
	<20190403034358.21999-24-richard.henderson@linaro.org>
	<CAFEAcA_FZHKXJHg4819JOZkwwhE44Vx874GKrnxRrOau1HhzRw@mail.gmail.com>
	<CAMo8BfJVdDvYWEdN_08ed5OKBGXc+U8kSbmWaSWY9WCuvDj2pw@mail.gmail.com>
	<bd57c22c-1bdc-80b4-0415-565117f6ae3e@linaro.org>
	<CAMo8BfJsC9aPYUhi5Rg6SAXT4dhaZaU=dqy=um+aBJtnPMSwdA@mail.gmail.com>
In-Reply-To: <CAMo8BfJsC9aPYUhi5Rg6SAXT4dhaZaU=dqy=um+aBJtnPMSwdA@mail.gmail.com>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Tue, 30 Apr 2019 14:07:31 -0700
Message-ID: <CAMo8BfKjGrHsTn+riEnS8rxQDPgAQ9STwJrB4_TrYnqs2uHtmQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 23/26] target/xtensa: Convert to
 CPUClass::tlb_fill
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

On Tue, Apr 30, 2019 at 11:14 AM Max Filippov <jcmvbkbc@gmail.com> wrote:
> On Tue, Apr 30, 2019 at 10:44 AM Richard Henderson
> > And Peter's right that I should have kept EXC_USER.

It appears to work as is: the EXC_USER is set up by the
exception_cause helper because there's always PS_U in
the PS, PS_EXCM is cleared in the cpu_loop and the
current PC is preserved by the xtensa_cpu_tlb_fill.
I'll play with it some more...

-- 
Thanks.
-- Max
