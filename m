Received: from eggs.gnu.org ([2001:4830:134:3::10]:37344)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dIY0f-0000Mo-VI
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 06:16:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dIY0f-0002wr-6I
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 06:16:17 -0400
Received: from mail-wm0-x22e.google.com ([2a00:1450:400c:c09::22e]:36719)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dIY0f-0002wS-0G
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 06:16:17 -0400
Received: by mail-wm0-x22e.google.com with SMTP id 7so114912801wmo.1
	for <qemu-devel@nongnu.org>; Wed, 07 Jun 2017 03:16:16 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170607003119.14778-1-rth@twiddle.net>
References: <20170607003119.14778-1-rth@twiddle.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 7 Jun 2017 11:15:55 +0100
Message-ID: <CAFEAcA94ZMiArYk-7mgfReTDOfd+W9Ymy1pvFi5rZUc2D32CLA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v2 00/70] target/s390x tcg patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>

On 7 June 2017 at 01:30, Richard Henderson <rth@twiddle.net> wrote:
> The queue has gotten overlong.  This includes my unwinding patches,
> the execute rewrite, and Aurelien's flushing out of missing Z insns.
>
> It does *not* include Aurelian's final patch to bump the base tcg
> cpu to z800.  David Hildenbrand had objections to that; I expect
> that we can address that in the next patch set.
>
> Changes since pull v1: Fix LPQ and STPQ implementations for
> !CONFIG_ATOMIC128 hosts.  Patches by Aurelien; tested by myself
> on an aarch64 host (which does not have CONFIG_ATOMIC128).
>
>
> r~
>
>
> The following changes since commit 65dfad62a176f5265f801683be64149c5ad55f7d:
>
>   Merge remote-tracking branch 'remotes/xtensa/tags/20170606-xtensa' into staging (2017-06-06 17:00:12 +0100)
>
> are available in the git repository at:
>
>   git://github.com/rth7680/qemu.git tags/pull-s390-20170606
>
> for you to fetch changes up to 49921d6886c54ec8727f2253b7698f173166bbd3:
>
>   target/s390x: addressing exceptions are suppressing (2017-06-06 15:25:14 -0700)
>
> ----------------------------------------------------------------
> Queued s390 patches
>

Applied, thanks.

-- PMM
