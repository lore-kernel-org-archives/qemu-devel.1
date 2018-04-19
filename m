Received: from eggs.gnu.org ([2001:4830:134:3::10]:47435)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1f9IWU-0004Tb-02
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 18:59:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1f9IWT-0002nB-97
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 18:59:26 -0400
References: <20180416114414.18406-1-vsementsov@virtuozzo.com>
	<20180416114414.18406-6-vsementsov@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <06c381e6-85d3-1f20-b9cb-58d9eb716032@redhat.com>
Date: Thu, 19 Apr 2018 18:59:08 -0400
MIME-Version: 1.0
In-Reply-To: <20180416114414.18406-6-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 5/7] blockdev: refactor
 block-dirty-bitmap-clear transaction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, armbru@redhat.com, mreitz@redhat.com, pbonzini@redhat.com, den@openvz.org



On 04/16/2018 07:44 AM, Vladimir Sementsov-Ogievskiy wrote:
> bdrv_clear_dirty_bitmap do not fail, so we can call it in transaction
> commit, avoiding any rollback.
> 
> After this, bdrv_undo_clear_dirty_bitmap() becomes unused, so, drop it.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---

Sorry if it was my idea entirely that led you on this wild goose chase,
I had forgotten :(
