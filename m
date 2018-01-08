Received: from eggs.gnu.org ([2001:4830:134:3::10]:53619)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYYzX-00036b-Uh
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 10:05:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYYzV-0007bJ-TM
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 10:05:35 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180103224208.30291-1-f4bug@amsat.org>
	<CAFEAcA82rAEcG5RH3LxVTHqKpEVDqL+mnW=NfoW-bQ=_VxoHEQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <797fc842-813f-77dd-959c-2055ee5e2b90@amsat.org>
Date: Mon, 8 Jan 2018 12:05:23 -0300
MIME-Version: 1.0
In-Reply-To: <CAFEAcA82rAEcG5RH3LxVTHqKpEVDqL+mnW=NfoW-bQ=_VxoHEQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 0/2] pxa2xx_timer: ignore incorrect
 registers access to use U-Boot
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Alistair Francis <alistair.francis@xilinx.com>, Andrzej Zaborowski <balrogg@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, qemu-arm <qemu-arm@nongnu.org>, Fam Zheng <famz@redhat.com>

On 01/08/2018 11:52 AM, Peter Maydell wrote:
> On 3 January 2018 at 22:42, Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>> since v1:
>> - fixed qemu_log_mask() lines indentation (Alistair)
>> - added Alistair's R-b
>>
>> tiny patches that allow to boot a Gumstix Connex board and use U-Boot.
> 
> Thanks, applied to target-arm.next. Patch 2 is missing
> a #include "qemu/log.h" (hence the patchew warning) -- I'll
> just fix that in my tree.

Thank you!

I'm adding a sticker to my monitor "build with
--enable-trace-backends=simple" before sending a series with new trace
events.
