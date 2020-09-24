Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4064C4727D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 09:21:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4867022208
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 09:21:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VwbXG+HU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4867022208
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56934 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLNRY-0007MJ-7b
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 05:21:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37802)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kLNQF-0006Og-Aa
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 05:20:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52553)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kLNQD-0005a3-8I
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 05:20:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600939212;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DMQKbmEgRVJHgyL5PhQoezSPMUMwIr8B8kyS+LUDP8Y=;
 b=VwbXG+HUKAkAkL49DDgZupEWExsS5rSjRAH2hc3kGIMGsukhdfW10TD+R3vFRm5v+x0UXu
 Y6nggByKzYfSgeo4Azu4wch9KxGcuhY+4hMrk68muePd6+8JU5yrTSTEGUXMiz+cWf3Rm0
 oDrS6ID3pl2zZOMPNXSDt7jv8sLnBAo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-569-RNjpd1y0NruGla1I9quuOA-1; Thu, 24 Sep 2020 05:20:10 -0400
X-MC-Unique: RNjpd1y0NruGla1I9quuOA-1
Received: by mail-wr1-f70.google.com with SMTP id g6so1001610wrv.3
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2020 02:20:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=DMQKbmEgRVJHgyL5PhQoezSPMUMwIr8B8kyS+LUDP8Y=;
 b=kE/jaUVXEM1hmh3Jbjswbp7dZSGoVmyyaAgx6whm8/ebjBQUGeoUuaI/8vMqxUnW9c
 A9e0PALXWKvrrHypO1KoqPBeyCOunGyZ2x1MBehfu8VDzjHg7MVdcRew5CHHEKjQy36Z
 DUo5eWpwNX1HtSXPu4SYriUilSqjWmJdxhNOXmgY/TDBoemR0GjW8yDAD+snqDrSI+P0
 /pwRORYwhajz75oG1tf82LHgXvb3czno6PyW2DeMaWztq/T0mynbke4nGrjGItr7EOJ9
 cb2oFDs3012bj/S25SrLaQ/q0owjg7BRZe90VPZfaOWi7e+3sg/gal5QKZGN/Omnyr48
 8gxA==
X-Gm-Message-State: AOAM533p5h4hIaWK/VHVU9W4a6cjVw4nhrfW24gt/l64+ffZuB719iAn
 XztHRVw1YieHyiLbmVUAQkhDgumXYiTBWiq65x+z3FdYkj21trXyWfk6vfBndYsXRe8BlkdNDrs
 PYtdO0ZMkqtmZywU=
X-Received: by 2002:a1c:96cf:: with SMTP id y198mr3912646wmd.104.1600939209631; 
 Thu, 24 Sep 2020 02:20:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxnvXEwkLhbCROCj8EccJu2Mv6skujJtHkEGHZualIwvEp0brjC62XlZCYJoNVaD0EG1uJ7gg==
X-Received: by 2002:a1c:96cf:: with SMTP id y198mr3912628wmd.104.1600939209394; 
 Thu, 24 Sep 2020 02:20:09 -0700 (PDT)
Received: from redhat.com (bzq-79-179-71-128.red.bezeqint.net. [79.179.71.128])
 by smtp.gmail.com with ESMTPSA id c205sm2669439wmd.33.2020.09.24.02.20.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2020 02:20:08 -0700 (PDT)
