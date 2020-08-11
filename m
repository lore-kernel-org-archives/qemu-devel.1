Return-Path: <SRS0=wQM/=BV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67CADC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 13:10:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 310582076B
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 13:10:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="P/Zagtcy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 310582076B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59178 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5U2u-00028P-Ee
	for qemu-devel@archiver.kernel.org; Tue, 11 Aug 2020 09:10:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47120)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1k5U2C-0001dh-GF
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 09:09:44 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:36182)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1k5U28-0001g3-PZ
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 09:09:43 -0400
Received: by mail-wm1-x341.google.com with SMTP id 3so2793881wmi.1
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2020 06:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=+Upfvy4Ke0A6RZaX4b1kLqo3LfcfzDbhpTqrEFdheMg=;
 b=P/ZagtcyB1CT+zwGAkWj0jjHtx4JuLQQ99ihJm+MnsFE003R4vUeGn52nQA5nzOTRt
 7o0QLxA4GZtXuDt/waPmPb0TUsw8MgYDyvkOYPBgYGYZcbYtCqmCNjQjp7xnliTf1Veg
 X3pbsjjZvjvdsR6KG+hCQVEetGu+F14NzyP8R4DYgLRpTkXto6LvLGn+0xdPuB0ZAMZR
 42Aq/mvcpKVio/FIMi4rEJcYaKEl6XkFj/sqhIpL+0oiRuzPxUGlklPYb2lnzn3ReBi9
 1wqjoKY6TOqdoovtHfQYgNZQLCH0rKWJ7x7CM4YRsFRcvHd1cQsVlmfihvh2qGnWXfSZ
 8rug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=+Upfvy4Ke0A6RZaX4b1kLqo3LfcfzDbhpTqrEFdheMg=;
 b=nbBEBVZwToxJQe0bLcdKyQj3MPYuQJASY7p10TqU9EqwG2zr6o0Zmr6NtdeC/IqRHz
 mr9MHM20TPcEuWgWb9nO+olX1EFZleTiZz/Pbi6Iu2iY52ocBcMCVyGY7bvJ658PQd9X
 QqdKLPEkCu/39jwao1pwnaEYekNMj6qI77dGp+7JW1YBLtwhgYIiLLchO4xoPfck3KBG
 gi2v8MKMVQyKx7CGMiZPMI3pia27ALgnFk7yma05h2wJ/L69e2eR5aD6GksDvw39gwbQ
 Gs0KLWcu6mEvniy+szhBiJ+0NJewJm6mYjw/MzyUZzu9cbUJGYU/d9wIBj37c7Qe2/2N
 25Kg==
X-Gm-Message-State: AOAM530OYOB7ugf1GWWfiOvEXXobNLtBeOYOpMnBMtq7GjtFL2th1O3r
 r3VXK9G9XN7MiownxFyqxYaY2CMTNqjK9IP8w2xIfQ==
X-Google-Smtp-Source: ABdhPJzOhzX2tyFea8n0aqQD0/WjxveR0ZoJT1M7+jwVpxcFz5l88x4BHjs+kCe+EXa8UNQCNk2oBxInyfCIjdZr5j8=
X-Received: by 2002:a1c:df02:: with SMTP id w2mr4282441wmg.137.1597151378550; 
 Tue, 11 Aug 2020 06:09:38 -0700 (PDT)
MIME-Version: 1.0
References: <1597058982-70090-1-git-send-email-ani@anisinha.ca>
 <20200810104602-mutt-send-email-mst@kernel.org>
 <CAARzgwwsuzw9rcQzu3MF7KZO8F+0PHMs3hCsiSPJCXJS-dEkhw@mail.gmail.com>
 <20200810105634-mutt-send-email-mst@kernel.org>
 <e4f24840-880b-4912-b251-b0e0bc9469b8@Spark>
 <20200810111827-mutt-send-email-mst@kernel.org>
 <e6a5ef18-948b-43d9-98f4-28a372c72730@Spark>
In-Reply-To: <e6a5ef18-948b-43d9-98f4-28a372c72730@Spark>
From: Ani Sinha <ani@anisinha.ca>
Date: Tue, 11 Aug 2020 18:39:26 +0530
Message-ID: <CAARzgwyLdRwUsb27_P08t4My+z8y+Zwav2YeJcRXMEm9A2_niA@mail.gmail.com>
Subject: Re: [PATCH] Introduce global piix flag to disable PCI hotplug
To: "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: none client-ip=2a00:1450:4864:20::341;
 envelope-from=ani@anisinha.ca; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, jusual@redhat.com,
 qemu-devel@nongnu.org, Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Aug 10, 2020 at 9:11 PM Ani Sinha <ani@anisinha.ca> wrote:
