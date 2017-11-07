Received: from eggs.gnu.org ([2001:4830:134:3::10]:43224)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eBrjF-0007Gg-BJ
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 19:27:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eBrjE-00027V-Ku
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 19:26:57 -0500
References: <20171012135313.227864-1-vsementsov@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <d3df5de2-9e07-c747-a98a-08a2efba12d0@redhat.com>
Date: Mon, 6 Nov 2017 19:26:33 -0500
MIME-Version: 1.0
In-Reply-To: <20171012135313.227864-1-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 0/5] backup improvements part 1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, jcody@redhat.com, mreitz@redhat.com, stefanha@redhat.com, den@openvz.org



On 10/12/2017 09:53 AM, Vladimir Sementsov-Ogievskiy wrote:
> Hi all. Here is a continuation of my "new backup architecture" series,
> The very first part, but it is meaningful itself.
> 
> v2: rebase on master
> 01: add test and fix bug

Nice, glad you caught it.

Reviewed-by: John Snow <jsnow@redhat.com>

> 02: move commit about NONE mode to this patch, add John's r-b (hope,
>      you are OK with this tiny change)

ACK

> 03: tiny refactor (John)

Reviewed-by: John Snow <jsnow@redhat.com>

> 04: improve commit message, add John's r-b
> 05: add John's r-b
> 
> Vladimir Sementsov-Ogievskiy (5):
>   hbitmap: add next_zero function
>   backup: move from done_bitmap to copy_bitmap
>   backup: init copy_bitmap from sync_bitmap for incremental
>   backup: simplify non-dirty bits progress processing
>   backup: use copy_bitmap in incremental backup
> 
>  include/block/dirty-bitmap.h |   1 +
>  include/qemu/hbitmap.h       |   8 +++
>  block/backup.c               | 118 ++++++++++++++++++++++++-------------------
>  block/dirty-bitmap.c         |   5 ++
>  tests/test-hbitmap.c         |  61 ++++++++++++++++++++++
>  util/hbitmap.c               |  39 ++++++++++++++
>  6 files changed, 180 insertions(+), 52 deletions(-)
> 

I'm not sure if this still qualifies for RC, but since it's my fault it
languished on the list, I'd still be willing to send the PR and suffer
Peter's wrath.

I apologize for the unexpected leave.

--John
