Received: from eggs.gnu.org ([2001:4830:134:3::10]:43181)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dercs-0003Gi-Al
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 19:40:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dercn-0007ah-H8
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 19:39:58 -0400
References: <20170803150301.10177-1-kwolf@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <73c3ab64-382a-fc41-093c-99ad63923c83@redhat.com>
Date: Mon, 7 Aug 2017 19:39:40 -0400
MIME-Version: 1.0
In-Reply-To: <20170803150301.10177-1-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH for-2.10 0/5] block:
 bdrv_reopen() fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org



On 08/03/2017 11:02 AM, Kevin Wolf wrote:
> This is the first part of some fixes to bdrv_reopen(), which seems
> reasonable enough to merge for 2.10.
> 
> There is much more wrong with bdrv_reopen() currently, especially with
> respect to op blocker permissions (basically the required permissions
> can change based on the options used in bdrv_reopen(), and both things
> affect the whole tree and aren't integrated with each other at all), but
> I have little hope to get this fixed before 2.10, so let's start with
> what is ready now.
> 
> Kevin Wolf (5):
>   block: Fix order in bdrv_replace_child()
>   block: Allow reopen rw without BDRV_O_ALLOW_RDWR
>   block: Set BDRV_O_ALLOW_RDWR during rw reopen
>   qemu-io: Allow reopen read-write
>   qemu-iotests: Test reopen between read-only and read-write
> 
>  include/block/block.h      |  3 +-
>  block.c                    | 20 +++++++++-----
>  qemu-io-cmds.c             | 19 +++++++++++--
>  tests/qemu-iotests/187     | 69 ++++++++++++++++++++++++++++++++++++++++++++++
>  tests/qemu-iotests/187.out | 18 ++++++++++++
>  tests/qemu-iotests/group   |  1 +
>  6 files changed, 120 insertions(+), 10 deletions(-)
>  create mode 100755 tests/qemu-iotests/187
>  create mode 100644 tests/qemu-iotests/187.out
> 

Not that you need it, but I reviewed the series because I wanted to know
what this change was, so while I'm here:

Reviewed-by: John Snow <jsnow@redhat.com>
