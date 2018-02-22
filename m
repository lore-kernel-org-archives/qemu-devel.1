Received: from eggs.gnu.org ([2001:4830:134:3::10]:60412)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eoqbs-0001lY-71
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 08:08:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eoqbr-0000gK-7r
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 08:08:28 -0500
Received: from mail-ot0-x243.google.com ([2607:f8b0:4003:c0f::243]:37083)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eoqbr-0000g1-1B
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 08:08:27 -0500
Received: by mail-ot0-x243.google.com with SMTP id e64so4535556ote.4
	for <qemu-devel@nongnu.org>; Thu, 22 Feb 2018 05:08:27 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180215220540.6556-1-f4bug@amsat.org>
References: <20180215220540.6556-1-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Feb 2018 13:08:05 +0000
Message-ID: <CAFEAcA9SxXuU6xtnwNZikfisBZ6JHW8z+DBHD75BVR5A-PsQxw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Alistair Francis <alistair.francis@xilinx.com>, Igor Mitsyanko <i.mitsyanko@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Prasad J Pandit <pjp@fedoraproject.org>, Andrzej Zaborowski <balrogg@gmail.com>

On 15 February 2018 at 22:05, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>=
 wrote:
> Since v3:
> - use assert() in sd_state_name() and sd_response_name() (Alistair review=
)
> - added sdmmc-internal.h & sdmmc-common.c to reuse helpers with hw/sd/cor=
e.c
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
> 007/11:[0014] [FC] 'sdcard: define SDMMC_CMD_MAX instead of using the mag=
ic '64''
> 008/11:[0020] [FC] 'sdcard: display command name when tracing CMD/ACMD'
> 009/11:[----] [--] 'sdcard: display protocol used when tracing'
> 010/11:[----] [-C] 'sdcard: use G_BYTE from cutils'
> 011/11:[----] [-C] 'sdcard: use the registerfields API to access the OCR =
register'

Hi. I've applied patches 1-5, 7, 10 and 11 to target-arm.next.
The rest I've left you review comments for.

-- PMM
