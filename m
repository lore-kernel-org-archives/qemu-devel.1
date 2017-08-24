Received: from eggs.gnu.org ([2001:4830:134:3::10]:52877)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dkfga-0004hT-ES
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 20:07:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dkfgV-0005ln-Gk
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 20:07:48 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:35231)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dkfgV-0005lf-Ca
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 20:07:43 -0400
Received: by mail-qt0-x242.google.com with SMTP id r28so961114qte.2
	for <qemu-devel@nongnu.org>; Wed, 23 Aug 2017 17:07:43 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170823162004.27337-1-marcandre.lureau@redhat.com>
	<20170823162004.27337-20-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <4a862953-2e46-5314-73bb-7e524bb48316@amsat.org>
Date: Wed, 23 Aug 2017 21:07:38 -0300
MIME-Version: 1.0
In-Reply-To: <20170823162004.27337-20-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 19/27] vhost-user-scsi: avoid use of iscsi_
 namespace
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
> It is confusing and could easily conflict with future versions.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>   contrib/vhost-user-scsi/vhost-user-scsi.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/contrib/vhost-user-scsi/vhost-user-scsi.c b/contrib/vhost-user-scsi/vhost-user-scsi.c
> index 2ceca964f4..2ab14f1a83 100644
> --- a/contrib/vhost-user-scsi/vhost-user-scsi.c
> +++ b/contrib/vhost-user-scsi/vhost-user-scsi.c
> @@ -245,7 +245,7 @@ struct scsi_task {
>   
>   /** libiscsi integration **/
>   
> -static int iscsi_add_lun(VusIscsiLun *lun, char *iscsi_uri)
> +static int vus_iscsi_add_lun(VusIscsiLun *lun, char *iscsi_uri)
>   {
>       struct iscsi_url *iscsi_url;
>       struct iscsi_context *iscsi_ctx;
> @@ -705,7 +705,7 @@ int main(int argc, char **argv)
>       }
>       vdev_scsi = vdev_scsi_new(sock);
>   
> -    if (iscsi_add_lun(&vdev_scsi->lun, iscsi_uri) != 0) {
> +    if (vus_iscsi_add_lun(&vdev_scsi->lun, iscsi_uri) != 0) {
>           goto err;
>       }
>   
> 
