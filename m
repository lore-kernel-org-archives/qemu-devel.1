Received: from eggs.gnu.org ([2001:4830:134:3::10]:50784)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eKIGP-0000VO-HJ
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 01:24:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eKIGK-0005Iq-IZ
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 01:24:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55488)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eKIGK-0005HH-BF
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 01:23:56 -0500
Date: Thu, 30 Nov 2017 14:23:45 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20171130062345.GC22901@xz-mi>
References: <20171129084628.12336-1-david@gibson.dropbear.id.au>
	<20171129084628.12336-5-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171129084628.12336-5-david@gibson.dropbear.id.au>
Subject: Re: [Qemu-devel] [for-2.12 4/7] pci: Simplify pci_bus_is_root()
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

On Wed, Nov 29, 2017 at 07:46:25PM +1100, David Gibson wrote:

[...]

>  struct PCIBus {
>      BusState qbus;
> +    enum PCIBusFlags flags;
>      PCIIOMMUFunc iommu_fn;
>      void *iommu_opaque;
>      uint8_t devfn_min;
> @@ -440,8 +446,12 @@ struct PCIBus {
>      Notifier machine_done;
>  };

I would prefer directly defining flags as uint64_t then it's more
clear that it's a bitmask (enum let me think of only one flag will be
set, but I may be wrong), but it's fine too to me.

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu
