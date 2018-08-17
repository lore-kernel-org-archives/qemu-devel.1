Received: from eggs.gnu.org ([2001:4830:134:3::10]:56986)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1fqedZ-00008U-FC
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 09:17:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1fqedV-0005Qr-Gw
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 09:17:57 -0400
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142]:44643)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
	id 1fqedV-0005Ps-8g
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 09:17:53 -0400
Received: by mail-lf1-x142.google.com with SMTP id g6-v6so5862472lfb.11
	for <qemu-devel@nongnu.org>; Fri, 17 Aug 2018 06:17:52 -0700 (PDT)
Date: Fri, 17 Aug 2018 15:17:49 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Message-ID: <20180817131749.2gv2sgfb42vopfvg@toto>
References: <20180817114619.22354-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180817114619.22354-1-peter.maydell@linaro.org>
Subject: Re: [Qemu-devel] [PATCH 0/3] Drop obsolete memory system
 request_ptr API
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Alistair Francis <alistair@alistair23.me>, KONRAD Frederic <frederic.konrad@adacore.com>

On Fri, Aug 17, 2018 at 12:46:16PM +0100, Peter Maydell wrote:
> Now that support has hit master for direct execution from
> arbitrary MMIO regions, we can remove the MMIO request_ptr
> API, which required special case support in each device that
> wanted to handle it, and also had bad race conditions that
> resulted in crashes if you tried to use it heavily.
> 
> This API was only ever used in one device in the source
> tree, the Xilinx SPIPS. These three patches remove the
> now-unneeded code from the Xilinx device and then the
> core memory subsystem code.


Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>



> 
> thanks
> -- PMM
> 
> Peter Maydell (3):
>   hw/ssi/xilinx_spips: Remove unneeded MMIO request_ptr code
>   memory: Remove MMIO request_ptr APIs
>   hw/misc: Remove mmio_interface device
> 
>  hw/misc/Makefile.objs            |   1 -
>  include/exec/memory.h            |  35 --------
>  include/hw/misc/mmio_interface.h |  49 -----------
>  hw/misc/mmio_interface.c         | 135 -------------------------------
>  hw/ssi/xilinx_spips.c            |  46 -----------
>  memory.c                         | 110 -------------------------
>  6 files changed, 376 deletions(-)
>  delete mode 100644 include/hw/misc/mmio_interface.h
>  delete mode 100644 hw/misc/mmio_interface.c
> 
> -- 
> 2.18.0
> 
