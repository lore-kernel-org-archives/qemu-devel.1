Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1493C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 01:19:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CAE020715
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 01:19:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="f3kybrPl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CAE020715
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58950 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIia2-0002lK-G5
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 21:19:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56022)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kIiXg-0008TT-D1; Wed, 16 Sep 2020 21:16:56 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:49533 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kIiXc-0002Ru-En; Wed, 16 Sep 2020 21:16:56 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4BsJvx1Z8Lz9sV6; Thu, 17 Sep 2020 11:16:44 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1600305405;
 bh=Wc3VykqGzaeb8hZEoDfWDPV9hCpyiAiimsRNX1MLfBg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=f3kybrPlB0cTG9dg3TZHvuIJGMrxky/IYwj6ZPcVxV6AWqQf0n+GIxbbR7Q32p4Md
 p6GDcWTdqdI1D9yc9L6oBSIfTfhFlR9n3dXQsC/r1gdGgb1Q+inzIkVBofHGU8B3Mz
 XVhzBB+1Dd9/h37qEzgPbFKVZ9lb2J90wP3wuDTk=
Date: Thu, 17 Sep 2020 10:44:34 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Eduardo Habkost <ehabkost@redhat.com>
Subject: Re: [PATCH 2/2] qom: Use DECLARE_INTERFACE_CHECKER macro
Message-ID: <20200917004434.GF5258@yekko.fritz.box>
References: <20200916223258.599367-1-ehabkost@redhat.com>
 <20200916223258.599367-3-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="NQTVMVnDVuULnIzU"
Content-Disposition: inline
In-Reply-To: <20200916223258.599367-3-ehabkost@redhat.com>
Received-SPF: pass client-ip=2401:3900:2:1::2; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Daniel P. Berrange" <berrange@redhat.com>, Corey Minyard <minyard@acm.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-ppc@nongnu.org,
 Juan Quintela <quintela@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-devel@nongnu.org,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-arm@nongnu.org,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>,
 =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--NQTVMVnDVuULnIzU
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 16, 2020 at 06:32:58PM -0400, Eduardo Habkost wrote:
> Mechanical search/replace to use the new
> DECLARE_INTERFACE_CHECKER macro instead of manually defining
> macros using INTERFACE_CHECK.
>=20
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

