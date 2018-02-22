Received: from eggs.gnu.org ([2001:4830:134:3::10]:32772)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eotfJ-0005Wm-91
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 11:24:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eotfI-00079r-Ez
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 11:24:13 -0500
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:41326)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eotfI-00079G-A7
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 11:24:12 -0500
Received: by mail-oi0-x243.google.com with SMTP id e10so4102165oiy.8
	for <qemu-devel@nongnu.org>; Thu, 22 Feb 2018 08:24:12 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180216215608.13227-2-richard.henderson@linaro.org>
References: <20180216215608.13227-1-richard.henderson@linaro.org>
	<20180216215608.13227-2-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Feb 2018 16:23:51 +0000
Message-ID: <CAFEAcA_FNWi8OK5hyekZiiZLvjAR=r3T4eHFLNCam4O8KGXi2Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 1/5] linux-user: Implement aarch64
 PR_SVE_SET/GET_VL
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 16 February 2018 at 21:56, Richard Henderson
<richard.henderson@linaro.org> wrote:
> As an implementation choice, widening VL has zeroed the
> previously inaccessible portion of the sve registers.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/aarch64/target_syscall.h |  3 +++
>  target/arm/cpu.h                    |  1 +
>  linux-user/syscall.c                | 27 ++++++++++++++++++++++++
>  target/arm/cpu64.c                  | 41 +++++++++++++++++++++++++++++++++++++
>  4 files changed, 72 insertions(+)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
