Received: from eggs.gnu.org ([2001:4830:134:3::10]:33350)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fEFnZ-0007ky-Uz
	for qemu-devel@nongnu.org; Thu, 03 May 2018 11:05:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fEFnU-0005gv-0X
	for qemu-devel@nongnu.org; Thu, 03 May 2018 11:05:33 -0400
Received: from mail-ot0-x22f.google.com ([2607:f8b0:4003:c0f::22f]:39454)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fEFnT-0005gg-Rr
	for qemu-devel@nongnu.org; Thu, 03 May 2018 11:05:27 -0400
Received: by mail-ot0-x22f.google.com with SMTP id l12-v6so21005760oth.6
	for <qemu-devel@nongnu.org>; Thu, 03 May 2018 08:05:27 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180501180455.11214-1-richard.henderson@linaro.org>
References: <20180501180455.11214-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 3 May 2018 16:05:06 +0100
Message-ID: <CAFEAcA-fEuV6COE7jzSZLpzRXPEb1pJo2zJjO_nbxXavLjwCjw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 0/2] target/arm: Coverity fixups
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

On 1 May 2018 at 19:04, Richard Henderson <richard.henderson@linaro.org> wrote:
> The first patch covers four related false positives.  However,
> we check the same condition twice and we certainly don't need
> to that.  Plus the assert might just help documentation-wise.
>
> The second patch covers dead code.  I believe that Coverity is
> right and that there are no paths that have !is_q at this point.
> Add the assert to check that is true.
>
> The RISU tests that I ran over these insns came out clean.
>

Applied to target-arm.next, thanks.

-- PMM
