Received: from eggs.gnu.org ([2001:4830:134:3::10]:49661)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gShUU-0007v9-VY
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 07:01:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gShUP-00032O-A0
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 07:01:50 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53366)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gShUO-00031P-IU
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 07:01:45 -0500
Received: by mail-wm1-f67.google.com with SMTP id y1so5510813wmi.3
	for <qemu-devel@nongnu.org>; Fri, 30 Nov 2018 04:01:43 -0800 (PST)
References: <1543571638-2892-1-git-send-email-liq3ea@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <16fc13de-778b-430e-d734-bbc802d25ba8@redhat.com>
Date: Fri, 30 Nov 2018 13:01:39 +0100
MIME-Version: 1.0
In-Reply-To: <1543571638-2892-1-git-send-email-liq3ea@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] util: vfio-helpers: use ARRAY_SIZE in
 qemu_vfio_init_pci()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@gmail.com>, laurent@vivier.eu
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org

On 30/11/18 10:53, Li Qiang wrote:
> Cc: qemu-trivial@nongnu.org
> 
> Signed-off-by: Li Qiang <liq3ea@gmail.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  util/vfio-helpers.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/util/vfio-helpers.c b/util/vfio-helpers.c
> index cccc9cd42e..342d4a2285 100644
> --- a/util/vfio-helpers.c
> +++ b/util/vfio-helpers.c
> @@ -348,7 +348,7 @@ static int qemu_vfio_init_pci(QEMUVFIOState *s, const char *device,
>          goto fail;
>      }
>  
> -    for (i = 0; i < 6; i++) {
> +    for (i = 0; i < ARRAY_SIZE(s->bar_region_info); i++) {
>          ret = qemu_vfio_pci_init_bar(s, i, errp);
>          if (ret) {
>              goto fail;
> 
