Received: from eggs.gnu.org ([2001:4830:134:3::10]:44246)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent.desnogues@gmail.com>) id 1fkrE3-0003hC-OR
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 09:31:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent.desnogues@gmail.com>) id 1fkrE2-0006yc-RQ
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 09:31:39 -0400
MIME-Version: 1.0
In-Reply-To: <20180801123111.3595-1-richard.henderson@linaro.org>
References: <20180801123111.3595-1-richard.henderson@linaro.org>
From: Laurent Desnogues <laurent.desnogues@gmail.com>
Date: Wed, 1 Aug 2018 15:31:37 +0200
Message-ID: <CABoDooOS+LgTWwxedNzwNesg_aiZjqbdT-=HaiDBZwj-QN5EQw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 0/4] target/arm sve fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, qemu-arm <qemu-arm@nongnu.org>

On Wed, Aug 1, 2018 at 2:31 PM, Richard Henderson
<richard.henderson@linaro.org> wrote:
> These four patches are minor, reported by Laurent this week.

This fixes the reported issues, thanks!

> If there happens to be an -rc4 release, it would be nice if
> they were included.  But if not, no biggie.  I suspect that
> other minor issues will be found past these four, so I would
> hope everyone who cares about sve is just as happy working
> from a branch anyway.

I indeed still have some things to look at.


Laurent

>
> r~
>
>
> Richard Henderson (4):
>   target/arm: Fix sign of sve_cmpeq_ppzw/sve_cmpne_ppzw
>   target/arm: Fix typo in do_sat_addsub_64
>   target/arm: Reorganize SVE WHILE
>   target/arm: Fix typo in helper_sve_movz_d
>
>  target/arm/sve_helper.c    | 19 ++++++--------
>  target/arm/translate-sve.c | 51 ++++++++++++++++++++++++--------------
>  2 files changed, 40 insertions(+), 30 deletions(-)
>
> --
> 2.17.1
>
