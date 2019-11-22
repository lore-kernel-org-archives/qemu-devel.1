Return-Path: <SRS0=TsRd=ZO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1909CC432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 18:07:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D81592070E
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 18:07:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NtlA9F5f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D81592070E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53594 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iYDKq-0000OO-9L
	for qemu-devel@archiver.kernel.org; Fri, 22 Nov 2019 13:07:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60579)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.williamson@redhat.com>) id 1iYCpm-0000HV-Kl
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 12:35:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.williamson@redhat.com>) id 1iYCph-0000Qv-FA
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 12:35:04 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:30779
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
 id 1iYCpc-0000Mg-OJ
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 12:34:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574444087;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gPiGoizCM76GX18nThuwiCXe74wPxfqP7dXCPVvRnKA=;
 b=NtlA9F5fnQCGCOLWszA0iCUvIpfD2FmufoK2EdprYAnaUQT7GsRKpdVCKcxSAHoNcRKXWr
 DpgXj9npSN5cawqmoVAudYnOVS4LKhw6MddwbUovNu5vSc5jU+b1lrGIoSLEfpKPfOzCjz
 5MR7599rwvMnfuIcrY7QRBBGeqdCcRU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-47-tSXv6F1LM9yoTod1VORT6Q-1; Fri, 22 Nov 2019 12:34:46 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6356A80268A;
 Fri, 22 Nov 2019 17:34:45 +0000 (UTC)
Received: from x1.home (ovpn-116-56.phx2.redhat.com [10.3.116.56])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C32797700B;
 Fri, 22 Nov 2019 17:34:38 +0000 (UTC)
Date: Fri, 22 Nov 2019 10:34:38 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Subject: Re: [RFC PATCH-for-5.0] hw/pci-host: Add Kconfig selector for IGD
 PCIe pass-through
Message-ID: <20191122103438.5cfa0570@x1.home>
In-Reply-To: <20191122172201.11456-1-philmd@redhat.com>
References: <20191122172201.11456-1-philmd@redhat.com>
Organization: Red Hat
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: tSXv6F1LM9yoTod1VORT6Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Thomas Huth <thuth@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 22 Nov 2019 18:22:01 +0100
Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:

