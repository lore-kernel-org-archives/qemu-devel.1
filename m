Received: from eggs.gnu.org ([209.51.188.92]:36073)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gxBSR-0008V3-6p
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 09:05:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gxBSP-0005qc-Np
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 09:05:42 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:38891)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gxBSO-0004tL-VQ
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 09:05:41 -0500
Received: by mail-wm1-x342.google.com with SMTP id v26so2075513wmh.3
	for <qemu-devel@nongnu.org>; Fri, 22 Feb 2019 06:05:09 -0800 (PST)
References: <20190222024106.9167-1-richard.henderson@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20190222024106.9167-1-richard.henderson@linaro.org>
Date: Fri, 22 Feb 2019 14:05:07 +0000
Message-ID: <87r2bz3omk.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 0/3] target/arm: Reduce overhead of
 cpu_get_tb_cpu_state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, cota@braap.org


Richard Henderson <richard.henderson@linaro.org> writes:

> Changes since v2:
>   * Do not cache VECLEN, VECSTRIDE, VFPEN.
>     These variables come from VFP_FPSCR and VFP_FPEXC, not from
>     system control registers.
>   * Move HANDLER and STACKCHECK to rebuild_hflags_a32,
>     instead of building them in rebuild_hflags_common.
>
> Changes since v1:
>   * Apparently I had started a last-minute API change, and failed to
>     covert all of the users, and also failed to re-test afterward.
>   * Retain assertions for --enable-debug-tcg.

I thought I was being clever by running our armhf test binaries on a
aarch64 image. However I have re-tested by doing a full armhf buster
install this time:

Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

>
>
> r~
>
>
>
> Richard Henderson (3):
>   target/arm: Split out recompute_hflags et al
>   target/arm: Rebuild hflags at el changes and MSR writes
>   target/arm: Rely on hflags correct in cpu_get_tb_cpu_state
>
>  target/arm/cpu.h           |  28 ++--
>  target/arm/helper.h        |   3 +
>  target/arm/internals.h     |   4 +
>  linux-user/syscall.c       |   1 +
>  target/arm/cpu.c           |   1 +
>  target/arm/helper-a64.c    |   3 +
>  target/arm/helper.c        | 266 ++++++++++++++++++++++---------------
>  target/arm/machine.c       |   1 +
>  target/arm/op_helper.c     |   1 +
>  target/arm/translate-a64.c |   6 +-
>  target/arm/translate.c     |  14 +-
>  11 files changed, 212 insertions(+), 116 deletions(-)


--
Alex Benn=C3=A9e
