Received: from eggs.gnu.org ([2001:4830:134:3::10]:56915)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cWKW0-0007vX-FK
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 05:09:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cWKVz-0000i0-Jx
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 05:09:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38290)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1cWKVz-0000hu-EZ
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 05:09:19 -0500
References: <cover.1485308342.git.ben@skyportsystems.com>
	<5c6a8bfb4e36acec297d39e2381cb5ed022265f1.1485308342.git.ben@skyportsystems.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <377c645f-d57b-2bd1-6a65-11b62f5e5a1c@redhat.com>
Date: Wed, 25 Jan 2017 11:09:16 +0100
MIME-Version: 1.0
In-Reply-To: <5c6a8bfb4e36acec297d39e2381cb5ed022265f1.1485308342.git.ben@skyportsystems.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 7/9] PC: Support dynamic sysbus on
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

On 01/25/17 02:43, ben@skyportsystems.com wrote:
> From: Ben Warren <ben@skyportsystems.com>
> 
> This allows pc_i440fx-based machines to add new devices such as VM Generation ID
> directly to the sysbus.
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
> 

Looks reasonable to me, especially that Q35 already sets it.

One nit: please wrap the commit message at 74 chars.

I'll let others review the rest of the patches. (My interest lies in the
ACPI & fw_cfg bits.)

Thanks!
Laszlo
