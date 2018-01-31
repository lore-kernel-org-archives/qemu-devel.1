Received: from eggs.gnu.org ([2001:4830:134:3::10]:39452)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1egt1D-0000Vc-Jf
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 09:05:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1egt17-00062K-TN
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 09:05:43 -0500
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:38834)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1egt17-00061M-N9
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 09:05:37 -0500
Received: by mail-qt0-x242.google.com with SMTP id z10so21950924qti.5
	for <qemu-devel@nongnu.org>; Wed, 31 Jan 2018 06:05:37 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180123035837.16578-1-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <78cbdfdc-4d4b-022c-9b75-c18a05b1659d@amsat.org>
Date: Wed, 31 Jan 2018 11:05:32 -0300
MIME-Version: 1.0
In-Reply-To: <20180123035837.16578-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 0/6] SDHCI: convert legacy devices to
 the SDBus API (part 6)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Michael Walle <michael@walle.cc>
Cc: qemu-devel@nongnu.org, Andrzej Zaborowski <balrogg@gmail.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Stefan Weil <sw@weilnetz.de>

Hi,

On 01/23/2018 12:58 AM, Philippe Mathieu-Daudé wrote:
> Since v1:
> - rebased on /master (Peter sdcard reset() patches)
> - fix milkymist-mmc from previous seris using instance_init (Michael Walle)
> 
> This series convert 3 devices using the legacy SDCard API to the SDBus API:
> - milkymist-mmc
> - pl181
> - ssi-sd
> 
> Then move the legacy API to a separate header "sdcard_legacy.h".

This series is not related to the previous set (2/3/4/5) and can be
applied independently.

> 
> Now the OMAP MMC is the last device using the legacy API, but need to get
> QOM'ified first.
> 
> Having a common sdbus interface simplify qtesting (next series)
> 
> Regards,
> 
> Phil.
> 
> $ git backport-diff
> 001/6:[----] [--] 'hw/sd/milkymist-memcard: use qemu_log_mask()'
> 002/6:[0014] [FC] 'hw/sd/milkymist-memcard: split realize() out of SysBusDevice init()'
> 003/6:[0004] [FC] 'hw/sd/milkymist-memcard: expose a SDBus and connect the SDCard to it'
> 004/6:[0006] [FC] 'hw/sd/pl181: expose a SDBus and connect the SDCard to it'
> 005/6:[down] 'hw/sd/ssi-sd: use the SDBus API, connect the SDCard to the bus'
> 006/6:[----] [-C] 'hw/sd: move sdcard legacy API to "hw/sd/sdcard_legacy.h"'
> 
> Based-on: 20180123033034.29493-19-f4bug@amsat.org
>           (or /master)
> 
> Philippe Mathieu-Daudé (6):
>   hw/sd/milkymist-memcard: use qemu_log_mask()
>   hw/sd/milkymist-memcard: split realize() out of SysBusDevice init()
>   hw/sd/milkymist-memcard: expose a SDBus and connect the SDCard to it
>   hw/sd/pl181: expose a SDBus and connect the SDCard to it
>   hw/sd/ssi-sd: use the SDBus API, connect the SDCard to the bus
>   hw/sd: move sdcard legacy API to "hw/sd/sdcard_legacy.h"
> 
>  include/hw/sd/sd.h            | 17 ---------
>  include/hw/sd/sdcard_legacy.h | 51 +++++++++++++++++++++++++++
>  hw/sd/milkymist-memcard.c     | 81 ++++++++++++++++++++++++-------------------
>  hw/sd/omap_mmc.c              |  2 +-
>  hw/sd/pl181.c                 | 32 +++++++++++------
>  hw/sd/sd.c                    |  1 +
>  hw/sd/ssi-sd.c                | 32 ++++++++++-------
>  7 files changed, 139 insertions(+), 77 deletions(-)
>  create mode 100644 include/hw/sd/sdcard_legacy.h
> 
