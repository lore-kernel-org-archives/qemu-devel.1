Received: from eggs.gnu.org ([2001:4830:134:3::10]:53695)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1f0QYj-0007qI-O1
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 07:45:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1f0QYg-0003D7-MW
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 07:45:05 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:45265)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1f0QYg-0003CF-GA
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 07:45:02 -0400
Received: by mail-wr0-f194.google.com with SMTP id u11so6273315wri.12
	for <qemu-devel@nongnu.org>; Mon, 26 Mar 2018 04:45:02 -0700 (PDT)
References: <20180326112056.8420-1-vsementsov@virtuozzo.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <30d6538c-3f5b-c51f-2f53-fb6d4e03ef00@redhat.com>
Date: Mon, 26 Mar 2018 13:44:58 +0200
MIME-Version: 1.0
In-Reply-To: <20180326112056.8420-1-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/7] Dirty bitmaps fixing and refactoring
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, armbru@redhat.com, mreitz@redhat.com, den@openvz.org, jsnow@redhat.com

On 26/03/2018 13:20, Vladimir Sementsov-Ogievskiy wrote:
> Nothing critical here.
> 
> 01 - these functions are unused for now, but the will be used in
>      the qmp bitmaps api.
> 
> Vladimir Sementsov-Ogievskiy (7):
>   block/dirty-bitmap: add lock to bdrv_enable/disable_dirty_bitmap
>   dirty-bitmaps: fix comment about dirty_bitmap_mutex
>   dirty-bitmap: remove missed bdrv_dirty_bitmap_get_autoload header
>   dirty-bitmap: separate unused meta-bitmap related functions
>   blockdev: refactor block-dirty-bitmap-clear transaction
>   block/dirty-bitmap: bdrv_clear_dirty_bitmap: drop unused parameter
>   blockdev: unify block-dirty-bitmap-clear command and transaction
>     action
> 
>  include/block/block_int.h    | 14 +++++----
>  include/block/dirty-bitmap.h | 15 ++++++----
>  block/dirty-bitmap.c         | 23 +++++++++------
>  blockdev.c                   | 69 ++++++++++++++------------------------------
>  4 files changed, 54 insertions(+), 67 deletions(-)
> 

Looks good apart from some dead code still being there.

Paolo
