Return-Path: <SRS0=NWXH=WU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AED5EC3A5A3
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Aug 2019 10:06:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2979220870
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Aug 2019 10:06:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="eQYpaTeO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2979220870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36644 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1Svz-0004PR-W0
	for qemu-devel@archiver.kernel.org; Sat, 24 Aug 2019 06:06:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50321)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1i1Sqg-00013U-DD
 for qemu-devel@nongnu.org; Sat, 24 Aug 2019 06:00:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1i1Sqe-0000Wm-DA
 for qemu-devel@nongnu.org; Sat, 24 Aug 2019 06:00:42 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:38917 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1i1SqV-0000FF-GX; Sat, 24 Aug 2019 06:00:32 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46Fv06394Hz9sMr; Sat, 24 Aug 2019 20:00:22 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1566640822;
 bh=+jeSq+wkgqfuMpRp8ohv2uAqJMVSeYc3u3uBqP1UQas=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=eQYpaTeOp3aO2/fND1NB6H3cVqrTW0bh7CMwYTf4281kufuCIEJKU/gb2nVTcpbeo
 e9Jygx4we9wdsY2hmQf1ndCTZVrnmWlHZJB6+J2vbnibDunbxgjUffbDqIK54O3vhN
 sNBPy4QpCKamLXC2MZgWoljZ/onRsc3pMVvf2+0c=
Date: Sat, 24 Aug 2019 19:50:13 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Damien Hedde <damien.hedde@greensocs.com>
Message-ID: <20190824095013.GL3027@umbus.fritz.box>
References: <20190821163341.16309-1-damien.hedde@greensocs.com>
 <20190821163341.16309-2-damien.hedde@greensocs.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="NPWyolIJAVLYbHY6"
Content-Disposition: inline
In-Reply-To: <20190821163341.16309-2-damien.hedde@greensocs.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [PATCH v4 01/10] add device_legacy_reset function
 to prepare for reset api change
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
Cc: Fam Zheng <fam@euphon.net>, peter.maydell@linaro.org,
 Collin Walling <walling@linux.ibm.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>, edgar.iglesias@xilinx.com,
 qemu-block@nongnu.org, David Hildenbrand <david@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, philmd@redhat.com,
 ehabkost@redhat.com, qemu-s390x@nongnu.org, qemu-arm@nongnu.org,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
 John Snow <jsnow@redhat.com>, Richard Henderson <rth@twiddle.net>,
 berrange@redhat.com, Cornelia Huck <cohuck@redhat.com>,
 mark.burton@greensocs.com, qemu-ppc@nongnu.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--NPWyolIJAVLYbHY6
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 21, 2019 at 06:33:32PM +0200, Damien Hedde wrote:
> Provide a temporary device_legacy_reset function doing what
> device_reset does to prepare for the transition with Resettable
> API.
>=20
> All occurrence of device_reset in the code tree are also replaced
> by device_legacy_reset.
>=20
> The new resettable API has different prototype and semantics
> (resetting child buses as well as the specified device). Subsequent
> commits will make the changeover for each call site individually; once
> that is complete device_legacy_reset() will be removed.
>=20
> Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

