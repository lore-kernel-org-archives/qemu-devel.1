Received: from eggs.gnu.org ([2001:4830:134:3::10]:53968)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1g8BkP-0005ZH-LB
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 18:05:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1g8BkN-00018k-Kl
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 18:05:29 -0400
Received: from mail-yb1-xb2b.google.com ([2607:f8b0:4864:20::b2b]:45414)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1g8BkN-000153-3Y
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 18:05:27 -0400
Received: by mail-yb1-xb2b.google.com with SMTP id d9-v6so4588884ybr.12
	for <qemu-devel@nongnu.org>; Thu, 04 Oct 2018 15:05:26 -0700 (PDT)
MIME-Version: 1.0
References: <20181004010505.26184-1-jcmvbkbc@gmail.com>
	<CAMo8BfJ==eV4g7L3nSuYa=o2RNw98nUg_0VJeBD6V8Q54m0wkg@mail.gmail.com>
	<39db072a-4ed9-834e-a77f-bb06df42a9f1@linaro.org>
	<CAMo8BfKJCYqFT31aL6ESD-N2zHKR2jv30RYxDPGYSbSpKQacvw@mail.gmail.com>
In-Reply-To: <CAMo8BfKJCYqFT31aL6ESD-N2zHKR2jv30RYxDPGYSbSpKQacvw@mail.gmail.com>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Thu, 4 Oct 2018 15:05:05 -0700
Message-ID: <CAMo8BfKVSo2JLtVKDa9hqzqeNOh-oNRqqX1SHtacoBfAWAKt-w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [RFC] target/xtensa: rework zero overhead loops
 implementation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>

On Thu, Oct 4, 2018 at 3:03 PM Max Filippov <jcmvbkbc@gmail.com> wrote:
> But I guess always storing low 13 bits of LEND - PC should work?

...when they're within two pages from each other...

-- 
Thanks.
-- Max
