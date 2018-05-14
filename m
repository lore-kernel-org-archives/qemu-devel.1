Received: from eggs.gnu.org ([2001:4830:134:3::10]:41806)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fIFe7-0004sS-GM
	for qemu-devel@nongnu.org; Mon, 14 May 2018 11:44:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fIFe6-0000Qt-NS
	for qemu-devel@nongnu.org; Mon, 14 May 2018 11:44:19 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:43032)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fIFe6-0000Qh-J7
	for qemu-devel@nongnu.org; Mon, 14 May 2018 11:44:18 -0400
Received: by mail-qt0-x242.google.com with SMTP id f13-v6so16676732qtp.10
	for <qemu-devel@nongnu.org>; Mon, 14 May 2018 08:44:18 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180512014801.17566-1-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <dbfbdc18-99a2-83ac-4670-322bcba7e0ff@amsat.org>
Date: Mon, 14 May 2018 12:44:14 -0300
MIME-Version: 1.0
In-Reply-To: <20180512014801.17566-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 1/2] hw/virtio: Fix brace Werror with clang
 6.0.0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>

On 05/11/2018 10:48 PM, Richard Henderson wrote:
> The warning is
> 
> hw/virtio/vhost-user.c:1319:26: error: suggest braces
>       around initialization of subobject [-Werror,-Wmissing-braces]
>     VhostUserMsg msg = { 0 };
>                          ^
>                          {}
> 
> While the original code is correct, and technically exactly correct
> as per ISO C89, both GCC and Clang support plain empty set of braces
> as an extension.
> 
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/virtio/vhost-user.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index 38da8692bb..b455fca394 100644
> --- a/hw/virtio/vhost-user.c
> +++ b/hw/virtio/vhost-user.c
> @@ -1316,7 +1316,7 @@ static bool vhost_user_requires_shm_log(struct vhost_dev *dev)
>  
>  static int vhost_user_migration_done(struct vhost_dev *dev, char* mac_addr)
>  {
> -    VhostUserMsg msg = { 0 };
> +    VhostUserMsg msg = { };
>  
>      assert(dev->vhost_ops->backend_type == VHOST_BACKEND_TYPE_USER);
>  
> 
