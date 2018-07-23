Received: from eggs.gnu.org ([2001:4830:134:3::10]:33346)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fhbSH-0004Ss-9x
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 10:04:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fhbSG-0006Gd-He
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 10:04:53 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:37150)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fhbSG-0006F9-9k
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 10:04:52 -0400
Received: by mail-oi0-x243.google.com with SMTP id k81-v6so1302920oib.4
	for <qemu-devel@nongnu.org>; Mon, 23 Jul 2018 07:04:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1532337784-334-1-git-send-email-thuth@redhat.com>
References: <1532337784-334-1-git-send-email-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 23 Jul 2018 15:04:31 +0100
Message-ID: <CAFEAcA96Wz09jbbSSB5kRkGKSz+FkHUxd5McGqXEXkyuhyqF1w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] hw/intc/exynos4210_gic: Turn instance_init
 into realize function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Igor Mitsyanko <i.mitsyanko@gmail.com>, qemu-arm <qemu-arm@nongnu.org>

On 23 July 2018 at 10:23, Thomas Huth <thuth@redhat.com> wrote:
> The instance_init function of the "exynos4210.gic" device creates a
> new "arm_gic" device and immediately realizes it with qdev_init_nofail().
> This will leave a lot of object in the QOM tree during introspection of
> the "exynos4210.gic" device, e.g. reproducible by starting QEMU like this:
>
> qemu-system-aarch64 -M none -nodefaults -nographic -monitor stdio
>
> And then by running "info qom-tree" at the HMP monitor, followed by
> "device_add exynos4210.gic,help" and finally checking "info qom-tree"
> again.
>
> Also note that qdev_init_nofail() can exit QEMU in case of errors - and
> this must never happen during an instance_init function, otherwise QEMU
> could terminate unexpectedly during introspection of a device.
>
> Since most of the code that follows the qdev_init_nofail() depends on
> the realized "gicbusdev", the easiest solution to the problem is to
> turn the whole instance_init function into a realize function instead.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>



Applied to target-arm.next, thanks.

-- PMM
