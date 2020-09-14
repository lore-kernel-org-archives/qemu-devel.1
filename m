Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A57F9C433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 13:29:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0789E206DB
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 13:29:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="wVA2XtuP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0789E206DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58166 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHoXs-00026m-S7
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 09:29:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55166)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kHoX4-0001Js-B6
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 09:28:34 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:38050)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kHoX2-0000UH-A2
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 09:28:34 -0400
Received: by mail-wm1-x344.google.com with SMTP id l9so35555wme.3
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2020 06:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=wxjC388Wf9sU6+PT6v7spNlIntUTnKLEnuEZMQ7hriE=;
 b=wVA2XtuP0e4uRDiaiDratXE7z89pvaPFSeir2s0d2ICP10JCGERlShLqbGU6KcwxMv
 VH4i3pjp/fl9XGKL9wsDHP/lkd612qJuZRsK1QSf0jTO5uLB5ejj9AF+ypbiPVrzmril
 qWhiPfX6keURQiqeKCurI7tiAiE5Mr4QxK5PWNReQMZgmjFs+e5AgygMIy9YxNH1a9D4
 4ZEgfMdQGuurK9jcIeiO5yGKxKKZK+Yym7ylZICnS66ljRHmcSmX8G8IuMcOZP3t6fU5
 kg+gYi0gB39l4HrwfdPHSCpu7bbWPeR6HTyWZT1isX723NmFS7seHQcffboePu+efR+L
 RN4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=wxjC388Wf9sU6+PT6v7spNlIntUTnKLEnuEZMQ7hriE=;
 b=Q6IfIqT4SEs4v4YwsmPsILsXeXT79jCZoOGr11siCqX7g77cQrUDAZR6soyJRMkETJ
 01/hCDiD7PB2mRm3K6ba45d9OA9Q7F9b15q1TFg/qF/nFKB3+keWzdO7M9z7vu3Ee6bv
 qoGyctmeY2XSPlW4hrx7znvEhZl6/LHBBCOOW84M+P/bR2DGHraG9Hrsp9AiQGuABVxr
 Hl6247S5GM5Cgn3un+aw0Y6T3f/RZHeNdE53XmBVU8wUoqzMHwHE5b/TSRxrxkO5ddM9
 5WTuws2fp4jwCLB1wVaGXEqHfX9emmyWV4icq6qHF7jF7iMj5WVczzETkZVUwwKuGn4r
 6p3Q==
X-Gm-Message-State: AOAM533tVQyExIQqg9x4N06WVT1YfsGMjHb8zeKTKgIV3SP1TvyWXCBe
 aiD7Y6mLU9JQdacxb4KH0DA1avFEFE9js658i4yJJg==
X-Google-Smtp-Source: ABdhPJwJ6JGIuG25hEUNoUgr+7S7PTpPA6Pab+eLLbJhtbWE3wm6dvQ8kgyRZ9grwdyNf2QiaLPzehzWhIlrQCwT7Ug=
X-Received: by 2002:a05:600c:2182:: with SMTP id
 e2mr15474805wme.102.1600090110414; 
 Mon, 14 Sep 2020 06:28:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200911180755.28409-1-ani@anisinha.ca>
 <20200911180755.28409-9-ani@anisinha.ca>
 <20200914150550.23a91fa2@redhat.com>
 <CAARzgwyrSW4jjrPCc1SJkDZUV9C-e_96RNGytZ8VjpPzzrWfXg@mail.gmail.com>
In-Reply-To: <CAARzgwyrSW4jjrPCc1SJkDZUV9C-e_96RNGytZ8VjpPzzrWfXg@mail.gmail.com>
From: Ani Sinha <ani@anisinha.ca>
Date: Mon, 14 Sep 2020 18:58:19 +0530
Message-ID: <CAARzgwx4T0MXtFTMe-b8DbAQCi7xq231kjOv8wRcRxwE5HPCyw@mail.gmail.com>
Subject: Re: [PATCH 9/9] piix4: don't reserve hw resources when hotplug is off
 globally
To: Igor Mammedov <imammedo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: none client-ip=2a00:1450:4864:20::344;
 envelope-from=ani@anisinha.ca; helo=mail-wm1-x344.google.com
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Julia Suvorova <jusual@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Sep 14, 2020 at 6:40 PM Ani Sinha <ani@anisinha.ca> wrote:
>
> On Mon, Sep 14, 2020 at 6:36 PM Igor Mammedov <imammedo@redhat.com> wrote:
> >
> > On Fri, 11 Sep 2020 23:37:55 +0530
> > Ani Sinha <ani@anisinha.ca> wrote:
> >
> > > When acpi hotplug is turned off for both root pci bus as well as for pci
> > > bridges, we should not generate the related amls for DSDT table or initialize
> > > related hw ports or reserve hw resources. This change makes sure all those
> > > operations are turned off in the case acpi pci hotplug is off globally.
> >
> > it still leaves around pure PCI hotplug ACPI code:
> >
> >             Method (PCNT, 0, NotSerialized)
> >             {
> >             }
>
> How do you suggest we fix this?

