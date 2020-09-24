Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1992CC4346E
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 09:05:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F36A23741
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 09:05:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MOFNXpGX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F36A23741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37102 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLNBf-0006OK-Ie
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 05:05:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33326)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kLN9A-0004F6-D6
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 05:02:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24862)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kLN98-00039O-By
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 05:02:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600938153;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lMdk596S4ITjzOz7XeP9L+AjtGfJQgCBU7cJi/MIIws=;
 b=MOFNXpGXYeCFEKNRyFdtK9YMgyGzca1jKtzat4okGtRuzaGky9DU7D5gCHM6X6dPJOe7hZ
 Re5vEFCD4IWPkiinLhT6/8dqh8j1G4c0e/1DsjJGzUrVWcpO9TykNiUWiWH+mKfybubW+C
 JqkS4TC/NpJJfRObcIOfhz92v8Ev9fs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-513-tSbkg0XVOliF1ZtkEYozqA-1; Thu, 24 Sep 2020 05:02:31 -0400
X-MC-Unique: tSbkg0XVOliF1ZtkEYozqA-1
Received: by mail-wr1-f72.google.com with SMTP id b7so980748wrn.6
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2020 02:02:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=lMdk596S4ITjzOz7XeP9L+AjtGfJQgCBU7cJi/MIIws=;
 b=MWMRJdjHLW7qRuRJ9RFOA5nM+7UVq4qLRUSROlIELUTAF+oMuQrE/BFEOk0KTx9HdD
 k9XuWmhMBTUaZUtcjgszrvNgGUS4E/Oe1DZwrpJGhTLLSwpn7q6DfMCsfaOtbipqbFat
 oqU+Tp+HT6njguwQgHukZcmthJlaOs0FDyq7c8M2P9WoVB6G3pt7CNXHNHEG3NvagHm0
 JsTZT6tbKgSV74Va9kdrmwQhCh2yOmLu1U8Gmuw1VdKRfW8+SBsXpi1m9RCgLkmoEWo+
 Co9lRWaAteG9cv87O8il8Sj149tjMJ3wIFkqzSvgd2WT9SKAK8VycKogpRO6OMYrniOw
 OueA==
X-Gm-Message-State: AOAM531nc16naLCRZ6d4HhzNepLFEzxz7eblUjN4LMb3kzPh6InlGBC3
 unW+zlJAMe38SVNcwwt1uDJN+swlC1C2t5enqd32dKHUL/UeoQP5CRDaFoYSkIIpTiq1POiV+o+
 9fQBb9BaEDVUWgI8=
X-Received: by 2002:adf:a29a:: with SMTP id s26mr3944089wra.197.1600938150657; 
 Thu, 24 Sep 2020 02:02:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJydopXE8yMRyJZ6C+KJQeUcOiluHVWpnpJ+GkKeDB3klg2jOsBWLCVagzXhhQLlcUQ943SuAw==
X-Received: by 2002:adf:a29a:: with SMTP id s26mr3944062wra.197.1600938150401; 
 Thu, 24 Sep 2020 02:02:30 -0700 (PDT)
Received: from redhat.com (bzq-79-179-71-128.red.bezeqint.net. [79.179.71.128])
 by smtp.gmail.com with ESMTPSA id q12sm2866979wrp.17.2020.09.24.02.02.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2020 02:02:29 -0700 (PDT)
Date: Thu, 24 Sep 2020 05:02:27 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Julia Suvorova <jusual@redhat.com>
Subject: Re: [RFC PATCH v3 3/7] hw/pci/pcie: Do not initialize slot
 capability if acpihp is used
