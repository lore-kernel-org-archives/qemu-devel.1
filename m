Received: from eggs.gnu.org ([2001:4830:134:3::10]:57448)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eKIY6-0007nU-Uz
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 01:42:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eKIY2-0001xk-DP
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 01:42:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59512)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eKIY2-0001wF-7f
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 01:42:14 -0500
Date: Thu, 30 Nov 2017 14:42:01 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20171130064201.GG22901@xz-mi>
References: <20171129084628.12336-1-david@gibson.dropbear.id.au>
	<20171129084628.12336-6-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171129084628.12336-6-david@gibson.dropbear.id.au>
Subject: Re: [Qemu-devel] [for-2.12 5/7] pci: Add pci_dev_bus_num() helper
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

On Wed, Nov 29, 2017 at 07:46:26PM +1100, David Gibson wrote:
> A fair proportion of the users of pci_bus_num() want to get the bus
> number on a specific device, so first have to look up the bus from the
> device then call it.  This adds a helper to do that (since we're going
> to make looking up the bus slightly more verbose).
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu
