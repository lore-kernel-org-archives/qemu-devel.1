Received: from eggs.gnu.org ([209.51.188.92]:56658)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hEuOr-00035S-V3
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 07:31:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hEuOr-0007df-5O
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 07:31:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:19304)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1hEuOq-0007d2-RX
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 07:31:17 -0400
Date: Fri, 12 Apr 2019 13:31:11 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190412133111.028a9c6d.cohuck@redhat.com>
In-Reply-To: <20190409155831.18764-1-eric.auger@redhat.com>
References: <20190409155831.18764-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-4.1] vfio/common: Introduce
 vfio_set_irq_signaling helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, alex.williamson@redhat.com, aik@ozlabs.ru

On Tue,  9 Apr 2019 17:58:31 +0200
Eric Auger <eric.auger@redhat.com> wrote:

> The code used to assign an interrupt index/subindex to an
> eventfd is duplicated many times. Let's introduce an helper that
> allows to set/unset the signaling for an ACTION_TRIGGER or
> ACTION_UNMASK action.

I like that, and it looks like ccw can use the new function as well. (I
can do a patch on top.)

> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> 
> ---
> 
> This is a follow-up to
> [PATCH v2 0/2] vfio-pci: Introduce vfio_set_event_handler().
> It looks to me that introducing vfio_set_irq_signaling() has more
> benefits in term of code reduction and the helper abstraction
> looks cleaner.
> ---
>  hw/vfio/common.c              |  61 +++++++++
>  hw/vfio/pci.c                 | 224 ++++++++--------------------------
>  hw/vfio/platform.c            |  55 +++------
>  include/hw/vfio/vfio-common.h |   2 +
>  4 files changed, 134 insertions(+), 208 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
