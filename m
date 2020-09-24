Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DEE1C4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 10:17:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C02023600
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 10:17:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aVKFWrgc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C02023600
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47222 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLOJM-00043e-1U
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 06:17:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43060)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kLNj2-0006dj-MV
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 05:39:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:38250)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kLNiz-00082u-38
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 05:39:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600940375;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Em4IkLJUF/1Mq/0K4sowgpoGFUKvRQ9W6yxqZRCeRAs=;
 b=aVKFWrgcXNsvJPrdgtL87emtLpxt31GOZYVdctHObZ7M+jJ7CjhSTaDBrqNxlX99GJtoB/
 Z6Xx5/Oo3ez6+iTSFezvf0ENktQAtGZfQcLCLTnnTagjxrKw1h4+kfQccz7GkUkMU1s0ex
 uxFgHyMQucVMnFbrT6NbPryKwBAAxpg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-310-iUxrCwA5NxugBZS8Ptqwcg-1; Thu, 24 Sep 2020 05:39:34 -0400
X-MC-Unique: iUxrCwA5NxugBZS8Ptqwcg-1
Received: by mail-wr1-f71.google.com with SMTP id 33so1023254wre.0
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2020 02:39:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Em4IkLJUF/1Mq/0K4sowgpoGFUKvRQ9W6yxqZRCeRAs=;
 b=EHd8FmH371aLFoHNmJ1j9ba2gaM13J2x9VHHEH0Yuw22hVGoEp2sXHeUHDW0fU/1lv
 0e8GxLzfrwmhlUHW3ncBrB2QYTHm93VVZ/q6CM+odrwVLYy5CkP9fLvY/3L/ShNBZjCg
 ZJluBtDHyZyImbeT0fJkkVNvqfZ4pbU//UVDQyQjz8/gQ5UT93Euau/aD8BP++Dh/1RG
 KIiqaiAX1/cLHVxVQCYgkLGkgETtQaMuiWmidYsiv1OfNHa0f/1JPWVw84e+Tdnmd1Gj
 qqSDyy0B6XQwP3nsnpBIk1Rlflpvf5Rj3t4qEqEF8XLo+6PN2XDDuff4vMHhxh2bl9Ak
 lDsQ==
X-Gm-Message-State: AOAM533mEOjPmLjZT7gu/F0YyR4pqUxKyEZ3d6jPlJGajh47ygmDygSr
 +K4qtxuCXx5OXEQmEoe7I8wA4PULr6qFPDTc5h9CfpcjxfrS26h/3NvLsOM26uiOMX4+tPlFIwc
 2dyP47uAesTwxwmM=
X-Received: by 2002:adf:8405:: with SMTP id 5mr4337581wrf.143.1600940372787;
 Thu, 24 Sep 2020 02:39:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwi+rUmxsjSVE0Tpvw4GyWvlh9+55SNMT6wNgpa4kN8UX99G5f512XO+AUCY0gTgX5awfikGg==
X-Received: by 2002:adf:8405:: with SMTP id 5mr4337560wrf.143.1600940372556;
 Thu, 24 Sep 2020 02:39:32 -0700 (PDT)
Received: from redhat.com (bzq-79-179-71-128.red.bezeqint.net. [79.179.71.128])
 by smtp.gmail.com with ESMTPSA id h3sm3153106wrq.0.2020.09.24.02.39.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2020 02:39:31 -0700 (PDT)
Date: Thu, 24 Sep 2020 05:39:29 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Subject: Re: [RFC PATCH v3 0/7] Use ACPI PCI hot-plug for Q35
Message-ID: <20200924053828-mutt-send-email-mst@kernel.org>
References: <20200924070013.165026-1-jusual@redhat.com>
 <20200924113000.17863350@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200924113000.17863350@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/24 01:10:00
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
Cc: Ani Sinha <ani@anisinha.ca>, Julia Suvorova <jusual@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Sep 24, 2020 at 11:30:00AM +0200, Igor Mammedov wrote:
> On Thu, 24 Sep 2020 09:00:06 +0200
> Julia Suvorova <jusual@redhat.com> wrote:
> 
> > The patch set consists of two parts:
> > patches 1-4: introduce new feature
> >              'acpi-pci-hotplug-with-bridge-support' on Q35
> > patches 5-7: make the feature default along with changes in ACPI tables
> > 
> > This way maintainers can decide which way to choose without breaking
> > the patch set.
> > 
> > With the feature disabled Q35 falls back to the native hot-plug.
> > 
> > Pros
> >     * no racy behavior during boot (see 110c477c2ed)
> >     * eject is possible - according to PCIe spec, attention button
> >       press should lead to power off, and then the adapter should be
> >       removed manually. As there is no power down state exists in QEMU,
> >       we cannot distinguish between an eject and a power down
> >       request.
> 
> if I recall right, you had a idea about
>  keeping pending removal request to distinguish between eject and poweroff
>  (i.e. eject if mgmt asked for removal and otherwise it could be poweroff|nop)
>  Why it didn't work out in the end?

