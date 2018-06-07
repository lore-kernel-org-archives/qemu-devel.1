Received: from eggs.gnu.org ([2001:4830:134:3::10]:46859)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fR2yE-0000a8-Pn
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 18:01:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fR2yC-00038O-8b
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 18:01:26 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45374 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fR2yC-00038A-3x
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 18:01:24 -0400
Date: Fri, 8 Jun 2018 01:01:22 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180608010114-mutt-send-email-mst@kernel.org>
References: <20180607154705.6316-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180607154705.6316-1-david@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v1 0/2] memory: fix alignment checks/asserts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Igor Mammedov <imammedo@redhat.com>

On Thu, Jun 07, 2018 at 05:47:03PM +0200, David Hildenbrand wrote:
> We can currently hit two asserts. Let's fix those.
> 
> Patch nr. 1 is a result from:
>     "[PATCH v4 00/14] MemoryDevice: use multi stage hotplug handlers"
> 
> We treat right now any alignment > 1GB as a violation, as it would
> fragment guest memory heavily. Turn the assert into a check.
> 
> Also, we run into an assert when using alignments that are not a power of
> two.

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

> David Hildenbrand (2):
>   memory-device: turn alignment assert into check
>   exec: check that alignment is a power of two
> 
>  exec.c                 | 4 ++++
>  hw/mem/memory-device.c | 8 +++++++-
>  2 files changed, 11 insertions(+), 1 deletion(-)
> 
> -- 
> 2.17.0
