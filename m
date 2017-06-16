Received: from eggs.gnu.org ([2001:4830:134:3::10]:36037)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dLtEC-0002Au-MM
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 11:32:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dLtEC-0008Eg-0F
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 11:32:04 -0400
Date: Fri, 16 Jun 2017 17:31:50 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170616153150.GC4366@noname.fritz.box>
References: <cover.1496844254.git.berto@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1496844254.git.berto@igalia.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/7] qcow2: Reduce the number of I/O ops
 when doing COW
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, "Denis V . Lunev" <den@openvz.org>, Stefan Hajnoczi <stefanha@redhat.com>

Am 07.06.2017 um 16:08 hat Alberto Garcia geschrieben:
> Hi all,
> 
> here's a patch series that rewrites the copy-on-write code in the
> qcow2 driver to reduce the number of I/O operations.
> 
> This is version v2, please refer to the original e-mail for a complete
> description:
> 
> https://lists.gnu.org/archive/html/qemu-block/2017-05/msg00882.html

I had two minor comments, and there's the one from Eric about the buffer
alignement. Other than that, this series looks good. Feel free to add my
Reviewed-by after addressing these three comments.

Kevin
