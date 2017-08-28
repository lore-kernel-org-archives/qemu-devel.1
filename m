Received: from eggs.gnu.org ([2001:4830:134:3::10]:57504)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dmKB8-0006iI-S6
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 09:34:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dmKB3-00087y-4e
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 09:34:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45138)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dmKB2-00086v-Un
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 09:34:05 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E5643C0587C5
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 13:34:02 +0000 (UTC)
Date: Mon, 28 Aug 2017 10:33:42 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170828133342.GP15315@localhost.localdomain>
References: <20170823221445.15243-1-ehabkost@redhat.com>
	<20170823221445.15243-4-ehabkost@redhat.com>
	<8884ab94-9921-2eef-8d4f-a50c625e0f1c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8884ab94-9921-2eef-8d4f-a50c625e0f1c@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 3/5] pci: Add INTERFACE_PCIE_DEVICE to all
 PCIe devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Laine Stump <laine@redhat.com>

On Sun, Aug 27, 2017 at 11:35:56AM +0300, Marcel Apfelbaum wrote:
> Hi Eduardo,
> 
> On 24/08/2017 1:14, Eduardo Habkost wrote:
> > Change all devices that set is_express=1 to implement
> > INTERFACE_PCIE_DEVICE.
> > 
> 
> Can this interface *replace* is_express field?

It can, but it has to be done carefully: 4 of the 5 hybrid
devices have is_express=0, so their logic need to be changed from
"set QEMU_PCI_CAP_EXPRESS manually if Express" to "clear
QEMU_PCI_CAP_EXPRESS manually if Conventional PCI".

Cleaning up the code on the hybrid devices is on my plans, but I
decided to do that after this series.

-- 
Eduardo
