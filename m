Received: from eggs.gnu.org ([2001:4830:134:3::10]:57367)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1d0QZp-0001XN-GY
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 06:41:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1d0QZm-00069U-BK
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 06:41:41 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45713)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1d0QZm-000693-28
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 06:41:38 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v3IAdFhk033071
	for <qemu-devel@nongnu.org>; Tue, 18 Apr 2017 06:41:36 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0a-001b2d01.pphosted.com with ESMTP id 29w0p74snh-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 18 Apr 2017 06:41:35 -0400
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Tue, 18 Apr 2017 11:41:32 +0100
Date: Tue, 18 Apr 2017 12:41:25 +0200
From: Cornelia Huck <cornelia.huck@de.ibm.com>
In-Reply-To: <20170417215916.12431-5-ehabkost@redhat.com>
References: <20170417215916.12431-1-ehabkost@redhat.com>
	<20170417215916.12431-5-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20170418124125.5222b591.cornelia.huck@de.ibm.com>
Subject: Re: [Qemu-devel] [RFC 4/7] pci: Change pci_register_bus() 'parent'
 parameter to PCIHostState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, aik@ozlabs.ru, David Gibson <dgibson@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Laszlo Ersek <lersek@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Richard Henderson <rth@twiddle.net>, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@imgtec.com>, Alexander Graf <agraf@suse.de>, Scott Wood <scottwood@freescale.com>, Paul Burton <paul.burton@imgtec.com>, David Gibson <david@gibson.dropbear.id.au>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-ppc@nongnu.org

On Mon, 17 Apr 2017 18:59:13 -0300
Eduardo Habkost <ehabkost@redhat.com> wrote:

> pci_register_bus() already requires the 'parent' argument to be a
> PCI_HOST_BRIDGE object. Change the parameter type to reflect that.
> 
> Cc: Richard Henderson <rth@twiddle.net>
> Cc: Aurelien Jarno <aurelien@aurel32.net>
> Cc: Yongbok Kim <yongbok.kim@imgtec.com>
> Cc: Alexander Graf <agraf@suse.de>
> Cc: Scott Wood <scottwood@freescale.com>
> Cc: Paul Burton <paul.burton@imgtec.com>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Marcel Apfelbaum <marcel@redhat.com>
> Cc: David Gibson <david@gibson.dropbear.id.au>
> Cc: Cornelia Huck <cornelia.huck@de.ibm.com>
> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> Cc: qemu-ppc@nongnu.org
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  include/hw/pci/pci.h      | 2 +-
>  hw/alpha/typhoon.c        | 2 +-
>  hw/mips/gt64xxx_pci.c     | 2 +-
>  hw/pci-host/apb.c         | 2 +-
>  hw/pci-host/bonito.c      | 2 +-
>  hw/pci-host/gpex.c        | 2 +-
>  hw/pci-host/grackle.c     | 2 +-
>  hw/pci-host/ppce500.c     | 2 +-
>  hw/pci-host/uninorth.c    | 4 ++--
>  hw/pci-host/xilinx-pcie.c | 2 +-
>  hw/pci/pci.c              | 4 ++--
>  hw/ppc/ppc4xx_pci.c       | 2 +-
>  hw/ppc/spapr_pci.c        | 2 +-
>  hw/s390x/s390-pci-bus.c   | 2 +-
>  hw/sh4/sh_pci.c           | 2 +-
>  15 files changed, 17 insertions(+), 17 deletions(-)

s390 parts:

Acked-by: Cornelia Huck <cornelia.huck@de.ibm.com>
