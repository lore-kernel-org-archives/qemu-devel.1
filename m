Received: from eggs.gnu.org ([2001:4830:134:3::10]:40420)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fqIwm-0006qr-Aa
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 10:08:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fqIwh-00078E-2m
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 10:08:20 -0400
MIME-Version: 1.0
References: <20180814162739.11814-1-stefanha@redhat.com>
	<CAFEAcA8p=e-C_U+wqjLjLyc9-nCC7R094_xD-xY06tzJCOz8dg@mail.gmail.com>
In-Reply-To: <CAFEAcA8p=e-C_U+wqjLjLyc9-nCC7R094_xD-xY06tzJCOz8dg@mail.gmail.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Thu, 16 Aug 2018 15:08:02 +0100
Message-ID: <CAJSP0QXAMHYZfrUdnjNNWJtAxu6U0Y6-Xw0GHPjTFjeEFrvW9w@mail.gmail.com>
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Jim Mussared <jim@groklearning.com>, =?UTF-8?Q?Steffen_G=C3=B6rtz?= <mail@steffen-goertz.de>, =?UTF-8?B?6IuP6Iiq?= <suhang16@mails.ucas.ac.cn>, Liviu Ionescu <ilg@livius.net>, Alistair Francis <alistair@alistair23.me>, qemu-devel <qemu-devel@nongnu.org>, Subbaraya Sundeep <sundeep.lkml@gmail.com>, =?UTF-8?Q?Steffen_G=C3=B6rtz?= <qemu.ml@steffen-goertz.de>, qemu-arm <qemu-arm@nongnu.org>, Joel Stanley <joel@jms.id.au>, Julia Suvorova <jusual@mail.ru>

On Thu, Aug 16, 2018 at 1:39 PM Peter Maydell <peter.maydell@linaro.org> wrote:
> On 14 August 2018 at 17:27, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> > This patch series:
> >  * Makes bitbanding optional on ARMv7MState.
> >  * Adds a "cortex-m0" cpu type which can be used with ARMMProfileState.  This
> >    works thanks to Julia's Cortex M0 emulation patches, which are now all
> >    merged.
> >  * Adds Su Hang's Intel HEX file format loader so that micro:bit and other
> >    microcontroller firmware images can be run using -kernel.  The micro:bit
> >    development tools typically only emit .hex files and not ELFs.
>
> Applied to target-arm.next, thanks.
>
> I notice that the change to generic-loader doesn't include an
> update to docs/generic-loader.txt -- could somebody do a followup
> patch for that? Currently the docs say
>
> # The loader device also allows files to be loaded into memory. It can load raw
> # files and ELF executable files.  Raw files are loaded verbatim.  ELF
> executable
> # files are loaded by an ELF loader.
>
> but looking at the code we also support uImage files and HEX files.
> We should mention all of these, and be clear about which ones
> require the <addr> to be specified, and what the PC will be set
> to in the case where <cpu-num> is specified.

Thanks, I will take a look and send a patch.

Stefan
