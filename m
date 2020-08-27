Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CABB5C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 14:52:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 877D52054F
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 14:52:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mo//pmKT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 877D52054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51414 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBJGD-0000gN-Qq
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 10:52:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41650)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <slp@redhat.com>) id 1kBJFd-0008Ik-3s
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 10:51:41 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:40176
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <slp@redhat.com>) id 1kBJFb-0007sf-1M
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 10:51:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598539898;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7Ys+PD66NqdKBQlJEKE/KdW1OfBO9g2gJM89aNgxtYs=;
 b=Mo//pmKT9FI+UAzuxZVJtPB3ZZUp+kRYVEea3XBw4S7+uTS0yLLBckehUfQnaYrApZU1QC
 92ppd+M8F9tUHiOhH9J8Wo+o2OE081aBfLBOoyGomax+7j46R5x4b8C4lhoLZasT42dn+r
 WB3AA6NuIwnlwVRtnp62fcYKG3CBwYA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-379-iaOfQldjPQGRhYLJok1fAQ-1; Thu, 27 Aug 2020 10:51:33 -0400
X-MC-Unique: iaOfQldjPQGRhYLJok1fAQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1128D100CEEA;
 Thu, 27 Aug 2020 14:51:31 +0000 (UTC)
Received: from localhost (ovpn-113-131.rdu2.redhat.com [10.10.113.131])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 586BC6147D;
 Thu, 27 Aug 2020 14:51:02 +0000 (UTC)
Date: Thu, 27 Aug 2020 16:51:02 +0200
From: Sergio Lopez <slp@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v6 14/20] x86: move acpi_dev from pc/microvm
Message-ID: <20200827145102.nxzgmfumncqkbkuy@mhamilton>
References: <20200826105254.28496-1-kraxel@redhat.com>
 <20200826105254.28496-15-kraxel@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200826105254.28496-15-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=slp@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="n34ibbgtml4aydsc"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=slp@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/27 00:53:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org, Shannon Zhao <shannon.zhaosl@gmail.com>,
 qemu-arm@nongnu.org, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--n34ibbgtml4aydsc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 26, 2020 at 12:52:48PM +0200, Gerd Hoffmann wrote:
> Both pc and microvm machine types have a acpi_dev field.
> Move it to the common base type.
>=20
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  include/hw/i386/microvm.h |  1 -
>  include/hw/i386/pc.h      |  1 -
>  include/hw/i386/x86.h     |  1 +
>  hw/i386/acpi-build.c      |  2 +-
>  hw/i386/acpi-microvm.c    |  5 +++--
>  hw/i386/microvm.c         | 10 ++++++----
>  hw/i386/pc.c              | 34 +++++++++++++++++++---------------
>  hw/i386/pc_piix.c         |  2 +-
>  hw/i386/pc_q35.c          |  2 +-
>  9 files changed, 32 insertions(+), 26 deletions(-)

Reviewed-by: Sergio Lopez <slp@redhat.com>


