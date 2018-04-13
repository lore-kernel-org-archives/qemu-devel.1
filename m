Received: from eggs.gnu.org ([2001:4830:134:3::10]:51893)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f6y9g-0006Xg-OP
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 08:50:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f6y9f-00019M-SH
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 08:50:16 -0400
Received: from mail-ot0-x243.google.com ([2607:f8b0:4003:c0f::243]:34592)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f6y9f-00018u-OK
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 08:50:15 -0400
Received: by mail-ot0-x243.google.com with SMTP id i5-v6so260854oth.1
	for <qemu-devel@nongnu.org>; Fri, 13 Apr 2018 05:50:15 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180324192455.12254-10-mdavidsaver@gmail.com>
References: <20180324192455.12254-1-mdavidsaver@gmail.com>
	<20180324192455.12254-10-mdavidsaver@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 13 Apr 2018 13:49:54 +0100
Message-ID: <CAFEAcA_zENm9KMW6sxD98xBCG7-ePaJYYtGVMiURasnUB5Xp4A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 09/14] timer: rename ds1338 -> dsrtc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Davidsaver <mdavidsaver@gmail.com>
Cc: Thomas Huth <thuth@redhat.com>, Antoine Mathys <barsamin@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, QEMU Developers <qemu-devel@nongnu.org>

On 24 March 2018 at 19:24, Michael Davidsaver <mdavidsaver@gmail.com> wrote:
> Prepare to generalize with a more generic
> name.
>
> Keep device name and vmstate name "ds1338"
> for compatibility.
>
> Signed-off-by: Michael Davidsaver <mdavidsaver@gmail.com>
> ---
>  hw/timer/ds1338.c | 74 +++++++++++++++++++++++++++----------------------------
>  1 file changed, 37 insertions(+), 37 deletions(-)
>
> diff --git a/hw/timer/ds1338.c b/hw/timer/ds1338.c
> index a969b5c8ba..28f788dd8e 100644
> --- a/hw/timer/ds1338.c
> +++ b/hw/timer/ds1338.c
> @@ -1,5 +1,5 @@
>  /*
> - * MAXIM DS1338 I2C RTC+NVRAM
> + * MAXIM DSRTC I2C RTC+NVRAM
>   *

I don't think the search-and-replace makes sense on this comment;
it should probably be "MAXIM DS13xx I2C RTC" or "DSxxxx" or
something, since we're trying to identify a product name/family.

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
