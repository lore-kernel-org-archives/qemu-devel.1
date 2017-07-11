Received: from eggs.gnu.org ([2001:4830:134:3::10]:34698)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dUuXi-0006Wr-Pd
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 08:45:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dUuXh-0005rO-VM
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 08:45:30 -0400
Received: from mail-wr0-x236.google.com ([2a00:1450:400c:c0c::236]:33026)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dUuXh-0005qw-Of
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 08:45:29 -0400
Received: by mail-wr0-x236.google.com with SMTP id r103so182126401wrb.0
	for <qemu-devel@nongnu.org>; Tue, 11 Jul 2017 05:45:29 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAAdtpL5_Qfy9h_Osa=tyMDMu4LhOn2mkXA-jYpmpgYwbDJq0yg@mail.gmail.com>
References: <1499771839-32518-1-git-send-email-peter.maydell@linaro.org>
	<CAAdtpL5_Qfy9h_Osa=tyMDMu4LhOn2mkXA-jYpmpgYwbDJq0yg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 11 Jul 2017 13:45:08 +0100
Message-ID: <CAFEAcA9kLCXqt7Cpe-gMGcne8z1h7_ttyf6DwxpLUmuqEonNTQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/7] ARM: implement MPS2 board (with 2 FPGA
 flavours)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philippe@mathieu-daude.net>
Cc: qemu-arm <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Patch Tracking <patches@linaro.org>

On 11 July 2017 at 13:11, Philippe Mathieu-Daud=C3=A9
<philippe@mathieu-daude.net> wrote:
> Hi Peter,
>
> It seems you forgot to add some files to MAINTAINERS.

True. I'll add this patch to v2 when it goes out:

    MAINTAINERS: Add entries for MPS2 board

    Add entries to the MAINTAINERS file for the new MPS2
    board and devices.

    Since the CMSDK devices are not specific to the MPS2 board,
    extend the existing 'PrimeCell' section to cover CMSDK
    devices as well; in both cases these are devices implemented
    by ARM and provided as RTL that may be used in multiple
    SoCs and boards.

    Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

diff --git a/MAINTAINERS b/MAINTAINERS
index 9529c94..10f5cd6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -380,7 +380,7 @@ F: hw/*/allwinner*
 F: include/hw/*/allwinner*
 F: hw/arm/cubieboard.c

-ARM PrimeCell
+ARM PrimeCell and CMSDK devices
 M: Peter Maydell <peter.maydell@linaro.org>
 L: qemu-arm@nongnu.org
 S: Maintained
@@ -394,6 +394,10 @@ F: hw/intc/pl190.c
 F: hw/sd/pl181.c
 F: hw/timer/pl031.c
 F: include/hw/arm/primecell.h
+F: hw/timer/cmsdk-apb-timer.c
+F: include/hw/timer/cmsdk-apb-timer.h
+F: hw/char/cmsdk-apb-uart.c
+F: include/hw/char/cmsdk-apb-uart.h

 ARM cores
 M: Peter Maydell <peter.maydell@linaro.org>
@@ -455,6 +459,14 @@ S: Maintained
 F: hw/arm/integratorcp.c
 F: hw/misc/arm_integrator_debug.c

+MPS2
+M: Peter Maydell <peter.maydell@linaro.org>
+L: qemu-arm@nongnu.org
+S: Maintained
+F: hw/arm/mps2.c
+F: hw/misc/mps2-scc.c
+F: include/hw/misc/mps2-scc.h
+
 Musicpal
 M: Jan Kiszka <jan.kiszka@web.de>
 L: qemu-arm@nongnu.org


thanks
-- PMM