> diff --git a/include/hw/i386/microvm.h b/include/hw/i386/microvm.h
> index b6e0d4395af7..b8ec99aeb051 100644
> --- a/include/hw/i386/microvm.h
> +++ b/include/hw/i386/microvm.h
> @@ -66,7 +66,6 @@ typedef struct {
>      bool kernel_cmdline_fixed;
>      Notifier machine_done;
>      Notifier powerdown_req;
> -    AcpiDeviceIf *acpi_dev;
>  } MicrovmMachineState;
> =20
>  #define TYPE_MICROVM_MACHINE   MACHINE_TYPE_NAME("microvm")
> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> index fe52e165b27c..0f7da2329b0f 100644
> --- a/include/hw/i386/pc.h
> +++ b/include/hw/i386/pc.h
> @@ -29,7 +29,6 @@ struct PCMachineState {
>      Notifier machine_done;
> =20
>      /* Pointers to devices and objects: */
> -    HotplugHandler *acpi_dev;
>      PCIBus *bus;
>      I2CBus *smbus;
>      PFlashCFI01 *flash[2];
> diff --git a/include/hw/i386/x86.h b/include/hw/i386/x86.h
> index a350ea3609f5..de74c831c3ab 100644
> --- a/include/hw/i386/x86.h
> +++ b/include/hw/i386/x86.h
> @@ -50,6 +50,7 @@ typedef struct {
>      FWCfgState *fw_cfg;
>      qemu_irq *gsi;
>      GMappedFile *initrd_mapped_file;
> +    HotplugHandler *acpi_dev;
> =20
>      /* RAM information (sizes, addresses, configuration): */
>      ram_addr_t below_4g_mem_size, above_4g_mem_size;
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index b7bcbbbb2a35..c356cc71fe08 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -2431,7 +2431,7 @@ void acpi_build(AcpiBuildTables *tables, MachineSta=
te *machine)
> =20
>      acpi_add_table(table_offsets, tables_blob);
>      acpi_build_madt(tables_blob, tables->linker, x86ms,
> -                    ACPI_DEVICE_IF(pcms->acpi_dev), true);
> +                    ACPI_DEVICE_IF(x86ms->acpi_dev), true);
> =20
>      vmgenid_dev =3D find_vmgenid_dev();
>      if (vmgenid_dev) {
> diff --git a/hw/i386/acpi-microvm.c b/hw/i386/acpi-microvm.c
> index b9ce3768b263..df39c5d3bd90 100644
> --- a/hw/i386/acpi-microvm.c
> +++ b/hw/i386/acpi-microvm.c
> @@ -108,7 +108,7 @@ build_dsdt_microvm(GArray *table_data, BIOSLinker *li=
nker,
>      sb_scope =3D aml_scope("_SB");
>      fw_cfg_add_acpi_dsdt(sb_scope, x86ms->fw_cfg);
>      isa_build_aml(ISA_BUS(isabus), sb_scope);
> -    build_ged_aml(sb_scope, GED_DEVICE, HOTPLUG_HANDLER(mms->acpi_dev),
> +    build_ged_aml(sb_scope, GED_DEVICE, x86ms->acpi_dev,
>                    GED_MMIO_IRQ, AML_SYSTEM_MEMORY, GED_MMIO_BASE);
>      acpi_dsdt_add_power_button(sb_scope);
>      acpi_dsdt_add_virtio(sb_scope, mms);
> @@ -136,6 +136,7 @@ static void acpi_build_microvm(AcpiBuildTables *table=
s,
>                                 MicrovmMachineState *mms)
>  {
>      MachineState *machine =3D MACHINE(mms);
> +    X86MachineState *x86ms =3D X86_MACHINE(mms);
>      GArray *table_offsets;
>      GArray *tables_blob =3D tables->table_data;
>      unsigned dsdt, xsdt;
> @@ -183,7 +184,7 @@ static void acpi_build_microvm(AcpiBuildTables *table=
s,
> =20
>      acpi_add_table(table_offsets, tables_blob);
>      acpi_build_madt(tables_blob, tables->linker, X86_MACHINE(machine),
> -                    mms->acpi_dev, false);
> +                    ACPI_DEVICE_IF(x86ms->acpi_dev), false);
> =20
>      xsdt =3D tables_blob->len;
>      build_xsdt(tables_blob, tables->linker, table_offsets, NULL, NULL);
> diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
> index 04209eb38fbe..9df15354ce0f 100644
> --- a/hw/i386/microvm.c
> +++ b/hw/i386/microvm.c
> @@ -143,7 +143,7 @@ static void microvm_devices_init(MicrovmMachineState =
*mms)
>          sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0,
>                             x86ms->gsi[GED_MMIO_IRQ]);
>          sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
> -        mms->acpi_dev =3D ACPI_DEVICE_IF(dev);
> +        x86ms->acpi_dev =3D HOTPLUG_HANDLER(dev);
>      }
> =20
>      if (mms->pic =3D=3D ON_OFF_AUTO_ON || mms->pic =3D=3D ON_OFF_AUTO_AU=
TO) {
> @@ -469,11 +469,13 @@ static void microvm_powerdown_req(Notifier *notifie=
r, void *data)
>  {
>      MicrovmMachineState *mms =3D container_of(notifier, MicrovmMachineSt=
ate,
>                                              powerdown_req);
> +    X86MachineState *x86ms =3D X86_MACHINE(mms);
> =20
> -    if (mms->acpi_dev) {
> -        Object *obj =3D OBJECT(mms->acpi_dev);
> +    if (x86ms->acpi_dev) {
> +        Object *obj =3D OBJECT(x86ms->acpi_dev);
>          AcpiDeviceIfClass *adevc =3D ACPI_DEVICE_IF_GET_CLASS(obj);
> -        adevc->send_event(mms->acpi_dev, ACPI_POWER_DOWN_STATUS);
> +        adevc->send_event(ACPI_DEVICE_IF(x86ms->acpi_dev),
> +                          ACPI_POWER_DOWN_STATUS);
>      }
>  }
> =20
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 5d8d5ef8b373..0bd6dbbd7bf6 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -1274,6 +1274,7 @@ static void pc_memory_pre_plug(HotplugHandler *hotp=
lug_dev, DeviceState *dev,
>                                 Error **errp)
>  {
>      const PCMachineState *pcms =3D PC_MACHINE(hotplug_dev);
> +    const X86MachineState *x86ms =3D X86_MACHINE(hotplug_dev);
>      const PCMachineClass *pcmc =3D PC_MACHINE_GET_CLASS(pcms);
>      const MachineState *ms =3D MACHINE(hotplug_dev);
>      const bool is_nvdimm =3D object_dynamic_cast(OBJECT(dev), TYPE_NVDIM=
M);
> @@ -1285,7 +1286,7 @@ static void pc_memory_pre_plug(HotplugHandler *hotp=
lug_dev, DeviceState *dev,
>       * but pcms->acpi_dev is still created. Check !acpi_enabled in
>       * addition to cover this case.
>       */
> -    if (!pcms->acpi_dev || !x86_machine_is_acpi_enabled(X86_MACHINE(pcms=
))) {
> +    if (!x86ms->acpi_dev || !x86_machine_is_acpi_enabled(x86ms)) {
>          error_setg(errp,
>                     "memory hotplug is not enabled: missing acpi device o=
r acpi disabled");
>          return;
> @@ -1296,7 +1297,7 @@ static void pc_memory_pre_plug(HotplugHandler *hotp=
lug_dev, DeviceState *dev,
>          return;
>      }
> =20
> -    hotplug_handler_pre_plug(pcms->acpi_dev, dev, &local_err);
> +    hotplug_handler_pre_plug(x86ms->acpi_dev, dev, &local_err);
>      if (local_err) {
>          error_propagate(errp, local_err);
>          return;
> @@ -1311,6 +1312,7 @@ static void pc_memory_plug(HotplugHandler *hotplug_=
dev,
>  {
>      Error *local_err =3D NULL;
>      PCMachineState *pcms =3D PC_MACHINE(hotplug_dev);
> +    X86MachineState *x86ms =3D X86_MACHINE(hotplug_dev);
>      MachineState *ms =3D MACHINE(hotplug_dev);
>      bool is_nvdimm =3D object_dynamic_cast(OBJECT(dev), TYPE_NVDIMM);
> =20
> @@ -1323,7 +1325,7 @@ static void pc_memory_plug(HotplugHandler *hotplug_=
dev,
>          nvdimm_plug(ms->nvdimms_state);
>      }
> =20
> -    hotplug_handler_plug(HOTPLUG_HANDLER(pcms->acpi_dev), dev, &error_ab=
ort);
> +    hotplug_handler_plug(x86ms->acpi_dev, dev, &error_abort);
>  out:
>      error_propagate(errp, local_err);
>  }
> @@ -1331,14 +1333,14 @@ out:
>  static void pc_memory_unplug_request(HotplugHandler *hotplug_dev,
>                                       DeviceState *dev, Error **errp)
>  {
> -    PCMachineState *pcms =3D PC_MACHINE(hotplug_dev);
> +    X86MachineState *x86ms =3D X86_MACHINE(hotplug_dev);
> =20
>      /*
>       * When -no-acpi is used with Q35 machine type, no ACPI is built,
>       * but pcms->acpi_dev is still created. Check !acpi_enabled in
>       * addition to cover this case.
>       */
> -    if (!pcms->acpi_dev || !x86_machine_is_acpi_enabled(X86_MACHINE(pcms=
))) {
> +    if (!x86ms->acpi_dev || !x86_machine_is_acpi_enabled(x86ms)) {
>          error_setg(errp,
>                     "memory hotplug is not enabled: missing acpi device o=
r acpi disabled");
>          return;
> @@ -1349,7 +1351,7 @@ static void pc_memory_unplug_request(HotplugHandler=
 *hotplug_dev,
>          return;
>      }
> =20
> -    hotplug_handler_unplug_request(HOTPLUG_HANDLER(pcms->acpi_dev), dev,
> +    hotplug_handler_unplug_request(x86ms->acpi_dev, dev,
>                                     errp);
>  }
> =20
> @@ -1357,9 +1359,10 @@ static void pc_memory_unplug(HotplugHandler *hotpl=
ug_dev,
>                               DeviceState *dev, Error **errp)
>  {
>      PCMachineState *pcms =3D PC_MACHINE(hotplug_dev);
> +    X86MachineState *x86ms =3D X86_MACHINE(hotplug_dev);
>      Error *local_err =3D NULL;
> =20
> -    hotplug_handler_unplug(HOTPLUG_HANDLER(pcms->acpi_dev), dev, &local_=
err);
> +    hotplug_handler_unplug(x86ms->acpi_dev, dev, &local_err);
>      if (local_err) {
>          goto out;
>      }
> @@ -1403,10 +1406,10 @@ static void pc_cpu_plug(HotplugHandler *hotplug_d=
ev,
>      Error *local_err =3D NULL;
>      X86CPU *cpu =3D X86_CPU(dev);
>      PCMachineState *pcms =3D PC_MACHINE(hotplug_dev);
> -    X86MachineState *x86ms =3D X86_MACHINE(pcms);
> +    X86MachineState *x86ms =3D X86_MACHINE(hotplug_dev);
> =20
> -    if (pcms->acpi_dev) {
> -        hotplug_handler_plug(HOTPLUG_HANDLER(pcms->acpi_dev), dev, &loca=
l_err);
> +    if (x86ms->acpi_dev) {
> +        hotplug_handler_plug(x86ms->acpi_dev, dev, &local_err);
>          if (local_err) {
>              goto out;
>          }
> @@ -1432,8 +1435,9 @@ static void pc_cpu_unplug_request_cb(HotplugHandler=
 *hotplug_dev,
>      int idx =3D -1;
>      X86CPU *cpu =3D X86_CPU(dev);
>      PCMachineState *pcms =3D PC_MACHINE(hotplug_dev);
> +    X86MachineState *x86ms =3D X86_MACHINE(hotplug_dev);
> =20
> -    if (!pcms->acpi_dev) {
> +    if (!x86ms->acpi_dev) {
>          error_setg(errp, "CPU hot unplug not supported without ACPI");
>          return;
>      }
> @@ -1445,7 +1449,7 @@ static void pc_cpu_unplug_request_cb(HotplugHandler=
 *hotplug_dev,
>          return;
>      }
> =20
> -    hotplug_handler_unplug_request(HOTPLUG_HANDLER(pcms->acpi_dev), dev,
> +    hotplug_handler_unplug_request(x86ms->acpi_dev, dev,
>                                     errp);
>  }
> =20
> @@ -1456,9 +1460,9 @@ static void pc_cpu_unplug_cb(HotplugHandler *hotplu=
g_dev,
>      Error *local_err =3D NULL;
>      X86CPU *cpu =3D X86_CPU(dev);
>      PCMachineState *pcms =3D PC_MACHINE(hotplug_dev);
> -    X86MachineState *x86ms =3D X86_MACHINE(pcms);
> +    X86MachineState *x86ms =3D X86_MACHINE(hotplug_dev);
> =20
> -    hotplug_handler_unplug(HOTPLUG_HANDLER(pcms->acpi_dev), dev, &local_=
err);
> +    hotplug_handler_unplug(x86ms->acpi_dev, dev, &local_err);
>      if (local_err) {
>          goto out;
>      }
> @@ -1487,7 +1491,7 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug=
_dev,
>      CPUX86State *env =3D &cpu->env;
>      MachineState *ms =3D MACHINE(hotplug_dev);
>      PCMachineState *pcms =3D PC_MACHINE(hotplug_dev);
> -    X86MachineState *x86ms =3D X86_MACHINE(pcms);
> +    X86MachineState *x86ms =3D X86_MACHINE(hotplug_dev);
>      unsigned int smp_cores =3D ms->smp.cores;
>      unsigned int smp_threads =3D ms->smp.threads;
>      X86CPUTopoInfo topo_info;
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index 32b1453e6a82..759b4a97facb 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -293,7 +293,7 @@ static void pc_init1(MachineState *machine,
> =20
>          object_property_add_link(OBJECT(machine), PC_MACHINE_ACPI_DEVICE=
_PROP,
>                                   TYPE_HOTPLUG_HANDLER,
> -                                 (Object **)&pcms->acpi_dev,
> +                                 (Object **)&x86ms->acpi_dev,
>                                   object_property_allow_set_link,
>                                   OBJ_PROP_LINK_STRONG);
>          object_property_set_link(OBJECT(machine), PC_MACHINE_ACPI_DEVICE=
_PROP,
> diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
> index 0cb9c18cd44d..622d0397172a 100644
> --- a/hw/i386/pc_q35.c
> +++ b/hw/i386/pc_q35.c
> @@ -240,7 +240,7 @@ static void pc_q35_init(MachineState *machine)
> =20
>      object_property_add_link(OBJECT(machine), PC_MACHINE_ACPI_DEVICE_PRO=
P,
>                               TYPE_HOTPLUG_HANDLER,
> -                             (Object **)&pcms->acpi_dev,
> +                             (Object **)&x86ms->acpi_dev,
>                               object_property_allow_set_link,
>                               OBJ_PROP_LINK_STRONG);
>      object_property_set_link(OBJECT(machine), PC_MACHINE_ACPI_DEVICE_PRO=
P,
> --=20
> 2.27.0
>=20

--n34ibbgtml4aydsc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEvtX891EthoCRQuii9GknjS8MAjUFAl9HyFUACgkQ9GknjS8M
AjVxUxAAg0RAfJBXOutCmj060ruba2qez8yHLdRFzA7AcFyBB6V5ZCy9tajfcmIa
7AkFpEgZIAEqLcBBX5JZ92n+FIaMybtskNuH6BpzuGQDy4k/bK8nwl3z/pfObsYD
8RS2Yx/vPM6Lw/lceKPMLuRex3Ym+xevwA2pkyHpoWBr8Dp8crMjNl4AITAJLVbq
WV0YEFxCSUAe7SMeYYXehPZmahRlDnKOLh+qI//EBBll6ZMfqQsnqQmnDX+8xpws
NEWcgEikAFeerHNQe7gG+kSGlq8l1OmZ8n59JZ/w/hvIDADzLVDSMTBeHuvfMx8o
6GaLu6BoSUEPxCcuH23JPU5S90uNdnN3Qw6s5Xq37pfr1wR5zJpJQw/lRqgDh7AS
FFMiSYoSQ2otD3lT+TQYp2Tjm3Vr6cH7QwqWhIebBHEJZifr9kQovCHjMmVb1PZZ
zgI2RM3Pnapno9vmkGfmgcz6YAdjG259Lfrym+sSbVvpDS6XVxMK+lY7TUy5zpze
QTxHKMmtLLJH+GCGM/sqDWh7nNbxAvaknJGOAQqU/G58PgKQF61D7HOsVW4bSjFO
gN3NlHmimn8RNm6bBuY3F7yDB+jE1JKOEp6hY2QhtJYmkF/Qi1YOjpD1KKxIIyVa
WQYSdRFRCGk1Pqv53xmDcxqMpWH/CCdSThR3Fjq5nQU1l9emB80=
=mCl3
-----END PGP SIGNATURE-----

--n34ibbgtml4aydsc--


