Received: from eggs.gnu.org ([2001:4830:134:3::10]:40403)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d3JNB-00051Y-CJ
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 05:36:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d3JNA-0008Hu-KZ
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 05:36:33 -0400
Date: Wed, 26 Apr 2017 11:36:22 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170426093622.GB4538@noname.str.redhat.com>
References: <20170426033413.17192-1-famz@redhat.com>
	<20170426033413.17192-3-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170426033413.17192-3-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v15 02/21] block: Define BLK_PERM_MAX
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, eblake@redhat.com, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

Am 26.04.2017 um 05:33 hat Fam Zheng geschrieben:
> This is the order of the largest possible permission.
> 
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  include/block/block.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/block/block.h b/include/block/block.h
> index eb0565d..a798f10 100644
> --- a/include/block/block.h
> +++ b/include/block/block.h
> @@ -224,6 +224,8 @@ enum {
>      BLK_PERM_ALL                = 0x1f,
>  };
>  
> +#define BLK_PERM_MAX (64 - clz64((uint64_t)BLK_PERM_ALL))

Contrary to the commit message, this is the number of permission bits in
use (i.e. one more than the largest possible permission). You're using
it correctly, though, because your loop condition is i < BLK_PERM_MAX.

This could use an updated commit message and a comment at the #define at
least. Ideally a less ambiguous name instead of the commit (because _MAX
seems to imply what the commit message currently says, not what it
really is), but I can't think of one.

Kevin
