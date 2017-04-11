Received: from eggs.gnu.org ([2001:4830:134:3::10]:36284)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cxlwE-0001Gc-Lj
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 22:53:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cxlwB-0005lt-Lk
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 22:53:50 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:36487)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cxlwB-0005lh-GG
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 22:53:47 -0400
Received: by mail-qk0-x242.google.com with SMTP id v75so22491786qkb.3
	for <qemu-devel@nongnu.org>; Mon, 10 Apr 2017 19:53:47 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170316092121.25672-1-marcandre.lureau@redhat.com>
	<20170316092121.25672-5-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <004f03e1-176c-7984-c8f8-9203b081c29d@amsat.org>
Date: Mon, 10 Apr 2017 23:53:43 -0300
MIME-Version: 1.0
In-Reply-To: <20170316092121.25672-5-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 04/21] container: don't leak container
 reference
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com

On 03/16/2017 06:21 AM, Marc-André Lureau wrote:
> object_property_add_child() references the child, unref it after to
> avoid ref leaks.
>
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  qom/container.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/qom/container.c b/qom/container.c
> index c9eb49b01e..f6ccaf7ea7 100644
> --- a/qom/container.c
> +++ b/qom/container.c
> @@ -40,6 +40,7 @@ Object *container_get(Object *root, const char *path)
>          if (!child) {
>              child = object_new("container");
>              object_property_add_child(obj, parts[i], child, NULL);
> +            object_unref(child);
>          }
>      }
>
>
