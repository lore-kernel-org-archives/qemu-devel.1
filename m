Received: from eggs.gnu.org ([2001:4830:134:3::10]:37109)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dI0iE-0005qn-Rq
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 18:43:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dI0iE-0006x9-5m
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 18:43:02 -0400
References: <20170511022036.32225-1-eblake@redhat.com>
	<20170511022036.32225-16-eblake@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <c519a9b9-2028-7d87-2b8d-67da078720e6@redhat.com>
Date: Mon, 5 Jun 2017 18:42:53 -0400
MIME-Version: 1.0
In-Reply-To: <20170511022036.32225-16-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 15/20] backup: Switch block_backup.h to
 byte-based
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Wen Congyang <wencongyang2@huawei.com>, Jeff Cody <jcody@redhat.com>, Max Reitz <mreitz@redhat.com>, Xie Changlong <xiechanglong.d@gmail.com>



On 05/10/2017 10:20 PM, Eric Blake wrote:
> We are gradually converting to byte-based interfaces, as they are
> easier to reason about than sector-based.  Continue by converting
> the public interface to backup jobs (no semantic change), including
> a change to CowRequest to track by bytes instead of cluster indices.
> 
> Note that this does not change the difference between the public
> interface (starting point, and size of the subsequent range) and
> the internal interface (starting and end points).
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> 

Reviewed-by: John Snow <jsnow@redhat.com>

> ---
> v2: change a couple more parameter names
> ---
>  include/block/block_backup.h | 11 +++++------
>  block/backup.c               | 33 ++++++++++++++++-----------------
>  block/replication.c          | 12 ++++++++----
>  3 files changed, 29 insertions(+), 27 deletions(-)
> 
