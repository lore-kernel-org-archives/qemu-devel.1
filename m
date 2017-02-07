Received: from eggs.gnu.org ([2001:4830:134:3::10]:37760)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cb6P9-0002bU-DX
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 09:06:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cb6P5-0007Wl-FV
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 09:05:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41486)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1cb6P5-0007W9-9a
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 09:05:55 -0500
Date: Tue, 7 Feb 2017 15:05:51 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170207150551.5c215384@nial.brq.redhat.com>
In-Reply-To: <a0d502ddafd0bb57633d863c8b2d89693ad5b06f.1486285434.git.ben@skyportsystems.com>
References: <cover.1486285434.git.ben@skyportsystems.com>
	<a0d502ddafd0bb57633d863c8b2d89693ad5b06f.1486285434.git.ben@skyportsystems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 08/10] PC: Support dynamic sysbus on
 pc_i440fx
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: ben@skyportsystems.com
Cc: qemu-devel@nongnu.org, lersek@redhat.com, mst@redhat.com

On Sun,  5 Feb 2017 01:12:03 -0800
ben@skyportsystems.com wrote:

> From: Ben Warren <ben@skyportsystems.com>
> 
> This allows pc_i440fx-based machines to add new devices such as
> VM Generation ID directly to the sysbus.
> 
> Signed-off-by: Ben Warren <ben@skyportsystems.com>
> ---
>  hw/i386/pc_piix.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index 9f102aa..c8ad99c 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -435,6 +435,7 @@ static void pc_i440fx_machine_options(MachineClass *m)
>      m->hot_add_cpu = pc_hot_add_cpu;
>      m->default_machine_opts = "firmware=bios-256k.bin";
>      m->default_display = "std";
> +    m->has_dynamic_sysbus = true;
>  }
>  
>  static void pc_i440fx_2_9_machine_options(MachineClass *m)
since vmgenid device doesn't need any external wiring by board
-device probably would also work if it's inherited from plain Device
