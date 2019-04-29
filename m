Received: from eggs.gnu.org ([209.51.188.92]:41192)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL723-0006er-8v
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 10:13:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL722-0001tR-HO
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 10:13:23 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:45194)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hL722-0001sT-8C
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 10:13:22 -0400
Received: by mail-ot1-x341.google.com with SMTP id e5so8688674otk.12
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 07:13:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190328230404.12909-1-richard.henderson@linaro.org>
	<20190328230404.12909-13-richard.henderson@linaro.org>
In-Reply-To: <20190328230404.12909-13-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Apr 2019 15:13:10 +0100
Message-ID: <CAFEAcA_uC6mHb2p1cM=UxW7sXhmJGHi3f_aCtyakwSi9g_f2Rg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH for-4.1 v2 12/36] target/i386: Use env_cpu,
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

On Thu, 28 Mar 2019 at 23:48, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Combined uses of CPU(x86_env_get_cpu()) were failures to use
> the more proper, ENV_GET_CPU macro, now replaced by env_cpu.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
