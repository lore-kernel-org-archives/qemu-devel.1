Received: from eggs.gnu.org ([2001:4830:134:3::10]:41624)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eopML-0001lo-Uu
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 06:48:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eopML-0006ip-8O
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 06:48:22 -0500
Received: from mail-ot0-x22b.google.com ([2607:f8b0:4003:c0f::22b]:45308)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eopML-0006iW-2n
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 06:48:21 -0500
Received: by mail-ot0-x22b.google.com with SMTP id f11so4333353otj.12
	for <qemu-devel@nongnu.org>; Thu, 22 Feb 2018 03:48:20 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180216022933.10945-1-f4bug@amsat.org>
References: <20180216022933.10945-1-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Feb 2018 11:47:59 +0000
Message-ID: <CAFEAcA_YneTscMtpT6hyf6GJeAgD1ehfc7Jopyb=EDRFcx9-RQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 0/7] SDHCI: convert legacy devices to
 the SDBus API (part 6)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Alistair Francis <alistair.francis@xilinx.com>, QEMU Developers <qemu-devel@nongnu.org>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Andrzej Zaborowski <balrogg@gmail.com>, Michael Walle <michael@walle.cc>, Stefan Weil <sw@weilnetz.de>

On 16 February 2018 at 02:29, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>=
 wrote:
> Hi,
>
> Since v2:
> - pl181: remove legacy sd_set_cb() (Peter)
>
> Since v1:
> - rebased on /master (Peter sdcard reset() patches)
> - fix milkymist-mmc from previous seris using instance_init (Michael Wall=
e)
>
> This series convert 3 devices using the legacy SDCard API to the SDBus AP=
I:
> - milkymist-mmc
> - pl181
> - ssi-sd
>
> Then move the legacy API to a separate header "sdcard_legacy.h".
>
> Now the OMAP MMC is the last device using the legacy API, but need to get
> QOM'ified first.
>
> Having a common sdbus interface simplify qtesting (next series)
>
> This series is not related to the previous set (4/5) and can be applied
> independently.
>
> Regards,
>
> Phil.
>
> $ git backport-diff
> 001/7:[----] [--] 'hw/sd/milkymist-memcard: use qemu_log_mask()'
> 002/7:[----] [--] 'hw/sd/milkymist-memcard: split realize() out of SysBus=
Device init()'
> 003/7:[----] [--] 'hw/sd/milkymist-memcard: expose a SDBus and connect th=
e SDCard to it'
> 004/7:[----] [--] 'hw/sd/ssi-sd: use the SDBus API, connect the SDCard to=
 the bus'
> 005/7:[0034] [FC] 'hw/sd/pl181: expose a SDBus and connect the SDCard to =
it'
> 006/7:[down] 'hw/sd: make sd_data_ready() static'
> 007/7:[0003] [FC] 'hw/sd: move sdcard legacy API to "hw/sd/sdcard_legacy.=
h"'

I've applied patches 1-4 to target-arm.next; I had a review comment on 5
and 6,7 depend on that one.

thanks
-- PMM
