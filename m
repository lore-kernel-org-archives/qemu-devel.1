Received: from eggs.gnu.org ([2001:4830:134:3::10]:53993)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eS9ee-0007lD-Th
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 17:49:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eS9ee-0000S5-54
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 17:49:32 -0500
Received: from mail-ot0-x242.google.com ([2607:f8b0:4003:c0f::242]:35572)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eS9ee-0000Rx-0M
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 17:49:32 -0500
Received: by mail-ot0-x242.google.com with SMTP id q5so1432686oth.2
	for <qemu-devel@nongnu.org>; Thu, 21 Dec 2017 14:49:31 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171221211103.30311-1-laurent@vivier.eu>
References: <20171221211103.30311-1-laurent@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 21 Dec 2017 22:49:10 +0000
Message-ID: <CAFEAcA8MvShVAZf1+OOf2ZZnhD3sQ_jgED4NPWBOOySwJitD2Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] hw/i386/vmport: fix missing definitions
 with x86_64-w64-mingw32
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>

On 21 December 2017 at 21:11, Laurent Vivier <laurent@vivier.eu> wrote:
> When compiled with x86_64-w64-mingw32, we have:
>
>    error: implicit declaration of function 'qemu_log_mask'
>    error: 'LOG_UNIMP' undeclared (first use in this function)
>
> This patch adds the missing include.
>
> Fixes: 7299e1a411
>        ("hw/i386/vmport: replace fprintf() by trace events or LOG_UNIMP")
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>

Looks to me like it'll be a bug for anything not configured
using the 'log' trace backend, rather than win32 specific.

I'll apply (and fix up the commit message).

thanks
-- PMM
