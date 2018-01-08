Received: from eggs.gnu.org ([2001:4830:134:3::10]:49543)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eYYne-0006M7-GN
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 09:53:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eYYnd-0000L9-PU
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 09:53:18 -0500
Received: from mail-ot0-x235.google.com ([2607:f8b0:4003:c0f::235]:44958)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eYYnd-0000Kj-K2
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 09:53:17 -0500
Received: by mail-ot0-x235.google.com with SMTP id g59so9418894otg.11
	for <qemu-devel@nongnu.org>; Mon, 08 Jan 2018 06:53:17 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180103224208.30291-1-f4bug@amsat.org>
References: <20180103224208.30291-1-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 8 Jan 2018 14:52:56 +0000
Message-ID: <CAFEAcA82rAEcG5RH3LxVTHqKpEVDqL+mnW=NfoW-bQ=_VxoHEQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Alistair Francis <alistair.francis@xilinx.com>, Andrzej Zaborowski <balrogg@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, qemu-arm <qemu-arm@nongnu.org>, Fam Zheng <famz@redhat.com>

On 3 January 2018 at 22:42, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> w=
rote:
> since v1:
> - fixed qemu_log_mask() lines indentation (Alistair)
> - added Alistair's R-b
>
> tiny patches that allow to boot a Gumstix Connex board and use U-Boot.

Thanks, applied to target-arm.next. Patch 2 is missing
a #include "qemu/log.h" (hence the patchew warning) -- I'll
just fix that in my tree.

thanks
-- PMM
