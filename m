Received: from eggs.gnu.org ([209.51.188.92]:33008)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hJhyr-0002uB-EW
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 13:16:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hJhwt-0002tD-Mg
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 13:14:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49810)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hJhwt-0002sl-HA
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 13:14:15 -0400
Date: Thu, 25 Apr 2019 14:14:06 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20190425171406.GN18406@habkost.net>
References: <20190425130939.29674-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190425130939.29674-1-stefanha@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] virtio: clarify VirtioPCIDeviceTypeInfo
 usage
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, sebastien.boeuf@intel.com

On Thu, Apr 25, 2019 at 02:09:39PM +0100, Stefan Hajnoczi wrote:
> How to use .base_name, .generic_name, .transitional_name, and
> .non_transitional_name can be confusing.
> 
> Existing devices have .generic_name but its behavior is somewhat magic.
> 
> Devices added to new versions of the VIRTIO specification should forego
> transitional mode completely and always operate in non-transitional mode
> because there are no existing drivers for them that require backwards
> compatibility.
> 
> This patch adds comments that hopefully make it easier for developers to
> decide how to fill out VirtioPCIDeviceTypeInfo.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

-- 
Eduardo
