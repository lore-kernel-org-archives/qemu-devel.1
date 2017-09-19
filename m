Received: from eggs.gnu.org ([2001:4830:134:3::10]:52068)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1duPER-00028H-Q5
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 16:35:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1duPEN-0006B3-Ov
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 16:34:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60474)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1duPEN-0006AT-Jg
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 16:34:55 -0400
Date: Tue, 19 Sep 2017 17:34:49 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170919203449.GG21016@localhost.localdomain>
References: <1503013010-11500-1-git-send-email-zuban32s@gmail.com>
	<1503013010-11500-2-git-send-email-zuban32s@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1503013010-11500-2-git-send-email-zuban32s@gmail.com>
Subject: Re: [Qemu-devel] [PATCH v7 1/4] hw/pci: introduce pcie-pci-bridge
 device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandr Bezzubikov <zuban32s@gmail.com>
Cc: qemu-devel@nongnu.org, marcel@redhat.com, seabios@seabios.org, lersek@redhat.com, mst@redhat.com

On Fri, Aug 18, 2017 at 02:36:47AM +0300, Aleksandr Bezzubikov wrote:
> Introduce a new PCIExpress-to-PCI Bridge device,
> which is a hot-pluggable PCI Express device and
> supports devices hot-plug with SHPC.
> 
> This device is intended to replace the DMI-to-PCI Bridge.
> 
> Signed-off-by: Aleksandr Bezzubikov <zuban32s@gmail.com>
> Reviewed-by: Marcel Apfelbaum <marcel@redhat.com>

It's possible to crash QEMU by instantiating this device, with;

  $ qemu-system-ppc64 -machine prep -device pcie-pci-bridge 
  qemu-system-ppc64: qemu/memory.c:1533: memory_region_finalize: Assertion `!mr->container' failed.
  Aborted

I didn't investigate the root cause.

-- 
Eduardo
