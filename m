Received: from eggs.gnu.org ([209.51.188.92]:43086)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL79l-0004En-RR
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 10:21:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL79l-00015l-1K
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 10:21:21 -0400
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d]:34119)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hL79k-00015I-TQ
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 10:21:20 -0400
Received: by mail-oi1-x22d.google.com with SMTP id v10so8442032oib.1
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 07:21:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190328230404.12909-1-richard.henderson@linaro.org>
	<20190328230404.12909-23-richard.henderson@linaro.org>
In-Reply-To: <20190328230404.12909-23-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Apr 2019 15:21:08 +0100
Message-ID: <CAFEAcA8phrZnNDN7aFJfMXDbBoyWFA4-=bORFemYY6yQNfKWsQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH for-4.1 v2 22/36] target/s390x: Use env_cpu,
 env_archcpu
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

On Thu, 28 Mar 2019 at 23:35, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/s390x/cpu.h          |  5 ----
>  linux-user/s390x/cpu_loop.c |  2 +-
>  target/s390x/cc_helper.c    |  5 ++--
>  target/s390x/diag.c         |  2 +-
>  target/s390x/excp_helper.c  |  6 ++---
>  target/s390x/fpu_helper.c   |  4 +--
>  target/s390x/helper.c       |  7 +++---
>  target/s390x/int_helper.c   |  3 +--
>  target/s390x/interrupt.c    |  6 ++---
>  target/s390x/mem_helper.c   | 28 ++++++++-------------
>  target/s390x/misc_helper.c  | 50 ++++++++++++++++++-------------------
>  target/s390x/mmu_helper.c   |  8 +++---
>  target/s390x/sigp.c         |  4 +--
>  13 files changed, 56 insertions(+), 74 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
