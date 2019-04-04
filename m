Received: from eggs.gnu.org ([209.51.188.92]:55906)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hC4Ch-00048Y-4K
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 11:22:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hC4Cg-00082H-AK
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 11:22:59 -0400
Date: Thu, 4 Apr 2019 17:22:46 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190404152246.GA7684@localhost.localdomain>
References: <20190403030526.12258-1-eblake@redhat.com>
	<20190404145226.32649-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190404145226.32649-1-eblake@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH for-4.0? 8/7] nbd/client: Fix
 error message for server with unusable sizing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, vsementsov@virtuozzo.com, qemu-block@nongnu.org

Am 04.04.2019 um 16:52 hat Eric Blake geschrieben:
> Add a missing space to the error message used when giving up on a
> server that insists on an alignment which renders the last few bytes
> of the export unreadable.
> 
> Fixes: 3add3ab78
> Signed-off-by: Eric Blake <eblake@redhat.com>

Reviewed-by: Kevin Wolf <kwolf@redhat.com>