> Introduce a kconfig selector to allow builds without Intel
> Integrated Graphics Device GPU PCIe passthrough.
> We keep the default as enabled.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
> RFC because to be able to use the Kconfig-generated
> "config-devices.h" header we have to move this device
> out of $common-obj and build i440fx.o on a per-target
> basis, which is not optimal...
> ---
>  hw/pci-host/i440fx.c      | 9 ++++++++-
>  hw/vfio/pci-quirks.c      | 6 ++++++
>  hw/pci-host/Kconfig       | 5 +++++
>  hw/pci-host/Makefile.objs | 2 +-
>  4 files changed, 20 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/pci-host/i440fx.c b/hw/pci-host/i440fx.c
> index f27131102d..41e93581f4 100644
> --- a/hw/pci-host/i440fx.c
> +++ b/hw/pci-host/i440fx.c
> @@ -34,6 +34,7 @@
>  #include "hw/pci-host/pam.h"
>  #include "qapi/visitor.h"
>  #include "qemu/error-report.h"
> +#include "config-devices.h"
> =20
>  /*
>   * I440FX chipset data sheet.
> @@ -386,6 +387,8 @@ static const TypeInfo i440fx_info =3D {
>      },
>  };
> =20
> +#ifdef CONFIG_INTEL_IGD_PASSTHROUGH
> +
>  /* IGD Passthrough Host Bridge. */
>  typedef struct {
>      uint8_t offset;
> @@ -470,6 +473,8 @@ static const TypeInfo igd_passthrough_i440fx_info =3D=
 {
>      .class_init    =3D igd_passthrough_i440fx_class_init,
>  };
> =20
> +#endif /* CONFIG_INTEL_IGD_PASSTHROUGH */
> +
>  static const char *i440fx_pcihost_root_bus_path(PCIHostState *host_bridg=
e,
>                                                  PCIBus *rootbus)
>  {
> @@ -514,8 +519,10 @@ static const TypeInfo i440fx_pcihost_info =3D {
>  static void i440fx_register_types(void)
>  {
>      type_register_static(&i440fx_info);
> -    type_register_static(&igd_passthrough_i440fx_info);
>      type_register_static(&i440fx_pcihost_info);
> +#ifdef CONFIG_INTEL_IGD_PASSTHROUGH
> +    type_register_static(&igd_passthrough_i440fx_info);
> +#endif /* CONFIG_INTEL_IGD_PASSTHROUGH */
>  }
> =20

Note that this IGD thing has nothing to do with the one below in vfio
code.  AIUI, the one above is specific to Xen and very unfortunately
named and placed to seem more generic than it is.  vfio IGD
*assignment* (not passthrough) has no dependency on this, so please
don't link them together.  Thanks,

Alex

>  type_init(i440fx_register_types)
> diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
> index 136f3a9ad6..858148fa39 100644
> --- a/hw/vfio/pci-quirks.c
> +++ b/hw/vfio/pci-quirks.c
> @@ -1166,6 +1166,8 @@ static void vfio_probe_rtl8168_bar2_quirk(VFIOPCIDe=
vice *vdev, int nr)
>      trace_vfio_quirk_rtl8168_probe(vdev->vbasedev.name);
>  }
> =20
> +#ifdef CONFIG_INTEL_IGD_PASSTHROUGH
> +
>  /*
>   * Intel IGD support
>   *
> @@ -1811,6 +1813,8 @@ out:
>      g_free(lpc);
>  }
> =20
> +#endif /* CONFIG_INTEL_IGD_PASSTHROUGH */
> +
>  /*
>   * Common quirk probe entry points.
>   */
> @@ -1860,7 +1864,9 @@ void vfio_bar_quirk_setup(VFIOPCIDevice *vdev, int =
nr)
>      vfio_probe_nvidia_bar5_quirk(vdev, nr);
>      vfio_probe_nvidia_bar0_quirk(vdev, nr);
>      vfio_probe_rtl8168_bar2_quirk(vdev, nr);
> +#ifdef CONFIG_INTEL_IGD_PASSTHROUGH
>      vfio_probe_igd_bar4_quirk(vdev, nr);
> +#endif /* CONFIG_INTEL_IGD_PASSTHROUGH */
>  }
> =20
>  void vfio_bar_quirk_exit(VFIOPCIDevice *vdev, int nr)
> diff --git a/hw/pci-host/Kconfig b/hw/pci-host/Kconfig
> index b0aa8351c4..0b7539765a 100644
> --- a/hw/pci-host/Kconfig
> +++ b/hw/pci-host/Kconfig
> @@ -1,6 +1,10 @@
>  config PAM
>      bool
> =20
> +config INTEL_IGD_PASSTHROUGH
> +    default y
> +    bool
> +
>  config PREP_PCI
>      bool
>      select PCI
> @@ -32,6 +36,7 @@ config PCI_I440FX
>      bool
>      select PCI
>      select PAM
> +    imply INTEL_IGD_PASSTHROUGH
> =20
>  config PCI_EXPRESS_Q35
>      bool
> diff --git a/hw/pci-host/Makefile.objs b/hw/pci-host/Makefile.objs
> index efd752b766..3c925192dd 100644
> --- a/hw/pci-host/Makefile.objs
> +++ b/hw/pci-host/Makefile.objs
> @@ -13,7 +13,7 @@ common-obj-$(CONFIG_VERSATILE_PCI) +=3D versatile.o
> =20
>  common-obj-$(CONFIG_PCI_SABRE) +=3D sabre.o
>  common-obj-$(CONFIG_FULONG) +=3D bonito.o
> -common-obj-$(CONFIG_PCI_I440FX) +=3D i440fx.o
> +obj-$(CONFIG_PCI_I440FX) +=3D i440fx.o
>  common-obj-$(CONFIG_PCI_EXPRESS_Q35) +=3D q35.o
>  common-obj-$(CONFIG_PCI_EXPRESS_GENERIC_BRIDGE) +=3D gpex.o
>  common-obj-$(CONFIG_PCI_EXPRESS_XILINX) +=3D xilinx-pcie.o


