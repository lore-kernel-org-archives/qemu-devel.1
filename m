Received: from eggs.gnu.org ([2001:4830:134:3::10]:43493)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1ebrcJ-0003Di-6E
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 12:35:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1ebrcI-0001zS-BV
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 12:35:15 -0500
Received: from mail-lf0-x243.google.com ([2a00:1450:4010:c07::243]:43039)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1ebrcH-0001yL-WD
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 12:35:14 -0500
Received: by mail-lf0-x243.google.com with SMTP id o89so18886084lfg.10
	for <qemu-devel@nongnu.org>; Wed, 17 Jan 2018 09:35:13 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <cover.1516209965.git.alistair.francis@xilinx.com>
References: <cover.1516209965.git.alistair.francis@xilinx.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 17 Jan 2018 09:34:42 -0800
Message-ID: <CAKmqyKMK4W=u6QUkhm-HtQaPTpOjfhU4vt0N-31NDARdksLKrQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 0/3] Add and connect the ZynqMP RTC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Edgar Iglesias <edgar.iglesias@xilinx.com>, Edgar Iglesias <edgar.iglesias@gmail.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>

On Wed, Jan 17, 2018 at 9:27 AM, Alistair Francis
<alistair.francis@xilinx.com> wrote:
> V3:
>  - Store an offset value
>  - Use mktimegm()
>  - Log unimplemented writes
>
> V2:
>  - Delete unused realise function
>  - Add cover letter
>  - Convert DB_PRINT() macro to trace
>
> Alistair Francis (3):
>   xlnx-zynqmp-rtc: Initial commit
>   xlnx-zynqmp-rtc: Add basic time support
>   xlnx-zynqmp: Connect the RTC device
>
>  hw/arm/xlnx-zynqmp.c               |  14 ++
>  hw/timer/Makefile.objs             |   1 +
>  hw/timer/trace-events              |   3 +
>  hw/timer/xlnx-zynqmp-rtc.c         | 282 +++++++++++++++++++++++++++++++=
++++++
>  include/hw/arm/xlnx-zynqmp.h       |   2 +
>  include/hw/timer/xlnx-zynqmp-rtc.h |  88 ++++++++++++
>  6 files changed, 390 insertions(+)
>  create mode 100644 hw/timer/xlnx-zynqmp-rtc.c
>  create mode 100644 include/hw/timer/xlnx-zynqmp-rtc.h
>
> --
> 2.14.1
>
> This email and any attachments are intended for the sole use of the named=
 recipient(s) and contain(s) confidential information that may be proprieta=
ry, privileged or copyrighted under applicable law. If you are not the inte=
nded recipient, do not read, copy, or forward this email message or any att=
achments. Delete this email message and any attachments immediately.

Sorry, I forgot this is still there. Still working with IT.

Alistair
