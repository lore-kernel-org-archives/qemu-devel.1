Received: from eggs.gnu.org ([209.51.188.92]:39022)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL6t6-0001Kj-Tg
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 10:04:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL6t4-0000LP-Ux
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 10:04:08 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:45128)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hL6t4-0000Gd-PK
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 10:04:06 -0400
Received: by mail-ot1-x342.google.com with SMTP id e5so8656929otk.12
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 07:04:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190328230404.12909-1-richard.henderson@linaro.org>
	<20190328230404.12909-9-richard.henderson@linaro.org>
In-Reply-To: <20190328230404.12909-9-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Apr 2019 15:03:51 +0100
Message-ID: <CAFEAcA-ha4XBihDiYG131HVQSq8N7ZrhbsdbBAACdwYh4QA4uw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH for-4.1 v2 08/36] target/alpha: Use env_cpu,
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

On Thu, 28 Mar 2019 at 23:23, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> With exactly one exception, most uses of alpha_env_get_cpu
> were failures to use the more proper, ENV_GET_CPU macro,
> now replaced by env_cpu.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/alpha/cpu.h          | 5 -----
>  linux-user/alpha/cpu_loop.c | 2 +-
>  target/alpha/helper.c       | 8 +++-----
>  target/alpha/sys_helper.c   | 8 ++++----
>  4 files changed, 8 insertions(+), 15 deletions(-)
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
