Return-Path: <SRS0=kH2x=XL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E102C49ED7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 09:07:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6AD8214D9
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 09:07:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6AD8214D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60177 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9myY-0000r7-Mq
	for qemu-devel@archiver.kernel.org; Mon, 16 Sep 2019 05:07:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35905)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1i9mxd-0000JF-BL
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 05:06:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1i9mxZ-0008Fx-JX
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 05:06:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47720)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1i9mxZ-0008FW-7c
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 05:06:13 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9248C10B78
 for <qemu-devel@nongnu.org>; Mon, 16 Sep 2019 09:06:11 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.13])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CB9C35D721;
 Mon, 16 Sep 2019 09:06:09 +0000 (UTC)
Date: Mon, 16 Sep 2019 10:06:06 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Message-ID: <20190916090606.GA2887@work-vm>
References: <20190912122514.22504-1-marcandre.lureau@redhat.com>
 <20190912122514.22504-4-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190912122514.22504-4-marcandre.lureau@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Mon, 16 Sep 2019 09:06:11 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 3/6] vmstate: replace DeviceState with
 VMStateIf
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
Cc: mprivozn@redhat.com, pbonzini@redhat.com, berrange@redhat.com,
 qemu-devel@nongnu.org, quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Marc-Andr=E9 Lureau (marcandre.lureau@redhat.com) wrote:
