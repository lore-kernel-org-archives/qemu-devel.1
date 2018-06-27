Received: from eggs.gnu.org ([2001:4830:134:3::10]:50942)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fYA8S-0000QZ-FL
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 09:05:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fYA8M-0002hL-RG
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 09:05:24 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180627035752.1425-1-famz@redhat.com>
	<20180627035752.1425-2-famz@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <56af7fda-18c4-b8ed-7462-3bef9583cc9c@amsat.org>
Date: Wed, 27 Jun 2018 10:05:02 -0300
MIME-Version: 1.0
In-Reply-To: <20180627035752.1425-2-famz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 1/2] qcow2: Remove dead check on !ret
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On 06/27/2018 12:57 AM, Fam Zheng wrote:
> In the beginning of the function, we initialize the local variable to 0,
> and in the body of the function, we check the assigned values and exit
> the loop immediately. So here it can never be non-zero.
> 
> Reported-by: Kevin Wolf <kwolf@redhat.com>
> Signed-off-by: Fam Zheng <famz@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  block/qcow2.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/block/qcow2.c b/block/qcow2.c
> index a3a3aa2a97..ff23063616 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -1772,7 +1772,7 @@ static coroutine_fn int qcow2_handle_l2meta(BlockDriverState *bs,
>      while (l2meta != NULL) {
>          QCowL2Meta *next;
>  
> -        if (!ret && link_l2) {
> +        if (link_l2) {
>              ret = qcow2_alloc_cluster_link_l2(bs, l2meta);
>              if (ret) {
>                  goto out;
> 
