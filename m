Received: from eggs.gnu.org ([2001:4830:134:3::10]:48467)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fmYPP-0003um-6A
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 01:50:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fmYPL-0008Uc-QE
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 01:50:23 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43648 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fmYPL-0008UW-Je
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 01:50:19 -0400
References: <20180805112850.26063-1-mark.cave-ayland@ilande.co.uk>
	<20180805112850.26063-3-mark.cave-ayland@ilande.co.uk>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <ebc16b0b-d318-119a-4d89-6e84c0c9df57@redhat.com>
Date: Mon, 6 Aug 2018 07:50:17 +0200
MIME-Version: 1.0
In-Reply-To: <20180805112850.26063-3-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/2] fw_cfg: set the
 get_boot_devices_list() ignore_suffixes parameter from machine property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, ehabkost@redhat.com, marcel.apfelbaum@gmail.com, lersek@redhat.com, qemu-devel@nongnu.org

On 08/05/2018 01:28 PM, Mark Cave-Ayland wrote:
> For the older machines (such as Mac and SPARC) the DT nodes representing
> bootdevices for disk nodes are irregular for mainly historical reasons, and
> should be handled on an individual basis via a custom FWPathProvider.
> 
> Since the majority of bootdevice nodes for these machines either do not have a
> separate disk node or require different (custom) names then it is much easier
> to allow the ignore_suffixes parameter to be set on a per-machine basis via
> a machine property.
> 
> The default value for this new fwcfg_bootdevice_ignore_suffixes machine
> property is false to preserve compatibility for existing machines.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  hw/core/machine.c   | 3 +++
>  hw/nvram/fw_cfg.c   | 5 ++++-
>  include/hw/boards.h | 1 +
>  3 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index a9aeb22f03..fbadb35865 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -525,6 +525,9 @@ static void machine_class_init(ObjectClass *oc, void *data)
>      mc->default_ram_size = 128 * MiB;
>      mc->rom_file_has_mr = true;
>  
> +    /* Default to using fwcfg bootdevice suffixes */
> +    mc->fwcfg_bootdevice_ignore_suffixes = false;

I guess you could omit this line since the memory for the machine class
is pre-initialized to zero. Anyway:

Reviewed-by: Thomas Huth <thuth@redhat.com>