ppc parts
Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
> This is an alternative to the patches submitted at
> https://lore.kernel.org/qemu-devel/20200916193101.511600-3-ehabkost@redha=
t.com/
> https://lore.kernel.org/qemu-devel/20200916193101.511600-4-ehabkost@redha=
t.com/
> ---
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Igor Mammedov <imammedo@redhat.com>
> Cc: Corey Minyard <minyard@acm.org>
> Cc: "C=E9dric Le Goater" <clg@kaod.org>
> Cc: David Gibson <david@gibson.dropbear.id.au>
> Cc: "Herv=E9 Poussineau" <hpoussin@reactos.org>
> Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
> Cc: Juan Quintela <quintela@redhat.com>
> Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: "Daniel P. Berrang=E9" <berrange@redhat.com>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Cc: Stefan Berger <stefanb@linux.ibm.com>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: qemu-devel@nongnu.org
> Cc: qemu-ppc@nongnu.org
> Cc: qemu-arm@nongnu.org
> ---
>  include/hw/acpi/acpi_dev_interface.h |  5 ++---
>  include/hw/arm/linux-boot-if.h       |  4 ++--
>  include/hw/fw-path-provider.h        |  4 ++--
>  include/hw/hotplug.h                 |  4 ++--
>  include/hw/intc/intc.h               |  5 ++---
>  include/hw/ipmi/ipmi.h               |  4 ++--
>  include/hw/isa/isa.h                 |  4 ++--
>  include/hw/mem/memory-device.h       |  4 ++--
>  include/hw/nmi.h                     |  4 ++--
>  include/hw/ppc/pnv_xscom.h           |  4 ++--
>  include/hw/ppc/spapr_irq.h           |  4 ++--
>  include/hw/ppc/xics.h                |  4 ++--
>  include/hw/ppc/xive.h                | 12 ++++++------
>  include/hw/rdma/rdma.h               |  5 ++---
>  include/hw/rtc/m48t59.h              |  4 ++--
>  include/hw/stream.h                  |  4 ++--
>  include/hw/vmstate-if.h              |  4 ++--
>  include/qom/object_interfaces.h      |  5 ++---
>  include/sysemu/tpm.h                 |  4 ++--
>  target/arm/idau.h                    |  4 ++--
>  tests/check-qom-interface.c          |  4 ++--
>  21 files changed, 46 insertions(+), 50 deletions(-)
>=20
> diff --git a/include/hw/acpi/acpi_dev_interface.h b/include/hw/acpi/acpi_=
dev_interface.h
> index 9adf1e4706..96aa63919a 100644
> --- a/include/hw/acpi/acpi_dev_interface.h
> +++ b/include/hw/acpi/acpi_dev_interface.h
> @@ -21,9 +21,8 @@ typedef enum {
>  typedef struct AcpiDeviceIfClass AcpiDeviceIfClass;
>  DECLARE_CLASS_CHECKERS(AcpiDeviceIfClass, ACPI_DEVICE_IF,
>                         TYPE_ACPI_DEVICE_IF)
> -#define ACPI_DEVICE_IF(obj) \
> -     INTERFACE_CHECK(AcpiDeviceIf, (obj), \
> -                     TYPE_ACPI_DEVICE_IF)
> +DECLARE_INTERFACE_CHECKER(AcpiDeviceIf, ACPI_DEVICE_IF,
> +                          TYPE_ACPI_DEVICE_IF)
> =20
>  typedef struct AcpiDeviceIf AcpiDeviceIf;
> =20
> diff --git a/include/hw/arm/linux-boot-if.h b/include/hw/arm/linux-boot-i=
f.h
> index c85f33b2c5..856d95831c 100644
> --- a/include/hw/arm/linux-boot-if.h
> +++ b/include/hw/arm/linux-boot-if.h
> @@ -12,8 +12,8 @@
>  typedef struct ARMLinuxBootIfClass ARMLinuxBootIfClass;
>  DECLARE_CLASS_CHECKERS(ARMLinuxBootIfClass, ARM_LINUX_BOOT_IF,
>                         TYPE_ARM_LINUX_BOOT_IF)
> -#define ARM_LINUX_BOOT_IF(obj) \
> -    INTERFACE_CHECK(ARMLinuxBootIf, (obj), TYPE_ARM_LINUX_BOOT_IF)
> +DECLARE_INTERFACE_CHECKER(ARMLinuxBootIf, ARM_LINUX_BOOT_IF,
> +                          TYPE_ARM_LINUX_BOOT_IF)
> =20
>  typedef struct ARMLinuxBootIf ARMLinuxBootIf;
> =20
> diff --git a/include/hw/fw-path-provider.h b/include/hw/fw-path-provider.h
> index 8e1d45651c..93d5fdb6c3 100644
> --- a/include/hw/fw-path-provider.h
> +++ b/include/hw/fw-path-provider.h
> @@ -25,8 +25,8 @@
>  typedef struct FWPathProviderClass FWPathProviderClass;
>  DECLARE_CLASS_CHECKERS(FWPathProviderClass, FW_PATH_PROVIDER,
>                         TYPE_FW_PATH_PROVIDER)
> -#define FW_PATH_PROVIDER(obj) \
> -     INTERFACE_CHECK(FWPathProvider, (obj), TYPE_FW_PATH_PROVIDER)
> +DECLARE_INTERFACE_CHECKER(FWPathProvider, FW_PATH_PROVIDER,
> +                          TYPE_FW_PATH_PROVIDER)
> =20
>  typedef struct FWPathProvider FWPathProvider;
> =20
> diff --git a/include/hw/hotplug.h b/include/hw/hotplug.h
> index e15f59c8b3..727c70ca9a 100644
> --- a/include/hw/hotplug.h
> +++ b/include/hw/hotplug.h
> @@ -19,8 +19,8 @@
>  typedef struct HotplugHandlerClass HotplugHandlerClass;
>  DECLARE_CLASS_CHECKERS(HotplugHandlerClass, HOTPLUG_HANDLER,
>                         TYPE_HOTPLUG_HANDLER)
> -#define HOTPLUG_HANDLER(obj) \
> -     INTERFACE_CHECK(HotplugHandler, (obj), TYPE_HOTPLUG_HANDLER)
> +DECLARE_INTERFACE_CHECKER(HotplugHandler, HOTPLUG_HANDLER,
> +                          TYPE_HOTPLUG_HANDLER)
> =20
>  typedef struct HotplugHandler HotplugHandler;
> =20
> diff --git a/include/hw/intc/intc.h b/include/hw/intc/intc.h
> index 7018f608ca..9f36c9c14f 100644
> --- a/include/hw/intc/intc.h
> +++ b/include/hw/intc/intc.h
> @@ -8,9 +8,8 @@
>  typedef struct InterruptStatsProviderClass InterruptStatsProviderClass;
>  DECLARE_CLASS_CHECKERS(InterruptStatsProviderClass, INTERRUPT_STATS_PROV=
IDER,
>                         TYPE_INTERRUPT_STATS_PROVIDER)
> -#define INTERRUPT_STATS_PROVIDER(obj) \
> -    INTERFACE_CHECK(InterruptStatsProvider, (obj), \
> -                    TYPE_INTERRUPT_STATS_PROVIDER)
> +DECLARE_INTERFACE_CHECKER(InterruptStatsProvider, INTERRUPT_STATS_PROVID=
ER,
> +                          TYPE_INTERRUPT_STATS_PROVIDER)
> =20
>  typedef struct InterruptStatsProvider InterruptStatsProvider;
> =20
> diff --git a/include/hw/ipmi/ipmi.h b/include/hw/ipmi/ipmi.h
> index 3fa5a4abd0..25133264ff 100644
> --- a/include/hw/ipmi/ipmi.h
> +++ b/include/hw/ipmi/ipmi.h
> @@ -109,8 +109,8 @@ uint32_t ipmi_next_uuid(void);
>   * and the BMC.
>   */
>  #define TYPE_IPMI_INTERFACE "ipmi-interface"
> -#define IPMI_INTERFACE(obj) \
> -     INTERFACE_CHECK(IPMIInterface, (obj), TYPE_IPMI_INTERFACE)
> +DECLARE_INTERFACE_CHECKER(IPMIInterface, IPMI_INTERFACE,
> +                          TYPE_IPMI_INTERFACE)
>  typedef struct IPMIInterfaceClass IPMIInterfaceClass;
>  DECLARE_CLASS_CHECKERS(IPMIInterfaceClass, IPMI_INTERFACE,
>                         TYPE_IPMI_INTERFACE)
> diff --git a/include/hw/isa/isa.h b/include/hw/isa/isa.h
> index ddb6a2d168..9e3e8aaaaa 100644
> --- a/include/hw/isa/isa.h
> +++ b/include/hw/isa/isa.h
> @@ -38,8 +38,8 @@ static inline uint16_t applesmc_port(void)
>  typedef struct IsaDmaClass IsaDmaClass;
>  DECLARE_CLASS_CHECKERS(IsaDmaClass, ISADMA,
>                         TYPE_ISADMA)
> -#define ISADMA(obj) \
> -    INTERFACE_CHECK(IsaDma, (obj), TYPE_ISADMA)
> +DECLARE_INTERFACE_CHECKER(IsaDma, ISADMA,
> +                          TYPE_ISADMA)
> =20
>  typedef enum {
>      ISADMA_TRANSFER_VERIFY,
> diff --git a/include/hw/mem/memory-device.h b/include/hw/mem/memory-devic=
e.h
> index cde52e83c9..c5b32e2c6a 100644
> --- a/include/hw/mem/memory-device.h
> +++ b/include/hw/mem/memory-device.h
> @@ -22,8 +22,8 @@
>  typedef struct MemoryDeviceClass MemoryDeviceClass;
>  DECLARE_CLASS_CHECKERS(MemoryDeviceClass, MEMORY_DEVICE,
>                         TYPE_MEMORY_DEVICE)
> -#define MEMORY_DEVICE(obj) \
> -     INTERFACE_CHECK(MemoryDeviceState, (obj), TYPE_MEMORY_DEVICE)
> +DECLARE_INTERFACE_CHECKER(MemoryDeviceState, MEMORY_DEVICE,
> +                          TYPE_MEMORY_DEVICE)
> =20
>  typedef struct MemoryDeviceState MemoryDeviceState;
> =20
> diff --git a/include/hw/nmi.h b/include/hw/nmi.h
> index fff41bebc6..b31082e969 100644
> --- a/include/hw/nmi.h
> +++ b/include/hw/nmi.h
> @@ -29,8 +29,8 @@
>  typedef struct NMIClass NMIClass;
>  DECLARE_CLASS_CHECKERS(NMIClass, NMI,
>                         TYPE_NMI)
> -#define NMI(obj) \
> -     INTERFACE_CHECK(NMIState, (obj), TYPE_NMI)
> +DECLARE_INTERFACE_CHECKER(NMIState, NMI,
> +                          TYPE_NMI)
> =20
>  typedef struct NMIState NMIState;
> =20
> diff --git a/include/hw/ppc/pnv_xscom.h b/include/hw/ppc/pnv_xscom.h
> index 7e3b189c07..0d24a75827 100644
> --- a/include/hw/ppc/pnv_xscom.h
> +++ b/include/hw/ppc/pnv_xscom.h
> @@ -25,8 +25,8 @@
>  typedef struct PnvXScomInterface PnvXScomInterface;
> =20
>  #define TYPE_PNV_XSCOM_INTERFACE "pnv-xscom-interface"
> -#define PNV_XSCOM_INTERFACE(obj) \
> -    INTERFACE_CHECK(PnvXScomInterface, (obj), TYPE_PNV_XSCOM_INTERFACE)
> +DECLARE_INTERFACE_CHECKER(PnvXScomInterface, PNV_XSCOM_INTERFACE,
> +                          TYPE_PNV_XSCOM_INTERFACE)
>  typedef struct PnvXScomInterfaceClass PnvXScomInterfaceClass;
>  DECLARE_CLASS_CHECKERS(PnvXScomInterfaceClass, PNV_XSCOM_INTERFACE,
>                         TYPE_PNV_XSCOM_INTERFACE)
> diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
> index c22a72c9e2..105e1fb4e7 100644
> --- a/include/hw/ppc/spapr_irq.h
> +++ b/include/hw/ppc/spapr_irq.h
> @@ -34,8 +34,8 @@ struct SpaprMachineState;
>  typedef struct SpaprInterruptController SpaprInterruptController;
> =20
>  #define TYPE_SPAPR_INTC "spapr-interrupt-controller"
> -#define SPAPR_INTC(obj)                                     \
> -    INTERFACE_CHECK(SpaprInterruptController, (obj), TYPE_SPAPR_INTC)
> +DECLARE_INTERFACE_CHECKER(SpaprInterruptController, SPAPR_INTC,
> +                          TYPE_SPAPR_INTC)
>  typedef struct SpaprInterruptControllerClass SpaprInterruptControllerCla=
ss;
>  DECLARE_CLASS_CHECKERS(SpaprInterruptControllerClass, SPAPR_INTC,
>                         TYPE_SPAPR_INTC)
> diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
> index c5a3cdcadc..eea6701371 100644
> --- a/include/hw/ppc/xics.h
> +++ b/include/hw/ppc/xics.h
> @@ -137,8 +137,8 @@ struct ICSIRQState {
>  };
> =20
>  #define TYPE_XICS_FABRIC "xics-fabric"
> -#define XICS_FABRIC(obj)                                     \
> -    INTERFACE_CHECK(XICSFabric, (obj), TYPE_XICS_FABRIC)
> +DECLARE_INTERFACE_CHECKER(XICSFabric, XICS_FABRIC,
> +                          TYPE_XICS_FABRIC)
>  typedef struct XICSFabricClass XICSFabricClass;
>  DECLARE_CLASS_CHECKERS(XICSFabricClass, XICS_FABRIC,
>                         TYPE_XICS_FABRIC)
> diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
> index 482fafccfd..3db9b4e5fd 100644
> --- a/include/hw/ppc/xive.h
> +++ b/include/hw/ppc/xive.h
> @@ -152,8 +152,8 @@
>  typedef struct XiveNotifier XiveNotifier;
> =20
>  #define TYPE_XIVE_NOTIFIER "xive-notifier"
> -#define XIVE_NOTIFIER(obj)                                     \
> -    INTERFACE_CHECK(XiveNotifier, (obj), TYPE_XIVE_NOTIFIER)
> +DECLARE_INTERFACE_CHECKER(XiveNotifier, XIVE_NOTIFIER,
> +                          TYPE_XIVE_NOTIFIER)
>  typedef struct XiveNotifierClass XiveNotifierClass;
>  DECLARE_CLASS_CHECKERS(XiveNotifierClass, XIVE_NOTIFIER,
>                         TYPE_XIVE_NOTIFIER)
> @@ -389,8 +389,8 @@ typedef struct XiveTCTXMatch {
>  } XiveTCTXMatch;
> =20
>  #define TYPE_XIVE_PRESENTER "xive-presenter"
> -#define XIVE_PRESENTER(obj)                                     \
> -    INTERFACE_CHECK(XivePresenter, (obj), TYPE_XIVE_PRESENTER)
> +DECLARE_INTERFACE_CHECKER(XivePresenter, XIVE_PRESENTER,
> +                          TYPE_XIVE_PRESENTER)
>  typedef struct XivePresenterClass XivePresenterClass;
>  DECLARE_CLASS_CHECKERS(XivePresenterClass, XIVE_PRESENTER,
>                         TYPE_XIVE_PRESENTER)
> @@ -414,8 +414,8 @@ int xive_presenter_tctx_match(XivePresenter *xptr, Xi=
veTCTX *tctx,
>   */
> =20
>  #define TYPE_XIVE_FABRIC "xive-fabric"
> -#define XIVE_FABRIC(obj)                                     \
> -    INTERFACE_CHECK(XiveFabric, (obj), TYPE_XIVE_FABRIC)
> +DECLARE_INTERFACE_CHECKER(XiveFabric, XIVE_FABRIC,
> +                          TYPE_XIVE_FABRIC)
>  typedef struct XiveFabricClass XiveFabricClass;
>  DECLARE_CLASS_CHECKERS(XiveFabricClass, XIVE_FABRIC,
>                         TYPE_XIVE_FABRIC)
> diff --git a/include/hw/rdma/rdma.h b/include/hw/rdma/rdma.h
> index e77e43a170..ba520b64fe 100644
> --- a/include/hw/rdma/rdma.h
> +++ b/include/hw/rdma/rdma.h
> @@ -22,9 +22,8 @@
>  typedef struct RdmaProviderClass RdmaProviderClass;
>  DECLARE_CLASS_CHECKERS(RdmaProviderClass, RDMA_PROVIDER,
>                         INTERFACE_RDMA_PROVIDER)
> -#define RDMA_PROVIDER(obj) \
> -    INTERFACE_CHECK(RdmaProvider, (obj), \
> -                    INTERFACE_RDMA_PROVIDER)
> +DECLARE_INTERFACE_CHECKER(RdmaProvider, RDMA_PROVIDER,
> +                          INTERFACE_RDMA_PROVIDER)
> =20
>  typedef struct RdmaProvider RdmaProvider;
> =20
> diff --git a/include/hw/rtc/m48t59.h b/include/hw/rtc/m48t59.h
> index 04abedf3b2..0e61c6c2c4 100644
> --- a/include/hw/rtc/m48t59.h
> +++ b/include/hw/rtc/m48t59.h
> @@ -34,8 +34,8 @@
>  typedef struct NvramClass NvramClass;
>  DECLARE_CLASS_CHECKERS(NvramClass, NVRAM,
>                         TYPE_NVRAM)
> -#define NVRAM(obj) \
> -    INTERFACE_CHECK(Nvram, (obj), TYPE_NVRAM)
> +DECLARE_INTERFACE_CHECKER(Nvram, NVRAM,
> +                          TYPE_NVRAM)
> =20
>  typedef struct Nvram Nvram;
> =20
> diff --git a/include/hw/stream.h b/include/hw/stream.h
> index e39d5a5b55..8662c4fcff 100644
> --- a/include/hw/stream.h
> +++ b/include/hw/stream.h
> @@ -9,8 +9,8 @@
>  typedef struct StreamSlaveClass StreamSlaveClass;
>  DECLARE_CLASS_CHECKERS(StreamSlaveClass, STREAM_SLAVE,
>                         TYPE_STREAM_SLAVE)
> -#define STREAM_SLAVE(obj) \
> -     INTERFACE_CHECK(StreamSlave, (obj), TYPE_STREAM_SLAVE)
> +DECLARE_INTERFACE_CHECKER(StreamSlave, STREAM_SLAVE,
> +                          TYPE_STREAM_SLAVE)
> =20
>  typedef struct StreamSlave StreamSlave;
> =20
> diff --git a/include/hw/vmstate-if.h b/include/hw/vmstate-if.h
> index 52df571d17..9797cb4321 100644
> --- a/include/hw/vmstate-if.h
> +++ b/include/hw/vmstate-if.h
> @@ -16,8 +16,8 @@
>  typedef struct VMStateIfClass VMStateIfClass;
>  DECLARE_CLASS_CHECKERS(VMStateIfClass, VMSTATE_IF,
>                         TYPE_VMSTATE_IF)
> -#define VMSTATE_IF(obj)                             \
> -    INTERFACE_CHECK(VMStateIf, (obj), TYPE_VMSTATE_IF)
> +DECLARE_INTERFACE_CHECKER(VMStateIf, VMSTATE_IF,
> +                          TYPE_VMSTATE_IF)
> =20
>  typedef struct VMStateIf VMStateIf;
> =20
> diff --git a/include/qom/object_interfaces.h b/include/qom/object_interfa=
ces.h
> index f118fb516b..1e6a6ce811 100644
> --- a/include/qom/object_interfaces.h
> +++ b/include/qom/object_interfaces.h
> @@ -9,9 +9,8 @@
>  typedef struct UserCreatableClass UserCreatableClass;
>  DECLARE_CLASS_CHECKERS(UserCreatableClass, USER_CREATABLE,
>                         TYPE_USER_CREATABLE)
> -#define USER_CREATABLE(obj) \
> -     INTERFACE_CHECK(UserCreatable, (obj), \
> -                     TYPE_USER_CREATABLE)
> +DECLARE_INTERFACE_CHECKER(UserCreatable, USER_CREATABLE,
> +                          TYPE_USER_CREATABLE)
> =20
>  typedef struct UserCreatable UserCreatable;
> =20
> diff --git a/include/sysemu/tpm.h b/include/sysemu/tpm.h
> index 1a85564e47..5a7f13400d 100644
> --- a/include/sysemu/tpm.h
> +++ b/include/sysemu/tpm.h
> @@ -29,8 +29,8 @@ typedef enum TPMVersion {
>  typedef struct TPMIfClass TPMIfClass;
>  DECLARE_CLASS_CHECKERS(TPMIfClass, TPM_IF,
>                         TYPE_TPM_IF)
> -#define TPM_IF(obj)                             \
> -    INTERFACE_CHECK(TPMIf, (obj), TYPE_TPM_IF)
> +DECLARE_INTERFACE_CHECKER(TPMIf, TPM_IF,
> +                          TYPE_TPM_IF)
> =20
>  typedef struct TPMIf TPMIf;
> =20
> diff --git a/target/arm/idau.h b/target/arm/idau.h
> index 0ef5251971..0d09ad0abd 100644
> --- a/target/arm/idau.h
> +++ b/target/arm/idau.h
> @@ -31,8 +31,8 @@
>  #include "qom/object.h"
> =20
>  #define TYPE_IDAU_INTERFACE "idau-interface"
> -#define IDAU_INTERFACE(obj) \
> -    INTERFACE_CHECK(IDAUInterface, (obj), TYPE_IDAU_INTERFACE)
> +DECLARE_INTERFACE_CHECKER(IDAUInterface, IDAU_INTERFACE,
> +                          TYPE_IDAU_INTERFACE)
>  typedef struct IDAUInterfaceClass IDAUInterfaceClass;
>  DECLARE_CLASS_CHECKERS(IDAUInterfaceClass, IDAU_INTERFACE,
>                         TYPE_IDAU_INTERFACE)
> diff --git a/tests/check-qom-interface.c b/tests/check-qom-interface.c
> index c99be97ed8..b0ca517510 100644
> --- a/tests/check-qom-interface.c
> +++ b/tests/check-qom-interface.c
> @@ -19,8 +19,8 @@
>  typedef struct TestIfClass TestIfClass;
>  DECLARE_CLASS_CHECKERS(TestIfClass, TEST_IF,
>                         TYPE_TEST_IF)
> -#define TEST_IF(obj) \
> -     INTERFACE_CHECK(TestIf, (obj), TYPE_TEST_IF)
> +DECLARE_INTERFACE_CHECKER(TestIf, TEST_IF,
> +                          TYPE_TEST_IF)
> =20
>  typedef struct TestIf TestIf;
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--NQTVMVnDVuULnIzU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl9isXEACgkQbDjKyiDZ
s5Lz1xAA1GkhEgsf2LE8OUkI6N7ihpNAbU0XiYyezMOho9s4ARTjzk5mnlAm8OEL
KBV34jmGHPOkbIx3zGhRR4OCgb3lJajKSEHfhBsOSISAPdqz7g2bxf+sfvE+31oq
pw+m9VDpJmy5iYcYFeC9FmSWPWtXIlFaVtqiidnbUeWP0eW6hfPAMyuLgFEyvZGH
tOfhkFYgTHPmhwRN0XiOF2L5F2NXxKW4n1SxPj92o/Qn80h+coCzsrSOBc3j9azu
2E2DKVv6sMPSCMYcz9PmZwSaaa+QxCMAAAhiIF7ehQMFjuj5E19DnK4bp4opX+9M
sYrYr/6mV0Cd/29ASYMIBqG1nZ3RfM91hgVM3qxhSlpV5QFVvAENZNMRevfw8KnR
xpQ2B24+uPMnx6Vo+nyX51Dova4dze/OWHUWJ8j7UVHGLGF2Rh1EECiUIRG3/ivn
oH2E/tNz9BDBU3vU9NvTjbns9ZBotTz5PylzipnG4Xb5WDbeZO6Ngc+HK9lg+mRm
9/WIEJewTxpU8uIaJ5i4Ik+t1dqffgrl8EBgHBZHteGbRRxqWt2/8Ge0OgNgFYDa
xQ2yNEETxwhkXUNsO1GPZAWTWsw7yJ4iz/NbOWLMAn900uR/M+ldIX48HMClPOxL
bM/eqX4LkfAugV3JfU6OHUVUjEDj845G67oqlZqcZFL5zWVwN/4=
=Si5n
-----END PGP SIGNATURE-----

--NQTVMVnDVuULnIzU--

