Received: from eggs.gnu.org ([2001:4830:134:3::10]:51212)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gIZJR-0006NN-12
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 09:16:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gIZJP-0001PJ-3H
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 09:16:32 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:46643)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gIZJN-0001JT-9c
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 09:16:29 -0400
Received: by mail-oi1-x243.google.com with SMTP id k64-v6so1506569oia.13
	for <qemu-devel@nongnu.org>; Fri, 02 Nov 2018 06:16:20 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20181101113711.28074-1-laurent@vivier.eu>
References: <20181101113711.28074-1-laurent@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 2 Nov 2018 13:15:59 +0000
Message-ID: <CAFEAcA_xnCxFJ0FOOuG+bbkvjnGx=j5_M19KbqZZ5ZmubLJcbg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/1] M68k for 3.1 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 1 November 2018 at 11:37, Laurent Vivier <laurent@vivier.eu> wrote:
> The following changes since commit 7d51a855cd568ec3399a1834ada4023cfa12f231:
>
>   Merge remote-tracking branch 'remotes/xtensa/tags/20181030-xtensa' into staging (2018-10-31 16:11:43 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/vivier/qemu-m68k.git tags/m68k-for-3.1-pull-request
>
> for you to fetch changes up to b9f8e55bf7e994e192ab7360830731580384b813:
>
>   target/m68k: use EXCP_ILLEGAL instead of EXCP_UNSUPPORTED (2018-11-01 12:12:24 +0100)
>
> ----------------------------------------------------------------
> Fix illegal instruction exception number
>
> ----------------------------------------------------------------
>
> Laurent Vivier (1):
>   target/m68k: use EXCP_ILLEGAL instead of EXCP_UNSUPPORTED
>
>  linux-user/m68k/cpu_loop.c | 1 -
>  target/m68k/cpu.h          | 1 -
>  target/m68k/translate.c    | 6 +++---
>  3 files changed, 3 insertions(+), 5 deletions(-)
>

Applied, thanks.

-- PMM
