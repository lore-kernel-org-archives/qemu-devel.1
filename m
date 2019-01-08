Received: from eggs.gnu.org ([209.51.188.92]:41897)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gh0nQ-0007Z1-Pv
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 18:28:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gh0nO-0005TD-Rn
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 18:28:31 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:46022)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gh0nN-0005Ro-Gq
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 18:28:29 -0500
Received: by mail-ot1-x344.google.com with SMTP id 32so5085898ota.12
	for <qemu-devel@nongnu.org>; Tue, 08 Jan 2019 15:28:28 -0800 (PST)
MIME-Version: 1.0
References: <20190108223129.5570-1-richard.henderson@linaro.org>
	<20190108223129.5570-6-richard.henderson@linaro.org>
In-Reply-To: <20190108223129.5570-6-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 8 Jan 2019 23:28:15 +0000
Message-ID: <CAFEAcA9-YJ3FZYJ1E=YfsVF1T1hWj+emKrTYabubRH4u7s72GQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 05/31] target/arm: Add PAuth helpers
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

On Tue, 8 Jan 2019 at 22:31, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> The cryptographic internals are stubbed out for now,
> but the enable and trap bits are checked.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ----
> v2: Remove trap from xpac* helpers; these are now side-effect free.
>     Use struct ARMPACKey.
> v3: Move code to pauth_helper.c; use raise_exception_ra.
> ---
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
