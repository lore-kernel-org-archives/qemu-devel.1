Received: from eggs.gnu.org ([2001:4830:134:3::10]:59523)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eYZDp-0004a6-Ej
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 10:20:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eYZDo-0007br-FD
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 10:20:21 -0500
Received: from mail-ot0-x241.google.com ([2607:f8b0:4003:c0f::241]:35201)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eYZDo-0007bT-9x
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 10:20:20 -0500
Received: by mail-ot0-x241.google.com with SMTP id q5so9490179oth.2
	for <qemu-devel@nongnu.org>; Mon, 08 Jan 2018 07:20:20 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <797fc842-813f-77dd-959c-2055ee5e2b90@amsat.org>
References: <20180103224208.30291-1-f4bug@amsat.org>
	<CAFEAcA82rAEcG5RH3LxVTHqKpEVDqL+mnW=NfoW-bQ=_VxoHEQ@mail.gmail.com>
	<797fc842-813f-77dd-959c-2055ee5e2b90@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 8 Jan 2018 15:19:59 +0000
Message-ID: <CAFEAcA8=KPXJWEjPYFPWd0BGmkh-h_H=SJT9LKfmLSfsARkNkw@mail.gmail.com>
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

On 8 January 2018 at 15:05, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> w=
rote:
> I'm adding a sticker to my monitor "build with
> --enable-trace-backends=3Dsimple" before sending a series with new trace
> events.

I think it would be better to try to harden the log backend
for trace and our log.h so that we get a compile error for
this mistake even with the log backend.

Something like:
 * pull out the bits of log.h that generated trace.h needs
   into a new header (log-for-trace.h ?). I think that's
   just the LOG_TRACE define, qemu_log_mask() and the things
   qemu_log_mask() needs
 * have the generated trace.h files include that header
   instead of full log.h
 * have log.h include that header

That should catch almost all of these "forgot an include"
errors, I think (since almost all uses of log.h from C
code will want one of the other LOG_FOO defines).

thanks
-- PMM
