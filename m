Received: from eggs.gnu.org ([2001:4830:134:3::10]:34176)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cr779-0002xe-6v
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 14:05:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cr778-0003xd-Ci
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 14:05:35 -0400
Date: Thu, 23 Mar 2017 19:05:23 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170323180523.GF5344@noname.redhat.com>
References: <20170308191434.2413-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170308191434.2413-1-mreitz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 for-2.10 0/4] block: Add errp to b{lk,
 drv}_truncate()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>

Am 08.03.2017 um 20:14 hat Max Reitz geschrieben:
> Having an Error parameter for these functions makes sense because we
> sometimes want a bit more information than just "Something failed". Some
> drivers already use error_report() and the like to emit this additional
> information, so it's rather obvious that we do want a real error object
> here.

I had only some minor comments about improving one error message or
another, so whether you fix them or not:

Reviewed-by: Kevin Wolf <kwolf@redhat.com>

(But if you don't fix them, you need to merge the patches yourself)
