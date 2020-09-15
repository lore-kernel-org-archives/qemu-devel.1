Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09DF9C433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 18:50:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 292152067C
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 18:50:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TW9t/ONG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 292152067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIG2Y-0004zM-61
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 14:50:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38722)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kIG1X-0004VR-Sg
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 14:49:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55752)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kIG1V-0007Ng-1i
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 14:49:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600195787;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pHUsYHMGXzu9UzJoa71h3kyrhTIyPPDQuQLTGrCCoW8=;
 b=TW9t/ONGiH01fNE2m9/HAtb4ho9mCOOoRQIFqNfGaEMy8UZyEaHj/d0GCUgWbu+KerUh/y
 4DYHd8DZxaj5V2WsxuKBJmD3QuGscKZjPqOE01nrDjsbPCeOsA7yjEt1qd3UKeDRgqA6eI
 PBp/86+FmZSu+53IQQArPTZ3tNZVDME=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-83-HPf1JGL6OSqVH14YO6PkOw-1; Tue, 15 Sep 2020 14:49:44 -0400
X-MC-Unique: HPf1JGL6OSqVH14YO6PkOw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A36B4EA322;
 Tue, 15 Sep 2020 18:49:42 +0000 (UTC)
Received: from work-vm (ovpn-115-25.ams2.redhat.com [10.36.115.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C844319D61;
 Tue, 15 Sep 2020 18:49:27 +0000 (UTC)
Date: Tue, 15 Sep 2020 19:49:25 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Subject: Re: [PATCH V1 32/32] vfio-pci: improved tracing
Message-ID: <20200915184925.GE2922@work-vm>
References: <1596122076-341293-1-git-send-email-steven.sistare@oracle.com>
 <1596122076-341293-33-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
In-Reply-To: <1596122076-341293-33-git-send-email-steven.sistare@oracle.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/15 02:10:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Steve Sistare (steven.sistare@oracle.com) wrote:
> Print more info for existing trace points:
>   trace_kvm_irqchip_add_msi_route.
>   trace_pci_update_mappings_del
>   trace_pci_update_mappings_add
> 
> Add new trace points:
>   trace_kvm_irqchip_assign_irqfd
>   trace_msix_table_mmio_write
>   trace_vfio_dma_unmap
>   trace_vfio_dma_map
>   trace_vfio_region
>   trace_vfio_descriptors
>   trace_ram_block_add
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>

Why don't you split this out into a separate patch by itself; if they're
general extra useful tracing they can just go in.

Note that you've also added a new warning in  vfio_dma_unmap

Dave

> ---
>  accel/kvm/kvm-all.c    |  8 ++++++--
>  accel/kvm/trace-events |  3 ++-
>  exec.c                 |  3 +++
>  hw/pci/msix.c          |  1 +
>  hw/pci/pci.c           | 10 ++++++----
>  hw/pci/trace-events    |  5 +++--
>  hw/vfio/common.c       | 16 +++++++++++++++-
>  hw/vfio/pci.c          |  1 +
>  hw/vfio/trace-events   |  9 ++++++---
>  trace-events           |  2 ++
>  10 files changed, 45 insertions(+), 13 deletions(-)
> 
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index 63ef6af..5511ea7 100644
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
> @@ -1717,6 +1718,7 @@ static int kvm_irqchip_assign_irqfd(KVMState *s, EventNotifier *event,
>  {
>      int fd = event_notifier_get_fd(event);
>      int rfd = resample ? event_notifier_get_fd(resample) : -1;
> +    int ret;
>  
>      struct kvm_irqfd irqfd = {
>          .fd = fd,
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
> index a68eb66..67a01e6 100644
> --- a/accel/kvm/trace-events
> +++ b/accel/kvm/trace-events
> @@ -9,7 +9,8 @@ kvm_device_ioctl(int fd, int type, void *arg) "dev fd %d, type 0x%x, arg %p"
>  kvm_failed_reg_get(uint64_t id, const char *msg) "Warning: Unable to retrieve ONEREG %" PRIu64 " from KVM: %s"
>  kvm_failed_reg_set(uint64_t id, const char *msg) "Warning: Unable to set ONEREG %" PRIu64 " to KVM: %s"
>  kvm_irqchip_commit_routes(void) ""
> -kvm_irqchip_add_msi_route(char *name, int vector, int virq) "dev %s vector %d virq %d"
> +kvm_irqchip_add_msi_route(char *name, int vector, int virq, uint64_t addr, uint32_t data) "%s, vector %d, virq %d, msg {addr 0x%"PRIx64", data 0x%x}"
> +kvm_irqchip_assign_irqfd(int fd, int virq, int rfd, int status) "(fd=%d, virq=%d, rfd=%d) KVM_IRQFD returns %d"
>  kvm_irqchip_update_msi_route(int virq) "Updating MSI route virq=%d"
>  kvm_irqchip_release_virq(int virq) "virq %d"
>  kvm_set_ioeventfd_mmio(int fd, uint64_t addr, uint32_t val, bool assign, uint32_t size, bool datamatch) "fd: %d @0x%" PRIx64 " val=0x%x assign: %d size: %d match: %d"
> diff --git a/exec.c b/exec.c
> index 5473c09..dd99ee0 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -2319,6 +2319,9 @@ static void ram_block_add(RAMBlock *new_block, Error **errp, bool shared)
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
> index c2e1509..6142411 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -1324,9 +1324,11 @@ void pci_update_mappings(PCIDevice *d)
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
> @@ -1340,18 +1342,18 @@ void pci_update_mappings(PCIDevice *d)
>  
>          /* now do the real mapping */
>          if (r->addr != PCI_BAR_UNMAPPED) {
> -            trace_pci_update_mappings_del(d, pci_dev_bus_num(d),
> +            trace_pci_update_mappings_del(d->name, pci_dev_bus_num(d),
>                                            PCI_SLOT(d->devfn),
>                                            PCI_FUNC(d->devfn),
> -                                          i, r->addr, r->size);
> +                                          i, r->addr, r->size, name);
>              memory_region_del_subregion(r->address_space, r->memory);
>          }
>          r->addr = new_addr;
>          if (r->addr != PCI_BAR_UNMAPPED) {
> -            trace_pci_update_mappings_add(d, pci_dev_bus_num(d),
> +            trace_pci_update_mappings_add(d->name, pci_dev_bus_num(d),
>                                            PCI_SLOT(d->devfn),
>                                            PCI_FUNC(d->devfn),
> -                                          i, r->addr, r->size);
> +                                          i, r->addr, r->size, name);
>              memory_region_add_subregion_overlap(r->address_space,
>                                                  r->addr, r->memory, 1);
>          }
> diff --git a/hw/pci/trace-events b/hw/pci/trace-events
> index def4b39..6dd7015 100644
> --- a/hw/pci/trace-events
> +++ b/hw/pci/trace-events
> @@ -1,8 +1,8 @@
>  # See docs/devel/tracing.txt for syntax documentation.
>  
>  # pci.c
> -pci_update_mappings_del(void *d, uint32_t bus, uint32_t slot, uint32_t func, int bar, uint64_t addr, uint64_t size) "d=%p %02x:%02x.%x %d,0x%"PRIx64"+0x%"PRIx64
> -pci_update_mappings_add(void *d, uint32_t bus, uint32_t slot, uint32_t func, int bar, uint64_t addr, uint64_t size) "d=%p %02x:%02x.%x %d,0x%"PRIx64"+0x%"PRIx64
> +pci_update_mappings_del(const char *dname, uint32_t bus, uint32_t slot, uint32_t func, int bar, uint64_t addr, uint64_t size, const char *name) "%s %02x:%02x.%x [%d] 0x%"PRIx64", 0x%"PRIx64"B \"%s\""
> +pci_update_mappings_add(const char *dname, uint32_t bus, uint32_t slot, uint32_t func, int bar, uint64_t addr, uint64_t size, const char *name) "%s %02x:%02x.%x [%d] 0x%"PRIx64", 0x%"PRIx64"B \"%s\""
>  
>  # pci_host.c
>  pci_cfg_read(const char *dev, unsigned devid, unsigned fnid, unsigned offs, unsigned val) "%s %02u:%u @0x%x -> 0x%x"
> @@ -10,3 +10,4 @@ pci_cfg_write(const char *dev, unsigned devid, unsigned fnid, unsigned offs, uns
>  
>  # msix.c
>  msix_write_config(char *name, bool enabled, bool masked) "dev %s enabled %d masked %d"
> +msix_table_mmio_write(char *name, uint64_t addr, uint64_t val, unsigned size)  "(%s, @%"PRId64", 0x%"PRIx64", %dB)"
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index a51a093..23c8bf3 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -304,6 +304,8 @@ static int vfio_dma_unmap(VFIOContainer *container,
>          return 0;
>      }
>  
> +    trace_vfio_dma_unmap(container->fd, iova, size);
> +
>      while (ioctl(container->fd, VFIO_IOMMU_UNMAP_DMA, &unmap)) {
>          /*
>           * The type1 backend has an off-by-one bug in the kernel (71a7d3d78e3c
> @@ -327,6 +329,11 @@ static int vfio_dma_unmap(VFIOContainer *container,
>          return -errno;
>      }
>  
> +    if (unmap.size != size) {
> +        error_printf("warn: VFIO_UNMAP_DMA(0x%lx, 0x%lx) only unmaps 0x%llx",
> +                     iova, size, unmap.size);
> +    }
> +
>      return 0;
>  }
>  
> @@ -345,6 +352,9 @@ static int vfio_dma_map(VFIOContainer *container, hwaddr iova,
>          return 0;
>      }
>  
> +    trace_vfio_dma_map(container->fd, iova, size, vaddr,
> +                       (readonly ? "r" : "rw"));
> +
>      if (!readonly) {
>          map.flags |= VFIO_DMA_MAP_FLAG_WRITE;
>      }
> @@ -985,7 +995,8 @@ int vfio_region_mmap(VFIORegion *region)
>          trace_vfio_region_mmap(memory_region_name(&region->mmaps[i].mem),
>                                 region->mmaps[i].offset,
>                                 region->mmaps[i].offset +
> -                               region->mmaps[i].size - 1);
> +                               region->mmaps[i].size - 1,
> +                               region->mmaps[i].mmap);
>      }
>  
>      return 0;
> @@ -1696,6 +1707,9 @@ retry:
>          goto retry;
>      }
>  
> +    trace_vfio_region(vbasedev->name, index, (*info)->offset, (*info)->size,
> +                      (*info)->cap_offset, (*info)->flags);
> +
>      return 0;
>  }
>  
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index f72e277..d74e078 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -41,6 +41,7 @@
>  #include "trace.h"
>  #include "qapi/error.h"
>  #include "migration/blocker.h"
> +#include "trace-root.h"
>  
>  #define TYPE_VFIO_PCI "vfio-pci"
>  #define PCI_VFIO(obj)    OBJECT_CHECK(VFIOPCIDevice, obj, TYPE_VFIO_PCI)
> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
> index 10d899c..83cd0a6 100644
> --- a/hw/vfio/trace-events
> +++ b/hw/vfio/trace-events
> @@ -25,7 +25,7 @@ vfio_pci_size_rom(const char *name, int size) "%s ROM size 0x%x"
>  vfio_vga_write(uint64_t addr, uint64_t data, int size) " (0x%"PRIx64", 0x%"PRIx64", %d)"
>  vfio_vga_read(uint64_t addr, int size, uint64_t data) " (0x%"PRIx64", %d) = 0x%"PRIx64
>  vfio_pci_read_config(const char *name, int addr, int len, int val) " (%s, @0x%x, len=0x%x) 0x%x"
> -vfio_pci_write_config(const char *name, int addr, int val, int len) " (%s, @0x%x, 0x%x, len=0x%x)"
> +vfio_pci_write_config(const char *name, int addr, int val, int len) "(%s, @0x%x, 0x%x, 0x%xB)"
>  vfio_msi_setup(const char *name, int pos) "%s PCI MSI CAP @0x%x"
>  vfio_msix_early_setup(const char *name, int pos, int table_bar, int offset, int entries) "%s PCI MSI-X CAP @0x%x, BAR %d, offset 0x%x, entries %d"
>  vfio_check_pcie_flr(const char *name) "%s Supports FLR via PCIe cap"
> @@ -37,7 +37,7 @@ vfio_pci_hot_reset_dep_devices(int domain, int bus, int slot, int function, int
>  vfio_pci_hot_reset_result(const char *name, const char *result) "%s hot reset: %s"
>  vfio_populate_device_config(const char *name, unsigned long size, unsigned long offset, unsigned long flags) "Device %s config:\n  size: 0x%lx, offset: 0x%lx, flags: 0x%lx"
>  vfio_populate_device_get_irq_info_failure(const char *errstr) "VFIO_DEVICE_GET_IRQ_INFO failure: %s"
> -vfio_realize(const char *name, int group_id) " (%s) group %d"
> +vfio_realize(const char *name, int group_id) "(%s) group %d"
>  vfio_mdev(const char *name, bool is_mdev) " (%s) is_mdev %d"
>  vfio_add_ext_cap_dropped(const char *name, uint16_t cap, uint16_t offset) "%s 0x%x@0x%x"
>  vfio_pci_reset(const char *name) " (%s)"
> @@ -109,7 +109,7 @@ vfio_get_device(const char * name, unsigned int flags, unsigned int num_regions,
>  vfio_put_base_device(int fd) "close vdev->fd=%d"
>  vfio_region_setup(const char *dev, int index, const char *name, unsigned long flags, unsigned long offset, unsigned long size) "Device %s, region %d \"%s\", flags: 0x%lx, offset: 0x%lx, size: 0x%lx"
>  vfio_region_mmap_fault(const char *name, int index, unsigned long offset, unsigned long size, int fault) "Region %s mmaps[%d], [0x%lx - 0x%lx], fault: %d"
> -vfio_region_mmap(const char *name, unsigned long offset, unsigned long end) "Region %s [0x%lx - 0x%lx]"
> +vfio_region_mmap(const char *name, unsigned long offset, unsigned long end, void *addr) "%s [0x%lx - 0x%lx] maps to %p"
>  vfio_region_exit(const char *name, int index) "Device %s, region %d"
>  vfio_region_finalize(const char *name, int index) "Device %s, region %d"
>  vfio_region_mmaps_set_enabled(const char *name, bool enabled) "Region %s mmaps enabled: %d"
> @@ -117,6 +117,9 @@ vfio_region_sparse_mmap_header(const char *name, int index, int nr_areas) "Devic
>  vfio_region_sparse_mmap_entry(int i, unsigned long start, unsigned long end) "sparse entry %d [0x%lx - 0x%lx]"
>  vfio_get_dev_region(const char *name, int index, uint32_t type, uint32_t subtype) "%s index %d, %08x/%0x8"
>  vfio_dma_unmap_overflow_workaround(void) ""
> +vfio_dma_unmap(int fd, uint64_t iova, uint64_t size) "fd %d, iova 0x%"PRIx64", len 0x%"PRIx64
> +vfio_dma_map(int fd, uint64_t iova, uint64_t size, void *addr, const char *access) "fd %d, iova 0x%"PRIx64", len 0x%"PRIx64", va %p, %s"
> +vfio_region(const char *name, int index, uint64_t offset, uint64_t size, int cap_offset, int flags) "%s [%d]: +0x%"PRIx64", 0x%"PRIx64"B, cap +0x%x, flags 0x%x"
>  
>  # platform.c
>  vfio_platform_base_device_init(char *name, int groupid) "%s belongs to group #%d"
> diff --git a/trace-events b/trace-events
> index 42107eb..98589a4 100644
> --- a/trace-events
> +++ b/trace-events
> @@ -107,6 +107,8 @@ qmp_job_complete(void *job) "job %p"
>  qmp_job_finalize(void *job) "job %p"
>  qmp_job_dismiss(void *job) "job %p"
>  
> +# exec.c
> +ram_block_add(void *host, uint64_t maxlen, const char *name, const char *mode) "host=%p, maxlen=0x%"PRIx64", mr = {name=%s, %s}"
>  
>  ### Guest events, keep at bottom
>  
> -- 
> 1.8.3.1
> 
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


