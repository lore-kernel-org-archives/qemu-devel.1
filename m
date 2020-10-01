Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E3C2C4727C
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 08:57:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B77A220BED
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 08:57:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CANTDXXN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B77A220BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNuP4-0002V4-Sy
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 04:57:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40256)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsuvorov@redhat.com>)
 id 1kNuNU-0001Bd-R8
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 04:55:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:38904)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsuvorov@redhat.com>)
 id 1kNuNS-0005qq-2o
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 04:55:52 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601542549;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JVHCU7ladiuoS1l3PyBDXTsMi8Lg6z2W73d1fDWYdM4=;
 b=CANTDXXN7LTScNq/hCBXHffh1YQ9V/oh5jHSa1dvd+3RjowSNUvpD8bIm8CnUfekjI2dGZ
 p5RxWmuV4j5ClW9k2RdK0Hf7aGG03l+EjvUElWGtGsV1pFWZfHcyXX2QmMRdtKhnxzpwpk
 CsN1xraEo+TzInqxRXUv/OibB3VKHP0=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-450-lR-rKWAvNvy2exsrRu9NUA-1; Thu, 01 Oct 2020 04:55:47 -0400
X-MC-Unique: lR-rKWAvNvy2exsrRu9NUA-1
Received: by mail-oi1-f197.google.com with SMTP id a143so1524891oib.14
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2020 01:55:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=JVHCU7ladiuoS1l3PyBDXTsMi8Lg6z2W73d1fDWYdM4=;
 b=Lh5jzIfLNywr2AJp/ingbkv3u6by9xitp21FWNbw2Xmdlznnpos3RnlRLCKL+goKuc
 KSLHwCz4YzhIBR7TPDwX16FXB+tjVqY5htDlzn1An2E3L4aiFmqag69nYBG2ApL0oZJs
 so0x5WChGjAw+vBKGk6G5lLubhjyu/cE1FZbxCvIYFxHaiYw5eEdnFrmfOc2GsmEAtB6
 ewOou0KVX641BicVyF69o1yAx7l4V7vVuYSau+dK4OtwSBYLffNfmdFoJshZf4KisMa8
 Y/aBusVqSTO7cjH8yO9BLtl3QjJQXKAjUfqRXhLlfrSFWHZ6hoQ6u0nmrKemyTWOcDAV
 hJsA==
X-Gm-Message-State: AOAM5328v92gCL8LgfpmWhYCMpBz2D6HaQUBAJDMgp0CN2wVtFUGZAZT
 5YCo5t//moPlTtfwVxzgX0gEDfZqn4ZWo5H40oTA5LsySFlxu8OSZD+cbWBiJZaoSVWEc6Kolps
 wHCZ426MaC3s7rN36h0u8AEyrvYodips=
X-Received: by 2002:a05:6808:491:: with SMTP id
 z17mr3777657oid.110.1601542546877; 
 Thu, 01 Oct 2020 01:55:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwcrd8Et+35MPPpTw/KfAuWfbzHjsY3S6BnsC3iMyF2KK4cR9sli4t6mLVj92UwWx/iZj5UMdAOGrdGM8msGN0=
X-Received: by 2002:a05:6808:491:: with SMTP id
 z17mr3777649oid.110.1601542546658; 
 Thu, 01 Oct 2020 01:55:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200924070013.165026-1-jusual@redhat.com>
 <20200924050236-mutt-send-email-mst@kernel.org>
In-Reply-To: <20200924050236-mutt-send-email-mst@kernel.org>
From: Julia Suvorova <jusual@redhat.com>
Date: Thu, 1 Oct 2020 10:55:35 +0200
Message-ID: <CAMDeoFU_ZO7UxQsz-tvA6WsFm2qK755W5guGoVHfVs55Gb7aUg@mail.gmail.com>
Subject: Re: [RFC PATCH v3 0/7] Use ACPI PCI hot-plug for Q35
To: "Michael S. Tsirkin" <mst@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsuvorov@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=jsuvorov@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/01 02:15:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.469,
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

On Thu, Sep 24, 2020 at 11:20 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Thu, Sep 24, 2020 at 09:00:06AM +0200, Julia Suvorova wrote:
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
>
> something I don't quite get is whether with this one can still add
> new pcie bridges and then hotplug into these with native
> hotplug.

Right now I disable native if there is acpihp anywhere, but even if
you enable it for hotplugged devices, native hot-plug will not work.

> the challenge to answering this with certainty is that right now qemu
> does not allow hotplugging complex devices such as bridges at all,
> we only have a hack for multifunction devices.
> Maybe adding a bridge as function 1 on command line, then hotplugging another device as
> function 0 will work to test this.
>
>
>
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
> > --
> > 2.25.4
>


