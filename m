Received: from eggs.gnu.org ([2001:4830:134:3::10]:40840)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ewmOX-0006gL-1l
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 06:15:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ewmOS-0006hR-5B
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 06:15:29 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60384 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ewmOR-0006h7-U1
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 06:15:23 -0400
References: <1521193892-15552-1-git-send-email-thuth@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1ef42117-6b16-b22f-29fe-f4910361aa2a@redhat.com>
Date: Fri, 16 Mar 2018 11:15:01 +0100
MIME-Version: 1.0
In-Reply-To: <1521193892-15552-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.12 0/4] Fix crashes with CAN bus and
 ISA DMA devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, Eduardo Habkost <ehabkost@redhat.com>, Pavel Pisa <pisa@cmp.felk.cvut.cz>, Jason Wang <jasowang@redhat.com>

On 16/03/2018 10:51, Thomas Huth wrote:
> The new CAN bus devices and some older ISA devices that use DMA can be
> used to crash QEMU. These patches introduce some proper checks so that
> the users get a proper error message instead.
> 
> Alexey Kardashevskiy (1):
>   fdc: Exit if ISA controller does not support DMA
> 
> Thomas Huth (3):
>   hw/net/can: Fix segfaults when using the devices without bus
>   hw/audio: Fix crashes when devices are used on ISA bus without DMA
>   scripts/device-crash-test: Remove fixed isapc-with-iommu entry
> 
>  hw/audio/cs4231a.c        | 8 +++++++-
>  hw/audio/gus.c            | 7 ++++++-
>  hw/audio/sb16.c           | 9 +++++++--
>  hw/block/fdc.c            | 5 ++++-
>  hw/net/can/can_sja1000.c  | 4 ++++
>  scripts/device-crash-test | 8 --------
>  6 files changed, 28 insertions(+), 13 deletions(-)
> 

Queued, thanks.

Paolo
