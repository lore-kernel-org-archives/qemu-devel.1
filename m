Received: from eggs.gnu.org ([2001:4830:134:3::10]:59117)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fJay6-0005uA-Hs
	for qemu-devel@nongnu.org; Fri, 18 May 2018 04:42:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fJay5-0008Kr-NM
	for qemu-devel@nongnu.org; Fri, 18 May 2018 04:42:30 -0400
Date: Fri, 18 May 2018 10:42:21 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180518084221.GA4833@localhost.localdomain>
References: <20180517165253.19958-1-kwolf@redhat.com>
	<20180517165253.19958-3-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180517165253.19958-3-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/3] qemu-iotests: Filter NFS paths
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org

Am 17.05.2018 um 18:52 hat Kevin Wolf geschrieben:
> NFS paths were only partially filtered in _filter_img_create, _img_info
> and _filter_img_info, resulting in "nfs://127.0.0.1TEST_DIR/t.IMGFMT".
> This adds another replacement to the sed calls that matches $TEST_IMG as
> a whole.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>

Self-NACK, this replaces a bit too much... (Some places in the test
scripts override $TEST_IMG, but not $TEST_IMG_FILE).

Maybe we need to introduce some $TEST_DIR_REMOTE (any suggestions for
a better name?) that would contain "nfs://127.0.0.1$TEST_DIR" and can be
used in the filter function.

Kevin
