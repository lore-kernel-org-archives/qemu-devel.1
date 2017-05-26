Received: from eggs.gnu.org ([2001:4830:134:3::10]:59767)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dEALc-00061B-1T
	for qemu-devel@nongnu.org; Fri, 26 May 2017 04:11:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dEALa-0007Tm-1J
	for qemu-devel@nongnu.org; Fri, 26 May 2017 04:11:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39106)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1dEALZ-0007Sc-QV
	for qemu-devel@nongnu.org; Fri, 26 May 2017 04:11:45 -0400
Date: Fri, 26 May 2017 10:11:42 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170526081142.GB7211@noname.str.redhat.com>
References: <1495186480-114192-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1495186480-114192-6-git-send-email-anton.nefedov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1495186480-114192-6-git-send-email-anton.nefedov@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH v1 05/13] qcow2: set inactive flag
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>
Cc: qemu-devel@nongnu.org, den@virtuozzo.com, mreitz@redhat.com

Am 19.05.2017 um 11:34 hat Anton Nefedov geschrieben:
> Qcow2State and BlockDriverState flags have to be in sync
> 
> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
> ---
>  block/qcow2.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/block/qcow2.c b/block/qcow2.c
> index 6e7ce96..07c1706 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -1939,6 +1939,7 @@ static int qcow2_inactivate(BlockDriverState *bs)
>  
>      if (result == 0) {
>          qcow2_mark_clean(bs);
> +        s->flags |= BDRV_O_INACTIVE;
>      }

Good catch.

But can't we simply use bs->open_flags and completely get rid of
s->flags?

Kevin
