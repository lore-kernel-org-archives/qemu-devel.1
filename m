Received: from eggs.gnu.org ([2001:4830:134:3::10]:34562)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dimWV-00030H-Md
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 15:01:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dimWS-0000Ap-LI
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 15:01:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52402)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dimWS-00009O-GC
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 15:01:32 -0400
Date: Fri, 18 Aug 2017 16:01:26 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170818190126.GD27715@localhost.localdomain>
References: <1502841979-6233-1-git-send-email-tianyu.lan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1502841979-6233-1-git-send-email-tianyu.lan@intel.com>
Subject: Re: [Qemu-devel] [PATCH v3 1/2] pc: add 2.11 machine type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Lan Tianyu <tianyu.lan@intel.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, rkrcmar@redhat.com, pbonzini@redhat.com, rth@twiddle.net, Laurent Vivier <lvivier@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On Tue, Aug 15, 2017 at 08:06:18PM -0400, Lan Tianyu wrote:
> Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
> ---
>  hw/i386/pc_piix.c    | 14 +++++++++++---
>  hw/i386/pc_q35.c     | 14 +++++++++++---
>  include/hw/compat.h  |  3 +++
>  include/hw/i386/pc.h |  3 +++
>  4 files changed, 28 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index 11b4336..e99ec8c 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -436,11 +436,21 @@ static void pc_i440fx_machine_options(MachineClass *m)
>      m->default_display = "std";
>  }
>  
> -static void pc_i440fx_2_10_machine_options(MachineClass *m)
> +static void pc_i440fx_2_11_machine_options(MachineClass *m)
>  {
>      pc_i440fx_machine_options(m);
>      m->alias = "pc";
>      m->is_default = 1;
> +}
> +
> +DEFINE_I440FX_MACHINE(v2_11, "pc-i440fx-2.11", NULL,
> +                      pc_i440fx_2_11_machine_options);
> +
> +static void pc_i440fx_2_10_machine_options(MachineClass *m)
> +{
> +    pc_i440fx_machine_options(m);
> +    m->is_default = 0;
> +    m->alias = NULL;
>      m->numa_auto_assign_ram = numa_legacy_auto_assign_ram;

Interesting, this was supposed to be in
pc_i440fx_2_9_machine_options() (see commit 3bfe5716 "numa:
equally distribute memory on nodes"), but the merge commit
adb354dd ("Merge remote-tracking branch 'mst/tags/for_upstream'
into staging") moved it to the pc_i440fx_2_10_machine_options().

I will submit a fix for -rc4 ASAP.

-- 
Eduardo
