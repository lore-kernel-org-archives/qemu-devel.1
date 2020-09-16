Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A37F2C433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 19:16:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB99920738
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 19:16:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TV4ZW3C2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB99920738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40242 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIcvH-0002ll-A7
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 15:16:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42612)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsuvorov@redhat.com>)
 id 1kIctK-0001lz-Gk
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 15:14:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:42970)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsuvorov@redhat.com>)
 id 1kIctH-0007L4-Qi
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 15:14:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600283689;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eqhYZKw1D2QyCVvvvt/lyAqVpl8uzzOku8v9rN9QE3Q=;
 b=TV4ZW3C26x4jkFfT1UO0nqymr2RzTPHWA4++njTA5qfUDDJnisxyu4NbkwloSDIyeue7fl
 6ROqDfc1gqWJP5QlVk67qpEIgf39VlvdnpFNPOm4Ol6VG6GCgcvcvGqwyXlhndXAqHBsxM
 Q94AxL0SKuxwSRzMh9IOLtGgmElLvUc=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-140-_Q0SPF3FO6WxwOqk7R_l7Q-1; Wed, 16 Sep 2020 15:14:48 -0400
X-MC-Unique: _Q0SPF3FO6WxwOqk7R_l7Q-1
Received: by mail-yb1-f198.google.com with SMTP id d15so4981177ybk.0
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2020 12:14:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=eqhYZKw1D2QyCVvvvt/lyAqVpl8uzzOku8v9rN9QE3Q=;
 b=PgADW1UCGyNUAL99V5nabcoB7lrIG39f7ffPA0w29iUd+Mv8OJhxbQrx6lI70JoMYs
 06dcNHlx6QgCX39doG0lNJzug1mGZkipkYDO/QcXfkPvJ73WKIMeli+KACxpfJ+722Ms
 crjZ2j0VXJzWIGblbyFeYBi55ok5jqOygDuSt/oFL5qDETsWFywPS3tYQIoptdMcHWcs
 /+9XKNZmk1uQZckp01bz4S0KakURzyABNWbKHGmX4ikY81R/Ng522poLKkAv3Gov+fCm
 0s8MiE97gXjmE41HAwJwMLN+1VZuTutAQwvMdryTGWE2wBFhPpExN8ReDGKSy57f1lnW
 AKdA==
X-Gm-Message-State: AOAM532GXBFLa0XtDs+wx8YI6UqV/43Us8jv44TpWOyS2GTOoQqwZXx+
 zoKWLLalHY6eRxbWiTWhFTuXV5ZnMpsBVxY/YjblgebGM+E6MKYr+BZBYu+fEn6ZMkTigns8b6C
 r3ejk592PpbifJaK6XKNoIPgjZ+New/I=
X-Received: by 2002:a25:4ac2:: with SMTP id x185mr28225418yba.81.1600283687670; 
 Wed, 16 Sep 2020 12:14:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzxI1rgxRhQLfKd+5OeYPlcW7SaczE+sQiXJTxLi04tJhuPHsuMl9AGxbPYAM7SgsWJKSpzICPaZ4mG5XoxMag=
X-Received: by 2002:a25:4ac2:: with SMTP id x185mr28225399yba.81.1600283687451; 
 Wed, 16 Sep 2020 12:14:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200818215227.181654-1-jusual@redhat.com>
 <20200818215227.181654-4-jusual@redhat.com>
 <20200821141339.00f2076c@redhat.com>
 <CAMDeoFU4nHJZ6FNtTKjnpA8h12AmLpycSEKGkUO85CNy643WyQ@mail.gmail.com>
In-Reply-To: <CAMDeoFU4nHJZ6FNtTKjnpA8h12AmLpycSEKGkUO85CNy643WyQ@mail.gmail.com>
From: Julia Suvorova <jusual@redhat.com>
Date: Wed, 16 Sep 2020 21:14:36 +0200
Message-ID: <CAMDeoFW+KC69j7GW_-w5n1iJashYmZ2i_f-nEsPOs3DQkzog7g@mail.gmail.com>
Subject: Re: [RFC PATCH v2 3/4] hw/i386/acpi-build: Turn off support of PCIe
 native hot-plug and SHPC in _OSC