Message-ID: <20200924050147-mutt-send-email-mst@kernel.org>
References: <20200924070013.165026-1-jusual@redhat.com>
 <20200924070013.165026-4-jusual@redhat.com>
 <20200924033305-mutt-send-email-mst@kernel.org>
 <CAMDeoFXobPuNnKB3bQB=20SPbvTCgNiE_UWJrtsT6d5aAS5sTQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAMDeoFXobPuNnKB3bQB=20SPbvTCgNiE_UWJrtsT6d5aAS5sTQ@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 23:02:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.228,
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
Cc: Ani Sinha <ani@anisinha.ca>, Igor Mammedov <imammedo@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Sep 24, 2020 at 10:23:13AM +0200, Julia Suvorova wrote:
> On Thu, Sep 24, 2020 at 9:36 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Thu, Sep 24, 2020 at 09:00:09AM +0200, Julia Suvorova wrote:
> > > Instead of changing the hot-plug type in _OSC register, do not
> > > initialize the slot capability or set the 'Slot Implemented' flag.
> > > This way guest will choose ACPI hot-plug if it is preferred and leave
> > > the option to use SHPC with pcie-pci-bridge.
> > >
> > > Signed-off-by: Julia Suvorova <jusual@redhat.com>
> > > ---
> > >  hw/i386/acpi-build.h |  2 ++
> > >  hw/i386/acpi-build.c |  2 +-
> > >  hw/pci/pcie.c        | 16 ++++++++++++++++
> > >  3 files changed, 19 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/hw/i386/acpi-build.h b/hw/i386/acpi-build.h
> > > index 487ec7710f..4c5bfb3d0b 100644
> > > --- a/hw/i386/acpi-build.h
> > > +++ b/hw/i386/acpi-build.h
> > > @@ -11,4 +11,6 @@ extern const struct AcpiGenericAddress x86_nvdimm_acpi_dsmio;
> > >
> > >  void acpi_setup(void);
> > >
> > > +Object *object_resolve_type_unambiguous(const char *typename);
> > > +
> > >  #endif
> > > diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> > > index cf503b16af..b7811a8912 100644
> > > --- a/hw/i386/acpi-build.c
> > > +++ b/hw/i386/acpi-build.c
> > > @@ -174,7 +174,7 @@ static void init_common_fadt_data(MachineState *ms, Object *o,
> > >      *data = fadt;
> > >  }
> > >
> > > -static Object *object_resolve_type_unambiguous(const char *typename)
> > > +Object *object_resolve_type_unambiguous(const char *typename)
> > >  {
> > >      bool ambig;
> > >      Object *o = object_resolve_path_type("", typename, &ambig);
> > > diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
> > > index 5b48bae0f6..c1a082e8b9 100644
> > > --- a/hw/pci/pcie.c
> > > +++ b/hw/pci/pcie.c
> > > @@ -27,6 +27,8 @@
> > >  #include "hw/pci/pci_bus.h"
> > >  #include "hw/pci/pcie_regs.h"
> > >  #include "hw/pci/pcie_port.h"
> > > +#include "hw/i386/ich9.h"
> > > +#include "hw/i386/acpi-build.h"
> > >  #include "qemu/range.h"
> > >
> > >  //#define DEBUG_PCIE
> >
> >
> > Not really happy with pcie.c getting an i386 dependency.
> >
> >
> >
> > > @@ -515,12 +517,26 @@ void pcie_cap_slot_unplug_request_cb(HotplugHandler *hotplug_dev,
> > >      pcie_cap_slot_push_attention_button(hotplug_pdev);
> > >  }
> > >
> > > +static bool acpi_pcihp_enabled(void)
> > > +{
> > > +    Object *lpc = object_resolve_type_unambiguous(TYPE_ICH9_LPC_DEVICE);
> > > +
> > > +    return lpc &&
> > > +           object_property_get_bool(lpc, "acpi-pci-hotplug-with-bridge-support",
> > > +                                    NULL);
> > > +
> > > +}
> > > +
> >
> > Why not just check the property unconditionally?
> 
> Ok.
> 
> > >  /* pci express slot for pci express root/downstream port
> > >     PCI express capability slot registers */
> > >  void pcie_cap_slot_init(PCIDevice *dev, PCIESlot *s)
> > >  {
> > >      uint32_t pos = dev->exp.exp_cap;
> > >
> > > +    if (acpi_pcihp_enabled()) {
> > > +        return;
> > > +    }
> > > +
> >
> > I think I would rather not teach pcie about acpi. How about we
> > change the polarity, name the property
> > "pci-native-hotplug" or whatever makes sense.
> 
> I'd prefer not to change the property name since the common code in
> hw/i386/acpi-build.c depends on it, but I can add a new one if it
> makes any sense.

And maybe prefix with "x-" so we don't commit to it as an
external API.


> > >      pci_word_test_and_set_mask(dev->config + pos + PCI_EXP_FLAGS,
> > >                                 PCI_EXP_FLAGS_SLOT);
> > >
> > > --
> > > 2.25.4
> >


