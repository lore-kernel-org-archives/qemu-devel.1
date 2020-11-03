Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E77F7C2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 20:51:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 738CD22409
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 20:51:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CIRc07Kx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 738CD22409
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47466 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ka3Gk-0000kZ-H1
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 15:51:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48344)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1ka3Ff-0008Ah-Bd
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 15:49:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:24900)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1ka3Fc-00019W-6H
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 15:49:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604436593;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qrttKk9HH8HXHL1LscEsWpQNe4r2NxsysIy6DR0fF8c=;
 b=CIRc07KxdDCWYmdY7IB7QWW/7QF+dSBTv849+pSccSd+Mf1QyZYxWIZVSovKZ+aAM56oJU
 3yripIlwozw6IToZE9kItz+ICmleYYCJxfgQLHS1zuFLfG6Xm1jz2hBB9SiOgACiQHjPrF
 c/h2CNgJyiKG8oVnPwNMYopLE/nsKOo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-14-q3bdLHYNPVyblgWFu2j6Ww-1; Tue, 03 Nov 2020 15:49:50 -0500
X-MC-Unique: q3bdLHYNPVyblgWFu2j6Ww-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DE00D809DDB;
 Tue,  3 Nov 2020 20:49:48 +0000 (UTC)
Received: from w520.home (ovpn-112-213.phx2.redhat.com [10.3.112.213])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 778155B4B6;
 Tue,  3 Nov 2020 20:49:45 +0000 (UTC)
Date: Tue, 3 Nov 2020 13:49:45 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Subject: Re: [PATCH V1] vfio-pci: improved tracing
Message-ID: <20201103134945.4ee05fe0@w520.home>
In-Reply-To: <1604345694-48400-1-git-send-email-steven.sistare@oracle.com>
References: <1604345694-48400-1-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=alex.williamson@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 01:02:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon,  2 Nov 2020 11:34:54 -0800
Steve Sistare <steven.sistare@oracle.com> wrote:

> Print more info for existing trace points:
>   trace_kvm_irqchip_add_msi_route
>   trace_pci_update_mappings_del
>   trace_pci_update_mappings_add
> 
> Add new trace points:
>   trace_kvm_irqchip_assign_irqfd
>   trace_msix_table_mmio_write
>   trace_vfio_dma_unmap
>   trace_vfio_dma_map
>   trace_vfio_region
>   trace_vfio_region_mmap
>   trace_ram_block_add
> 
> Sample output: (timestamps deleted for clarity)
> 
> ram_block_add host=0x7f4497e00000, maxlen=0x40000000, mr = {"pc.ram", rw}
> 
> vfio_region 0000:3a:10.0 [3]: len 0x4000 @ +0x30000000000, cap +0x20, flags 0xf
> 
> vfio_region_mmap "0000:3a:10.0 BAR 0 mmaps[0]" [0x0 - 0x3fff] maps to 0x7f44e3eb9000
> 
> msix_table_mmio_write vfio-pci, @ 16, val 0xfee01004, len 4
> 
> kvm_irqchip_add_msi_route dev vfio-pci, vector 1, virq 25, msg {addr 0xfee01004, data 0x40b1}
> 
> kvm_irqchip_assign_irqfd fd=164, virq=25, rfd=-1 returns 0
> 
> vfio_dma_map fd 24, iova 0xa0000, len 0x10000, va 0x7f4495800000, rw
> vfio_dma_unmap fd 24, iova 0xfebf5000, len 0x3000
> 
> pci_update_mappings_add vfio-pci d=0x563d101e7050 00:07.0 [3] @ 0xfebf4000 len 0x4000 "0000:3a:10.0 base BAR 3"
> pci_update_mappings_del vfio-pci d=0x563d101e7050 00:07.0 [3] @ 0xfebf4000 len 0x4000 "0000:3a:10.0 base BAR 3"
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>  accel/kvm/kvm-all.c    |  8 ++++++--
>  accel/kvm/trace-events |  3 ++-
>  exec.c                 |  3 +++
>  hw/pci/msix.c          |  1 +
>  hw/pci/pci.c           | 10 ++++++----
>  hw/pci/trace-events    |  5 +++--
>  hw/vfio/common.c       | 11 ++++++++++-
>  hw/vfio/trace-events   |  5 ++++-
>  trace-events           |  2 ++
>  9 files changed, 37 insertions(+), 11 deletions(-)


