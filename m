Received: from eggs.gnu.org ([2001:4830:134:3::10]:45958)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dY9Fg-0004fR-5v
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 07:04:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dY9Ff-0005eK-A7
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 07:04:16 -0400
Received: from mail-wr0-x22f.google.com ([2a00:1450:400c:c0c::22f]:32843)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dY9Ff-0005e2-2v
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 07:04:15 -0400
Received: by mail-wr0-x22f.google.com with SMTP id v105so39100405wrb.0
	for <qemu-devel@nongnu.org>; Thu, 20 Jul 2017 04:04:14 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170719233455.8740-1-rth@twiddle.net>
References: <20170719233455.8740-1-rth@twiddle.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 20 Jul 2017 12:03:53 +0100
Message-ID: <CAFEAcA-ZQPV89sqJxnqTUTjR+R_miPC=SESyzyggqEF4A5Lq6A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v2 00/14] tcg-next patch queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 20 July 2017 at 00:34, Richard Henderson <rth@twiddle.net> wrote:
> This edition is a real mix:
>   * Code gen improvement for mips64 host (Jiang)
>   * Build fix for ppc-linux (Philippe)
>   * Runtime fix for tci (Philippe)
>   * Fix atomic helper names in debugging dumps (rth)
>
>   * Cross-target tcg code gen improvements (Philippe)
>     This one had no obvious tree through which it should go,
>     so I went ahead and took them all.
>
>   * Cherry-picked the first patch from Lluis' generic translate loop,
>     wherein the interface to gen_intermediate_code changes trivially.
>     It's the only patch from that series that touches all targets,
>     and I see little point carrying it around further.
>
> V2: Fixed typo in the sparc mulscc deposit patch.
>
>
> r~
>
>
> The following changes since commit d4e59218ab80e86015753782fb5378767a51ccd0:
>
>   Merge remote-tracking branch 'remotes/berrange/tags/pull-qcrypto-2017-07-18-2' into staging (2017-07-19 20:45:37 +0100)
>
> are available in the git repository at:
>
>   git://github.com/rth7680/qemu.git tags/pull-tcg-20170719
>
> for you to fetch changes up to 9c489ea6bed134fecfd556b439c68bba48fbe102:
>
>   tcg: Pass generic CPUState to gen_intermediate_code() (2017-07-19 14:45:16 -0700)
>
> ----------------------------------------------------------------
> Queued tcg and tcg code gen related cleanups

Applied, thanks.

-- PMM
