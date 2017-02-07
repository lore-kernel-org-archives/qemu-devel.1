Received: from eggs.gnu.org ([2001:4830:134:3::10]:51871)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cb8Ta-0003FX-Ks
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 11:18:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cb8TW-0002c7-KM
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 11:18:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46082)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1cb8TW-0002bY-EV
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 11:18:38 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7C10380478
	for <qemu-devel@nongnu.org>; Tue,  7 Feb 2017 16:18:38 +0000 (UTC)
Date: Tue, 7 Feb 2017 18:18:36 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170207181828-mutt-send-email-mst@kernel.org>
References: <20170203160651.19917-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170203160651.19917-1-dgilbert@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/4] virtio-net VMState conversion and new
 VMSTATE macros
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, quintela@redhat.com

On Fri, Feb 03, 2017 at 04:06:47PM +0000, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> Hi,
>   This set converts the virtio-net device to VMState;
> it uses a couple of new VMSTATE macros I've added, of which
> the VMSTATE_WITH_TMP is a bit unusual, but is intended for dealing
> with migration data that doesn't quite look like the data structure
> we have in memory.
> 
> Dave


Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

> 
> Dr. David Alan Gilbert (4):
>   migration: Add VMSTATE_UNUSED_VARRAY_UINT32
>   migration: Add VMSTATE_WITH_TMP
>   tests/migration: Add test for VMSTATE_WITH_TMP
>   virtio/migration: Migrate virtio-net to VMState
> 
>  hw/net/virtio-net.c            | 316 +++++++++++++++++++++++++++--------------
>  include/hw/virtio/virtio-net.h |   4 +-
>  include/migration/vmstate.h    |  30 ++++
>  migration/vmstate.c            |  40 ++++++
>  tests/test-vmstate.c           |  98 ++++++++++++-
>  5 files changed, 375 insertions(+), 113 deletions(-)
> 
> -- 
> 2.9.3
