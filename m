Received: from eggs.gnu.org ([209.51.188.92]:36953)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1ggsPP-0004MV-85
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 09:31:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1ggsPO-0002rQ-Ev
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 09:31:11 -0500
Received: from mail-wm1-f41.google.com ([209.85.128.41]:35317)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ggsPO-0002ik-8S
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 09:31:10 -0500
Received: by mail-wm1-f41.google.com with SMTP id t200so4631240wmt.0
	for <qemu-devel@nongnu.org>; Tue, 08 Jan 2019 06:31:07 -0800 (PST)
References: <20190108102301.1957-1-kraxel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <15165f29-ba5e-7320-10e1-d0987f8801f3@redhat.com>
Date: Tue, 8 Jan 2019 15:31:05 +0100
MIME-Version: 1.0
In-Reply-To: <20190108102301.1957-1-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] i2c-ddc: fix oob read
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: public@hansmi.ch

On 1/8/19 11:23 AM, Gerd Hoffmann wrote:
> Suggested-by: Michael Hanselmann <public@hansmi.ch>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  hw/i2c/i2c-ddc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/i2c/i2c-ddc.c b/hw/i2c/i2c-ddc.c
> index be34fe072c..0a0367ff38 100644
> --- a/hw/i2c/i2c-ddc.c
> +++ b/hw/i2c/i2c-ddc.c
> @@ -56,7 +56,7 @@ static int i2c_ddc_rx(I2CSlave *i2c)
>      I2CDDCState *s = I2CDDC(i2c);
>  
>      int value;
> -    value = s->edid_blob[s->reg];
> +    value = s->edid_blob[s->reg % sizeof(s->edid_blob)];
>      s->reg++;
>      return value;
>  }
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
