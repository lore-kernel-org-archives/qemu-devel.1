Received: from eggs.gnu.org ([2001:4830:134:3::10]:36563)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fb20C-0001Cb-2d
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 07:00:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fb20B-0007a6-CT
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 07:00:44 -0400
Date: Thu, 5 Jul 2018 13:00:26 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180705110026.GG3309@localhost.localdomain>
References: <20180705073701.10558-1-famz@redhat.com>
	<20180705073701.10558-3-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180705073701.10558-3-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 2/9] block: Use BdrvChild to discard
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Jeff Cody <jcody@redhat.com>, Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

Am 05.07.2018 um 09:36 hat Fam Zheng geschrieben:
> Other I/O functions are already using a BdrvChild pointer in the API, so
> make discard do the same. It makes it possible to initiate the same
> permission checks before doing I/O, and much easier to share the
> helper functions for this, which will be added and used by write,
> truncate and copy range paths.
> 
> Signed-off-by: Fam Zheng <famz@redhat.com>

This conflicts with my block branch (because the new blklogwrites driver
needs to be changed to the new interface, too).

Kevin
