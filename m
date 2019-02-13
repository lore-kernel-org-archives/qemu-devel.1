Received: from eggs.gnu.org ([209.51.188.92]:54707)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gtscl-0004TY-4I
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 06:22:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gtsci-0005G8-Kt
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 06:22:42 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37229)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gtsci-00055a-FH
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 06:22:40 -0500
Received: by mail-wr1-f67.google.com with SMTP id c8so2048836wrs.4
	for <qemu-devel@nongnu.org>; Wed, 13 Feb 2019 03:22:26 -0800 (PST)
References: <1550041639-10232-1-git-send-email-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <baa367e4-459c-98cd-6a50-2a656a52ff54@redhat.com>
Date: Wed, 13 Feb 2019 12:22:22 +0100
MIME-Version: 1.0
In-Reply-To: <1550041639-10232-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] hw/sparc64: Explicitly set default_display
 = "std"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: Artyom Tarasenko <atar4qemu@gmail.com>, pbonzini@redhat.com, yang.zhong@intel.com, qemu-trivial@nongnu.org

On 2/13/19 8:07 AM, Thomas Huth wrote:
> The sun4uv_init() function expects vga_interface_type to be either
> VGA_STD or VGA_NONE and sets up a stdvga device or no vga card
> accordingly.
> However, the code in vl.c prefers the Cirrus VGA card to stdvga if
> it is available and the user and the machine did not specify anything
> else.
> So far this has not been a problem, since the Cirrus VGA was not linked
> into the sparc64 target. But with the upcoming Kconfig build system,
> all theoretically possible PCI cards will be enabled by default, so the
> Cirrus VGA card might become available on the sparc64 target, too. vl.c
> then picks the wrong card, causing sun4uv_init() to abort.
> Thus let's make it explicit that we always want stdvga for sparc64 and
> so set default_display = "std" for these machines.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  hw/sparc64/sun4u.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
> index ff24d9b..399f2d7 100644
> --- a/hw/sparc64/sun4u.c
> +++ b/hw/sparc64/sun4u.c
> @@ -797,6 +797,7 @@ static void sun4u_class_init(ObjectClass *oc, void *data)
>      mc->default_boot_order = "c";
>      mc->default_cpu_type = SPARC_CPU_TYPE_NAME("TI-UltraSparc-IIi");
>      mc->ignore_boot_device_suffixes = true;
> +    mc->default_display = "std";
>      fwc->get_dev_path = sun4u_fw_dev_path;
>  }
>  
> @@ -820,6 +821,7 @@ static void sun4v_class_init(ObjectClass *oc, void *data)
>      mc->max_cpus = 1; /* XXX for now */
>      mc->default_boot_order = "c";
>      mc->default_cpu_type = SPARC_CPU_TYPE_NAME("Sun-UltraSparc-T1");
> +    mc->default_display = "std";
>  }
>  
>  static const TypeInfo sun4v_type = {
> 
