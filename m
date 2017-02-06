Received: from eggs.gnu.org ([2001:4830:134:3::10]:57822)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1camCZ-0000gO-Ld
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 11:31:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1camCU-0004IP-Qq
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 11:31:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41168)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1camCU-0004I9-M0
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 11:31:34 -0500
Date: Mon, 6 Feb 2017 18:31:33 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170206182941-mutt-send-email-mst@kernel.org>
References: <cover.1486285434.git.ben@skyportsystems.com>
	<a0d502ddafd0bb57633d863c8b2d89693ad5b06f.1486285434.git.ben@skyportsystems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a0d502ddafd0bb57633d863c8b2d89693ad5b06f.1486285434.git.ben@skyportsystems.com>
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
Cc: qemu-devel@nongnu.org, lersek@redhat.com, imammedo@redhat.com, Marcel Apfelbaum <marcel.a@redhat.com>

On Sun, Feb 05, 2017 at 01:12:03AM -0800, ben@skyportsystems.com wrote:
> From: Ben Warren <ben@skyportsystems.com>
> 
> This allows pc_i440fx-based machines to add new devices such as
> VM Generation ID directly to the sysbus.
> 
> Signed-off-by: Ben Warren <ben@skyportsystems.com>

Only point is, we might have to add more flags like
cannot_instantiate_with_device_add_yet
to a bunch of devices.

Marcel, you did a similar thing for q35, can you
take a look here as well pls?

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
> -- 
> 2.7.4
