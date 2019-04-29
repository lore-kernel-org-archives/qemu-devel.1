Received: from eggs.gnu.org ([209.51.188.92]:48451)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL7V9-0000tE-U0
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 10:43:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL7V8-0008MQ-Qz
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 10:43:27 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:33147)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hL7V7-0008DQ-2G
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 10:43:26 -0400
Received: by mail-ot1-x341.google.com with SMTP id s11so4502833otp.0
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 07:43:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190328230404.12909-1-richard.henderson@linaro.org>
	<20190328230404.12909-32-richard.henderson@linaro.org>
In-Reply-To: <20190328230404.12909-32-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Apr 2019 15:43:11 +0100
Message-ID: <CAFEAcA9nWq44C=m3exNJBO-YpheGRdzzAL529uCaFtUNGCWGkQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH for-4.1 v2 31/36] cpu: Introduce
 CPUNegativeOffsetState
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
> Nothing in there so far, but all of the plumbing done
> within the target ArchCPU state.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

> +/*
> + * This structure must be placed in ArchCPU immedately
> + * before CPUArchState, as a field named "neg".
> + */
> +typedef struct CPUNegativeOffsetState {
> +    /* Empty */
> +} CPUNegativeOffsetState;

It would be nice if we could do a compile-time assert that
 offsetof(CPUArchState, neg) + sizeof(CPUNegativeOffsetState)
  == offsetof(CPUArchState, env)

but I guess the possibility of within-struct padding
between the two structs makes that dubious. Or does our
generated code rely on there being no padding between neg
and env anyway ?

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
