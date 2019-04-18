Return-Path: <SRS0=08iY=SU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D831AC10F0E
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 11:23:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 946F0214DA
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 11:23:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 946F0214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39646 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hH58X-0004bf-Js
	for qemu-devel@archiver.kernel.org; Thu, 18 Apr 2019 07:23:25 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47667)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hH558-0002Bj-SU
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 07:19:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hH557-0002ZI-Kk
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 07:19:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45576)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>)
	id 1hH556-0002Yb-TF; Thu, 18 Apr 2019 07:19:53 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 062CB81E19;
	Thu, 18 Apr 2019 11:19:51 +0000 (UTC)
Received: from localhost (unknown [10.43.2.182])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 9414C600C5;
	Thu, 18 Apr 2019 11:19:44 +0000 (UTC)
Date: Thu, 18 Apr 2019 13:19:40 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: David Hildenbrand <david@redhat.com>
Message-ID: <20190418131940.38df1a91@redhat.com>
In-Reply-To: <20190417113143.5551-3-david@redhat.com>
References: <20190417113143.5551-1-david@redhat.com>
	<20190417113143.5551-3-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.25]);
	Thu, 18 Apr 2019 11:19:51 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 2/2] exec: Introduce
 qemu_maxrampagesize() and rename qemu_getrampagesize()
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: peter.maydell@linaro.org, Thomas Huth <thuth@redhat.com>,
	qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>,
	qemu-devel@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
	Christian Borntraeger <borntraeger@de.ibm.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	qemu-ppc@nongnu.org, pbonzini@redhat.com,
	David Gibson <david@gibson.dropbear.id.au>,
	Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190418111940.jr08YeNyiw8aphv1xr1JHcsWw0ZzeiEVl5HHd1hpGF8@z>

On Wed, 17 Apr 2019 13:31:43 +0200
David Hildenbrand <david@redhat.com> wrote:

