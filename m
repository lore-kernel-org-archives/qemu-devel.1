Received: from eggs.gnu.org ([2001:4830:134:3::10]:35496)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1erO7H-0002DD-6U
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 08:19:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1erO7G-0000uv-BV
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 08:19:23 -0500
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:39852)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1erO7G-0000uk-4X
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 08:19:22 -0500
Received: by mail-oi0-x243.google.com with SMTP id t185so4410215oif.6
	for <qemu-devel@nongnu.org>; Thu, 01 Mar 2018 05:19:22 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180228193125.20577-4-richard.henderson@linaro.org>
References: <20180228193125.20577-1-richard.henderson@linaro.org>
	<20180228193125.20577-4-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 1 Mar 2018 13:19:01 +0000
Message-ID: <CAFEAcA9rSKMGTtV6c1aCdMZj+5RbSCrXMv7jSgdyhpV44Q0gYg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v3 03/16] target/arm: Refactor
 disas_simd_indexed size checks
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

On 28 February 2018 at 19:31, Richard Henderson
<richard.henderson@linaro.org> wrote:
> The integer size check was already outside of the opcode switch;
> move the floating-point size check outside as well.  Unify the
> size vs index adjustment between fp and integer paths.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
