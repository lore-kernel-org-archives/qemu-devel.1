Received: from eggs.gnu.org ([2001:4830:134:3::10]:60708)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f6yLD-0006eA-Ie
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 09:02:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f6yLC-0002qK-NV
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 09:02:11 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:43288)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f6yLC-0002pq-J8
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 09:02:10 -0400
Received: by mail-oi0-x242.google.com with SMTP id u84-v6so8268067oie.10
	for <qemu-devel@nongnu.org>; Fri, 13 Apr 2018 06:02:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180324192455.12254-14-mdavidsaver@gmail.com>
References: <20180324192455.12254-1-mdavidsaver@gmail.com>
	<20180324192455.12254-14-mdavidsaver@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 13 Apr 2018 14:01:48 +0100
Message-ID: <CAFEAcA8tE6THy1+ku5-KfxEGvUuiOrMS6tscVJY+MeNuUGhYgw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 13/14] timer: ds-rtc model ds1375
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
> differences from ds1338
>
> * Has alarms (not modeled)
> * different control register (not modeled)
> * smaller address space (0x20 vs. 0x40)
>
> Signed-off-by: Michael Davidsaver <mdavidsaver@gmail.com>
> ---
>  hw/timer/ds-rtc.c | 30 ++++++++++++++++++++++++++++--
>  1 file changed, 28 insertions(+), 2 deletions(-)
>
> diff --git a/hw/timer/ds-rtc.c b/hw/timer/ds-rtc.c
> index 5a4df1b115..e5da36cae8 100644
> --- a/hw/timer/ds-rtc.c
> +++ b/hw/timer/ds-rtc.c
> @@ -1,8 +1,9 @@
>  /*
> - * MAXIM DSRTC I2C RTC+NVRAM
> + * MAXIM/Dallas DS1338 and DS1375 I2C RTC+NVRAM

Ah, if you're going to change this to this text here, you
should just leave it reading DS1338 in the earlier patch.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
