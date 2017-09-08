Received: from eggs.gnu.org ([2001:4830:134:3::10]:56547)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dqGYr-0006BC-6T
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 06:31:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dqGYm-00072l-QM
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 06:30:57 -0400
Date: Fri, 8 Sep 2017 12:30:35 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170908103035.GA3283@localhost.localdomain>
References: <20170908094457.25317-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170908094457.25317-1-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3] file-posix: Clear out first sector in
 hdev_create
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

Am 08.09.2017 um 11:44 hat Fam Zheng geschrieben:
> People get surprised when, after "qemu-img create -f raw /dev/sdX", they
> still see qcow2 with "qemu-img info", if previously the bdev had a qcow2
> header. While this is natural because raw doesn't need to write any
> magic bytes during creation, hdev_create is free to clear out the first
> sector to make sure the stale qcow2 header doesn't cause such confusion.
> 
> Signed-off-by: Fam Zheng <famz@redhat.com>

Thanks, applied to the block branch.

Kevin
