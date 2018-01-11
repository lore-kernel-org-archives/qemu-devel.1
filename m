Received: from eggs.gnu.org ([2001:4830:134:3::10]:38126)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1eZk8O-0001vl-1K
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 16:11:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1eZk8M-0006fZ-Jc
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 16:11:36 -0500
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:42366)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1eZk8M-0006di-A8
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 16:11:34 -0500
Received: by mail-wr0-x244.google.com with SMTP id e41so3167401wre.9
	for <qemu-devel@nongnu.org>; Thu, 11 Jan 2018 13:11:34 -0800 (PST)
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <20180111193021.17466-1-f4bug@amsat.org>
References: <20180111193021.17466-1-f4bug@amsat.org>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Thu, 11 Jan 2018 13:11:02 -0800
Message-ID: <CAKmqyKNnh8G2G-1R6cFxou6zN0mKpDYTQCn9XLyVK95gWzOxpA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 00/13] SDHCI: housekeeping
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Alistair Francis <alistair.francis@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

On Thu, Jan 11, 2018 at 11:30 AM, Philippe Mathieu-Daud=C3=A9
<f4bug@amsat.org> wrote:
> All patches reviewed :)

Do you think this can go through you Peter?

Alistair

>
> Since v5:
> - addressed Alistair reviews
> - added Alistair R-b
> - renamed the dma property "dma-memory" -> "dma"
>
> Since v4:
> - fixed incorrect use of &local_err in sdhci_sysbus/pci_realize()
>
> Since v3:
> - since the series was getting too big and first part reviewed, split in =
2.
> - addressed Fam's review from "refactor the common sysbus/pci qdev"
>   - improved commit descriptions
>   - restored useful s->fifo_buffer =3D NULL
> - added Alistair R-b
>
> Since v2:
> - more detailed 'capabilities', all boards converted to use these propert=
ies
> - since all qtests pass, removed the previous 'capareg' property
> - added Stefan/Alistair R-b
> - corrected 'access' LED behavior (Alistair's review)
> - more uses of the registerfields API
> - remove some dead code
> - cosmetix:
>   - added more comments
>   - renamed a pair of registers
>   - reordered few struct members
>
> Since v1:
> - addressed Alistair Francis review comments, added some R-b
> - only move register defines to "sd-internal.h"
> - fixed deposit64() arguments
> - dropped unuseful s->fifo_buffer =3D NULL
> - use a qemu_irq for the LED, restrict the logging to ON/OFF
> - fixed a trace format string error
> - included Andrey Smirnov ACMD12ERRSTS write patch
> - dropped few unuseful patches, and separate the Python polemical ones fo=
r later
>
> From the "SDHCI housekeeping" series:
> - 1: we restrict part of "sd/sd.h" into local "sd-internal.h",
> - 2,3: we somehow beautiful the code, no logical changes,
> - 4-7: we refactor the common sysbus/pci qdev code,
> - 8-10: we add plenty of trace events which will result useful later,
> - 11: we finally expose a "dma-memory" property.
> From the "SDHCI: add a qtest and fix few issues" series:
> - 12,13: fix registers
> - 14,15: boards can specify which SDHCI Spec to use (v2 and v3 so far)
> - 15-20: HCI qtest
>
> Regards,
>
> Phil.
>
> $ git backport-diff
> 001/13:[----] [--] 'sdhci: clean up includes'
> 002/13:[----] [--] 'sdhci: remove dead code'
> 003/13:[0004] [FC] 'sdhci: refactor same sysbus/pci properties into a com=
mon one'
> 004/13:[----] [--] 'sdhci: refactor common sysbus/pci class_init() into s=
dhci_common_class_init()'
> 005/13:[----] [--] 'sdhci: refactor common sysbus/pci realize() into sdhc=
i_common_realize()'
> 006/13:[----] [--] 'sdhci: refactor common sysbus/pci unrealize() into sd=
hci_common_unrealize()'
> 007/13:[----] [--] 'sdhci: use qemu_log_mask(UNIMP) instead of fprintf()'
> 008/13:[0020] [FC] 'sdhci: convert the DPRINT() calls into trace events'
> 009/13:[----] [--] 'sdhci: move MASK_TRNMOD with other SDHC_TRN* defines =
in "sd-internal.h"'
> 010/13:[----] [-C] 'sdhci: rename the SDHC_CAPAB register'
> 011/13:[0002] [FC] 'sdhci: fix CAPAB/MAXCURR registers, both are 64bit an=
d read-only'
> 012/13:[----] [--] 'sdhci: Implement write method of ACMD12ERRSTS registe=
r'
> 013/13:[0004] [FC] 'sdhci: add a "dma" property'
>
> Andrey Smirnov (1):
>   sdhci: Implement write method of ACMD12ERRSTS register
>
> Philippe Mathieu-Daud=C3=A9 (12):
>   sdhci: clean up includes
>   sdhci: remove dead code
>   sdhci: refactor same sysbus/pci properties into a common one
>   sdhci: refactor common sysbus/pci class_init() into sdhci_common_class_=
init()
>   sdhci: refactor common sysbus/pci realize() into sdhci_common_realize()
>   sdhci: refactor common sysbus/pci unrealize() into sdhci_common_unreali=
ze()
>   sdhci: use qemu_log_mask(UNIMP) instead of fprintf()
>   sdhci: convert the DPRINT() calls into trace events
>   sdhci: move MASK_TRNMOD with other SDHC_TRN* defines in "sd-internal.h"
>   sdhci: rename the SDHC_CAPAB register
>   sdhci: fix CAPAB/MAXCURR registers, both are 64bit and read-only
>   sdhci: add a "dma" property
>
>  include/hw/sd/sdhci.h  |  19 ++--
>  hw/sd/sdhci-internal.h |   7 +-
>  hw/sd/sdhci.c          | 260 ++++++++++++++++++++++++++++---------------=
------
>  hw/sd/trace-events     |  14 +++
>  4 files changed, 176 insertions(+), 124 deletions(-)
>
> --
> 2.15.1
>
>
