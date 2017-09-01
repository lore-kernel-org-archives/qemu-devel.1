Received: from eggs.gnu.org ([2001:4830:134:3::10]:50891)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dnjdR-0007fC-26
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 06:57:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dnjdM-0000kT-97
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 06:57:13 -0400
Date: Fri, 1 Sep 2017 11:56:54 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170901105654.GA20672@stefanha-x1.localdomain>
References: <20170901001502.29915-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170901001502.29915-1-jsnow@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v3 0/9] IDE: replace printfs
 with tracing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, stefanha@redhat.com, f4bug@amsat.org

On Thu, Aug 31, 2017 at 08:14:53PM -0400, John Snow wrote:
> Wherever possible, replace all printfs with proper tracing.
> In most places I've tried to do a straight replacement, but
> forthcoming patches may calibrate the tracing to be a little nicer.
> 
> For now, it's nice to just remove the all-or-nothing tracing.
> 
> Key:
> [----] : patches are identical
> [####] : number of functional differences between upstream/downstream patch
> [down] : patch is downstream-only
> The flags [FC] indicate (F)unctional and (C)ontextual differences, respectively
> 
> 001/9:[----] [--] 'IDE: replace DEBUG_IDE with tracing system'
> 002/9:[----] [--] 'IDE: Add register hints to tracing'
> 003/9:[----] [--] 'IDE: add tracing for data ports'
> 004/9:[0002] [FC] 'ATAPI: Replace DEBUG_IDE_ATAPI with tracing events'
> 005/9:[0011] [FC] 'IDE: replace DEBUG_AIO with trace events'
> 006/9:[----] [--] 'AHCI: Replace DPRINTF with trace-events'
> 007/9:[0004] [FC] 'AHCI: Rework IRQ constants'
> 008/9:[0052] [FC] 'AHCI: pretty-print FIS to buffer instead of stderr'
> 009/9:[----] [--] 'AHCI: remove DPRINTF macro'
> 
> ===
> v3:
> ===
> 
> 04: Change preprocessor gate mechanism for building cmd
>            packet buffer dumps (Stefan)
> 05: Add getter for IDE_DMA_CMD enumeration (Philippe)
> 07: Changed AHCI enumeration to match changes in 05,
>     (But leave assert in place to guard lookup table instead
>          of adding getter.)
> 08: Replace FIS buffer printer with something simpler (Stefan)
>     Change preprocessor gate mechanism for building AHCI buffer dumps (Stefan)
>     enconstify char parameters in trace-events file (Stefan)
> 
> ===
> v2:
> ===
> 
> 01: Rehabilitate commit message.
>     Fix switch () statement spacing. (Eric)
>     Adjust spacing in ide-tracing file to maintain columns.
>     Change filename orderings in trace-events. (Eric)
>     Fixed newline issue in trace-events. (Eric)
> 
> 02: Context / Added R-B.
> 
> 03: Added trace-events items to appropriate patch (removed from 04) (Eric)
>     Added a verbose warning for data tracers (Eric)
> 
> 04: Shifted items to 03 (Eric)
>     Fixed newline issue (Eric)
> 
> 05: Changed __END to __COUNT (Philippe)
>     Removed __BEGIN enumerator (Philippe)
> 
> 06: Added more information to unknown write (Philippe)
> 
> 08: Context (Entropy)
> 
> John Snow (9):
>   IDE: replace DEBUG_IDE with tracing system
>   IDE: Add register hints to tracing
>   IDE: add tracing for data ports
>   ATAPI: Replace DEBUG_IDE_ATAPI with tracing events
>   IDE: replace DEBUG_AIO with trace events
>   AHCI: Replace DPRINTF with trace-events
>   AHCI: Rework IRQ constants
>   AHCI: pretty-print FIS to buffer instead of stderr
>   AHCI: remove DPRINTF macro
> 
>  Makefile.objs             |   1 +
>  hw/ide/ahci.c             | 243 +++++++++++++++++++++++-----------------------
>  hw/ide/ahci_internal.h    |  44 +++++++--
>  hw/ide/atapi.c            |  69 +++++--------
>  hw/ide/cmd646.c           |  10 +-
>  hw/ide/core.c             | 185 ++++++++++++++++++++++-------------
>  hw/ide/pci.c              |  17 +---
>  hw/ide/piix.c             |  11 +--
>  hw/ide/trace-events       | 111 +++++++++++++++++++++
>  hw/ide/via.c              |  10 +-
>  include/hw/ide/internal.h |   8 +-
>  11 files changed, 437 insertions(+), 272 deletions(-)
>  create mode 100644 hw/ide/trace-events
> 
> -- 
> 2.9.5
> 
> 

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
