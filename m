Received: from eggs.gnu.org ([2001:4830:134:3::10]:56719)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1g7nyM-000744-0S
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 16:42:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1g7nlF-0003Rq-DN
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 16:28:46 -0400
References: <20181002230218.13949-1-jsnow@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <5ed59cbe-cf23-ec69-27a8-b1898ed2deb9@redhat.com>
Date: Wed, 3 Oct 2018 16:28:32 -0400
MIME-Version: 1.0
In-Reply-To: <20181002230218.13949-1-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 0/6] dirty-bitmaps: fix QMP command
 permissions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, eblake@redhat.com, Kevin Wolf <kwolf@redhat.com>, Juan Quintela <quintela@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, vsementsov@virtuozzo.com, Fam Zheng <famz@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>



On 10/02/2018 07:02 PM, John Snow wrote:
> based on: jsnow/bitmaps staging branch
> 
> This series builds on a previous standalone patch and adjusts
> the permission for all (or most) of the QMP bitmap commands.
> 
> V4:
>  - Replace "in-use" with "in use"
>  - Replace "user_modifiable" version with "user_locked"
>  - Remove more usages of frozen-and-or-locked in NBD.
> 
> John Snow (6):
>   block/dirty-bitmaps: add user_locked status checker
>   block/dirty-bitmaps: fix merge permissions
>   block/dirty-bitmaps: allow clear on disabled bitmaps
>   block/dirty-bitmaps: prohibit enable/disable on locked/frozen bitmaps
>   block/backup: prohibit backup from using in use bitmaps
>   nbd: forbid use of frozen bitmaps
> 
>  block/dirty-bitmap.c           | 13 +++++---
>  blockdev.c                     | 75 +++++++++++++++++++-----------------------
>  include/block/dirty-bitmap.h   |  1 +
>  migration/block-dirty-bitmap.c | 10 ++----
>  nbd/server.c                   |  4 +--
>  5 files changed, 48 insertions(+), 55 deletions(-)
> 

Thanks, applied to my bitmaps tree: [with edits suggested by Vladimir];

https://github.com/jnsnow/qemu/commits/bitmaps
https://github.com/jnsnow/qemu.git

--js
