Received: from eggs.gnu.org ([2001:4830:134:3::10]:37233)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1evISP-0006SN-PB
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 04:05:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1evISO-0005hW-SQ
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 04:05:21 -0400
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
References: <20180309182202.31206-1-farosas@linux.vnet.ibm.com>
	<20180309182202.31206-5-farosas@linux.vnet.ibm.com>
In-Reply-To: <20180309182202.31206-5-farosas@linux.vnet.ibm.com>
Date: Mon, 12 Mar 2018 11:05:10 +0300
Message-ID: <000601d3b9d8$d7d129c0$87737d40$@ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Language: ru
Subject: Re: [Qemu-devel] [PATCH 4/5] block/blkreplay: Remove
 protocol-related fields
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: 'Fabiano Rosas' <farosas@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, 'Pavel Dovgalyuk' <pavel.dovgaluk@ispras.ru>, 'Paolo Bonzini' <pbonzini@redhat.com>

> From: Fabiano Rosas [mailto:farosas@linux.vnet.ibm.com]
> The blkreplay driver is not a protocol so it should implement bdrv_open
> instead of bdrv_file_open and not provide a protocol_name.
> 
> Attempts to invoke this driver using protocol syntax
> (i.e. blkreplay:<filename:options:...>) will now fail gracefully:
> 
>   $ qemu-img info blkreplay:foo
>   qemu-img: Could not open 'blkreplay:foo': Unknown protocol 'blkreplay'
> 
> Signed-off-by: Fabiano Rosas <farosas@linux.vnet.ibm.com>
> ---
>  block/blkreplay.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/block/blkreplay.c b/block/blkreplay.c
> index 61e44a1949..fe5a9b4a98 100755
> --- a/block/blkreplay.c
> +++ b/block/blkreplay.c
> @@ -129,10 +129,9 @@ static int coroutine_fn blkreplay_co_flush(BlockDriverState *bs)
> 
>  static BlockDriver bdrv_blkreplay = {
>      .format_name            = "blkreplay",
> -    .protocol_name          = "blkreplay",
>      .instance_size          = 0,
> 
> -    .bdrv_file_open         = blkreplay_open,
> +    .bdrv_open              = blkreplay_open,
>      .bdrv_close             = blkreplay_close,
>      .bdrv_child_perm        = bdrv_filter_default_perms,
>      .bdrv_getlength         = blkreplay_getlength,
> --
> 2.13.6

Reviewed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>

Pavel Dovgalyuk
