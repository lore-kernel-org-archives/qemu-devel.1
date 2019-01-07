Received: from eggs.gnu.org ([209.51.188.92]:32994)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ggXG1-0008At-Rt
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 10:56:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ggXG1-0002Y9-6w
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 10:56:05 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:41706)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ggXG1-0002Xb-1L
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 10:56:05 -0500
Received: by mail-oi1-x244.google.com with SMTP id j21so679925oii.8
	for <qemu-devel@nongnu.org>; Mon, 07 Jan 2019 07:56:04 -0800 (PST)
MIME-Version: 1.0
References: <11488a08-1fe0-a278-2210-deb64731107f@gmx.co.uk>
In-Reply-To: <11488a08-1fe0-a278-2210-deb64731107f@gmx.co.uk>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 7 Jan 2019 15:55:50 +0000
Message-ID: <CAFEAcA8V1F=0tL3+P+EfGcKEi50OogCfHmYSUvPkUjEocUWFWA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v5] Support u-boot noload images for arm as
 used by, NetBSD/evbarm GENERIC kernel.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nick Hudson <nick.hudson@gmx.co.uk>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On Mon, 7 Jan 2019 at 08:31, Nick Hudson <nick.hudson@gmx.co.uk> wrote:
>
>
> noload kernels are loaded with the u-boot image header and as a result
> the header size needs adding to the entry point.  Fake up a hdr so the
> kernel image is loaded at the right address and the entry point is
> adjusted appropriately.
>
> The default location for the uboot file is 32MiB above bottom of DRAM.
> This matches the recommendation in Documentation/arm/Booting.


That avoids the bootloader-clash issue nicely.

> Clarify the load_uimage API to state the passing of a load address when an
> image doesn't specify one, or when loading a ramdisk is expected.
>
> Adjust callers of load_uimage, etc.
>



Applied to target-arm.next, thanks.

-- PMM
