Received: from eggs.gnu.org ([2001:4830:134:3::10]:39603)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dkZo1-00008O-6i
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 13:51:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dkZny-0006Aw-5P
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 13:51:05 -0400
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:34554)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dkZny-0006Ah-1B
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 13:51:02 -0400
Received: by mail-qk0-x241.google.com with SMTP id s3so225049qkd.1
	for <qemu-devel@nongnu.org>; Wed, 23 Aug 2017 10:51:01 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170823162004.27337-1-marcandre.lureau@redhat.com>
	<20170823162004.27337-5-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <000ec010-9c82-149f-5de0-6fcf193512df@amsat.org>
Date: Wed, 23 Aug 2017 14:50:57 -0300
MIME-Version: 1.0
In-Reply-To: <20170823162004.27337-5-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 04/27] vhost-user-scsi: use g_strdup()
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
> Since vhost-user-scsi uses glib.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>   contrib/vhost-user-scsi/vhost-user-scsi.c | 12 ++++--------
>   1 file changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/contrib/vhost-user-scsi/vhost-user-scsi.c b/contrib/vhost-user-scsi/vhost-user-scsi.c
> index 78bcc65f5a..1fb57da2da 100644
> --- a/contrib/vhost-user-scsi/vhost-user-scsi.c
> +++ b/contrib/vhost-user-scsi/vhost-user-scsi.c
> @@ -822,10 +822,10 @@ int main(int argc, char **argv)
>           case 'h':
>               goto help;
>           case 'u':
> -            unix_fn = strdup(optarg);
> +            unix_fn = g_strdup(optarg);
>               break;
>           case 'i':
> -            iscsi_uri = strdup(optarg);
> +            iscsi_uri = g_strdup(optarg);
>               break;
>           default:
>               goto help;
> @@ -854,12 +854,8 @@ out:
>           vdev_scsi_deinit(vdev_scsi);
>           free(vdev_scsi);
>       }
> -    if (unix_fn) {
> -        free(unix_fn);
> -    }
> -    if (iscsi_uri) {
> -        free(iscsi_uri);
> -    }
> +    g_free(unix_fn);
> +    g_free(iscsi_uri);
>   
>       return err;
>   
> 
