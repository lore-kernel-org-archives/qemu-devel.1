Received: from eggs.gnu.org ([2001:4830:134:3::10]:46957)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dI1Sh-0003p4-KE
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 19:31:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dI1Sg-000800-Pw
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 19:31:03 -0400
References: <20170511022036.32225-1-eblake@redhat.com>
	<20170511022036.32225-21-eblake@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <42b0ba3d-f237-bed1-9039-a4d2eb5d1fdf@redhat.com>
Date: Mon, 5 Jun 2017 19:30:49 -0400
MIME-Version: 1.0
In-Reply-To: <20170511022036.32225-21-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 20/20] block: Make
 bdrv_is_allocated_above() byte-based
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-block@nongnu.org, Wen Congyang <wencongyang2@huawei.com>, Jeff Cody <jcody@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Xie Changlong <xiechanglong.d@gmail.com>



On 05/10/2017 10:20 PM, Eric Blake wrote:
> We are gradually moving away from sector-based interfaces, towards
> byte-based.  In the common case, allocation is unlikely to ever use
> values that are not naturally sector-aligned, but it is possible
> that byte-based values will let us be more precise about allocation
> at the end of an unaligned file that can do byte-based access.
> 
> Changing the signature of the function to use int64_t *pnum ensures
> that the compiler enforces that all callers are updated.  For now,
> the io.c layer still assert()s that all callers are sector-aligned,
> but that can be relaxed when a later patch implements byte-based
> block status.  Therefore, for the most part this patch is just the
> addition of scaling at the callers followed by inverse scaling at
> bdrv_is_allocated().  But some code, particularly stream_run(),
> gets a lot simpler because it no longer has to mess with sectors.
> 
> For ease of review, bdrv_is_allocated() was tackled separately.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
>

Reviewed-by: John Snow <jsnow@redhat.com>