ppc parts
Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: "Daniel P. Berrang=E9" <berrange@redhat.com>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Cc: Richard Henderson <rth@twiddle.net>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> Cc: John Snow <jsnow@redhat.com>
> Cc: "C=E9dric Le Goater" <clg@kaod.org>
> Cc: Collin Walling <walling@linux.ibm.com>
> Cc: Cornelia Huck <cohuck@redhat.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Halil Pasic <pasic@linux.ibm.com>
> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> Cc: Dmitry Fleytman <dmitry.fleytman@gmail.com>
> Cc: Fam Zheng <fam@euphon.net>
> Cc: qemu-block@nongnu.org
> Cc: qemu-ppc@nongnu.org
> Cc: qemu-s390x@nongnu.org
> Cc: qemu-arm@nongnu.org
> ---
>  hw/audio/intel-hda.c     | 2 +-
>  hw/core/qdev.c           | 6 +++---
>  hw/hyperv/hyperv.c       | 2 +-
>  hw/i386/pc.c             | 2 +-
>  hw/ide/microdrive.c      | 8 ++++----
>  hw/intc/spapr_xive.c     | 2 +-
>  hw/ppc/pnv_psi.c         | 2 +-
>  hw/ppc/spapr_pci.c       | 2 +-
>  hw/ppc/spapr_vio.c       | 2 +-
>  hw/s390x/s390-pci-inst.c | 2 +-
>  hw/scsi/vmw_pvscsi.c     | 2 +-
>  hw/sd/omap_mmc.c         | 2 +-
>  hw/sd/pl181.c            | 2 +-
>  include/hw/qdev-core.h   | 4 ++--
>  14 files changed, 20 insertions(+), 20 deletions(-)
>=20
> diff --git a/hw/audio/intel-hda.c b/hw/audio/intel-hda.c
> index 6ecd383540..27b71c57cf 100644
> --- a/hw/audio/intel-hda.c
> +++ b/hw/audio/intel-hda.c
> @@ -1087,7 +1087,7 @@ static void intel_hda_reset(DeviceState *dev)
>      QTAILQ_FOREACH(kid, &d->codecs.qbus.children, sibling) {
>          DeviceState *qdev =3D kid->child;
>          cdev =3D HDA_CODEC_DEVICE(qdev);
> -        device_reset(DEVICE(cdev));
> +        device_legacy_reset(DEVICE(cdev));
>          d->state_sts |=3D (1 << cdev->cad);
>      }
>      intel_hda_update_irq(d);
> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
> index 60d66c2f39..a95d4fa87d 100644
> --- a/hw/core/qdev.c
> +++ b/hw/core/qdev.c
> @@ -257,7 +257,7 @@ HotplugHandler *qdev_get_hotplug_handler(DeviceState =
*dev)
> =20
>  static int qdev_reset_one(DeviceState *dev, void *opaque)
>  {
> -    device_reset(dev);
> +    device_legacy_reset(dev);
> =20
>      return 0;
>  }
> @@ -865,7 +865,7 @@ static void device_set_realized(Object *obj, bool val=
ue, Error **errp)
>              }
>          }
>          if (dev->hotplugged) {
> -            device_reset(dev);
> +            device_legacy_reset(dev);
>          }
>          dev->pending_deleted_event =3D false;
> =20
> @@ -1087,7 +1087,7 @@ void device_class_set_parent_unrealize(DeviceClass =
*dc,
>      dc->unrealize =3D dev_unrealize;
>  }
> =20
> -void device_reset(DeviceState *dev)
> +void device_legacy_reset(DeviceState *dev)
>  {
>      DeviceClass *klass =3D DEVICE_GET_CLASS(dev);
> =20
> diff --git a/hw/hyperv/hyperv.c b/hw/hyperv/hyperv.c
> index 6ebf31c310..cd9db3cb5c 100644
> --- a/hw/hyperv/hyperv.c
> +++ b/hw/hyperv/hyperv.c
> @@ -140,7 +140,7 @@ void hyperv_synic_reset(CPUState *cs)
>      SynICState *synic =3D get_synic(cs);
> =20
>      if (synic) {
> -        device_reset(DEVICE(synic));
> +        device_legacy_reset(DEVICE(synic));
>      }
>  }
> =20
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 3ab4bcb3ca..f33a8de42f 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -2826,7 +2826,7 @@ static void pc_machine_reset(MachineState *machine)
>          cpu =3D X86_CPU(cs);
> =20
>          if (cpu->apic_state) {
> -            device_reset(cpu->apic_state);
> +            device_legacy_reset(cpu->apic_state);
>          }
>      }
>  }
> diff --git a/hw/ide/microdrive.c b/hw/ide/microdrive.c
> index b0272ea14b..6b30e36ed8 100644
> --- a/hw/ide/microdrive.c
> +++ b/hw/ide/microdrive.c
> @@ -173,7 +173,7 @@ static void md_attr_write(PCMCIACardState *card, uint=
32_t at, uint8_t value)
>      case 0x00:	/* Configuration Option Register */
>          s->opt =3D value & 0xcf;
>          if (value & OPT_SRESET) {
> -            device_reset(DEVICE(s));
> +            device_legacy_reset(DEVICE(s));
>          }
>          md_interrupt_update(s);
>          break;
> @@ -316,7 +316,7 @@ static void md_common_write(PCMCIACardState *card, ui=
nt32_t at, uint16_t value)
>      case 0xe:	/* Device Control */
>          s->ctrl =3D value;
>          if (value & CTRL_SRST) {
> -            device_reset(DEVICE(s));
> +            device_legacy_reset(DEVICE(s));
>          }
>          md_interrupt_update(s);
>          break;
> @@ -541,7 +541,7 @@ static int dscm1xxxx_attach(PCMCIACardState *card)
>      md->attr_base =3D pcc->cis[0x74] | (pcc->cis[0x76] << 8);
>      md->io_base =3D 0x0;
> =20
> -    device_reset(DEVICE(md));
> +    device_legacy_reset(DEVICE(md));
>      md_interrupt_update(md);
> =20
>      return 0;
> @@ -551,7 +551,7 @@ static int dscm1xxxx_detach(PCMCIACardState *card)
>  {
>      MicroDriveState *md =3D MICRODRIVE(card);
> =20
> -    device_reset(DEVICE(md));
> +    device_legacy_reset(DEVICE(md));
>      return 0;
>  }
> =20
> diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
> index aad981cb78..a0f1787ee0 100644
> --- a/hw/intc/spapr_xive.c
> +++ b/hw/intc/spapr_xive.c
> @@ -1514,7 +1514,7 @@ static target_ulong h_int_reset(PowerPCCPU *cpu,
>          return H_PARAMETER;
>      }
> =20
> -    device_reset(DEVICE(xive));
> +    device_legacy_reset(DEVICE(xive));
> =20
>      if (kvm_irqchip_in_kernel()) {
>          Error *local_err =3D NULL;
> diff --git a/hw/ppc/pnv_psi.c b/hw/ppc/pnv_psi.c
> index 88ba8e7b9b..bfdc30d4e1 100644
> --- a/hw/ppc/pnv_psi.c
> +++ b/hw/ppc/pnv_psi.c
> @@ -705,7 +705,7 @@ static void pnv_psi_p9_mmio_write(void *opaque, hwadd=
r addr,
>          break;
>      case PSIHB9_INTERRUPT_CONTROL:
>          if (val & PSIHB9_IRQ_RESET) {
> -            device_reset(DEVICE(&psi9->source));
> +            device_legacy_reset(DEVICE(&psi9->source));
>          }
>          psi->regs[reg] =3D val;
>          break;
> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> index bf31fd854c..f4c918be8b 100644
> --- a/hw/ppc/spapr_pci.c
> +++ b/hw/ppc/spapr_pci.c
> @@ -2031,7 +2031,7 @@ static int spapr_phb_children_reset(Object *child, =
void *opaque)
>      DeviceState *dev =3D (DeviceState *) object_dynamic_cast(child, TYPE=
_DEVICE);
> =20
>      if (dev) {
> -        device_reset(dev);
> +        device_legacy_reset(dev);
>      }
> =20
>      return 0;
> diff --git a/hw/ppc/spapr_vio.c b/hw/ppc/spapr_vio.c
> index 0803649658..ff7ee4d822 100644
> --- a/hw/ppc/spapr_vio.c
> +++ b/hw/ppc/spapr_vio.c
> @@ -305,7 +305,7 @@ int spapr_vio_send_crq(SpaprVioDevice *dev, uint8_t *=
crq)
>  static void spapr_vio_quiesce_one(SpaprVioDevice *dev)
>  {
>      if (dev->tcet) {
> -        device_reset(DEVICE(dev->tcet));
> +        device_legacy_reset(DEVICE(dev->tcet));
>      }
>      free_crq(dev);
>  }
> diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
> index 00235148be..93cda37c27 100644
> --- a/hw/s390x/s390-pci-inst.c
> +++ b/hw/s390x/s390-pci-inst.c
> @@ -242,7 +242,7 @@ int clp_service_call(S390CPU *cpu, uint8_t r2, uintpt=
r_t ra)
>                  stw_p(&ressetpci->hdr.rsp, CLP_RC_SETPCIFN_FHOP);
>                  goto out;
>              }
> -            device_reset(DEVICE(pbdev));
> +            device_legacy_reset(DEVICE(pbdev));
>              pbdev->fh &=3D ~FH_MASK_ENABLE;
>              pbdev->state =3D ZPCI_FS_DISABLED;
>              stl_p(&ressetpci->fh, pbdev->fh);
> diff --git a/hw/scsi/vmw_pvscsi.c b/hw/scsi/vmw_pvscsi.c
> index 452a3b63b2..7baab1532f 100644
> --- a/hw/scsi/vmw_pvscsi.c
> +++ b/hw/scsi/vmw_pvscsi.c
> @@ -838,7 +838,7 @@ pvscsi_on_cmd_reset_device(PVSCSIState *s)
> =20
>      if (sdev !=3D NULL) {
>          s->resetting++;
> -        device_reset(&sdev->qdev);
> +        device_legacy_reset(&sdev->qdev);
>          s->resetting--;
>          return PVSCSI_COMMAND_PROCESSING_SUCCEEDED;
>      }
> diff --git a/hw/sd/omap_mmc.c b/hw/sd/omap_mmc.c
> index c6e516b611..4088a8a80b 100644
> --- a/hw/sd/omap_mmc.c
> +++ b/hw/sd/omap_mmc.c
> @@ -318,7 +318,7 @@ void omap_mmc_reset(struct omap_mmc_s *host)
>       * into any bus, and we must reset it manually. When omap_mmc is
>       * QOMified this must move into the QOM reset function.
>       */
> -    device_reset(DEVICE(host->card));
> +    device_legacy_reset(DEVICE(host->card));
>  }
> =20
>  static uint64_t omap_mmc_read(void *opaque, hwaddr offset,
> diff --git a/hw/sd/pl181.c b/hw/sd/pl181.c
> index 8033fe455d..2b3776a6a0 100644
> --- a/hw/sd/pl181.c
> +++ b/hw/sd/pl181.c
> @@ -482,7 +482,7 @@ static void pl181_reset(DeviceState *d)
>      /* Since we're still using the legacy SD API the card is not plugged
>       * into any bus, and we must reset it manually.
>       */
> -    device_reset(DEVICE(s->card));
> +    device_legacy_reset(DEVICE(s->card));
>  }
> =20
>  static void pl181_init(Object *obj)
> diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
> index de70b7a19a..09e6dfd664 100644
> --- a/include/hw/qdev-core.h
> +++ b/include/hw/qdev-core.h
> @@ -406,11 +406,11 @@ char *qdev_get_own_fw_dev_path_from_handler(BusStat=
e *bus, DeviceState *dev);
>  void qdev_machine_init(void);
> =20
>  /**
> - * @device_reset
> + * device_legacy_reset:
>   *
>   * Reset a single device (by calling the reset method).
>   */
> -void device_reset(DeviceState *dev);
> +void device_legacy_reset(DeviceState *dev);
> =20
>  void device_class_set_parent_reset(DeviceClass *dc,
>                                     DeviceReset dev_reset,

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--NPWyolIJAVLYbHY6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl1hCFUACgkQbDjKyiDZ
s5KrFQ/7BwQ5VU1H8da8yaUfCKcPtsIT4OGMst4oMd6j/cN9CBE/lu7hAYSErBAz
7cEUuO9ZiA/XQjbqdMf6TpaIfCU0l+nDhMw5AarfgwlNed4LWoKoGWtPpfIEBDYP
pvjC44r4t6hn1CwC5EXpUqnqZ3jp4omLDWE8WvfOkgymUdS5u0SYDIFBNPXzKifs
CBG+gYcm3ksn2buA77KF2yafCIP6LOWIF2yMeDUPPBECNTZ6XLTGZ6o3rEBPak3A
TjNGPbN0BK+2kPPyL0hZ7Z9D4qzfgXeiMab0sTpFQRwe56QcCM2L/R4+cn2qI4jd
8M18SWKpQqZtZAQ0fyz15ycMYvC3JJNzgQghUPq2TEAStCcro8GeAz67FJsPfKG9
EW9F8GCPvKX5SPrh9Ktw85+rchgSJoaIWHbQX+wURueUhodmS2y9iAsXErfc4kMV
h5rcE2SO63e5M8RLK7J7xruVYnFb7JQAJFjcOgt4rLHYghAuJEA0wOIr4QBILQaj
bZr4LhqLpheifRvkZz5zfjtU4YYzIg61bjQGqEzm5lBEmJaXD9lkAsQCLZM9icNu
BmEjchUn1tXyhuO0V9ZylWlhAI3hatIm0tCuXFM+MTNjmZFuWmqdaNOzOZmBccpi
iBQIECZGcuQyrph3njPdKhcquy10Xz+Ti2eRYNXMK6S8QT+Ryv4=
=gy7b
-----END PGP SIGNATURE-----

--NPWyolIJAVLYbHY6--