> Replace DeviceState dependency with VMStateIf on vmstate API.
>=20
> Signed-off-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> ---
>  docs/devel/migration.rst     |  2 +-
>  hw/block/onenand.c           |  2 +-
>  hw/core/qdev.c               |  7 ++++---
>  hw/ide/cmd646.c              |  2 +-
>  hw/ide/isa.c                 |  2 +-
>  hw/ide/piix.c                |  2 +-
>  hw/ide/via.c                 |  2 +-
>  hw/misc/max111x.c            |  2 +-
>  hw/net/eepro100.c            |  4 ++--
>  hw/net/vmxnet3.c             |  2 +-
>  hw/nvram/eeprom93xx.c        |  4 ++--
>  hw/ppc/spapr_drc.c           |  9 +++++----
>  hw/ppc/spapr_iommu.c         |  4 ++--
>  hw/s390x/s390-skeys.c        |  2 +-
>  include/migration/register.h |  4 ++--
>  include/migration/vmstate.h  |  8 ++++----
>  migration/savevm.c           | 26 +++++++++++++-------------
>  stubs/vmstate.c              |  4 ++--
>  18 files changed, 45 insertions(+), 43 deletions(-)
>=20
> diff --git a/docs/devel/migration.rst b/docs/devel/migration.rst
> index f7668ae389..c9932194d9 100644
> --- a/docs/devel/migration.rst
> +++ b/docs/devel/migration.rst
> @@ -183,7 +183,7 @@ another to load the state back.
> =20
>  .. code:: c
> =20
> -  int register_savevm_live(DeviceState *dev,
> +  int register_savevm_live(VMStateIf *obj,
>                             const char *idstr,
>                             int instance_id,
>                             int version_id,
> diff --git a/hw/block/onenand.c b/hw/block/onenand.c
> index fcc5a69b90..9c233c12e4 100644
> --- a/hw/block/onenand.c
> +++ b/hw/block/onenand.c
> @@ -822,7 +822,7 @@ static void onenand_realize(DeviceState *dev, Error=
 **errp)
>      onenand_mem_setup(s);
>      sysbus_init_irq(sbd, &s->intr);
>      sysbus_init_mmio(sbd, &s->container);
> -    vmstate_register(dev,
> +    vmstate_register(VMSTATE_IF(dev),
>                       ((s->shift & 0x7f) << 24)
>                       | ((s->id.man & 0xff) << 16)
>                       | ((s->id.dev & 0xff) << 8)
> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
> index 7e083dfcae..ad18c0383d 100644
> --- a/hw/core/qdev.c
> +++ b/hw/core/qdev.c
> @@ -849,7 +849,8 @@ static void device_set_realized(Object *obj, bool v=
alue, Error **errp)
>          dev->canonical_path =3D object_get_canonical_path(OBJECT(dev))=
;
> =20
>          if (qdev_get_vmsd(dev)) {
> -            if (vmstate_register_with_alias_id(dev, -1, qdev_get_vmsd(=
dev), dev,
> +            if (vmstate_register_with_alias_id(VMSTATE_IF(dev),
> +                                               -1, qdev_get_vmsd(dev),=
 dev,
>                                                 dev->instance_id_alias,
>                                                 dev->alias_required_for=
_version,
>                                                 &local_err) < 0) {
> @@ -884,7 +885,7 @@ static void device_set_realized(Object *obj, bool v=
alue, Error **errp)
>                                       local_errp);
>          }
>          if (qdev_get_vmsd(dev)) {
> -            vmstate_unregister(dev, qdev_get_vmsd(dev), dev);
> +            vmstate_unregister(VMSTATE_IF(dev), qdev_get_vmsd(dev), de=
v);
>          }
>          if (dc->unrealize) {
>              local_errp =3D local_err ? NULL : &local_err;
> @@ -908,7 +909,7 @@ child_realize_fail:
>      }
> =20
>      if (qdev_get_vmsd(dev)) {
> -        vmstate_unregister(dev, qdev_get_vmsd(dev), dev);
> +        vmstate_unregister(VMSTATE_IF(dev), qdev_get_vmsd(dev), dev);
>      }
> =20
>  post_realize_fail:
> diff --git a/hw/ide/cmd646.c b/hw/ide/cmd646.c
> index f3ccd11c79..01a982acbc 100644
> --- a/hw/ide/cmd646.c
> +++ b/hw/ide/cmd646.c
> @@ -301,7 +301,7 @@ static void pci_cmd646_ide_realize(PCIDevice *dev, =
Error **errp)
>          ide_register_restart_cb(&d->bus[i]);
>      }
> =20
> -    vmstate_register(DEVICE(dev), 0, &vmstate_ide_pci, d);
> +    vmstate_register(VMSTATE_IF(dev), 0, &vmstate_ide_pci, d);
>      qemu_register_reset(cmd646_reset, d);
>  }
> =20
> diff --git a/hw/ide/isa.c b/hw/ide/isa.c
> index 7b6e283679..9c7f88b2d5 100644
> --- a/hw/ide/isa.c
> +++ b/hw/ide/isa.c
> @@ -75,7 +75,7 @@ static void isa_ide_realizefn(DeviceState *dev, Error=
 **errp)
>      ide_init_ioport(&s->bus, isadev, s->iobase, s->iobase2);
>      isa_init_irq(isadev, &s->irq, s->isairq);
>      ide_init2(&s->bus, s->irq);
> -    vmstate_register(dev, 0, &vmstate_ide_isa, s);
> +    vmstate_register(VMSTATE_IF(dev), 0, &vmstate_ide_isa, s);
>      ide_register_restart_cb(&s->bus);
>  }
> =20
> diff --git a/hw/ide/piix.c b/hw/ide/piix.c
> index fba6bc8bff..cbaee9e2cc 100644
> --- a/hw/ide/piix.c
> +++ b/hw/ide/piix.c
> @@ -159,7 +159,7 @@ static void pci_piix_ide_realize(PCIDevice *dev, Er=
ror **errp)
>      bmdma_setup_bar(d);
>      pci_register_bar(dev, 4, PCI_BASE_ADDRESS_SPACE_IO, &d->bmdma_bar)=
;
> =20
> -    vmstate_register(DEVICE(dev), 0, &vmstate_ide_pci, d);
> +    vmstate_register(VMSTATE_IF(dev), 0, &vmstate_ide_pci, d);
> =20
>      pci_piix_init_ports(d);
>  }
> diff --git a/hw/ide/via.c b/hw/ide/via.c
> index 7087dc676e..6b9d4c6d78 100644
> --- a/hw/ide/via.c
> +++ b/hw/ide/via.c
> @@ -193,7 +193,7 @@ static void via_ide_realize(PCIDevice *dev, Error *=
*errp)
>      bmdma_setup_bar(d);
>      pci_register_bar(dev, 4, PCI_BASE_ADDRESS_SPACE_IO, &d->bmdma_bar)=
;
> =20
> -    vmstate_register(DEVICE(dev), 0, &vmstate_ide_pci, d);
> +    vmstate_register(VMSTATE_IF(dev), 0, &vmstate_ide_pci, d);
> =20
>      for (i =3D 0; i < 2; i++) {
>          ide_bus_new(&d->bus[i], sizeof(d->bus[i]), DEVICE(d), i, 2);
> diff --git a/hw/misc/max111x.c b/hw/misc/max111x.c
> index a713149f16..211008ce02 100644
> --- a/hw/misc/max111x.c
> +++ b/hw/misc/max111x.c
> @@ -146,7 +146,7 @@ static int max111x_init(SSISlave *d, int inputs)
>      s->input[7] =3D 0x80;
>      s->com =3D 0;
> =20
> -    vmstate_register(dev, -1, &vmstate_max111x, s);
> +    vmstate_register(VMSTATE_IF(dev), -1, &vmstate_max111x, s);
>      return 0;
>  }
> =20
> diff --git a/hw/net/eepro100.c b/hw/net/eepro100.c
> index cc2dd8b1c9..cc71a7a036 100644
> --- a/hw/net/eepro100.c
> +++ b/hw/net/eepro100.c
> @@ -1815,7 +1815,7 @@ static void pci_nic_uninit(PCIDevice *pci_dev)
>  {
>      EEPRO100State *s =3D DO_UPCAST(EEPRO100State, dev, pci_dev);
> =20
> -    vmstate_unregister(&pci_dev->qdev, s->vmstate, s);
> +    vmstate_unregister(VMSTATE_IF(&pci_dev->qdev), s->vmstate, s);
>      g_free(s->vmstate);
>      eeprom93xx_free(&pci_dev->qdev, s->eeprom);
>      qemu_del_nic(s->nic);
> @@ -1874,7 +1874,7 @@ static void e100_nic_realize(PCIDevice *pci_dev, =
Error **errp)
> =20
>      s->vmstate =3D g_memdup(&vmstate_eepro100, sizeof(vmstate_eepro100=
));
>      s->vmstate->name =3D qemu_get_queue(s->nic)->model;
> -    vmstate_register(&pci_dev->qdev, -1, s->vmstate, s);
> +    vmstate_register(VMSTATE_IF(&pci_dev->qdev), -1, s->vmstate, s);
>  }
> =20
>  static void eepro100_instance_init(Object *obj)
> diff --git a/hw/net/vmxnet3.c b/hw/net/vmxnet3.c
> index b07adeed9c..8625e93dc9 100644
> --- a/hw/net/vmxnet3.c
> +++ b/hw/net/vmxnet3.c
> @@ -2247,7 +2247,7 @@ static void vmxnet3_pci_uninit(PCIDevice *pci_dev=
)
> =20
>      VMW_CBPRN("Starting uninit...");
> =20
> -    unregister_savevm(dev, "vmxnet3-msix", s);
> +    unregister_savevm(VMSTATE_IF(dev), "vmxnet3-msix", s);
> =20
>      vmxnet3_net_uninit(s);
> =20
> diff --git a/hw/nvram/eeprom93xx.c b/hw/nvram/eeprom93xx.c
> index 5b01b9b03f..07f09549ed 100644
> --- a/hw/nvram/eeprom93xx.c
> +++ b/hw/nvram/eeprom93xx.c
> @@ -321,7 +321,7 @@ eeprom_t *eeprom93xx_new(DeviceState *dev, uint16_t=
 nwords)
>      /* Output DO is tristate, read results in 1. */
>      eeprom->eedo =3D 1;
>      logout("eeprom =3D 0x%p, nwords =3D %u\n", eeprom, nwords);
> -    vmstate_register(dev, 0, &vmstate_eeprom, eeprom);
> +    vmstate_register(VMSTATE_IF(dev), 0, &vmstate_eeprom, eeprom);
>      return eeprom;
>  }
> =20
> @@ -329,7 +329,7 @@ void eeprom93xx_free(DeviceState *dev, eeprom_t *ee=
prom)
>  {
>      /* Destroy EEPROM. */
>      logout("eeprom =3D 0x%p\n", eeprom);
> -    vmstate_unregister(dev, &vmstate_eeprom, eeprom);
> +    vmstate_unregister(VMSTATE_IF(dev), &vmstate_eeprom, eeprom);
>      g_free(eeprom);
>  }
> =20
> diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
> index 62f1a42592..17aeac3801 100644
> --- a/hw/ppc/spapr_drc.c
> +++ b/hw/ppc/spapr_drc.c
> @@ -511,7 +511,7 @@ static void realize(DeviceState *d, Error **errp)
>          error_propagate(errp, err);
>          return;
>      }
> -    vmstate_register(DEVICE(drc), spapr_drc_index(drc), &vmstate_spapr=
_drc,
> +    vmstate_register(VMSTATE_IF(drc), spapr_drc_index(drc), &vmstate_s=
papr_drc,
>                       drc);
>      trace_spapr_drc_realize_complete(spapr_drc_index(drc));
>  }
> @@ -523,7 +523,7 @@ static void unrealize(DeviceState *d, Error **errp)
>      gchar *name;
> =20
>      trace_spapr_drc_unrealize(spapr_drc_index(drc));
> -    vmstate_unregister(DEVICE(drc), &vmstate_spapr_drc, drc);
> +    vmstate_unregister(VMSTATE_IF(drc), &vmstate_spapr_drc, drc);
>      root_container =3D container_get(object_get_root(), DRC_CONTAINER_=
PATH);
>      name =3D g_strdup_printf("%x", spapr_drc_index(drc));
>      object_property_del(root_container, name, errp);
> @@ -619,7 +619,8 @@ static void realize_physical(DeviceState *d, Error =
**errp)
>          return;
>      }
> =20
> -    vmstate_register(DEVICE(drcp), spapr_drc_index(SPAPR_DR_CONNECTOR(=
drcp)),
> +    vmstate_register(VMSTATE_IF(drcp),
> +                     spapr_drc_index(SPAPR_DR_CONNECTOR(drcp)),
>                       &vmstate_spapr_drc_physical, drcp);
>      qemu_register_reset(drc_physical_reset, drcp);
>  }
> @@ -635,7 +636,7 @@ static void unrealize_physical(DeviceState *d, Erro=
r **errp)
>          return;
>      }
> =20
> -    vmstate_unregister(DEVICE(drcp), &vmstate_spapr_drc_physical, drcp=
);
> +    vmstate_unregister(VMSTATE_IF(drcp), &vmstate_spapr_drc_physical, =
drcp);
>      qemu_unregister_reset(drc_physical_reset, drcp);
>  }
> =20
> diff --git a/hw/ppc/spapr_iommu.c b/hw/ppc/spapr_iommu.c
> index e87b3d50f7..b9e7854da9 100644
> --- a/hw/ppc/spapr_iommu.c
> +++ b/hw/ppc/spapr_iommu.c
> @@ -315,7 +315,7 @@ static void spapr_tce_table_realize(DeviceState *de=
v, Error **errp)
> =20
>      QLIST_INSERT_HEAD(&spapr_tce_tables, tcet, list);
> =20
> -    vmstate_register(DEVICE(tcet), tcet->liobn, &vmstate_spapr_tce_tab=
le,
> +    vmstate_register(VMSTATE_IF(tcet), tcet->liobn, &vmstate_spapr_tce=
_table,
>                       tcet);
>  }
> =20
> @@ -418,7 +418,7 @@ static void spapr_tce_table_unrealize(DeviceState *=
dev, Error **errp)
>  {
>      SpaprTceTable *tcet =3D SPAPR_TCE_TABLE(dev);
> =20
> -    vmstate_unregister(DEVICE(tcet), &vmstate_spapr_tce_table, tcet);
> +    vmstate_unregister(VMSTATE_IF(tcet), &vmstate_spapr_tce_table, tce=
t);
> =20
>      QLIST_REMOVE(tcet, list);
> =20
> diff --git a/hw/s390x/s390-skeys.c b/hw/s390x/s390-skeys.c
> index d4807f7777..16b9bbf04d 100644
> --- a/hw/s390x/s390-skeys.c
> +++ b/hw/s390x/s390-skeys.c
> @@ -392,7 +392,7 @@ static inline void s390_skeys_set_migration_enabled=
(Object *obj, bool value,
>          register_savevm_live(NULL, TYPE_S390_SKEYS, 0, 1,
>                               &savevm_s390_storage_keys, ss);
>      } else {
> -        unregister_savevm(DEVICE(ss), TYPE_S390_SKEYS, ss);
> +        unregister_savevm(VMSTATE_IF(ss), TYPE_S390_SKEYS, ss);
>      }
>  }
> =20
> diff --git a/include/migration/register.h b/include/migration/register.=
h
> index 74f1578b29..f22f180286 100644
> --- a/include/migration/register.h
> +++ b/include/migration/register.h
> @@ -70,13 +70,13 @@ typedef struct SaveVMHandlers {
>      int (*resume_prepare)(MigrationState *s, void *opaque);
>  } SaveVMHandlers;
> =20
> -int register_savevm_live(DeviceState *dev,
> +int register_savevm_live(VMStateIf *obj,
>                           const char *idstr,
>                           int instance_id,
>                           int version_id,
>                           const SaveVMHandlers *ops,
>                           void *opaque);
> =20
> -void unregister_savevm(DeviceState *dev, const char *idstr, void *opaq=
ue);
> +void unregister_savevm(VMStateIf *obj, const char *idstr, void *opaque=
);
> =20
>  #endif
> diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
> index bdcf8a1652..1911e37d72 100644
> --- a/include/migration/vmstate.h
> +++ b/include/migration/vmstate.h
> @@ -1116,22 +1116,22 @@ int vmstate_save_state_v(QEMUFile *f, const VMS=
tateDescription *vmsd,
>  bool vmstate_save_needed(const VMStateDescription *vmsd, void *opaque)=
;
> =20
>  /* Returns: 0 on success, -1 on failure */
> -int vmstate_register_with_alias_id(DeviceState *dev, int instance_id,
> +int vmstate_register_with_alias_id(VMStateIf *obj, int instance_id,
>                                     const VMStateDescription *vmsd,
>                                     void *base, int alias_id,
>                                     int required_for_version,
>                                     Error **errp);
> =20
>  /* Returns: 0 on success, -1 on failure */
> -static inline int vmstate_register(DeviceState *dev, int instance_id,
> +static inline int vmstate_register(VMStateIf *obj, int instance_id,
>                                     const VMStateDescription *vmsd,
>                                     void *opaque)
>  {
> -    return vmstate_register_with_alias_id(dev, instance_id, vmsd,
> +    return vmstate_register_with_alias_id(obj, instance_id, vmsd,
>                                            opaque, -1, 0, NULL);
>  }
> =20
> -void vmstate_unregister(DeviceState *dev, const VMStateDescription *vm=
sd,
> +void vmstate_unregister(VMStateIf *obj, const VMStateDescription *vmsd=
,
>                          void *opaque);
> =20
>  struct MemoryRegion;
> diff --git a/migration/savevm.c b/migration/savevm.c
> index 6caa35a679..7902da16e6 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -684,7 +684,7 @@ static void savevm_state_handler_insert(SaveStateEn=
try *nse)
>     of the system, so instance_id should be removed/replaced.
>     Meanwhile pass -1 as instance_id if you do not already have a clear=
ly
>     distinguishing id for all instances of your device class. */
> -int register_savevm_live(DeviceState *dev,
> +int register_savevm_live(VMStateIf *obj,
>                           const char *idstr,
>                           int instance_id,
>                           int version_id,
> @@ -704,8 +704,8 @@ int register_savevm_live(DeviceState *dev,
>          se->is_ram =3D 1;
>      }
> =20
> -    if (dev) {
> -        char *id =3D qdev_get_dev_path(dev);
> +    if (obj) {
> +        char *id =3D vmstate_if_get_id(obj);
>          if (id) {
>              if (snprintf(se->idstr, sizeof(se->idstr), "%s/", id) >=3D
>                  sizeof(se->idstr)) {
> @@ -736,17 +736,17 @@ int register_savevm_live(DeviceState *dev,
>      return 0;
>  }
> =20
> -void unregister_savevm(DeviceState *dev, const char *idstr, void *opaq=
ue)
> +void unregister_savevm(VMStateIf *obj, const char *idstr, void *opaque=
)
>  {
>      SaveStateEntry *se, *new_se;
>      char id[256] =3D "";
> =20
> -    if (dev) {
> -        char *path =3D qdev_get_dev_path(dev);
> -        if (path) {
> -            pstrcpy(id, sizeof(id), path);
> +    if (obj) {
> +        char *oid =3D vmstate_if_get_id(obj);
> +        if (oid) {
> +            pstrcpy(id, sizeof(id), oid);
>              pstrcat(id, sizeof(id), "/");
> -            g_free(path);
> +            g_free(oid);
>          }

And since your previous patch defaults vmstate_if_get_id to return
qdev_get_dev_path that should mean there's no change.


Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

>      }
>      pstrcat(id, sizeof(id), idstr);
> @@ -760,7 +760,7 @@ void unregister_savevm(DeviceState *dev, const char=
 *idstr, void *opaque)
>      }
>  }
> =20
> -int vmstate_register_with_alias_id(DeviceState *dev, int instance_id,
> +int vmstate_register_with_alias_id(VMStateIf *obj, int instance_id,
>                                     const VMStateDescription *vmsd,
>                                     void *opaque, int alias_id,
>                                     int required_for_version,
> @@ -778,8 +778,8 @@ int vmstate_register_with_alias_id(DeviceState *dev=
, int instance_id,
>      se->vmsd =3D vmsd;
>      se->alias_id =3D alias_id;
> =20
> -    if (dev) {
> -        char *id =3D qdev_get_dev_path(dev);
> +    if (obj) {
> +        char *id =3D vmstate_if_get_id(obj);
>          if (id) {
>              if (snprintf(se->idstr, sizeof(se->idstr), "%s/", id) >=3D
>                  sizeof(se->idstr)) {
> @@ -810,7 +810,7 @@ int vmstate_register_with_alias_id(DeviceState *dev=
, int instance_id,
>      return 0;
>  }
> =20
> -void vmstate_unregister(DeviceState *dev, const VMStateDescription *vm=
sd,
> +void vmstate_unregister(VMStateIf *obj, const VMStateDescription *vmsd=
,
>                          void *opaque)
>  {
>      SaveStateEntry *se, *new_se;
> diff --git a/stubs/vmstate.c b/stubs/vmstate.c
> index e1e89b87f0..6951d9fdc5 100644
> --- a/stubs/vmstate.c
> +++ b/stubs/vmstate.c
> @@ -3,7 +3,7 @@
> =20
>  const VMStateDescription vmstate_dummy =3D {};
> =20
> -int vmstate_register_with_alias_id(DeviceState *dev,
> +int vmstate_register_with_alias_id(VMStateIf *obj,
>                                     int instance_id,
>                                     const VMStateDescription *vmsd,
>                                     void *base, int alias_id,
> @@ -13,7 +13,7 @@ int vmstate_register_with_alias_id(DeviceState *dev,
>      return 0;
>  }
> =20
> -void vmstate_unregister(DeviceState *dev,
> +void vmstate_unregister(VMStateIf *obj,
>                          const VMStateDescription *vmsd,
>                          void *opaque)
>  {
> --=20
> 2.23.0
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

