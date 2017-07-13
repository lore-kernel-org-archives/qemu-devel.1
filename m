Received: from eggs.gnu.org ([2001:4830:134:3::10]:53501)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dVciR-00049k-O6
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 07:55:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dVciO-0000FQ-M0
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 07:55:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40552)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dVciO-0000F2-FA
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 07:55:28 -0400
Date: Thu, 13 Jul 2017 13:55:22 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170713135522.3f39009e@gondolin>
In-Reply-To: <1499942429-55449-2-git-send-email-borntraeger@de.ibm.com>
References: <1499942429-55449-1-git-send-email-borntraeger@de.ibm.com>
	<1499942429-55449-2-git-send-email-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH/s390-next 1/3] s390x: initialize cpu firstly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, Yi Min Zhao <zyimin@linux.vnet.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Thomas Huth <thuth@redhat.com>

On Thu, 13 Jul 2017 12:40:27 +0200
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> From: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
> 
> By initializing the CPU firstly, we are able to retrieve and use the
> CPU model features when initializing other subsystem or devices.
> 
> Signed-off-by: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
> Reviewed-by: Pierre Morel<pmorel@linux.vnet.ibm.com>

Missing blank before address.

> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  hw/s390x/s390-virtio-ccw.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index e086cb5..23e9658 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -122,6 +122,9 @@ static void ccw_init(MachineState *machine)
>      s390_sclp_init();
>      s390_memory_init(machine->ram_size);
>  
> +    /* init CPUs */
> +    s390_init_cpus(machine);
> +
>      s390_flic_init();
>  
>      /* get a BUS */
> @@ -138,9 +141,6 @@ static void ccw_init(MachineState *machine)
>      /* register hypercalls */
>      virtio_ccw_register_hcalls();
>  
> -    /* init CPUs */
> -    s390_init_cpus(machine);
> -
>      if (kvm_enabled()) {
>          kvm_s390_enable_css_support(s390_cpu_addr2state(0));
>      }

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
