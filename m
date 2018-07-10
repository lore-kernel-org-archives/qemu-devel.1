Received: from eggs.gnu.org ([2001:4830:134:3::10]:60144)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fctuv-0004GF-Ny
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 10:47:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fctuu-0002s4-Qf
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 10:47:01 -0400
Date: Tue, 10 Jul 2018 16:46:54 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180710144654.GL5852@localhost.localdomain>
References: <20180710063124.2263-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180710063124.2263-1-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 00/10] block: Fix dst reading after tail
 copy offloading
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, vsementsov@virtuozzo.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Jeff Cody <jcody@redhat.com>, Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

Am 10.07.2018 um 08:31 hat Fam Zheng geschrieben:
> Based-on: 20180709163719.87107-1-vsementsov@virtuozzo.com
> 
> v3: - Rebase onto Vladmir's:
>       [PATCH v5 0/4] fix image fleecing
>       on top of master, which has blklogwrites to be converted to BdrvChild for
>       the bdrv_co_pdiscard() parameter.  [Kevin]
>     - Add file_ prefix to file protocol trace points. [Kevin]
>     - Assert that BdrvTrackedRequest bytes and offset don't overflow INT64_MAX.
>       [Kevin]
>     - Don't misuse req->offset/req->bytes in bdrv_co_write_req_prepare/finish.
>       [Kevin]
>     - Fix stat64_max. [Kevin]
>     - Keep lines within 80 columns. [Kevin]
>     - Grammar fix in commit message and rev-by. [Eric]
> 
> Qcow2 allocates new clusters after the end of the file. If it is the destinaton
> of copy offloading, we must adjust dst->bs->total_sectors. Otherwise, further
> reads will drop to the "beyond EOF" code path and return zeroes, which problem
> is caught by iotests 222.
> 
> Follow the logic in the normal write code and update bs->total_sectors after
> I/O is done.
> 
> While at it, add a few convenient trace points to aid future debug experiences
> in the topic.

Thanks, applied to the block branch.

Kevin
