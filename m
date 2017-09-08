Received: from eggs.gnu.org ([2001:4830:134:3::10]:45185)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dqG7Y-00065D-Uf
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 06:02:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dqG7U-0001mr-99
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 06:02:44 -0400
Received: from mail-wm0-x22b.google.com ([2a00:1450:400c:c09::22b]:45018)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dqG7U-0001mO-1f
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 06:02:40 -0400
Received: by mail-wm0-x22b.google.com with SMTP id 137so4862756wmj.1
	for <qemu-devel@nongnu.org>; Fri, 08 Sep 2017 03:02:39 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170907181938.3948-1-richard.henderson@linaro.org>
References: <20170907181938.3948-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 8 Sep 2017 11:02:17 +0100
Message-ID: <CAFEAcA8Dhmgzd7cbHe3vCvJkNTegPyqLd2eZkCpsAZObNUx+rA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/4] target/alpha queued patches
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

On 7 September 2017 at 19:19, Richard Henderson
<richard.henderson@linaro.org> wrote:
> Convert to TranslatorOps and do_transaction_failed.
>
>
> r~
>
>
> The following changes since commit cda4a338c4243fa3bff4498b935340ac7121cc76:
>
>   tcg/tci: Add TCG_TARGET_DEFAULT_MO (2017-09-07 18:57:34 +0100)
>
> are available in the git repository at:
>
>   git://github.com/rth7680/qemu.git tags/pull-axp-20170907
>
> for you to fetch changes up to 6ad4d7eed05a1e23537fc92b50f898f5977f37e6:
>
>   target/alpha: Switch to do_transaction_failed() hook (2017-09-07 11:15:55 -0700)
>
> ----------------------------------------------------------------
> Queued target/alpha patches
>
> ----------------------------------------------------------------
> Peter Maydell (1):
>       target/alpha: Switch to do_transaction_failed() hook
>
> Richard Henderson (3):
>       target/alpha: Convert to DisasJumpType
>       target/alpha: Convert to DisasContextBase
>       target/alpha: Convert to TranslatorOps
>
>  target/alpha/cpu.c        |   2 +-
>  target/alpha/cpu.h        |   8 +-
>  target/alpha/helper.c     |   8 ++
>  target/alpha/mem_helper.c |  19 +--
>  target/alpha/translate.c  | 347 +++++++++++++++++++++-------------------------
>  5 files changed, 180 insertions(+), 204 deletions(-)

Applied, thanks.

-- PMM
