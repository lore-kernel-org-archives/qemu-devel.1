Received: from eggs.gnu.org ([2001:4830:134:3::10]:44480)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fqHYg-0004DM-Su
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 08:39:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fqHYd-0006bY-V0
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 08:39:20 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:42278)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fqHYb-0006Zu-5c
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 08:39:18 -0400
Received: by mail-oi0-x243.google.com with SMTP id b16-v6so7691654oic.9
	for <qemu-devel@nongnu.org>; Thu, 16 Aug 2018 05:39:15 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180814162739.11814-1-stefanha@redhat.com>
References: <20180814162739.11814-1-stefanha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 Aug 2018 13:38:54 +0100
Message-ID: <CAFEAcA8p=e-C_U+wqjLjLyc9-nCC7R094_xD-xY06tzJCOz8dg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v6 0/6] arm: add Cortex M0 CPU model and
 hex file loader
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Julia Suvorova <jusual@mail.ru>, Joel Stanley <joel@jms.id.au>, qemu-arm <qemu-arm@nongnu.org>, Subbaraya Sundeep <sundeep.lkml@gmail.com>, Jim Mussared <jim@groklearning.com>, Alistair Francis <alistair@alistair23.me>, Steffen Gortz <qemu.ml@steffen-goertz.de>, =?UTF-8?Q?Steffen_G=C3=B6rtz?= <mail@steffen-goertz.de>, Su Hang <suhang16@mails.ucas.ac.cn>, Liviu Ionescu <ilg@livius.net>

On 14 August 2018 at 17:27, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> This patch series:
>  * Makes bitbanding optional on ARMv7MState.
>  * Adds a "cortex-m0" cpu type which can be used with ARMMProfileState.  This
>    works thanks to Julia's Cortex M0 emulation patches, which are now all
>    merged.
>  * Adds Su Hang's Intel HEX file format loader so that micro:bit and other
>    microcontroller firmware images can be run using -kernel.  The micro:bit
>    development tools typically only emit .hex files and not ELFs.

Applied to target-arm.next, thanks.

I notice that the change to generic-loader doesn't include an
update to docs/generic-loader.txt -- could somebody do a followup
patch for that? Currently the docs say

# The loader device also allows files to be loaded into memory. It can load raw
# files and ELF executable files.  Raw files are loaded verbatim.  ELF
executable
# files are loaded by an ELF loader.

but looking at the code we also support uImage files and HEX files.
We should mention all of these, and be clear about which ones
require the <addr> to be specified, and what the PC will be set
to in the case where <cpu-num> is specified.

thanks
-- PMM
