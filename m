Received: from eggs.gnu.org ([2001:4830:134:3::10]:43159)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1drkCj-0003Io-KY
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 08:22:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1drkCf-0002Hi-9g
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 08:22:13 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:34458)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1drkCf-0002H7-6N
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 08:22:09 -0400
Received: by mail-qt0-x242.google.com with SMTP id q8so7234307qtb.1
	for <qemu-devel@nongnu.org>; Tue, 12 Sep 2017 05:22:09 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170823162004.27337-1-marcandre.lureau@redhat.com>
	<20170823162004.27337-2-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <44c779e6-e50d-f111-3b3f-3f416884d8f4@amsat.org>
Date: Tue, 12 Sep 2017 09:22:04 -0300
MIME-Version: 1.0
In-Reply-To: <20170823162004.27337-2-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 01/27] glib-compat: move
 G_SOURCE_CONTINUE/REMOVE there
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

Acked-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>   include/glib-compat.h                     | 7 +++++++
>   contrib/vhost-user-scsi/vhost-user-scsi.c | 8 --------
>   2 files changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/include/glib-compat.h b/include/glib-compat.h
> index fcffcd3f07..d35d641b7f 100644
> --- a/include/glib-compat.h
> +++ b/include/glib-compat.h
> @@ -354,5 +354,12 @@ g_test_add_data_func_full(const char *path,
>   }
>   #endif
>   
> +/* Small compat shim from glib 2.32 */
> +#ifndef G_SOURCE_CONTINUE
> +#define G_SOURCE_CONTINUE TRUE
> +#endif
> +#ifndef G_SOURCE_REMOVE
> +#define G_SOURCE_REMOVE FALSE
> +#endif
>   
>   #endif
> diff --git a/contrib/vhost-user-scsi/vhost-user-scsi.c b/contrib/vhost-user-scsi/vhost-user-scsi.c
> index b5ae02c96f..78bcc65f5a 100644
> --- a/contrib/vhost-user-scsi/vhost-user-scsi.c
> +++ b/contrib/vhost-user-scsi/vhost-user-scsi.c
> @@ -17,14 +17,6 @@
>   
>   #include <glib.h>
>   
> -/* Small compat shim from glib 2.32 */
> -#ifndef G_SOURCE_CONTINUE
> -#define G_SOURCE_CONTINUE TRUE
> -#endif
> -#ifndef G_SOURCE_REMOVE
> -#define G_SOURCE_REMOVE FALSE
> -#endif
> -
>   /* #define VUS_DEBUG 1 */
>   
>   /** Log helpers **/
> 
