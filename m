Received: from eggs.gnu.org ([2001:4830:134:3::10]:54439)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gsomlo@gmail.com>) id 1e1Yw7-0007xf-DL
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 10:21:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gsomlo@gmail.com>) id 1e1Yw4-0004Il-4D
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 10:21:39 -0400
Date: Mon, 9 Oct 2017 10:21:32 -0400
From: "Gabriel L. Somlo" <gsomlo@gmail.com>
Message-ID: <20171009142130.GE8968@hedwig.ini.cmu.edu>
References: <20171006235023.11952-1-f4bug@amsat.org>
	<20171006235023.11952-55-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20171006235023.11952-55-f4bug@amsat.org>
Subject: Re: [Qemu-devel] [PATCH 54/88] KVM: use g_new() family of functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu trival <qemu-trivial@nongnu.org>

Reviewed-by: Gabriel Somlo <gsomlo@gmail.com>

On Fri, Oct 06, 2017 at 08:49:49PM -0300, Philippe Mathieu-Daudé wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> [PMD: more changes]
> ---
>  accel/kvm/kvm-all.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index 90c88b517d..12568d703c 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -278,7 +278,7 @@ int kvm_destroy_vcpu(CPUState *cpu)
>          goto err;
>      }
>  
> -    vcpu = g_malloc0(sizeof(*vcpu));
> +    vcpu = g_new0(struct KVMParkedVcpu, 1);
>      vcpu->vcpu_id = kvm_arch_vcpu_id(cpu);
>      vcpu->kvm_fd = cpu->kvm_fd;
>      QLIST_INSERT_HEAD(&kvm_state->kvm_parked_vcpus, vcpu, node);
> @@ -865,7 +865,7 @@ void kvm_memory_listener_register(KVMState *s, KVMMemoryListener *kml,
>  {
>      int i;
>  
> -    kml->slots = g_malloc0(s->nr_slots * sizeof(KVMSlot));
> +    kml->slots = g_new0(KVMSlot, s->nr_slots);
>      kml->as_id = as_id;
>  
>      for (i = 0; i < s->nr_slots; i++) {
> @@ -1129,7 +1129,7 @@ int kvm_irqchip_send_msi(KVMState *s, MSIMessage msg)
>              return virq;
>          }
>  
> -        route = g_malloc0(sizeof(KVMMSIRoute));
> +        route = g_new0(KVMMSIRoute, 1);
>          route->kroute.gsi = virq;
>          route->kroute.type = KVM_IRQ_ROUTING_MSI;
>          route->kroute.flags = 0;
> @@ -2243,7 +2243,7 @@ int kvm_insert_breakpoint(CPUState *cpu, target_ulong addr,
>              return 0;
>          }
>  
> -        bp = g_malloc(sizeof(struct kvm_sw_breakpoint));
> +        bp = g_new(struct kvm_sw_breakpoint, 1);
>          bp->pc = addr;
>          bp->use_count = 1;
>          err = kvm_arch_insert_sw_breakpoint(cpu, bp);
> -- 
> 2.14.2
> 
