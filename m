Received: from eggs.gnu.org ([2001:4830:134:3::10]:56557)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eKIVo-0006A9-7n
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 01:39:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eKIVl-0000Mf-55
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 01:39:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33644)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eKIVk-0000Ld-V1
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 01:39:53 -0500
Date: Thu, 30 Nov 2017 14:39:39 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20171130063939.GE22901@xz-mi>
References: <20171129084628.12336-1-david@gibson.dropbear.id.au>
	<20171129084628.12336-8-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171129084628.12336-8-david@gibson.dropbear.id.au>
Subject: Re: [Qemu-devel] [for-2.12 7/7] pci: Eliminate
 pci_find_primary_bus()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org

On Wed, Nov 29, 2017 at 07:46:28PM +1100, David Gibson wrote:
> pci_find_primary_bus() only has one user, in pc_xen_hvm_init().  That's
> inside the machine construction code, so it already has easy access to the
> machine's primary PCI bus.
> 
> Get it directly, and thereby remove pci_find_primary_bus().  This removes
> one of only a handful of users of the ugly pci_host_bridges global.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu
