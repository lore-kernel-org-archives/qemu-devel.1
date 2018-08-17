Received: from eggs.gnu.org ([2001:4830:134:3::10]:37274)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fqdtc-0003EV-0p
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 08:30:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fqdtQ-0003e7-Lp
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 08:30:23 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51206 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fqdtQ-0003de-G3
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 08:30:16 -0400
References: <20180817114619.22354-1-peter.maydell@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <74dcadc5-f4c8-3cab-dfe7-0799a124b881@redhat.com>
Date: Fri, 17 Aug 2018 14:30:11 +0200
MIME-Version: 1.0
In-Reply-To: <20180817114619.22354-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Peter Crosthwaite <crosthwaite.peter@gmail.com>, Alistair Francis <alistair@alistair23.me>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, KONRAD Frederic <frederic.konrad@adacore.com>

On 17/08/2018 13:46, Peter Maydell wrote:
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

The diffstat speaks for itself, go ahead and include it via the ARM tree.

Thanks,

Paolo
