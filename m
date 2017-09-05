Received: from eggs.gnu.org ([2001:4830:134:3::10]:42983)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dpA6u-0003kH-KV
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 05:25:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dpA6m-0004dY-RV
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 05:25:32 -0400
Received: from mail-wm0-x230.google.com ([2a00:1450:400c:c09::230]:35380)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dpA6m-0004d7-Ie
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 05:25:24 -0400
Received: by mail-wm0-x230.google.com with SMTP id h144so2392515wme.0
	for <qemu-devel@nongnu.org>; Tue, 05 Sep 2017 02:25:24 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170904175101.GA27187@kentang.lan>
References: <20170904175101.GA27187@kentang.lan>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 5 Sep 2017 10:25:02 +0100
Message-ID: <CAFEAcA-9Cd1pHrTGTssF5wsspoQ0NOtr7-qRoUX6iCMgAmS2Fw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL] qemu-sparc updates
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 4 September 2017 at 18:51, Mark Cave-Ayland
<mark.cave-ayland@ilande.co.uk> wrote:
> Hi Peter,
>
> Here is the first patchset in preparation for updating the sun4u machine PCI topology. Please pull.
>
>
> ATB,
>
> Mark.
>
>
> The following changes since commit 2b483739791b33c46e6084b51edcf62107058ae1:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20170904-2' into staging (2017-09-04 17:21:24 +0100)
>
> are available in the git repository at:
>
>
>   https://github.com/mcayland/qemu.git tags/qemu-sparc-signed
>
> for you to fetch changes up to e5fd1eb05ec918e9877640d85ec45680cf106632:
>
>   apb: add busA qdev property to PBM PCI bridge (2017-09-04 18:41:01 +0100)
>
> ----------------------------------------------------------------
> qemu-sparc update
>
> ----------------------------------------------------------------
> Mark Cave-Ayland (6):
>       sun4u: pass PCIDevice into pci_ebus_init() instead of PCIBus
>       sun4u: switch to using qdev to instantiate fw_cfg interface
>       sun4u: expose fw_cfg and NVRAM on ebus PCI IO address space
>       apb: fix up PCI bus nomenclature
>       apb: fix endianness for APB and PCI config accesses
>       apb: add busA qdev property to PBM PCI bridge
>
>  hw/pci-host/apb.c  |   62 +++++++++++++++++++++++++++++++++++++---------------
>  hw/sparc64/sun4u.c |   27 ++++++++++++++---------
>  2 files changed, 61 insertions(+), 28 deletions(-)


Applied, thanks.

-- PMM
