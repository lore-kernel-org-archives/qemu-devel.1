Received: from eggs.gnu.org ([209.51.188.92]:54621)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1guGyi-00070B-7I
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 08:23:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1guGri-0000zG-96
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 08:15:52 -0500
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332]:44103)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1guGrf-0000t9-B4
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 08:15:44 -0500
Received: by mail-ot1-x332.google.com with SMTP id g1so10310832otj.11
	for <qemu-devel@nongnu.org>; Thu, 14 Feb 2019 05:15:41 -0800 (PST)
MIME-Version: 1.0
References: <20190212212957.32393-1-richard.henderson@linaro.org>
In-Reply-To: <20190212212957.32393-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 Feb 2019 13:15:29 +0000
Message-ID: <CAFEAcA8n+A7oyJc24dcci2wB0Wv-kwPtCqmO3+oyZCjkbtq_aA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v2 00/24] target/hppa patch queue
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

On Tue, 12 Feb 2019 at 21:30, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> v2 fixes the clang build failure.  I've addressed this by changing
> the names of two of the insns.decode argument sets.  This could
> probably use an additional error from decodetree.py itself...
>
> Only reposting the changed patch, 12/24.
>
>
> r~
>
>
> The following changes since commit 0b5e750bea635b167eb03d86c3d9a09bbd43bc06:
>
>   Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request' into staging (2019-02-12 10:53:37 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/rth7680/qemu.git tags/pull-hppa-20190212
>
> for you to fetch changes up to cb82c5728c3402248068002c0d13f55f9adcb073:
>
>   hw/hppa: forward requests to CPU HPA (2019-02-12 08:59:21 -0800)
>
> ----------------------------------------------------------------
> Convert to decodetree.
> Fix signed overflow conditions.
> Fix dcor.
> Add CPU MIE to PCI address space.

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM
