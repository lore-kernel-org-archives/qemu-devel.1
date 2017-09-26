Received: from eggs.gnu.org ([2001:4830:134:3::10]:41083)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dwehh-0005D7-4R
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 21:30:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dwehf-0002PN-VD
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 21:30:29 -0400
Date: Tue, 26 Sep 2017 09:30:14 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170926013014.GB31924@lemon.lan>
References: <20170925145526.32690-1-eblake@redhat.com>
	<20170925145526.32690-19-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170925145526.32690-19-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v10 18/20] qcow2: Switch
 store_bitmap_data() to byte-based iteration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, jsnow@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On Mon, 09/25 09:55, Eric Blake wrote:
> Now that we have adjusted the majority of the calls this function
> makes to be byte-based, it is easier to read the code if it makes
> passes over the image using bytes rather than sectors.
> 
> iotests 165 was rather weak - on a default 64k-cluster image, where
> bitmap granularity also defaults to 64k bytes, a single cluster of
> the bitmap table thus covers (64*1024*8) bits which each cover 64k
> bytes, or 32G of image space.  But the test only uses a 1G image,
> so it cannot trigger any more than one loop of the code in
> store_bitmap_data(); and it was writing to the first cluster.  In
> order to test that we are properly aligning which portions of the
> bitmap are being written to the file, we really want to test a case
> where the first dirty bit returned by bdrv_dirty_iter_next() is not
> aligned to the start of a cluster, which we can do by modifying the
> test to write data that doesn't happen to fall in the first cluster
> of the image.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Vladimir Sementsov-Ogievskiy<vsementsov@virtuozzo.com>

Reviewed-by: Fam Zheng <famz@redhat.com>