>
>
> Ani
> On Aug 10, 2020, 20:49 +0530, Michael S. Tsirkin <mst@redhat.com>, wrote:
>
> On Mon, Aug 10, 2020 at 08:35:56PM +0530, Ani Sinha wrote:
>
>
> Ani
>
> On Aug 10, 2020, 20:30 +0530, Michael S. Tsirkin <mst@redhat.com>, wrote:
>
>
> On Mon, Aug 10, 2020 at 08:24:53PM +0530, Ani Sinha wrote:
>
>
>
>
>
>
> On Mon, Aug 10, 2020 at 8:17 PM Michael S. Tsirkin <mst@redhat.com>
>
> wrote:
>
>
>
>
> On Mon, Aug 10, 2020 at 04:59:41PM +0530, Ani Sinha wrote:
>
>
> We introduce a new global flag for PIIX with which we can
>
>
> turn on or off PCI device hotplug. This flag can be used
>
>
> to prevent all PCI devices from getting hotplugged/unplugged
>
>
> on the PCI bus. The new options disables all hotpluh HW
>
>
> initialization code as well as the ACPI AMLs.
>
>
>
>
> Signed-off-by: Ani Sinha <ani@anisinha.ca>
>
>
>
>
> Well we have a flag like this for pci bridges, right?
>
>
> So all that's left is an option to disable hotplug
>
>
> for the pci root, right?
>
>
> Wouldn't that be better than disabling it globally?
>
>
>
>
>
>
> The idea is to have just one option to disable all hotplug globally.
>
> But if you
>
>
> want to have two flags one for the bridges and one for the pci root, we
>
> can
>
>
> certainly look into it.
>
>
>
>
>
>
> I can certainly see the attraction of a global flag.
>
>
>
>
> However, with the interface we have for bridges right now, how are we
>
>
> going to resolve the conflict if hotplug is disabled globally but
>
>
> enabled for a given bridge?
>
>
>
>
> A reasonable way would be to change the default value for bridges,
>
>
> have a user-specified value override it.
>
>
> This patch doesn't do it, though.
>
>
>
> I think the global option should override the bridge option. So if the global
>
> option disables hotplug, the bridge option should be a noop.
>
>
>
> Well just ignoring inconsistent user input does not sound great.
>
> Tends to create support problems.
>
>
> Then I suggest we take your original idea - have the new option just disable hotplug on the pci root bus.
>
> This would be cleaner and would introduce less confusion.  Also the patch should be simple.

I have sent a patch to this effect.

