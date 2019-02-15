Received: from eggs.gnu.org ([209.51.188.92]:46041)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gukGH-0000Wf-3u
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 15:39:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gukGE-0006m6-U2
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 15:39:03 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43295)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gukGE-0006lI-O6
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 15:39:02 -0500
Received: by mail-wr1-f66.google.com with SMTP id r2so11644783wrv.10
	for <qemu-devel@nongnu.org>; Fri, 15 Feb 2019 12:39:02 -0800 (PST)
References: <20190215162533.19475-1-paul.durrant@citrix.com>
	<20190215162533.19475-2-paul.durrant@citrix.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <9c6c6f2e-cac0-9e75-d5e2-baf613aad6b7@redhat.com>
Date: Fri, 15 Feb 2019 21:38:59 +0100
MIME-Version: 1.0
In-Reply-To: <20190215162533.19475-2-paul.durrant@citrix.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/3] dataplane/xen-block: remove dead code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paul Durrant <paul.durrant@citrix.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, xen-devel@lists.xenproject.org
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Stefano Stabellini <sstabellini@kernel.org>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Anthony Perard <anthony.perard@citrix.com>

On 2/15/19 5:25 PM, Paul Durrant wrote:
> The if() statement is clearly bogus (dead code which should have been
> cleaned up when grant mapping was removed).

"... was removed in 06454c24ad)."

> 
> Spotted by Coverity: CID 1398635
> 
> While in the neighbourhood, add a missing 'fall through' annotation.
> 
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
> ---
> Cc: Stefan Hajnoczi <stefanha@redhat.com>
> Cc: Stefano Stabellini <sstabellini@kernel.org>
> Cc: Anthony Perard <anthony.perard@citrix.com>
> Cc: Kevin Wolf <kwolf@redhat.com>
> Cc: Max Reitz <mreitz@redhat.com>
> ---
>  hw/block/dataplane/xen-block.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/hw/block/dataplane/xen-block.c b/hw/block/dataplane/xen-block.c
> index c6a15da024..f1523c5b45 100644
> --- a/hw/block/dataplane/xen-block.c
> +++ b/hw/block/dataplane/xen-block.c
> @@ -281,10 +281,6 @@ static void xen_block_complete_aio(void *opaque, int ret)
>          break;
>      case BLKIF_OP_WRITE:
>      case BLKIF_OP_FLUSH_DISKCACHE:
> -        if (!request->req.nr_segments) {
> -            break;
> -        }
> -        break;
>      default:
>          break;
>      }
> @@ -298,6 +294,7 @@ static void xen_block_complete_aio(void *opaque, int ret)
>          if (!request->req.nr_segments) {
>              break;
>          }
> +        /* fall through */
>      case BLKIF_OP_READ:
>          if (request->status == BLKIF_RSP_OKAY) {
>              block_acct_done(blk_get_stats(dataplane->blk), &request->acct);
> 
