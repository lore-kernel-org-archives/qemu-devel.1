Received: from eggs.gnu.org ([2001:4830:134:3::10]:34592)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1drmlm-0005A4-C5
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 11:06:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1drmli-00081c-F8
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 11:06:34 -0400
Received: from mail-wm0-x22b.google.com ([2a00:1450:400c:c09::22b]:47084)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1drmli-00081A-7o
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 11:06:30 -0400
Received: by mail-wm0-x22b.google.com with SMTP id i189so59583533wmf.1
	for <qemu-devel@nongnu.org>; Tue, 12 Sep 2017 08:06:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <59B7F503.8010703@ispras.ru>
References: <59B7EBC5.9060908@ispras.ru>
	<CAFEAcA-to=vWWBHoxZRX-ExcbDe0OTMwpHunE7HXaYA0GE+ccw@mail.gmail.com>
	<59B7F503.8010703@ispras.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 12 Sep 2017 16:06:08 +0100
Message-ID: <CAFEAcA97i97_aoq8xNKtP8Z+i-u5Hq+_e6N80=T=WspSEW+A7A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] MIPS 'move' insn emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sergey Smolov <smolov@ispras.ru>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 12 September 2017 at 15:53, Sergey Smolov <smolov@ispras.ru> wrote:
> Generally speaking, is it possible at "run time" to detect write accesses to
> MIPS GPR registers?
> If true, which parts of code should I look in?

We don't currently support tracing at that level, I'm afraid.
(There are some patches on list starting to explore providing
an API for doing this kind of instrumentation, but they're
still at the "working out a design" stage.)
You might want to look at the -d options, which can give
you register dumps before every executed instruction if
you pick the right set of options (-d exec,cpu,nochain
-singlestep is probably a start.)

thanks
-- PMM
