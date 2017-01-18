Received: from eggs.gnu.org ([2001:4830:134:3::10]:46587)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cTlt5-000238-DU
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 03:46:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cTlt2-0005od-9N
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 03:46:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40416)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1cTlt2-0005nv-39
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 03:46:32 -0500
Date: Wed, 18 Jan 2017 09:46:28 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170118094628.7fe1ea33@nial.brq.redhat.com>
In-Reply-To: <91fadf23ab57b3accffc4af99083dfc8ada291fa.1484594095.git.ben@skyportsystems.com>
References: <cover.1484593565.git.ben@skyportsystems.com>
	<91fadf23ab57b3accffc4af99083dfc8ada291fa.1484594095.git.ben@skyportsystems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 6/6] PC: Support dynamic sysbus on
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
Cc: qemu-devel@nongnu.org

On Mon, 16 Jan 2017 11:20:58 -0800
ben@skyportsystems.com wrote:

> From: Ben Warren <ben@skyportsystems.com>
commit message should give a reason why it's need.

> 
> Signed-off-by: Ben Warren <ben@skyportsystems.com>
> ---
>  hw/i386/pc_piix.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index a54a468..8ac894c 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -435,6 +435,7 @@ static void pc_i440fx_machine_options(MachineClass *m)
>      m->hot_add_cpu = pc_hot_add_cpu;
>      m->default_machine_opts = "firmware=bios-256k.bin";
>      m->default_display = "std";
> +    m->has_dynamic_sysbus = true;
>  }
>  
>  static void pc_i440fx_2_8_machine_options(MachineClass *m)
