Received: from eggs.gnu.org ([2001:4830:134:3::10]:50939)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1droEQ-0008AC-VC
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 12:40:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1droEN-0007hK-Mm
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 12:40:15 -0400
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:35795)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1droEN-0007gr-I0
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 12:40:11 -0400
Received: by mail-qk0-x244.google.com with SMTP id o77so7501482qke.2
	for <qemu-devel@nongnu.org>; Tue, 12 Sep 2017 09:40:11 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170823162004.27337-1-marcandre.lureau@redhat.com>
	<20170823162004.27337-10-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <8796d1dd-9ed8-dc10-0ebd-295b8e01c6cc@amsat.org>
Date: Tue, 12 Sep 2017 13:40:08 -0300
MIME-Version: 1.0
In-Reply-To: <20170823162004.27337-10-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 09/27] vhost-user-scsi: also free the gtree
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
>   contrib/vhost-user-scsi/vhost-user-scsi.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/contrib/vhost-user-scsi/vhost-user-scsi.c b/contrib/vhost-user-scsi/vhost-user-scsi.c
> index 5f8ff9d9e5..d0456a5e7c 100644
> --- a/contrib/vhost-user-scsi/vhost-user-scsi.c
> +++ b/contrib/vhost-user-scsi/vhost-user-scsi.c
> @@ -693,6 +693,7 @@ static void vdev_scsi_free(vhost_scsi_dev_t *vdev_scsi)
>       }
>   
>       g_main_loop_unref(vdev_scsi->loop);
> +    g_tree_destroy(vdev_scsi->fdmap);
>       g_free(vdev_scsi);
>   }
>   
> 
