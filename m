Received: from eggs.gnu.org ([2001:4830:134:3::10]:50792)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eYyHQ-0000ip-0D
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 13:05:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eYyHP-0004Gp-7H
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 13:05:43 -0500
References: <20180108030946.14991-1-famz@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8c75f873-421d-4e26-d555-ad30b350ea1d@redhat.com>
Date: Tue, 9 Jan 2018 19:05:31 +0100
MIME-Version: 1.0
In-Reply-To: <20180108030946.14991-1-famz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] scsi: Don't check uninitialized local
 variable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Lieven <pl@kamp.de>, qemu-block@nongnu.org

On 08/01/2018 04:09, Fam Zheng wrote:
> After the out label there is a check on iTask.task but it is not
> initialized yet.
> 
> Fixes: e38bc23454ef763deb4405ebdee6a1081aa00bc8
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  block/iscsi.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/block/iscsi.c b/block/iscsi.c
> index 5c0a9e55b6..1cb8cc93c5 100644
> --- a/block/iscsi.c
> +++ b/block/iscsi.c
> @@ -659,8 +659,7 @@ static int64_t coroutine_fn iscsi_co_get_block_status(BlockDriverState *bs,
>      int64_t ret;
>  
>      if (!is_sector_request_lun_aligned(sector_num, nb_sectors, iscsilun)) {
> -        ret = -EINVAL;
> -        goto out;
> +        return -EINVAL;
>      }
>  
>      /* default to all sectors allocated */
> 

Queued, thanks.

Paolo
