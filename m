Received: from eggs.gnu.org ([2001:4830:134:3::10]:48887)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f6HRN-00037b-6R
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 11:13:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f6HRJ-0004Yk-2i
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 11:13:41 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:40095)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f6HRI-0004Xw-Rt
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 11:13:37 -0400
Received: by mail-oi0-x243.google.com with SMTP id x9-v6so2040885oig.7
	for <qemu-devel@nongnu.org>; Wed, 11 Apr 2018 08:13:36 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180410233110.2573-1-richard.henderson@linaro.org>
References: <20180410233110.2573-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 11 Apr 2018 16:13:15 +0100
Message-ID: <CAFEAcA_8bKU_PmL_foqZv1iYwpXR-EgpFXvy-kK7kt75UAVJ6g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL for-2.12 0/1] tcg patch queue
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

On 11 April 2018 at 00:31, Richard Henderson
<richard.henderson@linaro.org> wrote:
> The following changes since commit 26d6a7c87b05017ffabffb5e16837a0fccf67e90:
>
>   Merge remote-tracking branch 'remotes/ericb/tags/pull-qapi-2018-04-10' into staging (2018-04-10 22:16:19 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/rth7680/qemu.git tags/pull-tcg-20180411
>
> for you to fetch changes up to afd46fcad2dceffda35c0586f5723c127b6e09d8:
>
>   icount: fix cpu_restore_state_from_tb for non-tb-exit cases (2018-04-11 09:05:22 +1000)
>
> ----------------------------------------------------------------
> Handle read-modify-write i/o with icount
>
> ----------------------------------------------------------------
> Pavel Dovgalyuk (1):
>       icount: fix cpu_restore_state_from_tb for non-tb-exit cases
>
>  include/exec/exec-all.h      |  5 ++++-
>  accel/tcg/cpu-exec-common.c  | 10 +++++-----
>  accel/tcg/cpu-exec.c         |  1 -
>  accel/tcg/translate-all.c    | 27 ++++++++++++++-------------
>  accel/tcg/user-exec.c        |  2 +-
>  hw/misc/mips_itu.c           |  3 +--
>  target/alpha/helper.c        |  2 +-
>  target/alpha/mem_helper.c    |  6 ++----
>  target/arm/op_helper.c       |  6 +++---
>  target/cris/op_helper.c      |  4 ++--
>  target/i386/helper.c         |  2 +-
>  target/i386/svm_helper.c     |  2 +-
>  target/m68k/op_helper.c      |  4 ++--
>  target/moxie/helper.c        |  2 +-
>  target/openrisc/sys_helper.c |  8 ++++----
>  target/tricore/op_helper.c   |  2 +-
>  target/xtensa/op_helper.c    |  4 ++--
>  17 files changed, 45 insertions(+), 45 deletions(-)


Applied, thanks.

-- PMM
