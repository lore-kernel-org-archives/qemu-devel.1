Received: from eggs.gnu.org ([209.51.188.92]:53806)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gtYoB-0007Uf-BT
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 09:13:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gtYo9-0005lL-Vl
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 09:13:11 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36119)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gtYo9-0004ye-L6
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 09:13:09 -0500
Received: by mail-wr1-f65.google.com with SMTP id o17so2860823wrw.3
	for <qemu-devel@nongnu.org>; Tue, 12 Feb 2019 06:12:44 -0800 (PST)
References: <20190212134758.10514-1-dgilbert@redhat.com>
	<20190212134758.10514-4-dgilbert@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <727257ce-45fb-82f9-8e0b-d11e6d48b179@redhat.com>
Date: Tue, 12 Feb 2019 15:12:41 +0100
MIME-Version: 1.0
In-Reply-To: <20190212134758.10514-4-dgilbert@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 3/4] kvm: Add kvm_set_ioeventfd* traces
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>, qemu-devel@nongnu.org, pbonzini@redhat.com, kraxel@redhat.com, mst@redhat.com
Cc: qemu-trivial@nongnu.org

On 2/12/19 2:47 PM, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> Add a couple of traces around the kvm_set_ioeventfd* calls.
> 
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  accel/kvm/kvm-all.c    | 3 +++
>  accel/kvm/trace-events | 2 ++
>  2 files changed, 5 insertions(+)
> 
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index 4e1de942ce..fd92b6f375 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -657,6 +657,8 @@ static int kvm_set_ioeventfd_mmio(int fd, hwaddr addr, uint32_t val,
>          .fd = fd,
>      };
>  
> +    trace_kvm_set_ioeventfd_mmio(fd, (uint64_t)addr, val, assign, size,
> +                                 datamatch);
>      if (!kvm_enabled()) {
>          return -ENOSYS;
>      }
> @@ -688,6 +690,7 @@ static int kvm_set_ioeventfd_pio(int fd, uint16_t addr, uint16_t val,
>          .fd = fd,
>      };
>      int r;
> +    trace_kvm_set_ioeventfd_pio(fd, addr, val, assign, size, datamatch);
>      if (!kvm_enabled()) {
>          return -ENOSYS;
>      }
> diff --git a/accel/kvm/trace-events b/accel/kvm/trace-events
> index 58e98efe5d..8841025d68 100644
> --- a/accel/kvm/trace-events
> +++ b/accel/kvm/trace-events
> @@ -12,5 +12,7 @@ kvm_irqchip_commit_routes(void) ""
>  kvm_irqchip_add_msi_route(char *name, int vector, int virq) "dev %s vector %d virq %d"
>  kvm_irqchip_update_msi_route(int virq) "Updating MSI route virq=%d"
>  kvm_irqchip_release_virq(int virq) "virq %d"
> +kvm_set_ioeventfd_mmio(int fd, uint64_t addr, uint32_t val, bool assign, uint32_t size, bool datamatch) "fd: %d @0x%" PRIx64 " val=0x%x assign: %d size: %d match: %d"
> +kvm_set_ioeventfd_pio(int fd, uint16_t addr, uint32_t val, bool assign, uint32_t size, bool datamatch) "fd: %d @0x%x val=0x%x assign: %d size: %d match: %d"
>  kvm_set_user_memory(uint32_t slot, uint32_t flags, uint64_t guest_phys_addr, uint64_t memory_size, uint64_t userspace_addr, int ret) "Slot#%d flags=0x%x gpa=0x%"PRIx64 " size=0x%"PRIx64 " ua=0x%"PRIx64 " ret=%d"
>  
> 
