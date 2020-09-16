Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCA00C433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 18:04:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DE6D20838
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 18:04:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FgC4/fRZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DE6D20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45632 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIbn9-0001Gz-SN
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 14:04:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52736)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsuvorov@redhat.com>)
 id 1kIbmW-0000rv-Jh
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 14:03:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52743)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsuvorov@redhat.com>)
 id 1kIbmU-0006VX-4C
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 14:03:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600279424;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WoquiOdhe4q6RxMZ0Oj7bFMkolNKh9tXrHhIvDzlz1o=;
 b=FgC4/fRZLnnrkVqp1iuMi8laeOAvGYWZ0PkyM8F4HTDj1vWQlQTp8EIcKm3Z4XBzvrbNPt
 N36N7wN1bdgmomg3nSS3uJDPisPb55Xz7iCDvpOJMojvnXx0oj17hd46BgkOmi/rYBBs6Y
 umRb8sfbv9LAmFIwToRa5a6um7+O6Do=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-137-wlRCI-_LOk6fSEm149gbpQ-1; Wed, 16 Sep 2020 14:03:43 -0400
X-MC-Unique: wlRCI-_LOk6fSEm149gbpQ-1
Received: by mail-yb1-f198.google.com with SMTP id b127so7795727ybh.21
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2020 11:03:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=WoquiOdhe4q6RxMZ0Oj7bFMkolNKh9tXrHhIvDzlz1o=;
 b=ULv1oitNlS/Zh/ZEUxnf6qfGuyvvzwgiZU6Phci3CbzpiG5VQuo0THoZGqIxZlfYdx
 ljZcpuIp1vbllxtcbYP49iyX4CeJRfSYj/SSOHWobySGIGVcpAA9ZpZpPAuWW0MFbsO4
 p4BE+afEGozoiokHac4Nhm/YdoPfqoLpywdJl5VXqvCtm4Mz95la0zl7zbVApeYlK+eT
 xaaqk13PWGJPrruovIM6gzdu5wtPFLhJEBJUwQN7aoLhQvx094Kqal7emeOwz3es9uHX
 iLguCwz572DnqyNiDZ6n1CS3802YiC2lARdrnlcy1j4wRPJ4OpMPbIR2zEq5meOVvRgq
 ZYrA==
X-Gm-Message-State: AOAM531HNk9VziqTvq1FobOMqXUg+3tKnOgKMmOVD0iED0MttGokUEBQ
 oNY46WlKPJtEvTSWJTlGMnXzd8XXbpNHzW3O8aDtfgfB19WMmYs7bOylFVHUKjMvMDKIKqlov2E
 HYxsyAVd2tEAl2dsSPH9XklqRmZKZUQ8=
X-Received: by 2002:a25:198b:: with SMTP id 133mr8738785ybz.102.1600279422500; 
 Wed, 16 Sep 2020 11:03:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxwRTwUPq4CjrBfKLEI9z5zT4BOgCpXQA3RvR1YswQcwKS80g/Yu+07xhBOxmvvnAhx5u0iHsfAoPot6Dz4AtU=
X-Received: by 2002:a25:198b:: with SMTP id 133mr8738719ybz.102.1600279422017; 
 Wed, 16 Sep 2020 11:03:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200818215227.181654-1-jusual@redhat.com>
 <20200818215227.181654-4-jusual@redhat.com>
 <20200821141339.00f2076c@redhat.com>
In-Reply-To: <20200821141339.00f2076c@redhat.com>
From: Julia Suvorova <jusual@redhat.com>
Date: Wed, 16 Sep 2020 20:03:30 +0200
Message-ID: <CAMDeoFU4nHJZ6FNtTKjnpA8h12AmLpycSEKGkUO85CNy643WyQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 3/4] hw/i386/acpi-build: Turn off support of PCIe
 native hot-plug and SHPC in _OSC
To: Igor Mammedov <imammedo@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsuvorov@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=jsuvorov@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 02:16:02
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

