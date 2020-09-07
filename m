Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BEC2C433E2
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 12:51:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7C6921481
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 12:51:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J5+H0LN+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7C6921481
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48310 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFGcH-0007dQ-1J
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 08:51:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53868)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1kFGas-0005d0-KB
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 08:49:58 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:27713
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1kFGaq-0003mt-Si
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 08:49:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599482995;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U478Nr90vBVtzGib4F423naIxxgxs/JC77WG/k1RqGw=;
 b=J5+H0LN+HhYmrp2ucXFzzSH6rimP3R3rok5oEpuBjtUjc6WAK8J5h8xD9SCzZcK3u/Tuun
 kd9LFqxI1LAvZ92jCncB9JCzgLZip5R86PikAUC3vEMVcNZy+n3FSxjTbDQWev9QmTZzXk
 gB11wibSxE91lYO6wcq298fJdW5slBs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-79-c7QCA9JpNuarPSsoyUAJTQ-1; Mon, 07 Sep 2020 08:49:54 -0400
X-MC-Unique: c7QCA9JpNuarPSsoyUAJTQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 183CB18B9F09;
 Mon,  7 Sep 2020 12:49:53 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-115-56.ams2.redhat.com
 [10.36.115.56])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 22DAF7B9F4;
 Mon,  7 Sep 2020 12:49:51 +0000 (UTC)
Subject: Re: [PATCH v5 08/10] x86: acpi: introduce the PCI0.SMI0 ACPI device
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <20200907112348.530921-1-imammedo@redhat.com>
 <20200907112348.530921-9-imammedo@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <6b94c82c-6e35-fa36-66fd-35dcd8c348fd@redhat.com>
Date: Mon, 7 Sep 2020 14:49:51 +0200
MIME-Version: 1.0
In-Reply-To: <20200907112348.530921-9-imammedo@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=lersek@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=207.211.31.81; envelope-from=lersek@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/06 22:29:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: boris.ostrovsky@oracle.com, aaron.young@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 09/07/20 13:23, Igor Mammedov wrote:
> When CPU hotplug with SMI has been negotiated, describe the SMI
> register block in the DSDT. Pass the ACPI name of the SMI control
> register to build_cpus_aml(), so that CPU_SCAN_METHOD can access the
> register in the next patch.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> Reviewed-by: Laszlo Ersek <lersek@redhat.com>
> ---
>  include/hw/acpi/cpu.h |  1 +
>  hw/i386/acpi-build.c  | 29 ++++++++++++++++++++++++++++-
>  2 files changed, 29 insertions(+), 1 deletion(-)
> 
> diff --git a/include/hw/acpi/cpu.h b/include/hw/acpi/cpu.h
> index 62f0278ba2..0eeedaa491 100644
> --- a/include/hw/acpi/cpu.h
> +++ b/include/hw/acpi/cpu.h
> @@ -50,6 +50,7 @@ void cpu_hotplug_hw_init(MemoryRegion *as, Object *owner,
>  typedef struct CPUHotplugFeatures {
>      bool acpi_1_compatible;
>      bool has_legacy_cphp;
> +    const char *smi_path;
>  } CPUHotplugFeatures;
>  
>  void build_cpus_aml(Aml *table, MachineState *machine, CPUHotplugFeatures opts,
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index e61c17a484..7a33ef193e 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -1521,6 +1521,32 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>          aml_append(dev, aml_name_decl("_UID", aml_int(0)));
>          aml_append(dev, build_q35_osc_method());
>          aml_append(sb_scope, dev);
> +
> +        if (pm->smi_on_cpuhp) {
> +            /* reserve SMI block resources, IO ports 0xB2, 0xB3 */
> +            dev = aml_device("PCI0.SMI0");
> +            aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0A06")));
> +            aml_append(dev, aml_name_decl("_UID", aml_string("SMI resources")));
> +            crs = aml_resource_template();
> +            aml_append(crs,
> +                aml_io(
> +                       AML_DECODE16,
> +                       ACPI_PORT_SMI_CMD,
> +                       ACPI_PORT_SMI_CMD,
> +                       1,
> +                       2)
> +            );
> +            aml_append(dev, aml_name_decl("_CRS", crs));
> +            aml_append(dev, aml_operation_region("SMIR", AML_SYSTEM_IO,
> +                aml_int(ACPI_PORT_SMI_CMD), 2));
> +            field = aml_field("SMIR", AML_BYTE_ACC, AML_NOLOCK,
> +                              AML_WRITE_AS_ZEROS);
> +            aml_append(field, aml_named_field("SMIC", 8));
> +            aml_append(field, aml_reserved_field(8));
> +            aml_append(dev, field);
> +            aml_append(sb_scope, dev);
> +        }
> +
>          aml_append(dsdt, sb_scope);
>  
>          build_hpet_aml(dsdt);
> @@ -1536,7 +1562,8 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>          build_legacy_cpu_hotplug_aml(dsdt, machine, pm->cpu_hp_io_base);
>      } else {
>          CPUHotplugFeatures opts = {
> -            .acpi_1_compatible = true, .has_legacy_cphp = true
> +            .acpi_1_compatible = true, .has_legacy_cphp = true,
> +            .smi_path = pm->smi_on_cpuhp ? "\\_SB.PCI0.SMI0.SMIC" : NULL,
>          };
>          build_cpus_aml(dsdt, machine, opts, pm->cpu_hp_io_base,
>                         "\\_SB.PCI0", "\\_GPE._E02");
> 

Tested-by: Laszlo Ersek <lersek@redhat.com>


