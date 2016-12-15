Received: from eggs.gnu.org ([2001:4830:134:3::10]:37061)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cHW7o-0001uC-Pu
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 08:31:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cHW7l-0003a5-FE
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 08:31:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55028)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cHW7l-0003Ze-9C
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 08:31:05 -0500
Date: Thu, 15 Dec 2016 13:31:00 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20161215133100.GK2509@work-vm>
References: <20161108095603.72301-1-pasic@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161108095603.72301-1-pasic@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [RFC PATCH v2 0/8] VMS_ARRAY_OF_POINTER with null
 pointers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, Amit Shah <amit.shah@redhat.com>, Juan Quintela <quintela@redhat.com>, Guenther Hutzl <hutzl@linux.vnet.ibm.com>

* Halil Pasic (pasic@linux.vnet.ibm.com) wrote:
> Make VMS_ARRAY_OF_POINTER cope with null pointers. Currently the reward
> for trying to migrate an array with some null pointers in it is an
> illegal memory access, that is a swift and painless death of the
> process. Let's make vmstate cope with this scenario at least for
> pointers to structs.
> 
> Halil Pasic (7):
>   migration: drop unused VMStateField.start

Note that Jianjun uses .start in the QTAILQ migration series.

Dave

>   tests/test-vmstate.c: add save_buffer util func
>   tests/test-vmstate.c: add array of pointer to struct
>   migration/vmstate: renames in (load|save)_state
>   migration/vmstate: split up vmstate_base_addr
>   migration/vmstate: fix array of pointers to struct
>   tests/test-vmstate.c: add array of pointers to struct with NULL
> 
>  hw/char/exynos4210_uart.c   |   2 +-
>  hw/display/g364fb.c         |   2 +-
>  hw/dma/pl330.c              |   8 +-
>  hw/intc/exynos4210_gic.c    |   2 +-
>  hw/ipmi/isa_ipmi_bt.c       |   4 +-
>  hw/ipmi/isa_ipmi_kcs.c      |   4 +-
>  hw/net/vmxnet3.c            |   2 +-
>  hw/nvram/mac_nvram.c        |   2 +-
>  hw/nvram/spapr_nvram.c      |   2 +-
>  hw/sd/sdhci.c               |   2 +-
>  hw/timer/m48t59.c           |   2 +-
>  include/migration/vmstate.h |  27 +++--
>  migration/savevm.c          |   2 +-
>  migration/vmstate.c         |  91 ++++++++++------
>  target-s390x/machine.c      |   2 +-
>  tests/test-vmstate.c        | 250 +++++++++++++++++++++++++++++++++++++++++---
>  util/fifo8.c                |   2 +-
>  17 files changed, 327 insertions(+), 79 deletions(-)
> 
> -- 
> 2.8.4
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
