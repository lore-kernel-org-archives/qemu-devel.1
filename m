Received: from eggs.gnu.org ([2001:4830:134:3::10]:34291)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gYupW-0000dI-6e
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 10:29:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gYupS-0008Uo-4B
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 10:29:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:32796)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gYupR-0008SR-SQ
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 10:29:10 -0500
Date: Mon, 17 Dec 2018 10:28:58 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181217102841-mutt-send-email-mst@kernel.org>
References: <20181214131043.25071-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181214131043.25071-1-david@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 0/2] range/memory-device: fixes and
 cleanups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Fri, Dec 14, 2018 at 02:10:41PM +0100, David Hildenbrand wrote:
> These are the two leftovers from
>     [PATCH v3 0/7] qapi/range/memory-device: fixes and cleanups

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

Who's merging this Eduardo?

> The remaining patches extent the QEMU range code and rewrite
> memory-device code to make use of it.
> 
> v34 -> v5:
> - "memory-device: rewrite address assignment using ranges"
> -- Squash to error pathes that resulted in the same error message
> 
> v3 -> v4:
> - "memory-device: rewrite address assignment using ranges"
> -- Use better error messages
> -- Fix one theretical overflow
> 
> David Hildenbrand (2):
>   range: add some more functions
>   memory-device: rewrite address assignment using ranges
> 
>  hw/mem/memory-device.c | 51 +++++++++++++++++-----------------
>  include/qemu/range.h   | 62 ++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 88 insertions(+), 25 deletions(-)
> 
> -- 
> 2.17.2
