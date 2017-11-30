Received: from eggs.gnu.org ([2001:4830:134:3::10]:53717)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eKINr-00043W-Qb
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 01:31:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eKINo-0002ZP-OU
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 01:31:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55692)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eKINo-0002YR-Ic
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 01:31:40 -0500
Date: Thu, 30 Nov 2017 14:31:31 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20171130063131.GD22901@xz-mi>
References: <20171129084628.12336-1-david@gibson.dropbear.id.au>
	<20171129084628.12336-7-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171129084628.12336-7-david@gibson.dropbear.id.au>
Subject: Re: [Qemu-devel] [for-2.12 6/7] pci: Eliminate redundant
 PCIDevice::bus pointer
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

On Wed, Nov 29, 2017 at 07:46:27PM +1100, David Gibson wrote:
> The bus pointer in PCIDevice is basically redundant with QOM information.
> It's always initialized to the qdev_get_parent_bus(), the only difference
> is the type.
> 
> Therefore this patch eliminates the field, instead creating a pci_get_bus()
> helper to do the type mangling to derive it conveniently from the QOM
> Device object underneath.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu
