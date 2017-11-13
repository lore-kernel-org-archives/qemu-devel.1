Received: from eggs.gnu.org ([2001:4830:134:3::10]:34218)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eED6N-0000Kx-F7
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 06:40:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eED6M-0004OC-EA
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 06:40:31 -0500
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:51928)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eED6M-0004NX-7Q
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 06:40:30 -0500
Received: by mail-wr0-x243.google.com with SMTP id j15so14125435wre.8
	for <qemu-devel@nongnu.org>; Mon, 13 Nov 2017 03:40:29 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1510343626-25861-1-git-send-email-cota@braap.org>
References: <1510343626-25861-1-git-send-email-cota@braap.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 13 Nov 2017 11:40:08 +0000
Message-ID: <CAFEAcA-CLWOs-MS2Yyer5jWzOK7VUVex5Y1N-L7zjy0KDyJ6Ww@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH for 2.11 0/5] TCG/ARM fixes for 2.11
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <richard.henderson@linaro.org>, Thomas Huth <thuth@redhat.com>, qemu-arm <qemu-arm@nongnu.org>, Igor Mitsyanko <i.mitsyanko@gmail.com>, Alistair Francis <alistair.francis@xilinx.com>, "Edgar E . Iglesias" <edgar.iglesias@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>

On 10 November 2017 at 19:53, Emilio G. Cota <cota@braap.org> wrote:
> Some MachineClass changes to fix TCG initialization of some
> ARM boards for 2.11. This was originally reported by Thomas Huth in [1],
> where Peter suggested a way to fix it. Further discussion in
> another thread [2] followed up on this.
>
> As a result of that follow-up discussion we also got some Zynq changes from
> Alistair [3], which I'm including here since in order to test them
> we need the first patch in this series.
>
> Thanks,
>
>                 Emilio
>
> [1] https://lists.gnu.org/archive/html/qemu-devel/2017-11/msg00078.html
> [2] https://lists.gnu.org/archive/html/qemu-devel/2017-11/msg00502.html
> [3] https://lists.gnu.org/archive/html/qemu-devel/2017-11/msg01842.html
>
> Alistair Francis (2):
>   xlnx-zynqmp: Properly support the smp command line option
>   xlnx-zcu102: Add an info message deprecating the EP108
>
> Emilio G. Cota (3):
>   qom: move CPUClass.tcg_initialize to a global
>   xlnx-zcu102: Specify the max number of CPUs for the EP108
>   hw: add .min_cpus and .default_cpus fields to machine_class
>
>  qemu-doc.texi           |  7 +++++++
>  include/hw/boards.h     |  5 +++++
>  include/qom/cpu.h       |  1 -
>  exec.c                  |  5 +++--
>  hw/arm/exynos4_boards.c | 12 ++++--------
>  hw/arm/raspi.c          |  2 ++
>  hw/arm/xlnx-zcu102.c    |  9 ++++++++-
>  hw/arm/xlnx-zynqmp.c    | 26 ++++++++++++++++----------
>  vl.c                    | 21 ++++++++++++++++++---
>  9 files changed, 63 insertions(+), 25 deletions(-)

Since this is fixing Arm boards and I'm putting together an
arm pullreq anyway, I'm applying this to target-arm.next.
(Eduardo's reviewed the patches which touch the MachineClass
and option parsing code.)

thanks
-- PMM
