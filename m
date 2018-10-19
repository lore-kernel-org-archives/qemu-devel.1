Received: from eggs.gnu.org ([2001:4830:134:3::10]:41453)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1gDXqD-0002Qv-V4
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 12:41:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1gDXqD-0001ye-7W
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 12:41:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48526)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eric.auger@redhat.com>)
	id 1gDXqB-0001qS-Qa
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 12:41:35 -0400
References: <1539926412-21831-1-git-send-email-liq3ea@gmail.com>
	<1539926412-21831-5-git-send-email-liq3ea@gmail.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <40678697-be58-af17-0a1f-5195ed108614@redhat.com>
Date: Fri, 19 Oct 2018 18:41:23 +0200
MIME-Version: 1.0
In-Reply-To: <1539926412-21831-5-git-send-email-liq3ea@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 4/7] vfio: paltform: fix a typo
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@gmail.com>, alex.williamson@redhat.com
Cc: philmd@redhat.com, qemu-devel@nongnu.org

Hi,

On 10/19/18 7:20 AM, Li Qiang wrote:
> Signed-off-by: Li Qiang <liq3ea@gmail.com>
> ---
>  hw/vfio/platform.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/vfio/platform.c b/hw/vfio/platform.c
> index ba03dcd..5992fe7 100644
> --- a/hw/vfio/platform.c
> +++ b/hw/vfio/platform.c
> @@ -72,7 +72,7 @@ static VFIOINTp *vfio_init_intp(VFIODevice *vbasedev,
>          g_free(intp->interrupt);
>          g_free(intp);
>          error_setg_errno(errp, -ret,
> -                         "failed to initialize trigger eventd notifier");
> +                         "failed to initialize trigger eventfd notifier");
>          return NULL;
>      }
>      if (vfio_irq_is_automasked(intp)) {
> @@ -84,7 +84,7 @@ static VFIOINTp *vfio_init_intp(VFIODevice *vbasedev,
>              g_free(intp->unmask);
>              g_free(intp);
>              error_setg_errno(errp, -ret,
> -                             "failed to initialize resample eventd notifier");
> +                             "failed to initialize resample eventfd notifier");
>              return NULL;
>          }
>      }
> 
s/palform/platform in the commit message.

Besides
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric
