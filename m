Received: from eggs.gnu.org ([208.118.235.92]:52194)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gf3Bc-0007qP-Sg
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 08:37:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gf3Bc-00056d-9U
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 08:37:24 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:40068)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gf3Bc-00056J-4d
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 08:37:24 -0500
Received: by mail-ot1-x343.google.com with SMTP id s5so29358602oth.7
	for <qemu-devel@nongnu.org>; Thu, 03 Jan 2019 05:37:23 -0800 (PST)
MIME-Version: 1.0
References: <20181226215003.31438-1-richard.henderson@linaro.org>
In-Reply-To: <20181226215003.31438-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 3 Jan 2019 13:37:11 +0000
Message-ID: <CAFEAcA8aT+4p+qpWxtH-dOJwvHR5xDzH2sao4UMU-XZ=JkMU5w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] target/arm: SVE brk[ab] merging does not
 have s bit
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

On Wed, 26 Dec 2018 at 21:50, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> While brk[ab] zeroing has a flags setting option, the merging variant
> does not.  Retain the same argument structure, to share expansion but
> force the flag zero and do not decode bit 22.
>
> Reported-by: Laurent Desnogues <laurent.desnogues@gmail.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>
> The xml from which Alex and I extracted risu test cases does not call
> out bit 22 as a field, so we did not test this illegal encoding.
>
>
> r~



Applied to target-arm.next, thanks.

-- PMM
