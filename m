Received: from eggs.gnu.org ([2001:4830:134:3::10]:56885)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f0oN5-0005gE-6g
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 09:10:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f0oN4-0000nj-5S
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 09:10:39 -0400
Received: from mail-ot0-x243.google.com ([2607:f8b0:4003:c0f::243]:40627)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f0oN3-0000ms-Vj
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 09:10:38 -0400
Received: by mail-ot0-x243.google.com with SMTP id w12-v6so2456881otj.7
	for <qemu-devel@nongnu.org>; Tue, 27 Mar 2018 06:10:37 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180326165030.875-1-richard.henderson@linaro.org>
References: <20180326165030.875-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Mar 2018 14:10:16 +0100
Message-ID: <CAFEAcA-ifqhtoBQzTLNLMN-5-Xz=d45xc2SL9oYH-if_xZvCgg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL for-2.12 0/1] target/hppa: Fix for glibc 2.27
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

On 26 March 2018 at 17:50, Richard Henderson
<richard.henderson@linaro.org> wrote:
> The following changes since commit 2ffd221d07a671f72354a063d3080f244ec80b20:
>
>   Merge remote-tracking branch 'remotes/jasowang/tags/net-pull-request' into staging (2018-03-26 11:02:50 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/rth7680/qemu.git tags/pull-hppa-20180327
>
> for you to fetch changes up to ebd0e151149a6280ea9f4cd9638aea517bb3238b:
>
>   target/hppa: Include priv level in user-only iaoq (2018-03-26 22:56:57 +0800)
>
> ----------------------------------------------------------------
> Fix glibc 2.27 for hppa-linux-user
>
> ----------------------------------------------------------------
> Richard Henderson (1):
>       target/hppa: Include priv level in user-only iaoq
>
>  target/hppa/cpu.h       |  4 ++--
>  target/hppa/translate.c | 12 ++++--------
>  2 files changed, 6 insertions(+), 10 deletions(-)

Applied, thanks.

-- PMM