On Fri, Aug 21, 2020 at 2:13 PM Igor Mammedov <imammedo@redhat.com> wrote:
>
> On Tue, 18 Aug 2020 23:52:26 +0200
> Julia Suvorova <jusual@redhat.com> wrote:
>
> > Other methods may be used if the system is capable of this and the _OSC bit
> > is set. Disable them explicitly to force ACPI PCI hot-plug use. The older
> > versions will still use PCIe native.
> >
> > Signed-off-by: Julia Suvorova <jusual@redhat.com>
> > ---
> >  hw/i386/acpi-build.h | 11 +++++++++++
> >  hw/i386/acpi-build.c | 21 +++++++++++++++------
> >  2 files changed, 26 insertions(+), 6 deletions(-)
> >
> > diff --git a/hw/i386/acpi-build.h b/hw/i386/acpi-build.h
> > index 74df5fc612..6f94312c39 100644
> > --- a/hw/i386/acpi-build.h
> > +++ b/hw/i386/acpi-build.h
> > @@ -5,6 +5,17 @@
> >
> >  extern const struct AcpiGenericAddress x86_nvdimm_acpi_dsmio;
> >
> > +/* PCI Firmware Specification 3.2, Table 4-5 */
> > +typedef enum {
> > +    ACPI_OSC_NATIVE_HP_EN = 0,
> > +    ACPI_OSC_SHPC_EN = 1,
> > +    ACPI_OSC_PME_EN = 2,
> > +    ACPI_OSC_AER_EN = 3,
> > +    ACPI_OSC_PCIE_CAP_EN = 4,
> > +    ACPI_OSC_LTR_EN = 5,
> > +    ACPI_OSC_ALLONES_INVALID = 6,
> > +} AcpiOSCField;
> > +
> >  void acpi_setup(void);
> >
> >  #endif
> > diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> > index f3cd52bd06..c5f4802b8c 100644
> > --- a/hw/i386/acpi-build.c
> > +++ b/hw/i386/acpi-build.c
> > @@ -1411,7 +1411,7 @@ static void build_i386_pci_hotplug(Aml *table, uint64_t pcihp_addr)
> >      aml_append(table, scope);
> >  }
> >
> > -static Aml *build_q35_osc_method(void)
> > +static Aml *build_q35_osc_method(AcpiPmInfo *pm)
> >  {
> >      Aml *if_ctx;
> >      Aml *if_ctx2;
> > @@ -1419,6 +1419,7 @@ static Aml *build_q35_osc_method(void)
> >      Aml *method;
> >      Aml *a_cwd1 = aml_name("CDW1");
> >      Aml *a_ctrl = aml_local(0);
> > +    unsigned osc_ctrl;
> >
> >      method = aml_method("_OSC", 4, AML_NOTSERIALIZED);
> >      aml_append(method, aml_create_dword_field(aml_arg(3), aml_int(0), "CDW1"));
> > @@ -1430,11 +1431,19 @@ static Aml *build_q35_osc_method(void)
> >
> >      aml_append(if_ctx, aml_store(aml_name("CDW3"), a_ctrl));
> >
> > +    /* Always allow native PME, AER (depend on PCIE Capability Control) */
> > +    osc_ctrl = BIT(ACPI_OSC_PME_EN) | BIT(ACPI_OSC_AER_EN) |
> > +               BIT(ACPI_OSC_PCIE_CAP_EN);
> > +
> >      /*
> > -     * Always allow native PME, AER (no dependencies)
> > -     * Allow SHPC (PCI bridges can have SHPC controller)
> > +     * Guests seem to generally prefer native hot-plug control.
> > +     * Enable it only when we do not use ACPI hot-plug.
> >       */
> > -    aml_append(if_ctx, aml_and(a_ctrl, aml_int(0x1F), a_ctrl));
> > +    if (!pm->pcihp_bridge_en) {
> > +        osc_ctrl |= BIT(ACPI_OSC_NATIVE_HP_EN) | BIT(ACPI_OSC_SHPC_EN);
> > +    }
>
> ACPI hotplug works only for coldplugged bridges, and native one is used
> on hotplugged ones.
> Wouldn't that break SHPC/Native hotplug on hotplugged PCI/PCI-E bridge?

Yes, it would. I'll mention it in the commit message.

> > +    aml_append(if_ctx, aml_and(a_ctrl, aml_int(osc_ctrl), a_ctrl));
> >
> >      if_ctx2 = aml_if(aml_lnot(aml_equal(aml_arg(1), aml_int(1))));
> >      /* Unknown revision */
> > @@ -1514,7 +1523,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
> >          aml_append(dev, aml_name_decl("_CID", aml_eisaid("PNP0A03")));
> >          aml_append(dev, aml_name_decl("_ADR", aml_int(0)));
> >          aml_append(dev, aml_name_decl("_UID", aml_int(1)));
> > -        aml_append(dev, build_q35_osc_method());
> > +        aml_append(dev, build_q35_osc_method(pm));
> >          aml_append(sb_scope, dev);
> >          aml_append(dsdt, sb_scope);
> >
> > @@ -1590,7 +1599,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
> >              if (pci_bus_is_express(bus)) {
> >                  aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0A08")));
> >                  aml_append(dev, aml_name_decl("_CID", aml_eisaid("PNP0A03")));
> > -                aml_append(dev, build_q35_osc_method());
> > +                aml_append(dev, build_q35_osc_method(pm));
> >              } else {
> >                  aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0A03")));
> >              }
>


