Received: from eggs.gnu.org ([2001:4830:134:3::10]:41741)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fa3ES-0005dt-NJ
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 14:07:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fa3ER-0007NS-S8
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 14:07:24 -0400
Received: from mail-oi0-x22a.google.com ([2607:f8b0:4003:c06::22a]:46123)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fa3ER-0007N4-Mb
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 14:07:23 -0400
Received: by mail-oi0-x22a.google.com with SMTP id y207-v6so18044362oie.13
	for <qemu-devel@nongnu.org>; Mon, 02 Jul 2018 11:07:23 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180702160546.31969-1-richard.henderson@linaro.org>
References: <20180702160546.31969-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 2 Jul 2018 19:07:02 +0100
Message-ID: <CAFEAcA9FvHZComukPjAA6gwUBAgryFVW2P=yLwmTFqLb_LR5YQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/6] tcg queued patches
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

On 2 July 2018 at 17:05, Richard Henderson <richard.henderson@linaro.org> wrote:
> The following changes since commit 2d58e33ec1b76990f09bc1e3412e0b36e1ac4634:
>
>   Merge remote-tracking branch 'remotes/vivier/tags/m68k-for-3.0-pull-request' into staging (2018-07-02 13:43:10 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/rth7680/qemu.git tags/pull-tcg-20180702
>
> for you to fetch changes up to 9c8c334b0637bf3c592d432b0c11f3b62dd5dba3:
>
>   cpu: Assert asidx_from_attrs return value in range (2018-07-02 08:09:49 -0700)
>
> ----------------------------------------------------------------
> Assorted tlb and tb caching fixes
>
> ----------------------------------------------------------------
> Emilio G. Cota (1):
>       translate-all: fix locking of TBs whose two pages share the same physical page
>
> Peter Maydell (3):
>       tcg: Define and use new tlb_hit() and tlb_hit_page() functions
>       accel/tcg: Correct "is this a TLB miss" check in get_page_addr_code()
>       accel/tcg: Don't treat invalid TLB entries as needing recheck
>
> Richard Henderson (2):
>       accel/tcg: Avoid caching overwritten tlb entries
>       cpu: Assert asidx_from_attrs return value in range

Applied, thanks.

-- PMM