To: Igor Mammedov <imammedo@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsuvorov@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=jsuvorov@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 02:35:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Gerd Hoffmann <kraxel@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Sep 16, 2020 at 8:03 PM Julia Suvorova <jusual@redhat.com> wrote:
>
> On Fri, Aug 21, 2020 at 2:13 PM Igor Mammedov <imammedo@redhat.com> wrote:
> >
> > On Tue, 18 Aug 2020 23:52:26 +0200
> > Julia Suvorova <jusual@redhat.com> wrote:
> >
> > > Other methods may be used if the system is capable of this and the _OSC bit
> > > is set. Disable them explicitly to force ACPI PCI hot-plug use. The older
> > > versions will still use PCIe native.
> > >
> > > Signed-off-by: Julia Suvorova <jusual@redhat.com>
> > > ---
> > >  hw/i386/acpi-build.h | 11 +++++++++++
> > >  hw/i386/acpi-build.c | 21 +++++++++++++++------
> > >  2 files changed, 26 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/hw/i386/acpi-build.h b/hw/i386/acpi-build.h
> > > index 74df5fc612..6f94312c39 100644
> > > --- a/hw/i386/acpi-build.h
> > > +++ b/hw/i386/acpi-build.h
> > > @@ -5,6 +5,17 @@
> > >
> > >  extern const struct AcpiGenericAddress x86_nvdimm_acpi_dsmio;
> > >
> > > +/* PCI Firmware Specification 3.2, Table 4-5 */
> > > +typedef enum {
> > > +    ACPI_OSC_NATIVE_HP_EN = 0,
> > > +    ACPI_OSC_SHPC_EN = 1,
> > > +    ACPI_OSC_PME_EN = 2,
> > > +    ACPI_OSC_AER_EN = 3,
> > > +    ACPI_OSC_PCIE_CAP_EN = 4,
> > > +    ACPI_OSC_LTR_EN = 5,
> > > +    ACPI_OSC_ALLONES_INVALID = 6,
> > > +} AcpiOSCField;
> > > +
> > >  void acpi_setup(void);
> > >
> > >  #endif
> > > diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> > > index f3cd52bd06..c5f4802b8c 100644
> > > --- a/hw/i386/acpi-build.c
> > > +++ b/hw/i386/acpi-build.c
> > > @@ -1411,7 +1411,7 @@ static void build_i386_pci_hotplug(Aml *table, uint64_t pcihp_addr)
> > >      aml_append(table, scope);
> > >  }
> > >
> > > -static Aml *build_q35_osc_method(void)
> > > +static Aml *build_q35_osc_method(AcpiPmInfo *pm)
> > >  {
> > >      Aml *if_ctx;
> > >      Aml *if_ctx2;
> > > @@ -1419,6 +1419,7 @@ static Aml *build_q35_osc_method(void)
> > >      Aml *method;
> > >      Aml *a_cwd1 = aml_name("CDW1");
> > >      Aml *a_ctrl = aml_local(0);
> > > +    unsigned osc_ctrl;
> > >
> > >      method = aml_method("_OSC", 4, AML_NOTSERIALIZED);
> > >      aml_append(method, aml_create_dword_field(aml_arg(3), aml_int(0), "CDW1"));
> > > @@ -1430,11 +1431,19 @@ static Aml *build_q35_osc_method(void)
> > >
> > >      aml_append(if_ctx, aml_store(aml_name("CDW3"), a_ctrl));
> > >
> > > +    /* Always allow native PME, AER (depend on PCIE Capability Control) */
> > > +    osc_ctrl = BIT(ACPI_OSC_PME_EN) | BIT(ACPI_OSC_AER_EN) |
> > > +               BIT(ACPI_OSC_PCIE_CAP_EN);
> > > +
> > >      /*
> > > -     * Always allow native PME, AER (no dependencies)
> > > -     * Allow SHPC (PCI bridges can have SHPC controller)
> > > +     * Guests seem to generally prefer native hot-plug control.
> > > +     * Enable it only when we do not use ACPI hot-plug.
> > >       */
> > > -    aml_append(if_ctx, aml_and(a_ctrl, aml_int(0x1F), a_ctrl));
> > > +    if (!pm->pcihp_bridge_en) {
> > > +        osc_ctrl |= BIT(ACPI_OSC_NATIVE_HP_EN) | BIT(ACPI_OSC_SHPC_EN);
> > > +    }
> >
> > ACPI hotplug works only for coldplugged bridges, and native one is used
> > on hotplugged ones.
> > Wouldn't that break SHPC/Native hotplug on hotplugged PCI/PCI-E bridge?

Wait, what configuration are you talking about exactly?

> > > +    aml_append(if_ctx, aml_and(a_ctrl, aml_int(osc_ctrl), a_ctrl));
> > >
> > >      if_ctx2 = aml_if(aml_lnot(aml_equal(aml_arg(1), aml_int(1))));
> > >      /* Unknown revision */
> > > @@ -1514,7 +1523,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
> > >          aml_append(dev, aml_name_decl("_CID", aml_eisaid("PNP0A03")));
> > >          aml_append(dev, aml_name_decl("_ADR", aml_int(0)));
> > >          aml_append(dev, aml_name_decl("_UID", aml_int(1)));
> > > -        aml_append(dev, build_q35_osc_method());
> > > +        aml_append(dev, build_q35_osc_method(pm));
> > >          aml_append(sb_scope, dev);
> > >          aml_append(dsdt, sb_scope);
> > >
> > > @@ -1590,7 +1599,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
> > >              if (pci_bus_is_express(bus)) {
> > >                  aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0A08")));
> > >                  aml_append(dev, aml_name_decl("_CID", aml_eisaid("PNP0A03")));
> > > -                aml_append(dev, build_q35_osc_method());
> > > +                aml_append(dev, build_q35_osc_method(pm));
> > >              } else {
> > >                  aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0A03")));
> > >              }
> >


