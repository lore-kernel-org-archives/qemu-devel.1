Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D09FC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 14:41:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 673662075B
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 14:41:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XMJqkn2q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 673662075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44818 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juzdx-0000QP-MQ
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 10:41:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49640)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1juzdJ-0008ML-SZ
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 10:40:41 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:46002
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1juzdI-0003SB-76
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 10:40:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594651238;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bD4jgZUtvmgcK2myFxQQvBAQ0y1YTebJMQ3hBIU1F9M=;
 b=XMJqkn2qa/MuNNX5vUPZrgbNRaukP2w8cBecACxiidLuez5h5DNXgxkWL7X2BEPs3uL5wR
 lIbtf9HFKuVps1GovTrHPDdxDA5g7Uxiwf5c3zZVIuJpqtv5ijNfmX0ipq+PRFK7m2Z+tn
 rGAaHui+mRTo97oEa4y5esRwsKLlFeE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-51-gkRj4IViM8ahpmlDsKqyXw-1; Mon, 13 Jul 2020 10:40:37 -0400
X-MC-Unique: gkRj4IViM8ahpmlDsKqyXw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 134D71921B11;
 Mon, 13 Jul 2020 14:40:36 +0000 (UTC)
Received: from localhost (unknown [10.40.208.62])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 814CF1A836;
 Mon, 13 Jul 2020 14:39:56 +0000 (UTC)
Date: Mon, 13 Jul 2020 16:39:54 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Julia Suvorova <jusual@redhat.com>
Subject: Re: [RFC PATCH 3/5] hw/i386/acpi-build: Add ACPI PCI hot-plug
 methods to q35
Message-ID: <20200713163954.565722a5@redhat.com>
In-Reply-To: <20200708224615.114077-4-jusual@redhat.com>
References: <20200708224615.114077-1-jusual@redhat.com>
 <20200708224615.114077-4-jusual@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=imammedo@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 02:19:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: kraxel@redhat.com, qemu-devel@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu,  9 Jul 2020 00:46:13 +0200
Julia Suvorova <jusual@redhat.com> wrote:

> Implement notifications and gpe to support q35 ACPI PCI hot-plug.
> The addresses specified in [1] remain the same to make fewer changes.
> 
> [1] docs/spec/acpi_pci_hotplug.txt

CCing Gerd his opinion on reusing piix4 IO port range for q35

 
> Signed-off-by: Julia Suvorova <jusual@redhat.com>
> ---
>  hw/i386/acpi-build.c | 20 +++++++++++++-------
>  1 file changed, 13 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 11c598f955..5c5ad88ad6 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -201,10 +201,6 @@ static void acpi_get_pm_info(MachineState *machine, AcpiPmInfo *pm)
>          /* w2k requires FADT(rev1) or it won't boot, keep PC compatible */
>          pm->fadt.rev = 1;
>          pm->cpu_hp_io_base = PIIX4_CPU_HOTPLUG_IO_BASE;
> -        pm->pcihp_io_base =
> -            object_property_get_uint(obj, ACPI_PCIHP_IO_BASE_PROP, NULL);
> -        pm->pcihp_io_len =
> -            object_property_get_uint(obj, ACPI_PCIHP_IO_LEN_PROP, NULL);
>      }
>      if (lpc) {
>          struct AcpiGenericAddress r = { .space_id = AML_AS_SYSTEM_IO,
> @@ -214,6 +210,10 @@ static void acpi_get_pm_info(MachineState *machine, AcpiPmInfo *pm)
>          pm->fadt.flags |= 1 << ACPI_FADT_F_RESET_REG_SUP;
>          pm->cpu_hp_io_base = ICH9_CPU_HOTPLUG_IO_BASE;
>      }
> +    pm->pcihp_io_base =
> +        object_property_get_uint(obj, ACPI_PCIHP_IO_BASE_PROP, NULL);
> +    pm->pcihp_io_len =
> +        object_property_get_uint(obj, ACPI_PCIHP_IO_LEN_PROP, NULL);
>  
>      /* The above need not be conditional on machine type because the reset port
>       * happens to be the same on PIIX (pc) and ICH9 (q35). */
> @@ -472,7 +472,7 @@ static void build_append_pci_bus_devices(Aml *parent_scope, PCIBus *bus,
>          QLIST_FOREACH(sec, &bus->child, sibling) {
>              int32_t devfn = sec->parent_dev->devfn;
>  
> -            if (pci_bus_is_root(sec) || pci_bus_is_express(sec)) {
> +            if (pci_bus_is_root(sec)) {
>                  continue;
>              }
>  
> @@ -1586,7 +1586,12 @@ static void build_piix4_pci_hotplug(Aml *table)
>      aml_append(table, scope);
>  }
>  
> -static Aml *build_q35_osc_method(void)
> +static void build_q35_pci_hotplug(Aml *table)
> +{
> +    build_piix4_pci_hotplug(table);
> +}

s/build_piix4_pci_hotplug/build_i386_acpi_pci_hotplug/

and reuse it in both cases, instead of adding wrapper?

> +
> +static Aml *build_q35_osc_method(AcpiPmInfo *pm)
>  {
>      Aml *if_ctx;
>      Aml *if_ctx2;
> @@ -1698,6 +1703,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>          build_hpet_aml(dsdt);
>          build_q35_isa_bridge(dsdt);
>          build_isa_devices_aml(dsdt);
> +        build_q35_pci_hotplug(dsdt);
>          build_q35_pci0_int(dsdt);
>          if (pcms->smbus && !pcmc->do_not_add_smb_acpi) {
>              build_smb0(dsdt, pcms->smbus, ICH9_SMB_DEV, ICH9_SMB_FUNC);
> @@ -1724,7 +1730,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>      {
>          aml_append(scope, aml_name_decl("_HID", aml_string("ACPI0006")));
>  
> -        if (misc->is_piix4) {
> +        if (misc->is_piix4 || pm->pcihp_bridge_en) {
>              method = aml_method("_E01", 0, AML_NOTSERIALIZED);
>              aml_append(method,
>                  aml_acquire(aml_name("\\_SB.PCI0.BLCK"), 0xFFFF));


