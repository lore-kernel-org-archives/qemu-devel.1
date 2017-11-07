Received: from eggs.gnu.org ([2001:4830:134:3::10]:59088)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eC91O-00064i-Fk
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 13:54:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eC91K-0003Ux-Iw
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 13:54:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56412)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1eC91K-0003Uq-Ci
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 13:54:46 -0500
Date: Tue, 7 Nov 2017 20:54:41 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20171107205421-mutt-send-email-mst@kernel.org>
References: <20171107183503.6800-1-michael.nawrocki@gtri.gatech.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171107183503.6800-1-michael.nawrocki@gtri.gatech.edu>
Subject: Re: [Qemu-devel] [PATCH v3 0/2] Fix eepro100 simple transmission,
 add i82559 PCI ID
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mike Nawrocki <michael.nawrocki@gtri.gatech.edu>
Cc: qemu-devel@nongnu.org, jasowang@redhat.com, marcel@redhat.com

On Tue, Nov 07, 2017 at 01:35:01PM -0500, Mike Nawrocki wrote:
> This patch set does two things. First, it fixes the simple transmission mode
> for the eepro100 chipset. Second, it adds the PCI device ID 0x1030 for the
> i82559a chipset. This ID is set as the "alternate" PCI device ID for that
> chipset, and is selected by default using the new "x-use-alternate-device-id"
> property. This property is set to the compat value of false in
> "hw/include/compat.h"
> 
> Mike Nawrocki (2):
>   Fix eepro100 simple transmission mode
>   Add new PCI ID for i82559a

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

Jason, pls feel free to merge.

>  hw/net/eepro100.c    | 31 ++++++++++++++++---------------
>  include/hw/compat.h  |  4 ++++
>  include/hw/pci/pci.h |  1 +
>  qemu-options.hx      |  2 +-
>  4 files changed, 22 insertions(+), 16 deletions(-)
> 
> -- 
> 2.14.2
