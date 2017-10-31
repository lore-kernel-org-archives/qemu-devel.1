Received: from eggs.gnu.org ([2001:4830:134:3::10]:48354)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1e9Tkv-00017V-Sx
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 06:26:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1e9Tkv-0001Bc-0B
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 06:26:49 -0400
References: <20171012135313.227864-1-vsementsov@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <7627142e-25be-4a7f-0f00-af5375ad9440@virtuozzo.com>
Date: Tue, 31 Oct 2017 13:26:35 +0300
MIME-Version: 1.0
In-Reply-To: <20171012135313.227864-1-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: [Qemu-devel] ping Re: [PATCH v2 0/5] backup improvements part 1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: jsnow@redhat.com, famz@redhat.com, mreitz@redhat.com, kwolf@redhat.com, jcody@redhat.com, stefanha@redhat.com, den@openvz.org

Hey, what about this?

12.10.2017 16:53, Vladimir Sementsov-Ogievskiy wrote:
> Hi all. Here is a continuation of my "new backup architecture" series,
> The very first part, but it is meaningful itself.
>
> v2: rebase on master
> 01: add test and fix bug
> 02: move commit about NONE mode to this patch, add John's r-b (hope,
>       you are OK with this tiny change)
> 03: tiny refactor (John)
> 04: improve commit message, add John's r-b
> 05: add John's r-b
>
> Vladimir Sementsov-Ogievskiy (5):
>    hbitmap: add next_zero function
>    backup: move from done_bitmap to copy_bitmap
>    backup: init copy_bitmap from sync_bitmap for incremental
>    backup: simplify non-dirty bits progress processing
>    backup: use copy_bitmap in incremental backup
>
>   include/block/dirty-bitmap.h |   1 +
>   include/qemu/hbitmap.h       |   8 +++
>   block/backup.c               | 118 ++++++++++++++++++++++++-------------------
>   block/dirty-bitmap.c         |   5 ++
>   tests/test-hbitmap.c         |  61 ++++++++++++++++++++++
>   util/hbitmap.c               |  39 ++++++++++++++
>   6 files changed, 180 insertions(+), 52 deletions(-)
>


-- 
Best regards,
Vladimir
