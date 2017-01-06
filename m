Received: from eggs.gnu.org ([2001:4830:134:3::10]:39218)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cPWKM-0005tW-KV
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 10:21:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cPWKL-0004Iy-ED
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 10:21:10 -0500
Received: from mail-ua0-x22c.google.com ([2607:f8b0:400c:c08::22c]:36430)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cPWKL-0004Ie-59
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 10:21:09 -0500
Received: by mail-ua0-x22c.google.com with SMTP id 88so403236941uaq.3
	for <qemu-devel@nongnu.org>; Fri, 06 Jan 2017 07:21:09 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170106143527.sdto622nm6hflp5b@roojbos.sk>
References: <20170106143527.sdto622nm6hflp5b@roojbos.sk>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Jan 2017 15:20:48 +0000
Message-ID: <CAFEAcA_Cjm02WMGCDmsi+0Bv7cnYg9=ePFmBg_1RGJ8Xufr94w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [RESEND PATCH] target-arm/abi32: check for
 segfault in do_kernel_trap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Seraphime Kirkovski <kirkseraph@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Riku Voipio <riku.voipio@iki.fi>, qemu-arm <qemu-arm@nongnu.org>

On 6 January 2017 at 14:35, Seraphime Kirkovski <kirkseraph@gmail.com> wrote:
> In terms of implementation, I find it would be better to extract the
> __kernel_cmpxchg code in a separate function. On the one hand, this
> would avoid code duplication or strange gotos and make do_kernel_trap
> more readable. On the other hand, this would clutter a bit git history.
> If it is acceptable, I will send a patch with those changes. If not,
> will try to find a cleaner solution without creating new functions.

Refactoring the code sounds like a good idea to me -- go ahead.

thanks
-- PMM
