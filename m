Received: from eggs.gnu.org ([2001:4830:134:3::10]:54148)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ennK3-0006px-FH
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 10:25:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ennK2-0003Ww-Ki
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 10:25:43 -0500
Received: from mail-ot0-x242.google.com ([2607:f8b0:4003:c0f::242]:45143)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ennK2-0003W3-FA
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 10:25:42 -0500
Received: by mail-ot0-x242.google.com with SMTP id f11so3233360otj.12
	for <qemu-devel@nongnu.org>; Mon, 19 Feb 2018 07:25:42 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1519053606-9817-3-git-send-email-minyard@acm.org>
References: <CACRpkda9B=frmS0QF429p-q+KoCKG=5NON-kQ0Rt-nba2powRA@mail.gmail.com>
	<1519053606-9817-1-git-send-email-minyard@acm.org>
	<1519053606-9817-3-git-send-email-minyard@acm.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 19 Feb 2018 15:25:21 +0000
Message-ID: <CAFEAcA-jTZMDNTF2rPn20DjSxu=z7n9M+2xo-pNfAYoha_LuzQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 2/2] i2c: Move the bus class to i2c.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Corey Minyard <minyard@acm.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, Corey Minyard <cminyard@mvista.com>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 19 February 2018 at 15:20,  <minyard@acm.org> wrote:
> From: Corey Minyard <cminyard@mvista.com>
>
> Some devices need access to it.
>
> Signed-off-by: Corey Minyard <cminyard@mvista.com>
> ---
>  hw/i2c/core.c        | 17 -----------------
>  include/hw/i2c/i2c.h | 17 +++++++++++++++++
>  2 files changed, 17 insertions(+), 17 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