This might be easier to process if it were split into kvm+exec, pci,
and vfio patches so each maintainer could take their chunk, but I'll
toss this out in case one of the other maintainers wants to roll it in:

Acked-by: Alex Williamson <alex.williamson@redhat.com>
Reviewed-by: Alex Williamson <alex.williamson@redhat.com> 

Thanks,
Alex
 
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index 63ef6af..01d0561 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -46,6 +46,7 @@
>  #include "sysemu/reset.h"
>  
>  #include "hw/boards.h"
> +#include "trace-root.h"
>  
>  /* This check must be after config-host.h is included */
>  #ifdef CONFIG_EVENTFD
> @@ -1670,7 +1671,7 @@ int kvm_irqchip_add_msi_route(KVMState *s, int vector, PCIDevice *dev)
>      }
>  
>      trace_kvm_irqchip_add_msi_route(dev ? dev->name : (char *)"N/A",
> -                                    vector, virq);
> +                                    vector, virq, msg.address, msg.data);
>  
>      kvm_add_routing_entry(s, &kroute);
>      kvm_arch_add_msi_route_post(&kroute, vector, dev);
> @@ -1715,6 +1716,7 @@ static int kvm_irqchip_assign_irqfd(KVMState *s, EventNotifier *event,
>                                      EventNotifier *resample, int virq,
>                                      bool assign)
>  {
> +    int ret;
>      int fd = event_notifier_get_fd(event);
>      int rfd = resample ? event_notifier_get_fd(resample) : -1;
>  
> @@ -1758,7 +1760,9 @@ static int kvm_irqchip_assign_irqfd(KVMState *s, EventNotifier *event,
>          return -ENOSYS;
>      }
>  
> -    return kvm_vm_ioctl(s, KVM_IRQFD, &irqfd);
> +    ret = kvm_vm_ioctl(s, KVM_IRQFD, &irqfd);
> +    trace_kvm_irqchip_assign_irqfd(fd, virq, rfd, ret);
> +    return ret;
>  }
>  
>  int kvm_irqchip_add_adapter_route(KVMState *s, AdapterInfo *adapter)
> diff --git a/accel/kvm/trace-events b/accel/kvm/trace-events
> index a68eb66..c4ed199 100644
> --- a/accel/kvm/trace-events
> +++ b/accel/kvm/trace-events
> @@ -9,7 +9,8 @@ kvm_device_ioctl(int fd, int type, void *arg) "dev fd %d, type 0x%x, arg %p"
>  kvm_failed_reg_get(uint64_t id, const char *msg) "Warning: Unable to retrieve ONEREG %" PRIu64 " from KVM: %s"
>  kvm_failed_reg_set(uint64_t id, const char *msg) "Warning: Unable to set ONEREG %" PRIu64 " to KVM: %s"
>  kvm_irqchip_commit_routes(void) ""
> -kvm_irqchip_add_msi_route(char *name, int vector, int virq) "dev %s vector %d virq %d"
> +kvm_irqchip_add_msi_route(char *name, int vector, int virq, uint64_t addr, uint32_t data) "dev %s, vector %d, virq %d, msg {addr 0x%"PRIx64", data 0x%x}"
> +kvm_irqchip_assign_irqfd(int fd, int virq, int rfd, int status) "fd=%d, virq=%d, rfd=%d returns %d"
>  kvm_irqchip_update_msi_route(int virq) "Updating MSI route virq=%d"
>  kvm_irqchip_release_virq(int virq) "virq %d"
>  kvm_set_ioeventfd_mmio(int fd, uint64_t addr, uint32_t val, bool assign, uint32_t size, bool datamatch) "fd: %d @0x%" PRIx64 " val=0x%x assign: %d size: %d match: %d"
> diff --git a/exec.c b/exec.c
> index 6f381f9..5d05154 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -2309,6 +2309,9 @@ static void ram_block_add(RAMBlock *new_block, Error **errp, bool shared)
>          }
>          ram_block_notify_add(new_block->host, new_block->max_length);
>      }
> +    trace_ram_block_add(new_block->host, new_block->max_length,
> +                        memory_region_name(new_block->mr),
> +                        new_block->mr->readonly ? "ro" : "rw");
>  }
>  
>  #ifdef CONFIG_POSIX
> diff --git a/hw/pci/msix.c b/hw/pci/msix.c
> index 67e34f3..65a2882 100644
> --- a/hw/pci/msix.c
> +++ b/hw/pci/msix.c
> @@ -189,6 +189,7 @@ static void msix_table_mmio_write(void *opaque, hwaddr addr,
>      int vector = addr / PCI_MSIX_ENTRY_SIZE;
>      bool was_masked;
>  
> +    trace_msix_table_mmio_write(dev->name, addr, val, size);
>      was_masked = msix_is_masked(dev, vector);
>      pci_set_long(dev->msix_table + addr, val);
>      msix_handle_mask_update(dev, vector, was_masked);
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index de0fae1..1bc1533 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -1321,9 +1321,11 @@ static void pci_update_mappings(PCIDevice *d)
>      PCIIORegion *r;
>      int i;
>      pcibus_t new_addr;
> +    const char *name;
>  
>      for(i = 0; i < PCI_NUM_REGIONS; i++) {
>          r = &d->io_regions[i];
> +        name = r->memory ? r->memory->name : "";
>  
>          /* this region isn't registered */
>          if (!r->size)
> @@ -1337,18 +1339,18 @@ static void pci_update_mappings(PCIDevice *d)
>  
>          /* now do the real mapping */
>          if (r->addr != PCI_BAR_UNMAPPED) {
> -            trace_pci_update_mappings_del(d, pci_dev_bus_num(d),
> +            trace_pci_update_mappings_del(d->name, d, pci_dev_bus_num(d),
>                                            PCI_SLOT(d->devfn),
>                                            PCI_FUNC(d->devfn),
> -                                          i, r->addr, r->size);
> +                                          i, r->addr, r->size, name);
>              memory_region_del_subregion(r->address_space, r->memory);
>          }
>          r->addr = new_addr;
>          if (r->addr != PCI_BAR_UNMAPPED) {
> -            trace_pci_update_mappings_add(d, pci_dev_bus_num(d),
> +            trace_pci_update_mappings_add(d->name, d, pci_dev_bus_num(d),
>                                            PCI_SLOT(d->devfn),
>                                            PCI_FUNC(d->devfn),
> -                                          i, r->addr, r->size);
> +                                          i, r->addr, r->size, name);
>              memory_region_add_subregion_overlap(r->address_space,
>                                                  r->addr, r->memory, 1);
>          }
> diff --git a/hw/pci/trace-events b/hw/pci/trace-events
> index def4b39..56fc6c6 100644
> --- a/hw/pci/trace-events
> +++ b/hw/pci/trace-events
> @@ -1,8 +1,8 @@
>  # See docs/devel/tracing.txt for syntax documentation.
>  
>  # pci.c
> -pci_update_mappings_del(void *d, uint32_t bus, uint32_t slot, uint32_t func, int bar, uint64_t addr, uint64_t size) "d=%p %02x:%02x.%x %d,0x%"PRIx64"+0x%"PRIx64
> -pci_update_mappings_add(void *d, uint32_t bus, uint32_t slot, uint32_t func, int bar, uint64_t addr, uint64_t size) "d=%p %02x:%02x.%x %d,0x%"PRIx64"+0x%"PRIx64
> +pci_update_mappings_del(const char *dname, void *d, uint32_t bus, uint32_t slot, uint32_t func, int bar, uint64_t addr, uint64_t size, const char *name) "%s d=%p %02x:%02x.%x [%d] @ 0x%"PRIx64" len 0x%"PRIx64" \"%s\""
> +pci_update_mappings_add(const char *dname, void *d, uint32_t bus, uint32_t slot, uint32_t func, int bar, uint64_t addr, uint64_t size, const char *name) "%s d=%p %02x:%02x.%x [%d] @ 0x%"PRIx64" len 0x%"PRIx64" \"%s\""
>  
>  # pci_host.c
>  pci_cfg_read(const char *dev, unsigned devid, unsigned fnid, unsigned offs, unsigned val) "%s %02u:%u @0x%x -> 0x%x"
> @@ -10,3 +10,4 @@ pci_cfg_write(const char *dev, unsigned devid, unsigned fnid, unsigned offs, uns
>  
>  # msix.c
>  msix_write_config(char *name, bool enabled, bool masked) "dev %s enabled %d masked %d"
> +msix_table_mmio_write(char *name, uint64_t addr, uint64_t val, unsigned size)  "%s, @ %"PRId64", val 0x%"PRIx64", len %d"
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 3335714..50b8202 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -299,6 +299,8 @@ static int vfio_dma_unmap(VFIOContainer *container,
>          .size = size,
>      };
>  
> +    trace_vfio_dma_unmap(container->fd, iova, size);
> +
>      while (ioctl(container->fd, VFIO_IOMMU_UNMAP_DMA, &unmap)) {
>          /*
>           * The type1 backend has an off-by-one bug in the kernel (71a7d3d78e3c
> @@ -336,6 +338,9 @@ static int vfio_dma_map(VFIOContainer *container, hwaddr iova,
>          .size = size,
>      };
>  
> +    trace_vfio_dma_map(container->fd, iova, size, vaddr,
> +                       (readonly ? "r" : "rw"));
> +
>      if (!readonly) {
>          map.flags |= VFIO_DMA_MAP_FLAG_WRITE;
>      }
> @@ -976,7 +981,8 @@ int vfio_region_mmap(VFIORegion *region)
>          trace_vfio_region_mmap(memory_region_name(&region->mmaps[i].mem),
>                                 region->mmaps[i].offset,
>                                 region->mmaps[i].offset +
> -                               region->mmaps[i].size - 1);
> +                               region->mmaps[i].size - 1,
> +                               region->mmaps[i].mmap);
>      }
>  
>      return 0;
> @@ -1639,6 +1645,9 @@ retry:
>          goto retry;
>      }
>  
> +    trace_vfio_region(vbasedev->name, index, (*info)->size, (*info)->offset,
> +                      (*info)->cap_offset, (*info)->flags);
> +
>      return 0;
>  }
>  
> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
> index b1ef55a..78a3cfa 100644
> --- a/hw/vfio/trace-events
> +++ b/hw/vfio/trace-events
> @@ -107,7 +107,7 @@ vfio_get_device(const char * name, unsigned int flags, unsigned int num_regions,
>  vfio_put_base_device(int fd) "close vdev->fd=%d"
>  vfio_region_setup(const char *dev, int index, const char *name, unsigned long flags, unsigned long offset, unsigned long size) "Device %s, region %d \"%s\", flags: 0x%lx, offset: 0x%lx, size: 0x%lx"
>  vfio_region_mmap_fault(const char *name, int index, unsigned long offset, unsigned long size, int fault) "Region %s mmaps[%d], [0x%lx - 0x%lx], fault: %d"
> -vfio_region_mmap(const char *name, unsigned long offset, unsigned long end) "Region %s [0x%lx - 0x%lx]"
> +vfio_region_mmap(const char *name, unsigned long offset, unsigned long end, void *addr) "\"%s\" [0x%lx - 0x%lx] maps to %p"
>  vfio_region_exit(const char *name, int index) "Device %s, region %d"
>  vfio_region_finalize(const char *name, int index) "Device %s, region %d"
>  vfio_region_mmaps_set_enabled(const char *name, bool enabled) "Region %s mmaps enabled: %d"
> @@ -115,6 +115,9 @@ vfio_region_sparse_mmap_header(const char *name, int index, int nr_areas) "Devic
>  vfio_region_sparse_mmap_entry(int i, unsigned long start, unsigned long end) "sparse entry %d [0x%lx - 0x%lx]"
>  vfio_get_dev_region(const char *name, int index, uint32_t type, uint32_t subtype) "%s index %d, %08x/%0x8"
>  vfio_dma_unmap_overflow_workaround(void) ""
> +vfio_dma_unmap(int fd, uint64_t iova, uint64_t size) "fd %d, iova 0x%"PRIx64", len 0x%"PRIx64
> +vfio_dma_map(int fd, uint64_t iova, uint64_t size, void *addr, const char *access) "fd %d, iova 0x%"PRIx64", len 0x%"PRIx64", va %p, %s"
> +vfio_region(const char *name, int index, uint64_t size, uint64_t offset, int cap_offset, int flags) "%s [%d]: len 0x%"PRIx64" @ +0x%"PRIx64", cap +0x%x, flags 0x%x"
>  
>  # platform.c
>  vfio_platform_base_device_init(char *name, int groupid) "%s belongs to group #%d"
> diff --git a/trace-events b/trace-events
> index 42107eb..e05238a 100644
> --- a/trace-events
> +++ b/trace-events
> @@ -107,6 +107,8 @@ qmp_job_complete(void *job) "job %p"
>  qmp_job_finalize(void *job) "job %p"
>  qmp_job_dismiss(void *job) "job %p"
>  
> +# exec.c
> +ram_block_add(void *host, uint64_t maxlen, const char *name, const char *mode) "host=%p, maxlen=0x%"PRIx64", mr = {\"%s\", %s}"
>  
>  ### Guest events, keep at bottom
>  


