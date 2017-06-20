Received: from eggs.gnu.org ([2001:4830:134:3::10]:48453)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dNKL9-0001MY-AO
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 10:41:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dNKL8-00019c-Gw
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 10:41:11 -0400
Date: Tue, 20 Jun 2017 16:40:59 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170620144059.GC6306@noname.redhat.com>
References: <20170620130136.14557-1-berto@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170620130136.14557-1-berto@igalia.com>
Subject: Re: [Qemu-devel] [PATCH] qcow2: Use offset_into_cluster() and
 offset_to_l2_index()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

Am 20.06.2017 um 15:01 hat Alberto Garcia geschrieben:
> We already have functions for doing these calculations, so let's use
> them instead of doing everything by hand. This makes the code a bit
> more readable.
> 
> Signed-off-by: Alberto Garcia <berto@igalia.com>

Thanks, applied to the block branch.

Kevin
