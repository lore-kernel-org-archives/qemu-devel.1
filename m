Received: from eggs.gnu.org ([2001:4830:134:3::10]:32986)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eomnS-0005ru-9V
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 04:04:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eomnR-0003K8-CU
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 04:04:10 -0500
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:47025)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eomnR-0003JN-5g
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 04:04:09 -0500
Received: by mail-wr0-x241.google.com with SMTP id 34so9714422wre.13
	for <qemu-devel@nongnu.org>; Thu, 22 Feb 2018 01:04:08 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180215220540.6556-1-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <de76e2a2-5b63-d9a8-117c-b40584a25d14@amsat.org>
Date: Thu, 22 Feb 2018 06:04:06 -0300
MIME-Version: 1.0
In-Reply-To: <20180215220540.6556-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4 00/11] SDCard: housekeeping,
 add tracing (part 4)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Alistair Francis <alistair.francis@xilinx.com>, Igor Mitsyanko <i.mitsyanko@gmail.com>, qemu-devel@nongnu.org, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Prasad J Pandit <pjp@fedoraproject.org>, Andrzej Zaborowski <balrogg@gmail.com>

ping? :)

On 02/15/2018 07:05 PM, Philippe Mathieu-Daudé wrote:
> Since v3:
> - use assert() in sd_state_name() and sd_response_name() (Alistair review)
> - added sdmmc-internal.h & sdmmc-common.c to reuse helpers with hw/sd/core.c
> 
> Since v2:
> - split again in 2... this part is cleanup/tracing
> - add more tracepoints
> - move some code reusable by sdbus in sdmmc-internal.h
> 
> Since v1:
> - rewrote mostly all patches to keep it simpler.
> 
> $ git backport-diff
> 001/11:[----] [--] 'sdcard: reorder SDState struct members'
> 002/11:[0003] [FC] 'sdcard: replace DPRINTF() by trace events'
> 003/11:[0001] [FC] 'sdcard: add a trace event for command responses'
> 004/11:[0007] [FC] 'sdcard: replace fprintf() by qemu_hexdump()'
> 005/11:[----] [--] 'sdcard: add more trace events'
> 006/11:[----] [--] 'sdcard: do not trace CMD55 when expecting ACMD'
> 007/11:[0014] [FC] 'sdcard: define SDMMC_CMD_MAX instead of using the magic '64''
> 008/11:[0020] [FC] 'sdcard: display command name when tracing CMD/ACMD'
> 009/11:[----] [--] 'sdcard: display protocol used when tracing'
> 010/11:[----] [-C] 'sdcard: use G_BYTE from cutils'
> 011/11:[----] [-C] 'sdcard: use the registerfields API to access the OCR register'
> 
> Philippe Mathieu-Daudé (11):
>   sdcard: reorder SDState struct members
>   sdcard: replace DPRINTF() by trace events
>   sdcard: add a trace event for command responses
>   sdcard: replace fprintf() by qemu_hexdump()
>   sdcard: add more trace events
>   sdcard: do not trace CMD55 when expecting ACMD
>   sdcard: define SDMMC_CMD_MAX instead of using the magic '64'
>   sdcard: display command name when tracing CMD/ACMD
>   sdcard: display protocol used when tracing
>   sdcard: use G_BYTE from cutils
>   sdcard: use the registerfields API to access the OCR register
> 
>  hw/sd/sdmmc-internal.h |  18 +++++
>  include/hw/sd/sd.h     |   1 -
>  hw/sd/sd.c             | 184 ++++++++++++++++++++++++++++++++++---------------
>  hw/sd/sdmmc-common.c   |  72 +++++++++++++++++++
>  hw/sd/Makefile.objs    |   2 +-
>  hw/sd/trace-events     |  20 ++++++
>  6 files changed, 241 insertions(+), 56 deletions(-)
>  create mode 100644 hw/sd/sdmmc-internal.h
>  create mode 100644 hw/sd/sdmmc-common.c
> 
