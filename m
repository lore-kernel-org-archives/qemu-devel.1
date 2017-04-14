Received: from eggs.gnu.org ([2001:4830:134:3::10]:52737)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cywJt-0002bT-Rc
	for qemu-devel@nongnu.org; Fri, 14 Apr 2017 04:11:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cywJs-0005qy-Ue
	for qemu-devel@nongnu.org; Fri, 14 Apr 2017 04:11:05 -0400
Date: Fri, 14 Apr 2017 16:10:55 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170414081055.GB25212@lemon>
References: <20170414080206.2301-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170414080206.2301-1-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.9-rc5 v2] block: Drain BH in
 bdrv_drained_begin
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, pbonzini@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, jcody@redhat.com

On Fri, 04/14 16:02, Fam Zheng wrote:
> @@ -167,8 +167,12 @@ static bool bdrv_drain_recurse(BlockDriverState *bs)
>          bs->drv->bdrv_drain(bs);
>      }
>  
> -    QLIST_FOREACH(child, &bs->children, next) {
> -        waited |= bdrv_drain_recurse(child->bs);
> +    QLIST_FOREACH_SAFE(child, &bs->children, next, tmp) {
> +        BlockDriverState *bs = child->bs;

Poor name, @bs is the function parameter already, let's use something like @bs1.

Fam
