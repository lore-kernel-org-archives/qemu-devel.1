Received: from eggs.gnu.org ([2001:4830:134:3::10]:51631)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fk8ZT-0002ns-4i
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 09:50:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fk8ZS-0003fv-C0
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 09:50:47 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:46509)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fk8ZS-0003fh-5W
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 09:50:46 -0400
Received: by mail-oi0-x244.google.com with SMTP id y207-v6so21323059oie.13
	for <qemu-devel@nongnu.org>; Mon, 30 Jul 2018 06:50:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180725113000.11014-1-geert+renesas@glider.be>
References: <20180725113000.11014-1-geert+renesas@glider.be>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 30 Jul 2018 14:50:25 +0100
Message-ID: <CAFEAcA8jw0d5BOHx_vMBM32w194mb3rkLmUyo5t1zRhpApgJZQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] hw/arm/sysbus-fdt: Fix assertion in
 copy_properties_from_host()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Eric Auger <eric.auger@linaro.org>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>

On 25 July 2018 at 12:30, Geert Uytterhoeven <geert+renesas@glider.be> wrote:
> When copy_properties_from_host() ignores the error for an optional
> property, it frees the error, but fails to reset it.
>
> Hence if two or more optional properties are missing, an assertion is
> triggered:
>
>     util/error.c:57: error_setv: Assertion `*errp == NULL' failed.
>
> Fis this by resetting err to NULL after ignoring the error.
>
> Fixes: 9481cf2e5f2f2bb6 ("hw/arm/sysbus-fdt: helpers for clock node generation")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks, applied to target-arm.next for 3.0.

-- PMM
