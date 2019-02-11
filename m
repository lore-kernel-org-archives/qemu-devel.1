Received: from eggs.gnu.org ([209.51.188.92]:38129)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gtFWj-0000AY-W3
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 12:37:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gtFWj-0005Dy-4D
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 12:37:53 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54279)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gtFWi-0004uG-Kh
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 12:37:52 -0500
Received: by mail-wm1-f68.google.com with SMTP id a62so73157wmh.4
	for <qemu-devel@nongnu.org>; Mon, 11 Feb 2019 09:37:35 -0800 (PST)
References: <1549694366-1284-1-git-send-email-thuth@redhat.com>
	<1549694366-1284-23-git-send-email-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <3d8e2191-12b2-ebdf-7e35-594d160653ec@redhat.com>
Date: Mon, 11 Feb 2019 18:37:32 +0100
MIME-Version: 1.0
In-Reply-To: <1549694366-1284-23-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 22/25] hw/arm: Express dependencies of
 nrf51 Kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: yang.zhong@intel.com, pbonzini@redhat.com, qemu-arm@nongnu.org

Hi Thomas,

On 2/9/19 7:39 AM, Thomas Huth wrote:
> Add Kconfig dependencies for the NRF51 / microbit machine.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  hw/arm/Kconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index c4b3cd2..aad2dd3 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -379,6 +379,8 @@ config FSL_IMX6UL
>  
>  config NRF51_SOC
>      bool
> +    select I2C
> +    select ARM_V7M

Don't we need a microbit config too?

config MICROBIT
    bool
    select NRF51_SOC

>  
>  config MSF2
>      bool
> 