One way to fix this would be to do this:

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 7e3cf3b57b..2bd0c37143 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -483,7 +483,8 @@ static void build_append_pci_bus_devices(Aml
*parent_scope, PCIBus *bus,
             aml_append(method, aml_name("^S%.02X.PCNT", devfn));
         }
     }
-    aml_append(parent_scope, method);
+    if (bsel)
+        aml_append(parent_scope, method);
     qobject_unref(bsel);
 }

This means that if the hotplug on the root bus is disabled, we also
disable PCNT. This will also need the unit test update as the unit
test
will fail with :

@@ -3113,24 +3113,20 @@
                 Name (_ADR, 0x00010000)  // _ADR: Address
                 Method (_S1D, 0, NotSerialized)  // _S1D: S1 Device State
                 {
                     Return (Zero)
                 }

                 Method (_S2D, 0, NotSerialized)  // _S2D: S2 Device State
                 {
                     Return (Zero)
                 }

                 Method (_S3D, 0, NotSerialized)  // _S3D: S3 Device State
                 {
                     Return (Zero)
                 }
             }
-
-            Method (PCNT, 0, NotSerialized)
-            {
-            }
         }
     }
 }

Let's fix this as a separate patch.

>
> > >
> > > Signed-off-by: Ani Sinha <ani@anisinha.ca>
> > > ---
> > >  hw/acpi/piix4.c      |  6 ++++--
> > >  hw/i386/acpi-build.c | 10 ++++++++--
> > >  2 files changed, 12 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
> > > index e6163bb6ce..b70b1f98af 100644
> > > --- a/hw/acpi/piix4.c
> > > +++ b/hw/acpi/piix4.c
> > > @@ -596,8 +596,10 @@ static void piix4_acpi_system_hot_add_init(MemoryRegion *parent,
> > >                            "acpi-gpe0", GPE_LEN);
> > >      memory_region_add_subregion(parent, GPE_BASE, &s->io_gpe);
> > >
> > > -    acpi_pcihp_init(OBJECT(s), &s->acpi_pci_hotplug, bus, parent,
> > > -                    s->use_acpi_hotplug_bridge);
> > > +    if (s->use_acpi_hotplug_bridge || s->use_acpi_root_pci_hotplug) {
> > > +        acpi_pcihp_init(OBJECT(s), &s->acpi_pci_hotplug, bus, parent,
> > > +                        s->use_acpi_hotplug_bridge);
> > > +    }
> > >
> > >      s->cpu_hotplug_legacy = true;
> > >      object_property_add_bool(OBJECT(s), "cpu-hotplug-legacy",
> > > diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> > > index e079b686f5..7e3cf3b57b 100644
> > > --- a/hw/i386/acpi-build.c
> > > +++ b/hw/i386/acpi-build.c
> > > @@ -95,6 +95,7 @@ typedef struct AcpiPmInfo {
> > >      bool s3_disabled;
> > >      bool s4_disabled;
> > >      bool pcihp_bridge_en;
> > > +    bool pcihp_root_en;
> > >      uint8_t s4_val;
> > >      AcpiFadtData fadt;
> > >      uint16_t cpu_hp_io_base;
> > > @@ -245,6 +246,9 @@ static void acpi_get_pm_info(MachineState *machine, AcpiPmInfo *pm)
> > >      pm->pcihp_bridge_en =
> > >          object_property_get_bool(obj, "acpi-pci-hotplug-with-bridge-support",
> > >                                   NULL);
> > > +    pm->pcihp_root_en =
> > > +        object_property_get_bool(obj, "acpi-root-pci-hotplug",
> > > +                                 NULL);
> > >  }
> > >
> > >  static void acpi_get_misc_info(AcpiMiscInfo *info)
> > > @@ -1504,7 +1508,9 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
> > >          build_hpet_aml(dsdt);
> > >          build_piix4_isa_bridge(dsdt);
> > >          build_isa_devices_aml(dsdt);
> > > -        build_piix4_pci_hotplug(dsdt);
> > > +        if (pm->pcihp_bridge_en || pm->pcihp_root_en) {
> > > +            build_piix4_pci_hotplug(dsdt);
> > > +        }
> > >          build_piix4_pci0_int(dsdt);
> > >      } else {
> > >          sb_scope = aml_scope("_SB");
> > > @@ -1698,7 +1704,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
> > >      crs_range_set_free(&crs_range_set);
> > >
> > >      /* reserve PCIHP resources */
> > > -    if (pm->pcihp_io_len) {
> > > +    if (pm->pcihp_io_len && (pm->pcihp_bridge_en || pm->pcihp_root_en)) {
> > >          dev = aml_device("PHPR");
> > >          aml_append(dev, aml_name_decl("_HID", aml_string("PNP0A06")));
> > >          aml_append(dev,
> >

