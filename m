Received: from eggs.gnu.org ([2001:4830:134:3::10]:43001)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fqHQp-0007qP-Q4
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 08:31:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fqHQp-0000zG-5N
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 08:31:15 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:33225)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fqHQo-0000xC-TC
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 08:31:15 -0400
Received: by mail-oi0-x243.google.com with SMTP id 8-v6so7685534oip.0
	for <qemu-devel@nongnu.org>; Thu, 16 Aug 2018 05:31:14 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <cover.1532984236.git.jcd@tribudubois.net>
References: <cover.1532984236.git.jcd@tribudubois.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 Aug 2018 13:30:53 +0100
Message-ID: <CAFEAcA_O95mg+qS4pb6Rvxtz6Xzhf5ag9iLuewaV-nwF616NVg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 0/3] i.MX: Add the i.MX6UL SOC and a
 reference board.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jean-Christophe Dubois <jcd@tribudubois.net>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Peter Chubb <peter.chubb@nicta.com.au>, Andrey Smirnov <andrew.smirnov@gmail.com>

On 30 July 2018 at 22:03, Jean-Christophe Dubois <jcd@tribudubois.net> wrote:
> This series adds the i.MX6UL SOC from NXP/Freescale and the reference
> evaluation board.
>
> This series was tested by booting linux 4.18 (built using imx_v6_v7_defconfig)
> on the emulated board (with the appropriate device tree).
>
> Jean-Christophe Dubois (3):
>   i.MX6UL: Add i.MX6UL specific CCM device
>   i.MX6UL: Add i.MX6UL SOC
>   i.MX6UL: Add Freescale i.MX6 UltraLite 14x14 EVK Board

Applied to target-arm.next, thanks (I fixed up a few comment
typos like "the the").

-- PMM
