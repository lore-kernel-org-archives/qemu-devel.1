Received: from eggs.gnu.org ([209.51.188.92]:54864)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gosoe-0006x7-Fe
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 11:34:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gosod-0008AM-MJ
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 11:34:20 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40144)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gosod-00089k-Ga
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 11:34:19 -0500
Received: by mail-wm1-f67.google.com with SMTP id f188so167072wmf.5
	for <qemu-devel@nongnu.org>; Wed, 30 Jan 2019 08:34:19 -0800 (PST)
References: <1548863140-31975-1-git-send-email-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <51a8dddf-7f14-10b9-2509-dc9acdf56a02@redhat.com>
Date: Wed, 30 Jan 2019 17:34:16 +0100
MIME-Version: 1.0
In-Reply-To: <1548863140-31975-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] MAINTAINERS: XIVE is an interrupt
 controller, not a machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Cc: qemu-devel@nongnu.org

On 1/30/19 4:45 PM, Thomas Huth wrote:
> The "XIVE" section is currently listed in the "PowerPC Machines"
> section, which is weird, since this is an interrupt controller
> device. Move it to the "Devices" section instead.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  MAINTAINERS | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b334b53..eac36b6 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1038,14 +1038,6 @@ F: tests/libqos/*spapr*
>  F: tests/rtas*
>  F: tests/libqos/rtas*
>  
> -XIVE
> -M: David Gibson <david@gibson.dropbear.id.au>
> -M: Cédric Le Goater <clg@kaod.org>
> -L: qemu-ppc@nongnu.org
> -S: Supported
> -F: hw/*/*xive*
> -F: include/hw/*/*xive*
> -
>  virtex_ml507
>  M: Edgar E. Iglesias <edgar.iglesias@gmail.com>
>  L: qemu-ppc@nongnu.org
> @@ -1645,6 +1637,14 @@ F: tests/libqos/fw_cfg.c
>  F: tests/fw_cfg-test.c
>  T: git https://github.com/philmd/qemu.git fw_cfg-next
>  
> +XIVE
> +M: David Gibson <david@gibson.dropbear.id.au>
> +M: Cédric Le Goater <clg@kaod.org>
> +L: qemu-ppc@nongnu.org
> +S: Supported
> +F: hw/*/*xive*

   F: hw/intc/*xive*

> +F: include/hw/*/*xive*

I'd expect them in /intc/ like the source, but they are in:

   F: include/hw/ppc/*xive*

> +
>  Subsystems
>  ----------
>  Audio
> 

With or without the paths updated:
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
