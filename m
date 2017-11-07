Received: from eggs.gnu.org ([2001:4830:134:3::10]:51336)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eC3OD-0004P9-EO
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 07:54:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eC3OC-0003Ca-8X
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 07:54:01 -0500
Received: from mail-wm0-x230.google.com ([2a00:1450:400c:c09::230]:43587)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eC3OC-0003Bm-1x
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 07:54:00 -0500
Received: by mail-wm0-x230.google.com with SMTP id r68so12889045wmr.0
	for <qemu-devel@nongnu.org>; Tue, 07 Nov 2017 04:53:59 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1510049762-4609-1-git-send-email-peter.maydell@linaro.org>
References: <1510049762-4609-1-git-send-email-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 7 Nov 2017 12:53:37 +0000
Message-ID: <CAFEAcA-6nEHiXvxXDPym1oguvXEHBUyVNnL23mssNvT-qCaAYA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/3] cocoa queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: G 3 <programmingkidx@gmail.com>

On 7 November 2017 at 10:15, Peter Maydell <peter.maydell@linaro.org> wrote:
> Cocoa patches for rc0.
>
> The following changes since commit 299d1ea9bb56bd9f45f905125489bdd7d543a1aa:
>
>   Merge remote-tracking branch 'remotes/yongbok/tags/mips-20171106' into staging (2017-11-06 16:13:10 +0000)
>
> are available in the git repository at:
>
>   git://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-cocoa-20171107
>
> for you to fetch changes up to ef2088f9af16d3a19f5f094da160dd8ba52231a9:
>
>   ui/cocoa.m: Send ctrl-alt key combos to guest if QEMU isn't using them (2017-11-07 10:14:14 +0000)
>
> ----------------------------------------------------------------
> cocoa queue:
>  * make scrolling work in GUI monitor windows
>  * change ungrab to ctrl-alt-g (matching gtk)
>  * pass unused ctrl-alt combos to guest
>
> ----------------------------------------------------------------
> John Arbuckle (2):
>       ui/cocoa.m: Make scrolling work again in GUI monitor windows
>       ui/cocoa.m: move ungrab to ctrl-alt-g
>
> Peter Maydell (1):
>       ui/cocoa.m: Send ctrl-alt key combos to guest if QEMU isn't using them
>
>  ui/cocoa.m | 135 +++++++++++++++++++++++++++++++++++++++----------------------
>  1 file changed, 86 insertions(+), 49 deletions(-)

Applied, thanks.

-- PMM