> Rename qemu_getrampagesize() to qemu_minrampagesize(). While at it,
> properly rename find_max_supported_pagesize() to
> find_min_backend_pagesize().
> 
> s390x is actually interested into the maximum ram pagesize, so
> introduce and use qemu_maxrampagesize().
> 
> Add a TODO, indicating that looking at any mapped memory backends is not
> 100% correct in some cases.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  exec.c                     | 44 ++++++++++++++++++++++++++++++++++----
>  hw/ppc/spapr_caps.c        |  4 ++--
>  hw/s390x/s390-virtio-ccw.c |  2 +-
>  hw/vfio/spapr.c            |  2 +-
>  include/exec/ram_addr.h    |  3 ++-
>  target/ppc/kvm.c           |  2 +-
>  6 files changed, 47 insertions(+), 10 deletions(-)
> 
> diff --git a/exec.c b/exec.c
> index 6ab62f4eee..f9b834ef82 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -1687,7 +1687,7 @@ void ram_block_dump(Monitor *mon)
>   * when we actually open and map them.  Iterate over the file
>   * descriptors instead, and use qemu_fd_getpagesize().
>   */
> -static int find_max_supported_pagesize(Object *obj, void *opaque)
> +static int find_min_backend_pagesize(Object *obj, void *opaque)
>  {
>      long *hpsize_min = opaque;
>  
> @@ -1703,7 +1703,27 @@ static int find_max_supported_pagesize(Object *obj, void *opaque)
>      return 0;
>  }
>  
> -long qemu_getrampagesize(void)
> +static int find_max_backend_pagesize(Object *obj, void *opaque)
> +{
> +    long *hpsize_max = opaque;
> +
> +    if (object_dynamic_cast(obj, TYPE_MEMORY_BACKEND)) {
> +        HostMemoryBackend *backend = MEMORY_BACKEND(obj);
> +        long hpsize = host_memory_backend_pagesize(backend);
> +
> +        if (host_memory_backend_is_mapped(backend) && (hpsize > *hpsize_max)) {
> +            *hpsize_max = hpsize;
> +        }
> +    }
> +
> +    return 0;
> +}
> +
> +/*
> + * TODO: We assume right now that all mapped host memory backends are
> + * used as RAM, however some might be used for different purposes.
> + */
> +long qemu_minrampagesize(void)
>  {
>      long hpsize = LONG_MAX;
>      long mainrampagesize;
> @@ -1723,7 +1743,7 @@ long qemu_getrampagesize(void)
>       */
>      memdev_root = object_resolve_path("/objects", NULL);
>      if (memdev_root) {
> -        object_child_foreach(memdev_root, find_max_supported_pagesize, &hpsize);
> +        object_child_foreach(memdev_root, find_min_backend_pagesize, &hpsize);
>      }
>      if (hpsize == LONG_MAX) {
>          /* No additional memory regions found ==> Report main RAM page size */
> @@ -1746,8 +1766,24 @@ long qemu_getrampagesize(void)
>  
>      return hpsize;
>  }
> +
> +long qemu_maxrampagesize(void)
> +{
> +    long pagesize = qemu_mempath_getpagesize(mem_path);
> +    Object *memdev_root = object_resolve_path("/objects", NULL);
> +
> +    if (memdev_root) {
> +        object_child_foreach(memdev_root, find_max_backend_pagesize,
> +                             &pagesize);
> +    }
> +    return pagesize;
> +}
>  #else
> -long qemu_getrampagesize(void)
> +long qemu_minrampagesize(void)
> +{
> +    return getpagesize();
> +}
> +long qemu_maxrampagesize(void)
>  {
>      return getpagesize();
>  }
> diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
> index edc5ed0e0c..9b1c10baa6 100644
> --- a/hw/ppc/spapr_caps.c
> +++ b/hw/ppc/spapr_caps.c
> @@ -347,7 +347,7 @@ static void cap_hpt_maxpagesize_apply(SpaprMachineState *spapr,
>          warn_report("Many guests require at least 64kiB hpt-max-page-size");
>      }
>  
> -    spapr_check_pagesize(spapr, qemu_getrampagesize(), errp);
> +    spapr_check_pagesize(spapr, qemu_minrampagesize(), errp);
>  }
>  
>  static bool spapr_pagesize_cb(void *opaque, uint32_t seg_pshift,
> @@ -609,7 +609,7 @@ static SpaprCapabilities default_caps_with_cpu(SpaprMachineState *spapr,
>          uint8_t mps;
>  
>          if (kvmppc_hpt_needs_host_contiguous_pages()) {
> -            mps = ctz64(qemu_getrampagesize());
> +            mps = ctz64(qemu_minrampagesize());
>          } else {
>              mps = 34; /* allow everything up to 16GiB, i.e. everything */
>          }
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index 3be5679657..7e256d3d31 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -188,7 +188,7 @@ static void s390_memory_init(ram_addr_t mem_size)
>       * Configure the maximum page size. As no memory devices were created
>       * yet, this is the page size of initial memory only.
>       */
> -    s390_set_max_pagesize(qemu_getrampagesize(), &local_err);
> +    s390_set_max_pagesize(qemu_maxrampagesize(), &local_err);
>      if (local_err) {
>          error_report_err(local_err);
>          exit(EXIT_FAILURE);
> diff --git a/hw/vfio/spapr.c b/hw/vfio/spapr.c
> index 57fe758e54..96c0ad9d9b 100644
> --- a/hw/vfio/spapr.c
> +++ b/hw/vfio/spapr.c
> @@ -148,7 +148,7 @@ int vfio_spapr_create_window(VFIOContainer *container,
>      uint64_t pagesize = memory_region_iommu_get_min_page_size(iommu_mr);
>      unsigned entries, bits_total, bits_per_level, max_levels;
>      struct vfio_iommu_spapr_tce_create create = { .argsz = sizeof(create) };
> -    long rampagesize = qemu_getrampagesize();
> +    long rampagesize = qemu_minrampagesize();
>  
>      /*
>       * The host might not support the guest supported IOMMU page size,
> diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
> index 9ecd911c3e..139ad79390 100644
> --- a/include/exec/ram_addr.h
> +++ b/include/exec/ram_addr.h
> @@ -73,7 +73,8 @@ static inline unsigned long int ramblock_recv_bitmap_offset(void *host_addr,
>  
>  bool ramblock_is_pmem(RAMBlock *rb);
>  
> -long qemu_getrampagesize(void);
> +long qemu_minrampagesize(void);
> +long qemu_maxrampagesize(void);
>  
>  /**
>   * qemu_ram_alloc_from_file,
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index 2427c8ee13..59d92c4275 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -2136,7 +2136,7 @@ uint64_t kvmppc_rma_size(uint64_t current_size, unsigned int hash_shift)
>      /* Find the largest hardware supported page size that's less than
>       * or equal to the (logical) backing page size of guest RAM */
>      kvm_get_smmu_info(&info, &error_fatal);
> -    rampagesize = qemu_getrampagesize();
> +    rampagesize = qemu_minrampagesize();
>      best_page_shift = 0;
>  
>      for (i = 0; i < KVM_PPC_PAGE_SIZES_MAX_SZ; i++) {


