Received: from eggs.gnu.org ([209.51.188.92]:44857)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gtuA4-0004ZG-VW
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 08:01:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gttuK-0003LR-1D
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 07:44:56 -0500
References: <1550041639-10232-1-git-send-email-thuth@redhat.com>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <72ad411d-d955-0988-f873-86322494b124@ilande.co.uk>
Date: Wed, 13 Feb 2019 12:44:35 +0000
MIME-Version: 1.0
In-Reply-To: <1550041639-10232-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
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
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Artyom Tarasenko <atar4qemu@gmail.com>, pbonzini@redhat.com, yang.zhong@intel.com, philmd@redhat.com, qemu-trivial@nongnu.org

On 13/02/2019 07:07, Thomas Huth wrote:

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

Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>


ATB,

Mark.
