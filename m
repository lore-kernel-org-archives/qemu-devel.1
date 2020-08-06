Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 126A9C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:00:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D347C22D02
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:00:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D347C22D02
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36288 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3d40-0007Ua-Rs
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 06:23:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34356)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jason.zeng@linux.intel.com>)
 id 1k3d3S-00073q-NW
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 06:23:22 -0400
Received: from mga17.intel.com ([192.55.52.151]:49270)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jason.zeng@linux.intel.com>)
 id 1k3d3Q-0004c5-CI
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 06:23:22 -0400
IronPort-SDR: swiz2Su6UrkIhmevIG1JpkDJpW/eBKBOSp98ylCTfPKBvG8Y61ukslKfv7It6pWRNsr98b2YZF
 M+gl3lOxl2UQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9704"; a="132850649"
X-IronPort-AV: E=Sophos;i="5.75,441,1589266800"; d="scan'208";a="132850649"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2020 03:23:16 -0700
IronPort-SDR: mxdXF4IRNkqO+zPZ45zbgSEaJA6MU+Y/skm4qEvhx4o9KQjsXjiMwkWy/xzND0vJ2ihVuDlfim
 JI8eWqmJu3bw==
X-IronPort-AV: E=Sophos;i="5.75,441,1589266800"; d="scan'208";a="467798831"
Received: from x48.bj.intel.com (HELO x48) ([10.238.157.64])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2020 03:23:12 -0700
Date: Thu, 6 Aug 2020 18:22:59 +0800
From: Jason Zeng <jason.zeng@linux.intel.com>
To: Steve Sistare <steven.sistare@oracle.com>
Subject: Re: [PATCH V1 30/32] vfio-pci: save and restore
Message-ID: <20200806102259.GA25634@x48>
References: <1596122076-341293-1-git-send-email-steven.sistare@oracle.com>
 <1596122076-341293-31-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1596122076-341293-31-git-send-email-steven.sistare@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Received-SPF: none client-ip=192.55.52.151;
 envelope-from=jason.zeng@linux.intel.com; helo=mga17.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/06 06:23:16
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
 Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Steve,

On Thu, Jul 30, 2020 at 08:14:34AM -0700, Steve Sistare wrote:
> @@ -3182,6 +3207,51 @@ static Property vfio_pci_dev_properties[] = {
>      DEFINE_PROP_END_OF_LIST(),
>  };
>  
> +static int vfio_pci_post_load(void *opaque, int version_id)
> +{
> +    int vector;
> +    MSIMessage msg;
> +    Error *err = 0;
> +    VFIOPCIDevice *vdev = opaque;
> +    PCIDevice *pdev = &vdev->pdev;
> +
> +    if (msix_enabled(pdev)) {
> +        vfio_msix_enable(vdev);
> +        pdev->msix_function_masked = false;
> +
> +        for (vector = 0; vector < vdev->pdev.msix_entries_nr; vector++) {
> +            if (!msix_is_masked(pdev, vector)) {
> +                msg = msix_get_message(pdev, vector);
> +                vfio_msix_vector_use(pdev, vector, msg);
> +            }
> +        }

It looks to me MSIX re-init here may lose device IRQs and impact
device hardware state?

The re-init will cause the kernel vfio driver to connect the device
MSIX vectors to new eventfds and KVM instance. But before that, device
IRQs will be routed to previous eventfd. Looks these IRQs will be lost.

And the re-init will make the device go through the procedure of
disabling MSIX, enabling INTX, and re-enabling MSIX and vectors.
So if the device is active, its hardware state will be impacted?


Thanks,
Jason

> +
> +    } else if (vfio_pci_read_config(pdev, PCI_INTERRUPT_PIN, 1)) {
> +        vfio_intx_enable(vdev, &err);
> +        if (err) {
> +            error_report_err(err);
> +        }
> +    }
> +
> +    vdev->vbasedev.group->container->reused = false;
> +    vdev->pdev.reused = false;
> +
> +    return 0;
> +}
> +
> +static const VMStateDescription vfio_pci_vmstate = {
> +    .name = "vfio-pci",
> +    .unmigratable = 1,
> +    .mode_mask = VMS_RESTART,
> +    .version_id = 0,
> +    .minimum_version_id = 0,
> +    .post_load = vfio_pci_post_load,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_MSIX(pdev, VFIOPCIDevice),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
>  static void vfio_pci_dev_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(klass);
> @@ -3189,6 +3259,7 @@ static void vfio_pci_dev_class_init(ObjectClass *klass, void *data)
>  
>      dc->reset = vfio_pci_reset;
>      device_class_set_props(dc, vfio_pci_dev_properties);
> +    dc->vmsd = &vfio_pci_vmstate;
>      dc->desc = "VFIO-based PCI device assignment";
>      set_bit(DEVICE_CATEGORY_MISC, dc->categories);
>      pdc->realize = vfio_realize;
> diff --git a/hw/vfio/platform.c b/hw/vfio/platform.c
> index ac2cefc..e6e1a5d 100644
> --- a/hw/vfio/platform.c
> +++ b/hw/vfio/platform.c
> @@ -592,7 +592,7 @@ static int vfio_base_device_init(VFIODevice *vbasedev, Error **errp)
>              return -EBUSY;
>          }
>      }
> -    ret = vfio_get_device(group, vbasedev->name, vbasedev, errp);
> +    ret = vfio_get_device(group, vbasedev->name, vbasedev, 0, errp);
>      if (ret) {
>          vfio_put_group(group);
>          return ret;
> diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
> index bd07c86..c926a24 100644
> --- a/include/hw/pci/pci.h
> +++ b/include/hw/pci/pci.h
> @@ -358,6 +358,7 @@ struct PCIDevice {
>  
>      /* ID of standby device in net_failover pair */
>      char *failover_pair_id;
> +    bool reused;
>  };
>  
>  void pci_register_bar(PCIDevice *pci_dev, int region_num,
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index c78f3ff..4e2a332 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -73,6 +73,8 @@ typedef struct VFIOContainer {
>      unsigned iommu_type;
>      Error *error;
>      bool initialized;
> +    bool reused;
> +    int cid;
>      unsigned long pgsizes;
>      QLIST_HEAD(, VFIOGuestIOMMU) giommu_list;
>      QLIST_HEAD(, VFIOHostDMAWindow) hostwin_list;
> @@ -177,7 +179,7 @@ void vfio_reset_handler(void *opaque);
>  VFIOGroup *vfio_get_group(int groupid, AddressSpace *as, Error **errp);
>  void vfio_put_group(VFIOGroup *group);
>  int vfio_get_device(VFIOGroup *group, const char *name,
> -                    VFIODevice *vbasedev, Error **errp);
> +                    VFIODevice *vbasedev, bool *reused, Error **errp);
>  
>  extern const MemoryRegionOps vfio_region_ops;
>  typedef QLIST_HEAD(VFIOGroupList, VFIOGroup) VFIOGroupList;
> diff --git a/migration/savevm.c b/migration/savevm.c
> index 881dc13..2606cf0 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -1568,7 +1568,7 @@ static int qemu_savevm_state(QEMUFile *f, VMStateMode mode, Error **errp)
>          return -EINVAL;
>      }
>  
> -    if (migrate_use_block()) {
> +    if ((mode & (VMS_SNAPSHOT | VMS_MIGRATE)) && migrate_use_block()) {
>          error_setg(errp, "Block migration and snapshots are incompatible");
>          return -EINVAL;
>      }
> -- 
> 1.8.3.1
> 
> 

