Received: from eggs.gnu.org ([2001:4830:134:3::10]:38110)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cYHQl-0001sC-F1
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 14:16:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cYHQk-0004Ax-Dh
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 14:15:59 -0500
Received: from mail-vk0-x22b.google.com ([2607:f8b0:400c:c05::22b]:34393)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cYHQk-0004Aj-9G
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 14:15:58 -0500
Received: by mail-vk0-x22b.google.com with SMTP id r136so222440667vke.1
	for <qemu-devel@nongnu.org>; Mon, 30 Jan 2017 11:15:58 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170130181634.13934-3-laurent@vivier.eu>
References: <20170130181634.13934-1-laurent@vivier.eu>
	<20170130181634.13934-3-laurent@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 30 Jan 2017 19:15:37 +0000
Message-ID: <CAFEAcA-s55AjSjaj94TPM79HCcWds7_KH2B6a5wyztSEV1wkeQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v2 02/16] softloat: disable
 floatx80_invalid_encoding() for m68k
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>

On 30 January 2017 at 18:16, Laurent Vivier <laurent@vivier.eu> wrote:
> According to the comment, this definition of invalid encoding is given
> by intel developer's manual, and doesn't work with the behavior
> of 680x0 FPU.
>
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>

Part of the reason these checks are here is that the code
behind them doesn't always cope nicely with the invalid
encodings.
https://lists.nongnu.org/archive/html/qemu-devel/2016-08/msg01991.html
has an x86 test case for certain sqrt inputs that cause
the floatx80_sqrt() function to go into an infinite loop,
for instance.

I guess we need to look more carefully at exactly what the
m68k does for these encodings (maybe have a 'normalize value'
function which squashes them down to whatever the equivalent
non-weird encoding is?).

thanks
-- PMM
