Received: from eggs.gnu.org ([2001:4830:134:3::10]:55295)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dopG9-0007Cp-BA
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 07:09:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dopFn-0004od-3I
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 07:09:41 -0400
Received: from mail-wr0-x22a.google.com ([2a00:1450:400c:c0c::22a]:35349)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dopFm-0004nV-S6
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 07:09:19 -0400
Received: by mail-wr0-x22a.google.com with SMTP id y15so596086wrc.2
	for <qemu-devel@nongnu.org>; Mon, 04 Sep 2017 04:09:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170825224833.4463-1-richard.henderson@linaro.org>
References: <20170825224833.4463-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 4 Sep 2017 12:08:57 +0100
Message-ID: <CAFEAcA-Wdth5paDKF7m0g9BXMwphPYLP=9-u+KtYb-h-GaAuBw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH] target/arm: Fix aa64 ldp
 register writeback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, qemu-stable <qemu-stable@nongnu.org>

On 25 August 2017 at 23:48, Richard Henderson
<richard.henderson@linaro.org> wrote:
> For "ldp x0, x1, [x0]", if the second load is on a second page and
> the second page is unmapped, the exception would be raised with x0
> already modified.  This means the instruction couldn't be restarted.
>
> Cc: qemu-arm@nongnu.org
> Cc: qemu-stable@nongnu.org
> Reported-by: Andrew <andrew@fubar.geek.nz>
> Fixes: https://bugs.launchpad.net/qemu/+bug/1713066
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/translate-a64.c | 28 ++++++++++++++++------------
>  1 file changed, 16 insertions(+), 12 deletions(-)

Applied to target-arm.next, thanks.

-- PMM
