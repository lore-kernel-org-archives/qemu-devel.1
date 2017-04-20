Received: from eggs.gnu.org ([2001:4830:134:3::10]:35614)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1d1C4k-0004IR-IN
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 09:24:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1d1C4j-0008Tu-LI
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 09:24:46 -0400
Received: from mail-wm0-x230.google.com ([2a00:1450:400c:c09::230]:37887)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1d1C4j-0008SR-FR
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 09:24:45 -0400
Received: by mail-wm0-x230.google.com with SMTP id m123so37515961wma.0
	for <qemu-devel@nongnu.org>; Thu, 20 Apr 2017 06:24:45 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <cover.1491947224.git.alistair.francis@xilinx.com>
References: <cover.1491947224.git.alistair.francis@xilinx.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 20 Apr 2017 14:24:23 +0100
Message-ID: <CAFEAcA-tL56biHbMYBkGaC5HiivxpkdywqRr84GW8C_GpLU3Rw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v3 0/5] Improve the Cadence GEM multi-queue
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, Alistair Francis <alistair23@gmail.com>

On 11 April 2017 at 23:30, Alistair Francis <alistair.francis@xilinx.com> wrote:
> Improve the Cadence GEM multi-queue support. This fixes a few bugs
> which were hanging around from the initial implementation.
>
> V3:
>  - Remove unessecary call of gem_update_int_status()
> V2:
>  - Fix up the interrupt updating logic and consolidate all the updates
>    to a single function.
>  - Improve the debug print information



Applied to target-arm.next, thanks.

-- PMM
