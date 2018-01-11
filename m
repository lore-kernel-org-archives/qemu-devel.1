Received: from eggs.gnu.org ([2001:4830:134:3::10]:56830)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eZhs4-0006Co-Dy
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 13:46:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eZhs3-0007hf-MZ
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 13:46:36 -0500
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:39935)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eZhs3-0007hN-Hc
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 13:46:35 -0500
Received: by mail-oi0-x242.google.com with SMTP id t8so2296239oie.6
	for <qemu-devel@nongnu.org>; Thu, 11 Jan 2018 10:46:35 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171218173022.18418-4-richard.henderson@linaro.org>
References: <20171218173022.18418-1-richard.henderson@linaro.org>
	<20171218173022.18418-4-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 11 Jan 2018 18:46:14 +0000
Message-ID: <CAFEAcA8fVCuZj+9-vZbdJS7pZVY9dRsS09f3WLjNNWaDH5RLJQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 3/9] target/arm: Use pointers in neon
 zip/uzp helpers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 18 December 2017 at 17:30, Richard Henderson
<richard.henderson@linaro.org> wrote:
> Rather than passing regnos to the helpers, pass pointers to the
> vector registers directly.  This eliminates the need to pass in
> the environment pointer and reduces the number of places that
> directly access env->vfp.regs[].
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/helper.h      |  20 +++---
>  target/arm/neon_helper.c | 162 +++++++++++++++++++++++++----------------------
>  target/arm/translate.c   |  42 ++++++------
>  3 files changed, 120 insertions(+), 104 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
