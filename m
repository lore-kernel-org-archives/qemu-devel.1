Received: from eggs.gnu.org ([2001:4830:134:3::10]:33754)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f96dH-0001pf-M0
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 06:17:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f96dG-0000JY-Ly
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 06:17:39 -0400
Received: from mail-ot0-x230.google.com ([2607:f8b0:4003:c0f::230]:44046)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f96dG-0000J1-Gk
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 06:17:38 -0400
Received: by mail-ot0-x230.google.com with SMTP id p33-v6so5224972otp.11
	for <qemu-devel@nongnu.org>; Thu, 19 Apr 2018 03:17:38 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180417221246.14672-1-richard.henderson@linaro.org>
References: <20180417221246.14672-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 19 Apr 2018 11:17:17 +0100
Message-ID: <CAFEAcA-auT4gVS0boZcFxeNuf-6x4u_wfochb9bqwKmryjtsUA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH for-2.13] tcg: Allow wider vectors for cmp
 and mul
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

On 17 April 2018 at 23:12, Richard Henderson
<richard.henderson@linaro.org> wrote:
> In db432672, we allow wide inputs for operations such as add.
> However, in 212be173 and 3774030a we didn't do the same for
> compare and multiply.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Can we hit these asserts in the uses of tcg_gen_mul_vec
and tcg_gen_cmp_vec currently in the aarch64 frontend, or
is this only a problem for the not-yet-landed SVE code?

I notice that do_shifti() also has a
    tcg_debug_assert(at->base_type == type);
Is that assert correct, or should it also be changed to >= ?

thanks
-- PMM
