Received: from eggs.gnu.org ([2001:4830:134:3::10]:59847)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <th.huth@gmail.com>) id 1eLWZD-00012K-Ur
	for qemu-devel@nongnu.org; Sun, 03 Dec 2017 10:52:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <th.huth@gmail.com>) id 1eLWZA-0000tM-RH
	for qemu-devel@nongnu.org; Sun, 03 Dec 2017 10:52:32 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:34441)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <th.huth@gmail.com>) id 1eLWZA-0000sw-LB
	for qemu-devel@nongnu.org; Sun, 03 Dec 2017 10:52:28 -0500
Received: by mail-wr0-f193.google.com with SMTP id y21so14648968wrc.1
	for <qemu-devel@nongnu.org>; Sun, 03 Dec 2017 07:52:28 -0800 (PST)
References: <151203716694.2960.12305472500745415473.malonedeb@gac.canonical.com>
	<151204437224.3145.2784740143531482152.malone@gac.canonical.com>
	<74ce90f9-f123-8fba-1038-7dd181d9148c@physik.fu-berlin.de>
	<177a2c67-932a-8842-fc71-229373bc28aa@physik.fu-berlin.de>
From: Thomas Huth <huth@tuxfamily.org>
Message-ID: <01c38497-beda-2450-026d-38876cfda2cc@tuxfamily.org>
Date: Sun, 3 Dec 2017 16:52:24 +0100
MIME-Version: 1.0
In-Reply-To: <177a2c67-932a-8842-fc71-229373bc28aa@physik.fu-berlin.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Bug 1735384] Re: OpenJDK JVM segfaults on
 qemu-sh4 (regression)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bug 1735384 <1735384@bugs.launchpad.net>, qemu-devel@nongnu.org, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: Richard Henderson <rth@twiddle.net>, Laurent Vivier <lvivier@redhat.com>

On 01.12.2017 00:25, John Paul Adrian Glaubitz wrote:
> The offending commit is:
> 
> d25f2a72272b9ffe0d06710d6217d1169bc2cc7d is the first bad commit
> commit d25f2a72272b9ffe0d06710d6217d1169bc2cc7d
> Author: Alex Bennée <alex.bennee@linaro.org>
> Date:   Mon Nov 13 13:55:27 2017 +0000
> 
>     accel/tcg/translate-all: expand cpu_restore_state addr check
> 
>     We are still seeing signals during translation time when we walk over
>     a page protection boundary. This expands the check to ensure the host
>     PC is inside the code generation buffer. The original suggestion was
>     to check versus tcg_ctx.code_gen_ptr but as we now segment the
>     translation buffer we have to settle for just a general check for
>     being inside.
> 
>     I've also fixed up the declaration to make it clear it can deal with
>     invalid addresses. A later patch will fix up the call sites.
> 
>     Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>     Reported-by: Peter Maydell <peter.maydell@linaro.org>
>     Reviewed-by: Laurent Vivier <laurent@vivier.eu>
>     Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>     Message-id: 20171108153245.20740-2-alex.bennee@linaro.org
>     Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
>     Cc: Richard Henderson <rth@twiddle.net>
>     Tested-by: Peter Maydell <peter.maydell@linaro.org>
>     Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> 
> :040000 040000 da50c4c43089d3ee7d1e9ad50d3c9036114e5f11 cd6a0dcaa1d284fe5439f6f3b61547d4b0662768 M      accel
> :040000 040000 c294a7c102d27295f8d81cc06b5d4d17357440ad 5a1268b7634f69f0806f22161ec7d6a1a26c8812 M      include
> 
> Reverting the commit resolves the issue.
> 

Alex, any ideas what might be wrong here?

 Thomas
