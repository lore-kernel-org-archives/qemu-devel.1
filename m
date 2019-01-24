Received: from eggs.gnu.org ([209.51.188.92]:58928)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gmday-0006aU-SQ
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 06:54:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gmday-0007Ki-7O
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 06:54:56 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:35299)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gmdax-0007I0-TE
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 06:54:56 -0500
Received: by mail-oi1-x241.google.com with SMTP id v6so4607150oif.2
	for <qemu-devel@nongnu.org>; Thu, 24 Jan 2019 03:54:55 -0800 (PST)
MIME-Version: 1.0
References: <20190108223129.5570-1-richard.henderson@linaro.org>
	<20190108223129.5570-19-richard.henderson@linaro.org>
In-Reply-To: <20190108223129.5570-19-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 24 Jan 2019 11:54:42 +0000
Message-ID: <CAFEAcA-dCxGzG81_z7aRQb0WZA6gMDO_V4w5Mh0HScNrSC4z9Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 18/31] target/arm: Create
 ARMVAParameters and helpers
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

On Tue, 8 Jan 2019 at 22:32, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Split out functions to extract the virtual address parameters.
> Let the functions choose T0 or T1 address space half, if present.
> Extract (most of) the control bits that vary between EL or Tx.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>


> +    top_bits = sextract64(address, inputsize, addrsize - inputsize);

I've just run into an assertion here running an aarch32 guest
that uses LPAE, because addrsize == inputsize == 32, and
sextract64() insists on a non-zero length...

thanks
-- PMM
