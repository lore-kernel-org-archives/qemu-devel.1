Received: from eggs.gnu.org ([2001:4830:134:3::10]:46163)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dNKCr-0000HF-09
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 10:32:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dNKCq-0006RL-2Z
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 10:32:37 -0400
Date: Tue, 20 Jun 2017 16:32:24 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170620143224.GB6306@noname.redhat.com>
References: <cover.1497879398.git.berto@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1497879398.git.berto@igalia.com>
Subject: Re: [Qemu-devel] [PATCH v4 0/7] Reduce the number of I/O ops when
 doing COW
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

Am 19.06.2017 um 15:40 hat Alberto Garcia geschrieben:
> Hi all,
> 
> here's a patch series that rewrites the copy-on-write code in the
> qcow2 driver to reduce the number of I/O operations.
> 
> This is version v4, please refer to the original e-mail for a complete
> description:
> 
> https://lists.gnu.org/archive/html/qemu-block/2017-05/msg00882.html

Thanks, applied to the block branch.

Kevin
