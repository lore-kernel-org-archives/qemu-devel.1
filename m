Received: from eggs.gnu.org ([209.51.188.92]:40832)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gjNaQ-0005vG-JC
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 07:12:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gjNaP-0008Di-Or
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 07:12:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:2728)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1gjNaP-0008Cr-Io
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 07:12:53 -0500
Date: Tue, 15 Jan 2019 13:12:43 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190115131243.6f8e51b3.cohuck@redhat.com>
In-Reply-To: <20190111165801.15181-3-eric.auger@redhat.com>
References: <20190111165801.15181-1-eric.auger@redhat.com>
	<20190111165801.15181-3-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/2] vfio-pci: Use
 vfio_register_event_notifier in vfio_intx_enable_kvm
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, alex.williamson@redhat.com

On Fri, 11 Jan 2019 17:58:01 +0100
Eric Auger <eric.auger@redhat.com> wrote:

> We can also use vfio_register_event_notifier() helper in
> vfio_intx_enable_kvm to set the signalling associated to
> VFIO_PCI_INTX_IRQ_INDEX.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>  hw/vfio/pci.c | 38 +++++++-------------------------------
>  1 file changed, 7 insertions(+), 31 deletions(-)
> 

>  static void vfio_intx_disable(VFIOPCIDevice *vdev)

I'm wondering why the _disable path can't use the new helper. Ordering
issues?
