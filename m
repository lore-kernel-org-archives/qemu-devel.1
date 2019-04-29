Received: from eggs.gnu.org ([209.51.188.92]:40559)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL6zu-0005bX-6c
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 10:11:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL6zt-0007k8-7t
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 10:11:10 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:40751)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hL6zt-0007iO-3V
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 10:11:09 -0400
Received: by mail-oi1-x244.google.com with SMTP id y64so2843208oia.7
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 07:11:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190328230404.12909-1-richard.henderson@linaro.org>
	<20190328230404.12909-12-richard.henderson@linaro.org>
In-Reply-To: <20190328230404.12909-12-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Apr 2019 15:10:56 +0100
Message-ID: <CAFEAcA9x-34eEU4B4utse+9DDhZkCmv3Q0yqR-b55R2DBMf8ng@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH for-4.1 v2 11/36] target/hppa: Use env_cpu,
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

On Thu, 28 Mar 2019 at 23:26, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Combined uses of CPU(hppa_env_get_cpu()) were failures to use
> the more proper, ENV_GET_CPU macro, now replaced by env_cpu.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/hppa/cpu.h          |  5 -----
>  linux-user/hppa/cpu_loop.c |  2 +-
>  target/hppa/helper.c       |  3 +--
>  target/hppa/int_helper.c   |  4 ++--
>  target/hppa/mem_helper.c   | 10 ++++------
>  target/hppa/op_helper.c    |  8 +++-----
>  6 files changed, 11 insertions(+), 21 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
