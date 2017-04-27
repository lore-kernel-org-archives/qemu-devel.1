Received: from eggs.gnu.org ([2001:4830:134:3::10]:58264)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d3k3p-0005HJ-AK
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 10:06:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d3k3o-0004ot-EG
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 10:06:21 -0400
Date: Thu, 27 Apr 2017 16:06:07 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170427140607.GF4805@noname.str.redhat.com>
References: <20170420005428.11465-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170420005428.11465-1-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3] iotests: 109: Filter out "len" of
 failed jobs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org, pbonzini@redhat.com

Am 20.04.2017 um 02:54 hat Fam Zheng geschrieben:
> Mirror calculates job len from current I/O progress:
> 
>     s->common.len = s->common.offset +
>                     (cnt + s->sectors_in_flight) * BDRV_SECTOR_SIZE;
> 
> The final "len" of a failed mirror job in iotests 109 depends on the
> subtle timing of the completion of read and write issued in the first
> mirror iteration.  The second iteration may or may not have run when the
> I/O error happens, resulting in non-deterministic output of the
> BLOCK_JOB_COMPLETED event text.
> 
> Similar to what was done in a752e4786, filter out the field to make the
> test robust.
> 
> Signed-off-by: Fam Zheng <famz@redhat.com>

Thanks, applied to block-next.

Kevin
