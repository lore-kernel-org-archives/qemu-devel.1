Received: from eggs.gnu.org ([2001:4830:134:3::10]:53484)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dsHoQ-0007nU-Tt
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 20:15:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dsHoQ-0002Bd-1u
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 20:15:22 -0400
References: <20170912203119.24166-1-eblake@redhat.com>
	<20170912203119.24166-12-eblake@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <8db498fd-6f7f-ee78-da44-8e0087243ef1@redhat.com>
Date: Wed, 13 Sep 2017 20:15:12 -0400
MIME-Version: 1.0
In-Reply-To: <20170912203119.24166-12-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v7 11/20] dirty-bitmap: Change
 bdrv_dirty_iter_next() to report byte offset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, Fam Zheng <famz@redhat.com>, qemu-block@nongnu.org, Jeff Cody <jcody@redhat.com>, Max Reitz <mreitz@redhat.com>



On 09/12/2017 04:31 PM, Eric Blake wrote:
> Thanks to recent cleanups, most callers were scaling a return value
> of sectors into bytes (the exception, in qcow2-bitmap, will be
> converted to byte-based iteration later).  Update the interface to
> do the scaling internally instead.
> 
> In qcow2-bitmap, the code was specifically checking for an error
> to be -1; it is more robust to treat all negative values as an
> error, but at the same time it is also easy enough to ensure we
> return -1 (and not -512) on error.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> 

This patch now smells like a bugfix and a separate incremental feature
enhancement.

Do we need to backport the error-checking to a possible 2.10.1?

If no:

Reviewed-by: John Snow <jsnow@redhat.com>
