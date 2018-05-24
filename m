Received: from eggs.gnu.org ([2001:4830:134:3::10]:48232)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fLqBa-0008KE-51
	for qemu-devel@nongnu.org; Thu, 24 May 2018 09:21:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fLqBV-0003sp-Gb
	for qemu-devel@nongnu.org; Thu, 24 May 2018 09:21:42 -0400
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:38425)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fLqBV-0003s0-Bk
	for qemu-devel@nongnu.org; Thu, 24 May 2018 09:21:37 -0400
Received: by mail-ot0-x244.google.com with SMTP id n3-v6so1889077ota.5
	for <qemu-devel@nongnu.org>; Thu, 24 May 2018 06:21:37 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180522175629.24932-1-richard.henderson@linaro.org>
References: <20180522175629.24932-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 24 May 2018 14:21:16 +0100
Message-ID: <CAFEAcA_-tuEXm0gGNkzs0xb2Rm90Nm_t2i3pYJRULay08h_FLg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] tcg: Fix helper function vs host abi for
 float16
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

On 22 May 2018 at 18:56, Richard Henderson <richard.henderson@linaro.org> wrote:
> Depending on the host abi, float16, aka uint16_t, values are
> passed and returned either zero-extended in the host register
> or with garbage at the top of the host register.
>
> The tcg code generator has so far been assuming garbage, as that
> matches the x86 abi, but this is incorrect for other host abis.
> Further, target/arm has so far been assuming zero-extended results,
> so that it may store the 16-bit value into a 32-bit slot with the
> high 16-bits already clear.
>
> Rectify both problems by mapping "f16" in the helper definition
> to uint32_t instead of (a typedef for) uint16_t.  This forces
> the host compiler to assume garbage in the upper 16 bits on input
> and to zero-extend the result on output.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Applied to target-arm.next, thanks. Is it worth marking this as
cc:stable?

thanks
-- PMM
