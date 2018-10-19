Received: from eggs.gnu.org ([2001:4830:134:3::10]:44994)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gDNGD-0006pV-2M
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 01:23:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gDNG9-0006Hu-KL
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 01:23:44 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45011)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gDNG9-0006D5-3v
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 01:23:41 -0400
Received: by mail-wr1-f67.google.com with SMTP id 63-v6so35939169wra.11
	for <qemu-devel@nongnu.org>; Thu, 18 Oct 2018 22:23:40 -0700 (PDT)
References: <1539926412-21831-1-git-send-email-liq3ea@gmail.com>
	<1539926412-21831-5-git-send-email-liq3ea@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <eb60be2d-6f7c-3db9-721f-c18880452067@redhat.com>
Date: Fri, 19 Oct 2018 07:23:37 +0200
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
Cc: qemu-devel@nongnu.org

On 19/10/2018 07:20, Li Qiang wrote:
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

There is another in "sysemu/kvm.h".
