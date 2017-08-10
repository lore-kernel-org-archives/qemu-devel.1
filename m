Received: from eggs.gnu.org ([2001:4830:134:3::10]:34403)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <konrad.wilk@oracle.com>) id 1dfrtA-0000Z7-6I
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 14:08:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <konrad.wilk@oracle.com>) id 1dfrt7-0006UF-Hb
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 14:08:56 -0400
Received: from userp1040.oracle.com ([156.151.31.81]:48907)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <konrad.wilk@oracle.com>)
	id 1dfrt7-0006S7-6k
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 14:08:53 -0400
Date: Thu, 10 Aug 2017 14:08:38 -0400
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Message-ID: <20170810180838.GS2547@char.us.oracle.com>
References: <1502337500-5718-1-git-send-email-tianyu.lan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1502337500-5718-1-git-send-email-tianyu.lan@intel.com>
Subject: Re: [Qemu-devel] [PATCH] x86: Increase max vcpu number to 352
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Lan Tianyu <tianyu.lan@intel.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, mst@redhat.com

On Wed, Aug 09, 2017 at 11:58:20PM -0400, Lan Tianyu wrote:
> Intel Xeon phi chip will support 352 logical threads. For HPC
> usage case, it will create a huge VM with vcpus number as same as host
> cpus. This patch is to increase max vcpu number to 352.

There is this ioctl called KVM_CAP_MAX_VCPUS. Why not use that?

Oh wait, this is generic code. Perhaps there is a way to make
this more abstract? Where this information is provided via
an function to which various accelerators register?

> 
> Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
> ---
>  hw/i386/pc_q35.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
> index 169a214..5e93749 100644
> --- a/hw/i386/pc_q35.c
> +++ b/hw/i386/pc_q35.c
> @@ -299,7 +299,7 @@ static void pc_q35_machine_options(MachineClass *m)
>      m->default_display = "std";
>      m->no_floppy = 1;
>      m->has_dynamic_sysbus = true;
> -    m->max_cpus = 288;
> +    m->max_cpus = 352;
>  }
>  
>  static void pc_q35_2_10_machine_options(MachineClass *m)
> -- 
> 1.8.3.1
> 
> 
