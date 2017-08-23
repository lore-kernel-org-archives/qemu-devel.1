Received: from eggs.gnu.org ([2001:4830:134:3::10]:41333)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dkZuh-0003l0-Aw
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 13:58:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dkZug-0001tr-Bx
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 13:57:59 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:34562)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dkZug-0001tL-7Z
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 13:57:58 -0400
Received: by mail-qt0-x244.google.com with SMTP id f63so232099qtb.1
	for <qemu-devel@nongnu.org>; Wed, 23 Aug 2017 10:57:58 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170823162004.27337-1-marcandre.lureau@redhat.com>
	<20170823162004.27337-16-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <cf442c53-aec4-8b40-8507-9403364514b5@amsat.org>
Date: Wed, 23 Aug 2017 14:57:53 -0300
MIME-Version: 1.0
In-Reply-To: <20170823162004.27337-16-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 15/27] vhost-user-scsi: remove
 vdev_scsi_add_iscsi_lun()
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
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>   contrib/vhost-user-scsi/vhost-user-scsi.c | 16 +---------------
>   1 file changed, 1 insertion(+), 15 deletions(-)
> 
> diff --git a/contrib/vhost-user-scsi/vhost-user-scsi.c b/contrib/vhost-user-scsi/vhost-user-scsi.c
> index 988417393f..f6f9e7b192 100644
> --- a/contrib/vhost-user-scsi/vhost-user-scsi.c
> +++ b/contrib/vhost-user-scsi/vhost-user-scsi.c
> @@ -658,20 +658,6 @@ static vhost_scsi_dev_t *vdev_scsi_new(int server_sock)
>       return vdev_scsi;
>   }
>   
> -static int vdev_scsi_add_iscsi_lun(vhost_scsi_dev_t *vdev_scsi,
> -                                   char *iscsi_uri, uint32_t lun)
> -{
> -    assert(vdev_scsi);
> -    assert(iscsi_uri);
> -    assert(lun < VUS_MAX_LUNS);
> -
> -    if (iscsi_add_lun(&vdev_scsi->luns[lun], iscsi_uri) != 0) {
> -        return -1;
> -    }
> -
> -    return 0;
> -}
> -
>   static int vdev_scsi_run(vhost_scsi_dev_t *vdev_scsi)
>   {
>       GIOChannel *chan;
> @@ -736,7 +722,7 @@ int main(int argc, char **argv)
>       }
>       vdev_scsi = vdev_scsi_new(sock);
>   
> -    if (vdev_scsi_add_iscsi_lun(vdev_scsi, iscsi_uri, 0) != 0) {
> +    if (iscsi_add_lun(&vdev_scsi->luns[0], iscsi_uri) != 0) {
>           goto err;
>       }
>   
> 