Date: Thu, 24 Sep 2020 05:20:05 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Julia Suvorova <jusual@redhat.com>
Subject: Re: [RFC PATCH v3 0/7] Use ACPI PCI hot-plug for Q35
Message-ID: <20200924050236-mutt-send-email-mst@kernel.org>
References: <20200924070013.165026-1-jusual@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200924070013.165026-1-jusual@redhat.com>
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
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Sep 24, 2020 at 09:00:06AM +0200, Julia Suvorova wrote:
> The patch set consists of two parts:
> patches 1-4: introduce new feature
>              'acpi-pci-hotplug-with-bridge-support' on Q35
> patches 5-7: make the feature default along with changes in ACPI tables
> 
> This way maintainers can decide which way to choose without breaking
> the patch set.
> 
> With the feature disabled Q35 falls back to the native hot-plug.
> 
> Pros
>     * no racy behavior during boot (see 110c477c2ed)
>     * eject is possible - according to PCIe spec, attention button
>       press should lead to power off, and then the adapter should be
>       removed manually. As there is no power down state exists in QEMU,
>       we cannot distinguish between an eject and a power down
>       request.
>     * no delay during deleting - after the actual power off software
>       must wait at least 1 second before indicating about it. This case
>       is quite important for users, it even has its own bug:
>           https://bugzilla.redhat.com/show_bug.cgi?id=1594168
>     * no timer-based behavior - in addition to the previous example,
>       the attention button has a 5-second waiting period, during which
>       the operation can be canceled with a second press. While this
>       looks fine for manual button control, automation will result in
>       the need to queue or drop events, and the software receiving
>       events in all sort of unspecified combinations of attention/power
>       indicator states, which is racy and uppredictable.
>     * fixes:
>         * https://bugzilla.redhat.com/show_bug.cgi?id=1752465
>         * https://bugzilla.redhat.com/show_bug.cgi?id=1690256
> 
> Cons:
>     * lose per-port control over hot-plug (can be resolved)
>     * no access to possible features presented in slot capabilities
>       (this is only surprise removal AFAIK)

something I don't quite get is whether with this one can still add
new pcie bridges and then hotplug into these with native
hotplug.

the challenge to answering this with certainty is that right now qemu
does not allow hotplugging complex devices such as bridges at all,
we only have a hack for multifunction devices.
Maybe adding a bridge as function 1 on command line, then hotplugging another device as
function 0 will work to test this.



> v3:
>     * drop change of _OSC to allow SHPC on hotplugged bridges
>     * use 'acpi-root-pci-hotplug'
>     * add migration states [Igor]
>     * minor style changes
> 
> v2:
>     * new ioport range for acpiphp [Gerd]
>     * drop find_pci_host() [Igor]
>     * explain magic numbers in _OSC [Igor]
>     * drop build_q35_pci_hotplug() wrapper [Igor]
> 
> Julia Suvorova (7):
>   hw/acpi/pcihp: Enhance acpi_pcihp_disable_root_bus() to support Q35
>   hw/i386/acpi-build: Add ACPI PCI hot-plug methods to Q35
>   hw/pci/pcie: Do not initialize slot capability if acpihp is used
>   hw/acpi/ich9: Enable ACPI PCI hot-plug
>   bios-tables-test: Allow changes in DSDT ACPI tables
>   hw/acpi/ich9: Set ACPI PCI hot-plug as default
>   bios-tables-test: Update golden binaries
> 
>  hw/i386/acpi-build.h              |   7 ++++
>  include/hw/acpi/ich9.h            |   5 +++
>  include/hw/acpi/pcihp.h           |   3 +-
>  hw/acpi/ich9.c                    |  67 ++++++++++++++++++++++++++++++
>  hw/acpi/pcihp.c                   |  16 ++++---
>  hw/acpi/piix4.c                   |   4 +-
>  hw/i386/acpi-build.c              |  31 ++++++++------
>  hw/i386/pc.c                      |   1 +
>  hw/pci/pcie.c                     |  16 +++++++
>  tests/data/acpi/q35/DSDT          | Bin 7678 -> 7950 bytes
>  tests/data/acpi/q35/DSDT.acpihmat | Bin 9002 -> 9274 bytes
>  tests/data/acpi/q35/DSDT.bridge   | Bin 7695 -> 9865 bytes
>  tests/data/acpi/q35/DSDT.cphp     | Bin 8141 -> 8413 bytes
>  tests/data/acpi/q35/DSDT.dimmpxm  | Bin 9331 -> 9603 bytes
>  tests/data/acpi/q35/DSDT.ipmibt   | Bin 7753 -> 8025 bytes
>  tests/data/acpi/q35/DSDT.memhp    | Bin 9037 -> 9309 bytes
>  tests/data/acpi/q35/DSDT.mmio64   | Bin 8808 -> 9080 bytes
>  tests/data/acpi/q35/DSDT.numamem  | Bin 7684 -> 7956 bytes
>  tests/data/acpi/q35/DSDT.tis      | Bin 8283 -> 8555 bytes
>  19 files changed, 129 insertions(+), 21 deletions(-)
> 
> -- 
> 2.25.4


