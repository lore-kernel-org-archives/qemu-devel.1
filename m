Received: from eggs.gnu.org ([208.118.235.92]:52453)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gf3Cn-0000EH-Om
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 08:38:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gf3Ci-00061g-Km
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 08:38:37 -0500
Received: from mail-wm1-f42.google.com ([209.85.128.42]:51723)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gf3Ch-0005zU-Fm
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 08:38:32 -0500
Received: by mail-wm1-f42.google.com with SMTP id b11so29303214wmj.1
	for <qemu-devel@nongnu.org>; Thu, 03 Jan 2019 05:38:28 -0800 (PST)
References: <20190103132605.49476-1-liq3ea@163.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <0cecbd74-2fe7-6bda-d92e-f7ba8e912800@redhat.com>
Date: Thu, 3 Jan 2019 14:38:25 +0100
MIME-Version: 1.0
In-Reply-To: <20190103132605.49476-1-liq3ea@163.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] usb: dev-mtp: fix memory leak in error path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@163.com>, kraxel@redhat.com
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org

On 1/3/19 2:26 PM, Li Qiang wrote:
> Spotted by Coverity: CID 1397074
> 

Gerd, if you take this, can you add:

Fixes: c52d46e041b

> Signed-off-by: Li Qiang <liq3ea@163.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  hw/usb/dev-mtp.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
> index 6098005cd4..b19b576278 100644
> --- a/hw/usb/dev-mtp.c
> +++ b/hw/usb/dev-mtp.c
> @@ -1729,6 +1729,7 @@ static void usb_mtp_write_metadata(MTPState *s, uint64_t dlen)
>      if (strchr(filename, '/')) {
>          usb_mtp_queue_result(s, RES_PARAMETER_NOT_SUPPORTED, d->trans,
>                               0, 0, 0, 0);
> +        g_free(filename);
>          return;
>      }
>  
> 
