Received: from eggs.gnu.org ([2001:4830:134:3::10]:40954)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dkZtq-00038e-6N
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 13:57:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dkZtn-0001XR-3i
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 13:57:06 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:33954)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dkZtm-0001XF-VT
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 13:57:03 -0400
Received: by mail-qk0-x242.google.com with SMTP id s3so239456qkd.1
	for <qemu-devel@nongnu.org>; Wed, 23 Aug 2017 10:57:02 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170823162004.27337-1-marcandre.lureau@redhat.com>
	<20170823162004.27337-15-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <5cecd4f2-0381-74f7-876d-578b45d7b07e@amsat.org>
Date: Wed, 23 Aug 2017 14:56:58 -0300
MIME-Version: 1.0
In-Reply-To: <20170823162004.27337-15-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 14/27] vhost-user-scsi: assert() in
 iscsi_add_lun()
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

On 08/23/2017 01:19 PM, Marc-André Lureau wrote:
> Instead of a preliminary check, add an assert to the function that has
> the pre-condition.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   contrib/vhost-user-scsi/vhost-user-scsi.c | 6 +-----
>   1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/contrib/vhost-user-scsi/vhost-user-scsi.c b/contrib/vhost-user-scsi/vhost-user-scsi.c
> index b40009e234..988417393f 100644
> --- a/contrib/vhost-user-scsi/vhost-user-scsi.c
> +++ b/contrib/vhost-user-scsi/vhost-user-scsi.c
> @@ -255,6 +255,7 @@ static int iscsi_add_lun(iscsi_lun_t *lun, char *iscsi_uri)
>   
>       assert(lun);
>       assert(iscsi_uri);
> +    assert(!lun->iscsi_ctx);
>   
>       iscsi_ctx = iscsi_create_context(VUS_ISCSI_INITIATOR);
>       if (!iscsi_ctx) {
> @@ -664,11 +665,6 @@ static int vdev_scsi_add_iscsi_lun(vhost_scsi_dev_t *vdev_scsi,
>       assert(iscsi_uri);
>       assert(lun < VUS_MAX_LUNS);
>   
> -    if (vdev_scsi->luns[lun].iscsi_ctx) {
> -        PERR("Lun %d already configured", lun);
> -        return -1;
> -    }

the error message is lost :/

anyway:
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> -
>       if (iscsi_add_lun(&vdev_scsi->luns[lun], iscsi_uri) != 0) {
>           return -1;
>       }
> 
