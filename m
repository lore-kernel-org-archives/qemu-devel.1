Received: from eggs.gnu.org ([2001:4830:134:3::10]:34114)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1duIzA-0005iQ-9i
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 09:54:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1duIz6-0001R2-90
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 09:54:48 -0400
Received: from mail-wm0-f45.google.com ([74.125.82.45]:50824)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1duIz6-0001QZ-2R
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 09:54:44 -0400
Received: by mail-wm0-f45.google.com with SMTP id v142so79001wmv.5
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 06:54:43 -0700 (PDT)
References: <20170823162004.27337-1-marcandre.lureau@redhat.com>
	<20170823162004.27337-18-marcandre.lureau@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3a992294-f43c-ec40-b9c4-1ceb17169c84@redhat.com>
Date: Tue, 19 Sep 2017 15:54:40 +0200
MIME-Version: 1.0
In-Reply-To: <20170823162004.27337-18-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 17/27] vhost-user-scsi: remove
 unimplemented functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: changpeng.liu@intel.com, felipe@nutanix.com

On 23/08/2017 18:19, Marc-André Lureau wrote:
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  contrib/vhost-user-scsi/vhost-user-scsi.c | 21 +++------------------
>  1 file changed, 3 insertions(+), 18 deletions(-)
> 
> diff --git a/contrib/vhost-user-scsi/vhost-user-scsi.c b/contrib/vhost-user-scsi/vhost-user-scsi.c
> index 429e3065ea..882d887a32 100644
> --- a/contrib/vhost-user-scsi/vhost-user-scsi.c
> +++ b/contrib/vhost-user-scsi/vhost-user-scsi.c
> @@ -469,16 +469,6 @@ static void vus_del_watch_cb(VuDev *vu_dev, int fd)
>      }
>  }
>  
> -static void vus_proc_ctl(VuDev *vu_dev, int idx)
> -{
> -    /* Control VQ not implemented */
> -}
> -
> -static void vus_proc_evt(VuDev *vu_dev, int idx)
> -{
> -    /* Event VQ not implemented */
> -}
> -
>  static void vus_proc_req(VuDev *vu_dev, int idx)
>  {
>      vhost_scsi_dev_t *vdev_scsi;
> @@ -559,14 +549,9 @@ static void vus_queue_set_started(VuDev *vu_dev, int idx, bool started)
>  
>      vq = vu_get_queue(vu_dev, idx);
>  
> -    switch (idx) {
> -    case 0:
> -        vu_set_queue_handler(vu_dev, vq, started ? vus_proc_ctl : NULL);
> -        break;
> -    case 1:
> -        vu_set_queue_handler(vu_dev, vq, started ? vus_proc_evt : NULL);
> -        break;
> -    default:
> +    if (idx == 0 || idx == 1) {
> +        PDBG("queue %d unimplemented", idx);
> +    } else {
>          vu_set_queue_handler(vu_dev, vq, started ? vus_proc_req : NULL);
>      }
>  }
> 


Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
