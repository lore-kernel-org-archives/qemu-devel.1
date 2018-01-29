Received: from eggs.gnu.org ([2001:4830:134:3::10]:45682)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1egDGk-0006XJ-57
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 12:30:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1egDGj-0002ml-6Z
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 12:30:58 -0500
Received: from mail-ot0-x241.google.com ([2607:f8b0:4003:c0f::241]:33871)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1egDGj-0002la-1v
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 12:30:57 -0500
Received: by mail-ot0-x241.google.com with SMTP id x15so7286721ote.1
	for <qemu-devel@nongnu.org>; Mon, 29 Jan 2018 09:30:56 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180123035349.24538-2-richard.henderson@linaro.org>
References: <20180123035349.24538-1-richard.henderson@linaro.org>
	<20180123035349.24538-2-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Jan 2018 17:30:35 +0000
Message-ID: <CAFEAcA-9h0v_FqvR8rYrF-J4-CRnzHt7ByU1ygPA_6chukGEQw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 1/5] target/arm: Expand vector registers
 for SVE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>

On 23 January 2018 at 03:53, Richard Henderson
<richard.henderson@linaro.org> wrote:
> Change vfp.regs as a uint64_t to vfp.zregs as an ARMVectorReg.
> The previous patches have made the change in representation
> relatively painless.
>
> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/cpu.h           | 59 +++++++++++++++++++++++++++++++---------=
------
>  target/arm/machine.c       | 35 ++++++++++++++++++++++++++-
>  target/arm/translate-a64.c |  8 +++----
>  target/arm/translate.c     |  7 +++---
>  4 files changed, 81 insertions(+), 28 deletions(-)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
