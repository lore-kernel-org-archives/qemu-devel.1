Received: from eggs.gnu.org ([2001:4830:134:3::10]:41462)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gPr3N-0006UV-U8
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 10:38:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gPr3N-00015I-69
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 10:38:05 -0500
Date: Thu, 22 Nov 2018 16:37:55 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20181122153755.GF31879@linux.fritz.box>
References: <20181119172924.2296342-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181119172924.2296342-1-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-3.1] iotests: Enhance 223 to cover
 multiple bitmap granularities
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>

Am 19.11.2018 um 18:29 hat Eric Blake geschrieben:
> Testing granularity at the same size as the cluster isn't quite
> as fun as what happens when it is larger or smaller.  This
> enhancement also shows that qemu's nbd server can server the
> same disk over multiple exports simultaneously.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>

Thanks, applied to the block branch.

Kevin
