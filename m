Received: from eggs.gnu.org ([2001:4830:134:3::10]:37364)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eK1nq-0005SY-Q9
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 07:49:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eK1nq-0000Wx-2m
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 07:49:26 -0500
Received: from mail-oi0-x234.google.com ([2607:f8b0:4003:c06::234]:41315)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eK1np-0000Wd-UF
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 07:49:26 -0500
Received: by mail-oi0-x234.google.com with SMTP id t78so2276642oie.8
	for <qemu-devel@nongnu.org>; Wed, 29 Nov 2017 04:49:25 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171123163538.31411-1-laurent@vivier.eu>
References: <20171123163538.31411-1-laurent@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 29 Nov 2017 12:49:04 +0000
Message-ID: <CAFEAcA9+f2cgUUS00DXzF9a96evPRnxY5MTUZpe+OA3Trv84WA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 0/5] target/m68k: implement 680x0 FPU
 (part 3)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Thomas Huth <huth@tuxfamily.org>, Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>

On 23 November 2017 at 16:35, Laurent Vivier <laurent@vivier.eu> wrote:
> Implement fmod, frem, fscale, fgetman and fgetexp.
>
> Instead of using functions of libm (v1 of this series)
> and converting between host long double and floatx80 type
> the new version (v2) adds new floatx80 functions in softfloat.
>
> All the floatx80 functions are copied from "Previous",
> the NeXT Computer Emulator, and written by Andreas Grabher.

Hi; what license is that code under? Can you provide
a link to the original sources that you're taking the
functions from, please?

thanks
-- PMM
