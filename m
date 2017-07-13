Received: from eggs.gnu.org ([2001:4830:134:3::10]:36017)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dVZlz-0006QP-GX
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 04:47:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dVZlw-0003Vo-Cu
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 04:46:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42632)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dVZlw-0003VS-6x
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 04:46:56 -0400
Date: Thu, 13 Jul 2017 10:46:50 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170713104650.5910a467@gondolin>
In-Reply-To: <1499864265-144136-12-git-send-email-borntraeger@de.ibm.com>
References: <1499864265-144136-1-git-send-email-borntraeger@de.ibm.com>
	<1499864265-144136-12-git-send-email-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 11/11] s390x/css: update
 css_adapter_interrupt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, Yi Min Zhao <zyimin@linux.vnet.ibm.com>, Fei Li <sherrylf@linux.vnet.ibm.com>

On Wed, 12 Jul 2017 14:57:45 +0200
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> From: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
> 
> Let's use the new inject_airq callback of flic to inject adapter
> interrupts. For kvm case, if the kernel flic doesn't support the new
> interface, the irq routine remains unchanged. For non-kvm case,
> qemu-flic handles the suppression process.
> 
> Signed-off-by: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
> Signed-off-by: Fei Li <sherrylf@linux.vnet.ibm.com>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  hw/s390x/css.c          | 18 ++++++++++++++++--
>  hw/s390x/s390-pci-bus.c |  2 +-
>  hw/s390x/virtio-ccw.c   |  2 +-
>  include/hw/s390x/css.h  |  2 +-
>  4 files changed, 19 insertions(+), 5 deletions(-)

With the error_report change:

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
