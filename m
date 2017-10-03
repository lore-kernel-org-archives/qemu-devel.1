Received: from eggs.gnu.org ([2001:4830:134:3::10]:41554)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dzJNc-00006S-1Q
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 05:20:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dzJNX-00017u-8O
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 05:20:43 -0400
References: <20171003031556.15173-1-jsnow@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <f66d037c-67a3-30eb-05eb-fc105093ec80@virtuozzo.com>
Date: Tue, 3 Oct 2017 12:20:25 +0300
MIME-Version: 1.0
In-Reply-To: <20171003031556.15173-1-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH 0/3] blockjobs: add explicit job culling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
Cc: kwolf@redhat.com, pkrempa@redhat.com, jtc@redhat.com, qemu-devel@nongnu.org

03.10.2017 06:15, John Snow wrote:
> For jobs that complete when a monitor isn't looking, there's no way to
> tell what the job's final return code was. We need to allow jobs to
> remain in the list until queried for reliable management.
>
> This is an RFC; tests are on the way.
> (Tested only manually via qmp-shell for now.)

That's a cool feature!
What about transactions support?

>
> John Snow (3):
>    blockjob: add manual-cull property
>    qmp: add block-job-cull command
>    blockjob: expose manual-cull property
>
>   block/backup.c               | 20 +++++++++---------
>   block/commit.c               |  2 +-
>   block/mirror.c               |  2 +-
>   block/replication.c          |  5 +++--
>   block/stream.c               |  2 +-
>   block/trace-events           |  1 +
>   blockdev.c                   | 28 +++++++++++++++++++++----
>   blockjob.c                   | 46 +++++++++++++++++++++++++++++++++++++++--
>   include/block/block_int.h    |  8 +++++---
>   include/block/blockjob.h     | 21 +++++++++++++++++++
>   include/block/blockjob_int.h |  2 +-
>   qapi/block-core.json         | 49 ++++++++++++++++++++++++++++++++++++--------
>   tests/test-blockjob-txn.c    |  2 +-
>   tests/test-blockjob.c        |  2 +-
>   14 files changed, 155 insertions(+), 35 deletions(-)
>


-- 
Best regards,
Vladimir
