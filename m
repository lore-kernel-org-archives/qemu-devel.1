Received: from eggs.gnu.org ([2001:4830:134:3::10]:57976)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eENQ0-0005LT-4k
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 17:41:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eENPz-0008Hl-DN
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 17:41:28 -0500
References: <20171012135313.227864-1-vsementsov@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <d3b891f0-f9bd-5ced-5890-7e2f70ed1437@redhat.com>
Date: Mon, 13 Nov 2017 17:41:13 -0500
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
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, famz@redhat.com, jcody@redhat.com
Cc: kwolf@redhat.com, mreitz@redhat.com, stefanha@redhat.com, den@openvz.org

Jeff, I think this ought to go through your tree, but I'll sign off on it.

Fam: Do you agree?

(Probably -next material, but I'm sending this email because I'm taking
it out of my review queue and I don't want it to get lost.)

--js

On 10/12/2017 09:53 AM, Vladimir Sementsov-Ogievskiy wrote:
> Hi all. Here is a continuation of my "new backup architecture" series,
> The very first part, but it is meaningful itself.
> 
> v2: rebase on master
> 01: add test and fix bug
> 02: move commit about NONE mode to this patch, add John's r-b (hope,
>      you are OK with this tiny change)
> 03: tiny refactor (John)
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