>
>
>
>
>
>
>
>
>
>
>
>
>
> ---
>
>
> hw/acpi/piix4.c | 8 ++++++--
>
>
> hw/i386/acpi-build.c | 20 ++++++++++++++------
>
>
> 2 files changed, 20 insertions(+), 8 deletions(-)
>
>
>
>
> diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
>
>
> index 26bac4f..8b13e86 100644
>
>
> --- a/hw/acpi/piix4.c
>
>
> +++ b/hw/acpi/piix4.c
>
>
> @@ -78,6 +78,7 @@ typedef struct PIIX4PMState {
>
>
>
>
> AcpiPciHpState acpi_pci_hotplug;
>
>
> bool use_acpi_hotplug_bridge;
>
>
> + bool use_acpi_pci_hotplug;
>
>
>
>
> uint8_t disable_s3;
>
>
> uint8_t disable_s4;
>
>
> @@ -595,8 +596,9 @@ static void piix4_acpi_system_hot_add_init
>
>
> (MemoryRegion *parent,
>
>
> "acpi-gpe0", GPE_LEN);
>
>
> memory_region_add_subregion(parent, GPE_BASE, &s->io_gpe);
>
>
>
>
> - acpi_pcihp_init(OBJECT(s), &s->acpi_pci_hotplug, bus, parent,
>
>
> - s->use_acpi_hotplug_bridge);
>
>
> + if (s->use_acpi_pci_hotplug)
>
>
> + acpi_pcihp_init(OBJECT(s), &s->acpi_pci_hotplug, bus,
>
> parent,
>
>
> + s->use_acpi_hotplug_bridge);
>
>
>
>
> s->cpu_hotplug_legacy = true;
>
>
> object_property_add_bool(OBJECT(s), "cpu-hotplug-legacy",
>
>
> @@ -635,6 +637,8 @@ static Property piix4_pm_properties[] = {
>
>
> DEFINE_PROP_UINT8(ACPI_PM_PROP_S4_VAL, PIIX4PMState, s4_val,
>
> 2),
>
>
> DEFINE_PROP_BOOL("acpi-pci-hotplug-with-bridge-support",
>
>
> PIIX4PMState,
>
>
> use_acpi_hotplug_bridge, true),
>
>
> + DEFINE_PROP_BOOL("acpi-pci-hotplug", PIIX4PMState,
>
>
> + use_acpi_pci_hotplug, true),
>
>
> DEFINE_PROP_BOOL("memory-hotplug-support", PIIX4PMState,
>
>
> acpi_memory_hotplug.is_enabled, true),
>
>
> DEFINE_PROP_END_OF_LIST(),
>
>
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
>
>
> index b7bcbbb..343b9b6 100644
>
>
> --- a/hw/i386/acpi-build.c
>
>
> +++ b/hw/i386/acpi-build.c
>
>
> @@ -95,6 +95,7 @@ typedef struct AcpiPmInfo {
>
>
> bool s3_disabled;
>
>
> bool s4_disabled;
>
>
> bool pcihp_bridge_en;
>
>
> + bool pcihp_en;
>
>
> uint8_t s4_val;
>
>
> AcpiFadtData fadt;
>
>
> uint16_t cpu_hp_io_base;
>
>
> @@ -245,6 +246,9 @@ static void acpi_get_pm_info(MachineState
>
> *machine,
>
>
> AcpiPmInfo *pm)
>
>
> pm->pcihp_bridge_en =
>
>
> object_property_get_bool(obj,
>
>
> "acpi-pci-hotplug-with-bridge-support",
>
>
> NULL);
>
>
> + pm->pcihp_en =
>
>
> + object_property_get_bool(obj, "acpi-pci-hotplug", NULL);
>
>
> +
>
>
> }
>
>
>
>
> static void acpi_get_misc_info(AcpiMiscInfo *info)
>
>
> @@ -337,14 +341,16 @@ static void build_append_pcihp_notify_entry
>
> (Aml
>
>
> *method, int slot)
>
>
> }
>
>
>
>
> static void build_append_pci_bus_devices(Aml *parent_scope,
>
> PCIBus *bus,
>
>
> - bool pcihp_bridge_en)
>
>
> + bool pcihp_bridge_en,
>
> bool
>
>
> pcihp_en)
>
>
> {
>
>
> Aml *dev, *notify_method = NULL, *method;
>
>
> - QObject *bsel;
>
>
> + QObject *bsel = NULL;
>
>
> PCIBus *sec;
>
>
> int i;
>
>
>
>
> - bsel = object_property_get_qobject(OBJECT(bus),
>
>
> ACPI_PCIHP_PROP_BSEL, NULL);
>
>
> + if (pcihp_en)
>
>
> + bsel = object_property_get_qobject(OBJECT(bus),
>
>
> + ACPI_PCIHP_PROP_BSEL,
>
> NULL);
>
>
> if (bsel) {
>
>
> uint64_t bsel_val = qnum_get_uint(qobject_to(QNum,
>
> bsel));
>
>
>
>
> @@ -439,7 +445,8 @@ static void build_append_pci_bus_devices(Aml
>
>
> *parent_scope, PCIBus *bus,
>
>
> */
>
>
> PCIBus *sec_bus = pci_bridge_get_sec_bus(PCI_BRIDGE
>
> (pdev));
>
>
>
>
> - build_append_pci_bus_devices(dev, sec_bus,
>
> pcihp_bridge_en);
>
>
> + build_append_pci_bus_devices(dev, sec_bus,
>
> pcihp_bridge_en,
>
>
> + pcihp_en);
>
>
> }
>
>
> /* slot descriptor has been composed, add it into parent
>
> context
>
>
> */
>
>
> aml_append(parent_scope, dev);
>
>
> @@ -468,7 +475,7 @@ static void build_append_pci_bus_devices(Aml
>
>
> *parent_scope, PCIBus *bus,
>
>
> }
>
>
>
>
> /* Notify about child bus events in any case */
>
>
> - if (pcihp_bridge_en) {
>
>
> + if (pcihp_bridge_en && pcihp_en) {
>
>
> QLIST_FOREACH(sec, &bus->child, sibling) {
>
>
> int32_t devfn = sec->parent_dev->devfn;
>
>
>
>
> @@ -1818,7 +1825,8 @@ build_dsdt(GArray *table_data, BIOSLinker
>
> *linker,
>
>
> if (bus) {
>
>
> Aml *scope = aml_scope("PCI0");
>
>
> /* Scan all PCI buses. Generate tables to support
>
> hotplug. *
>
>
> /
>
>
> - build_append_pci_bus_devices(scope, bus, pm->
>
>
> pcihp_bridge_en);
>
>
> + build_append_pci_bus_devices(scope, bus, pm->
>
>
> pcihp_bridge_en,
>
>
> + pm->pcihp_en);
>
>
>
>
> if (TPM_IS_TIS_ISA(tpm)) {
>
>
> if (misc->tpm_version == TPM_VERSION_2_0) {
>
>
> --
>
>
> 2.7.4
>
>
>
>
>
>
>
>
>

