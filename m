Received: from eggs.gnu.org ([2001:4830:134:3::10]:35625)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cq3JZ-0005J6-0X
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 15:50:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cq3JV-0006dp-U4
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 15:50:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59224)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cq3JV-0006db-NE
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 15:49:57 -0400
Date: Mon, 20 Mar 2017 16:49:53 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170320194953.GF2811@thinpad.lan.raisama.net>
References: <1489750157-17401-1-git-send-email-tianyu.lan@intel.com>
	<1489750157-17401-2-git-send-email-tianyu.lan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1489750157-17401-2-git-send-email-tianyu.lan@intel.com>
Subject: Re: [Qemu-devel] [RFC PATCH 1/4] I440: Allow adding sysbus devices
 with -device on I440
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Lan Tianyu <tianyu.lan@intel.com>
Cc: qemu-devel@nongnu.org, chao.gao@intel.com, kevin.tian@intel.com, pbonzini@redhat.com, rth@twiddle.net, mst@redhat.com

On Fri, Mar 17, 2017 at 07:29:14PM +0800, Lan Tianyu wrote:
> From: Chao Gao <chao.gao@intel.com>
> 
> xen-viommu will be a sysbus device and the device model will
> be enabled via "-device" parameter.
> 
> Signed-off-by: Chao Gao <chao.gao@intel.com>
> Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>

I'm worried about the bugs we may expose by accepting all the
other sysbus devices in the command-line in addition to
xen-viommu.

I am working on a RFC to replace "has_dynamic_sysbus" with a
whitelist of sysbus device classes. This way we could enable only
xen-viommu on i440fx, instead of suddenly enabling all sysbus
devices just because of xen-viommu.

> ---
>  hw/i386/pc_piix.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index a07dc81..3289593 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -436,6 +436,7 @@ static void pc_i440fx_machine_options(MachineClass *m)
>      m->hot_add_cpu = pc_hot_add_cpu;
>      m->default_machine_opts = "firmware=bios-256k.bin";
>      m->default_display = "std";
> +    m->has_dynamic_sysbus = true;
>  }
>  
>  static void pc_i440fx_2_7_machine_options(MachineClass *m)
> -- 
> 1.8.3.1
> 

-- 
Eduardo
