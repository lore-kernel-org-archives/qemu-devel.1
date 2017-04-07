Received: from eggs.gnu.org ([2001:4830:134:3::10]:48763)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sahid.ferdjaoui@redhat.com>) id 1cwPWO-0001C4-6O
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 04:45:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sahid.ferdjaoui@redhat.com>) id 1cwPWK-0002D9-Rb
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 04:45:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35402)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sahid.ferdjaoui@redhat.com>)
	id 1cwPWK-0002Cz-LU
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 04:45:28 -0400
Date: Fri, 7 Apr 2017 10:45:24 +0200
From: Sahid Orentino Ferdjaoui <sferdjao@redhat.com>
Message-ID: <20170407084524.GB26482@redhat>
References: <1491548338-15128-1-git-send-email-weiqi4@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1491548338-15128-1-git-send-email-weiqi4@huawei.com>
Subject: Re: [Qemu-devel] [PATCH 2/3] vnc: simple clean up
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: weiqi <weiqi4@huawei.com>
Cc: kraxel@redhat.com, arei.gonglei@huawei.com, qemu-devel@nongnu.org

On Fri, Apr 07, 2017 at 02:58:58PM +0800, weiqi wrote:
> From: Wei Qi <weiqi4@huawei.com>
> 
> It is unnecessary to assign 'packed_bytes' to 'estimated_bytes', because 'estimated_bytes' unused after assignment.
> 
> Signed-off-by: Wei Qi <weiqi4@huawei.com>
> ---
>  ui/vnc-enc-zrle.c | 1 -
>  1 file changed, 1 deletion(-)

Reviewed-By: Sahid Orentino Ferdjaoui <sahid.ferdjaoui@redhat.com>

> 
> diff --git a/ui/vnc-enc-zrle.c b/ui/vnc-enc-zrle.c
> index 5489870..fd63d4f 100644
> --- a/ui/vnc-enc-zrle.c
> +++ b/ui/vnc-enc-zrle.c
> @@ -163,7 +163,6 @@ static void zrle_choose_palette_rle(VncState *vs, int w, int h,
>              if (packed_bytes < estimated_bytes) {
>                  *use_rle = false;
>                  *use_palette = true;
> -                estimated_bytes = packed_bytes;

I verified that 'estimated_bytes' is well a local variable defined in
'zrle_choose_palette_rle(...)'.

>              }
>          }
>      }
> -- 
> 1.8.3.1
> 
> 
