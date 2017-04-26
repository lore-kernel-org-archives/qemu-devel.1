Received: from eggs.gnu.org ([2001:4830:134:3::10]:37658)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1d3TYi-0003ez-MU
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 16:29:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1d3TYi-0001Mp-0o
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 16:29:08 -0400
Received: from mail-wr0-x235.google.com ([2a00:1450:400c:c0c::235]:33990)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1d3TYh-0001Mg-QL
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 16:29:07 -0400
Received: by mail-wr0-x235.google.com with SMTP id l9so6292003wre.1
	for <qemu-devel@nongnu.org>; Wed, 26 Apr 2017 13:29:07 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170426173044.32525-1-rth@twiddle.net>
References: <20170426173044.32525-1-rth@twiddle.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 26 Apr 2017 21:28:45 +0100
Message-ID: <CAFEAcA9k3KT+CsZKm50PrNo2AnvPD39USdkXjQWvS1GYHSwkCw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL] tcg queued patch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>

On 26 April 2017 at 18:30, Richard Henderson <rth@twiddle.net> wrote:
> Fixes a tcg_error when building with clang on some hosts.
>
>
> r~
>
>
> The following changes since commit 51b9d495f2a99c65c9e524c8f6fe283ebfabae1d:
>
>   Revert "COLO-compare: Optimize tcp compare trace event" (2017-04-26 16:19:27 +0100)
>
> are available in the git repository at:
>
>   git://github.com/rth7680/qemu.git tags/pull-tcg-20170426
>
> for you to fetch changes up to 79b1af906245558c30e0a5faf26cb52b63f83cce:
>
>   tcg: Initialize return value after exit_atomic (2017-04-26 19:26:11 +0200)
>
> ----------------------------------------------------------------
> Fix for exit_atomic tcg opcode paths
>
> ----------------------------------------------------------------
> Richard Henderson (1):
>       tcg: Initialize return value after exit_atomic
>
>  tcg/tcg-op.c | 6 ++++++
>  1 file changed, 6 insertions(+)


Applied, thanks.

-- PMM
