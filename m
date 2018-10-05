Received: from eggs.gnu.org ([2001:4830:134:3::10]:46506)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g8OGs-0002l6-GV
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 07:27:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g8OGc-0004np-BW
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 07:27:50 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:35676)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1g8OGc-0004lm-5E
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 07:27:34 -0400
Received: by mail-ot1-x344.google.com with SMTP id j9-v6so12364603otl.2
	for <qemu-devel@nongnu.org>; Fri, 05 Oct 2018 04:27:33 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20181005110837.28209-1-kraxel@redhat.com>
References: <20181005110837.28209-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 5 Oct 2018 12:27:13 +0100
Message-ID: <CAFEAcA_sJoCDT4mS2nEmdKiMVz6GgSN_bOiiNWFy5k7jm5=Gag@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] i2c: switch ddc to use the new edid
 generator
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Linus Walleij <linus.walleij@linaro.org>

On 5 October 2018 at 12:08, Gerd Hoffmann <kraxel@redhat.com> wrote:
> This also makes the default display resolution configurable,
> via xres and yres properties.  The default is 1024x768.
>
> The old code had a hard-coded resolution of 1600x1200.
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: BALATON Zoltan <balaton@eik.bme.hu>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  include/hw/i2c/i2c-ddc.h |   4 +-
>  hw/i2c/i2c-ddc.c         | 200 ++---------------------------------------------
>  2 files changed, 11 insertions(+), 193 deletions(-)

Nice diffstat :-)

Technically this is a migration break potentially if the guest
was halfway through reading the EDID data, but I think we
can live with that for the boards it affects (vexpress,
sam460ex).

thanks
-- PYMM
