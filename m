Received: from eggs.gnu.org ([2001:4830:134:3::10]:46461)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dFddp-0000II-IB
	for qemu-devel@nongnu.org; Tue, 30 May 2017 05:40:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dFddo-0001pl-PM
	for qemu-devel@nongnu.org; Tue, 30 May 2017 05:40:41 -0400
Received: from mail-wm0-x230.google.com ([2a00:1450:400c:c09::230]:36300)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dFddi-0001pP-Uc
	for qemu-devel@nongnu.org; Tue, 30 May 2017 05:40:40 -0400
Received: by mail-wm0-x230.google.com with SMTP id 7so84352672wmo.1
	for <qemu-devel@nongnu.org>; Tue, 30 May 2017 02:40:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <e3e560d2-c380-0529-181a-b5bf3146650d@twiddle.net>
References: <87pofj8kek.fsf@linaro.org>
	<e3e560d2-c380-0529-181a-b5bf3146650d@twiddle.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 May 2017 10:40:13 +0100
Message-ID: <CAFEAcA8v0oQQ-xX5HqyJ3eLLZytEYV8HuGLN9KpFDyJO-qDPTA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] Future of SoftFloat use in QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Bharata B Rao <bharata@linux.vnet.ibm.com>, Aurelien Jarno <aurelien@aurel32.net>, Aleksandar Markovic <aleksandar.markovic@imgtec.com>, Pranith Kumar <bobby.prani@gmail.com>, qemu-devel <qemu-devel@nongnu.org>

On 9 May 2017 at 02:56, Richard Henderson <rth@twiddle.net> wrote:
> Another possibility is the code that's shared between the linux kernel
> (include/math-emu) and glibc (soft-fp).  The glibc version has support for
> f16 while the kernel doesn't.  But the glibc version is LGPL 2.1, which I'd
> expect to be ok.
>
> It is mildly nasty in that it's a collection of macros, but that's how we
> managed really good performance with the compiler tech of 15 years ago.  On
> the other hand, it would be fairly easy to adjust the support macros to
> achive source compatibility with our current code.

Having tangled with that collection of macros 15 years ago I
definitely can't recommend it ;-)

thanks
-- PMM