For better or worse guests expect to eject and have it happen,
without also asking management to do it ...

> >     * no delay during deleting - after the actual power off software
> >       must wait at least 1 second before indicating about it. This case
> >       is quite important for users, it even has its own bug:
> >           https://bugzilla.redhat.com/show_bug.cgi?id=1594168
> >     * no timer-based behavior - in addition to the previous example,
> >       the attention button has a 5-second waiting period, during which
> >       the operation can be canceled with a second press. While this
> >       looks fine for manual button control, automation will result in
> >       the need to queue or drop events, and the software receiving
> >       events in all sort of unspecified combinations of attention/power
> >       indicator states, which is racy and uppredictable.
> >     * fixes:
> >         * https://bugzilla.redhat.com/show_bug.cgi?id=1752465
> >         * https://bugzilla.redhat.com/show_bug.cgi?id=1690256
> > 
> > Cons:
> >     * lose per-port control over hot-plug (can be resolved)
> >     * no access to possible features presented in slot capabilities
> >       (this is only surprise removal AFAIK)
> > 
> > v3:
> >     * drop change of _OSC to allow SHPC on hotplugged bridges
> >     * use 'acpi-root-pci-hotplug'
> >     * add migration states [Igor]
> >     * minor style changes
> > 
> > v2:
> >     * new ioport range for acpiphp [Gerd]
> >     * drop find_pci_host() [Igor]
> >     * explain magic numbers in _OSC [Igor]
> >     * drop build_q35_pci_hotplug() wrapper [Igor]
> > 
> > Julia Suvorova (7):
> >   hw/acpi/pcihp: Enhance acpi_pcihp_disable_root_bus() to support Q35
> >   hw/i386/acpi-build: Add ACPI PCI hot-plug methods to Q35
> >   hw/pci/pcie: Do not initialize slot capability if acpihp is used
> >   hw/acpi/ich9: Enable ACPI PCI hot-plug
> >   bios-tables-test: Allow changes in DSDT ACPI tables
> >   hw/acpi/ich9: Set ACPI PCI hot-plug as default
> >   bios-tables-test: Update golden binaries
> > 
> >  hw/i386/acpi-build.h              |   7 ++++
> >  include/hw/acpi/ich9.h            |   5 +++
> >  include/hw/acpi/pcihp.h           |   3 +-
> >  hw/acpi/ich9.c                    |  67 ++++++++++++++++++++++++++++++
> >  hw/acpi/pcihp.c                   |  16 ++++---
> >  hw/acpi/piix4.c                   |   4 +-
> >  hw/i386/acpi-build.c              |  31 ++++++++------
> >  hw/i386/pc.c                      |   1 +
> >  hw/pci/pcie.c                     |  16 +++++++
> >  tests/data/acpi/q35/DSDT          | Bin 7678 -> 7950 bytes
> >  tests/data/acpi/q35/DSDT.acpihmat | Bin 9002 -> 9274 bytes
> >  tests/data/acpi/q35/DSDT.bridge   | Bin 7695 -> 9865 bytes
> >  tests/data/acpi/q35/DSDT.cphp     | Bin 8141 -> 8413 bytes
> >  tests/data/acpi/q35/DSDT.dimmpxm  | Bin 9331 -> 9603 bytes
> >  tests/data/acpi/q35/DSDT.ipmibt   | Bin 7753 -> 8025 bytes
> >  tests/data/acpi/q35/DSDT.memhp    | Bin 9037 -> 9309 bytes
> >  tests/data/acpi/q35/DSDT.mmio64   | Bin 8808 -> 9080 bytes
> >  tests/data/acpi/q35/DSDT.numamem  | Bin 7684 -> 7956 bytes
> >  tests/data/acpi/q35/DSDT.tis      | Bin 8283 -> 8555 bytes
> >  19 files changed, 129 insertions(+), 21 deletions(-)
> > 


