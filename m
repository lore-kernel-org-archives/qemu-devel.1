Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9B1FC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 20:10:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70BA6206DB
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 20:10:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nbtbj0y7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70BA6206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38112 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jm0rV-0006YG-Mb
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 16:10:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51742)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jm0qk-0005vb-EM
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 16:09:26 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:25244
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jm0qi-00013w-62
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 16:09:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592510963;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=E5pZVdyZwhhGmeGHvt7TFD+6N1YhmZwE+YEciLSUig0=;
 b=Nbtbj0y7R8tooBvkHOcjM76PZ8qndOd5SvorMyGW7Dfdg7Y2Id3AnSG/djhfr4/b6KNFpO
 JZKPE156bWy7/fHSMxcAXmIwHNkUfDej2gEBp3gb9qi9T0rkSslYFUUzO4Bk3pqyHLKDVT
 HJsa1Yni3DmcBDjuELa7+qxsMKQj510=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-254-W__0emZTPmy-Xazqc0ZR5A-1; Thu, 18 Jun 2020 16:09:21 -0400
X-MC-Unique: W__0emZTPmy-Xazqc0ZR5A-1
Received: by mail-wm1-f69.google.com with SMTP id h6so2076220wmb.7
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2020 13:09:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=E5pZVdyZwhhGmeGHvt7TFD+6N1YhmZwE+YEciLSUig0=;
 b=B8CfeFugqctE7cE8iRz+nMNct8OvQXte94yPVofMyK6H5k+xZQ9MDZ6rN53niibRwB
 0EIchKJSmQaixTvXcJGbpzGP6Z79iOpn1Gc16YkwMFysMfHEGbHKRpJ1HVxB4WRhgekN
 NCbfLicjmVViuaXiuxVo+uBqpPwLP71hFa3adyjDGqS+WeD+wW6a46lH2XFLTWe6geBV
 TaKZoTs0mVTVcUdD99cVDq2H0CcZsbeRMATYyxSEFk3e6HpYYstX2nx4rdZyh2d4o5q3
 VsRO5WKnjw78tBFNYKKxjXikAKFDexLTC9qQflawPAzCGym+xw9ZJ1iZfvni/tj2poru
 CK2A==
X-Gm-Message-State: AOAM532CCjwccukNMmbVlVPC5R0pxk53m08qqs4AFYeKZ9jZ0PfG1Gb0
 4ou/qvYa/dp6/D69f+67a23KLkpQZ3EQpQvnRf/Uiqk/vJtMU6MIO8V8EHJLz8EamClekVg87T/
 JvKiyHK0DEq4zWZM=
X-Received: by 2002:a05:600c:21c2:: with SMTP id x2mr29478wmj.33.1592510960563; 
 Thu, 18 Jun 2020 13:09:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwR+7V9vt7kkdmB0EtAa4Iiht+0T6KurLF7yBkOSGVDYPZnU8gr1kRurxs1VC9Uphixl3QhMQ==
X-Received: by 2002:a05:600c:21c2:: with SMTP id x2mr29460wmj.33.1592510960344; 
 Thu, 18 Jun 2020 13:09:20 -0700 (PDT)
Received: from redhat.com (bzq-79-178-18-124.red.bezeqint.net. [79.178.18.124])
 by smtp.gmail.com with ESMTPSA id b187sm4706368wmd.26.2020.06.18.13.09.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jun 2020 13:09:19 -0700 (PDT)
Date: Thu, 18 Jun 2020 16:09:17 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v9 00/10] acpi: i386 tweaks
Message-ID: <20200618160818-mutt-send-email-mst@kernel.org>
References: <20200617071138.11159-1-kraxel@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200617071138.11159-1-kraxel@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/18 15:08:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Laurent Vivier <lvivier@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 John Snow <jsnow@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jun 17, 2020 at 09:11:28AM +0200, Gerd Hoffmann wrote:
> First batch of microvm patches, some generic acpi stuff.
> Split the acpi-build.c monster, specifically split the
> pc and q35 and pci bits into a separate file which we
> can skip building at some point in the future.

Thanks for the patches!
Pls take a look at tests/qtest/bios-tables-test.c, the comment
at top of this file outlines the process to use for
changing expected test files.
As it is, the patches won't be easily rebaseable or backportable.


> v2 changes: leave acpi-build.c largely as-is, move useful
> bits to other places to allow them being reused, specifically:
> 
>  * move isa device generator functions to individual isa devices.
>  * move fw_cfg generator function to fw_cfg.c
> 
> v3 changes: fix rtc, support multiple lpt devices.
> 
> v4 changes:
>  * drop merged patches.
>  * split rtc crs change to separata patch.
>  * added two cleanup patches.
>  * picked up ack & review tags.
> 
> v5 changes:
>  * add comment for rtc crs update.
>  * add even more cleanup patches.
>  * picked up ack & review tags.
> 
> v6 changes:
>  * floppy: move cmos_get_fd_drive_type.
>  * picked up ack & review tags.
> 
> v7 changes:
>  * rebased to mst/pci branch, resolved stubs conflict.
>  * dropped patches already queued up in mst/pci.
>  * added missing sign-off.
>  * picked up ack & review tags.
> 
> v8 changes:
>  * (re-)add patch to allow acpi table changes
> 
> v9 changes:
>  * add asl changes to commit messages.
>  * update acpi test data.
> 
> take care,
>   Gerd
> 
> Gerd Hoffmann (10):
>   acpi: bios-tables-test: show more context on asl diffs
>   acpi: move aml builder code for floppy device
>   floppy: make isa_fdc_get_drive_max_chs static
>   floppy: move cmos_get_fd_drive_type() from pc
>   acpi: move aml builder code for i8042 (kbd+mouse) device
>   acpi: factor out fw_cfg_add_acpi_dsdt()
>   acpi: simplify build_isa_devices_aml()
>   acpi: drop serial/parallel enable bits from dsdt
>   acpi: drop build_piix4_pm()
>   acpi: q35: drop _SB.PCI0.ISA.LPCD opregion.
> 
>  hw/i386/fw_cfg.h                  |   1 +
>  include/hw/block/fdc.h            |   3 +-
>  include/hw/i386/pc.h              |   1 -
>  hw/block/fdc.c                    | 111 +++++++++++++++-
>  hw/i386/acpi-build.c              | 210 +-----------------------------
>  hw/i386/fw_cfg.c                  |  28 ++++
>  hw/i386/pc.c                      |  25 ----
>  hw/input/pckbd.c                  |  31 +++++
>  stubs/cmos.c                      |   7 +
>  tests/qtest/bios-tables-test.c    |   2 +-
>  stubs/Makefile.objs               |   1 +
>  tests/data/acpi/pc/DSDT           | Bin 5014 -> 4934 bytes
>  tests/data/acpi/pc/DSDT.acpihmat  | Bin 6338 -> 6258 bytes
>  tests/data/acpi/pc/DSDT.bridge    | Bin 6873 -> 6793 bytes
>  tests/data/acpi/pc/DSDT.cphp      | Bin 5477 -> 5397 bytes
>  tests/data/acpi/pc/DSDT.dimmpxm   | Bin 6667 -> 6587 bytes
>  tests/data/acpi/pc/DSDT.ipmikcs   | Bin 5086 -> 5006 bytes
>  tests/data/acpi/pc/DSDT.memhp     | Bin 6373 -> 6293 bytes
>  tests/data/acpi/pc/DSDT.numamem   | Bin 5020 -> 4940 bytes
>  tests/data/acpi/q35/DSDT          | Bin 7752 -> 7678 bytes
>  tests/data/acpi/q35/DSDT.acpihmat | Bin 9076 -> 9002 bytes
>  tests/data/acpi/q35/DSDT.bridge   | Bin 7769 -> 7695 bytes
>  tests/data/acpi/q35/DSDT.cphp     | Bin 8215 -> 8141 bytes
>  tests/data/acpi/q35/DSDT.dimmpxm  | Bin 9405 -> 9331 bytes
>  tests/data/acpi/q35/DSDT.ipmibt   | Bin 7827 -> 7753 bytes
>  tests/data/acpi/q35/DSDT.memhp    | Bin 9111 -> 9037 bytes
>  tests/data/acpi/q35/DSDT.mmio64   | Bin 8882 -> 8808 bytes
>  tests/data/acpi/q35/DSDT.numamem  | Bin 7758 -> 7684 bytes
>  tests/data/acpi/q35/DSDT.tis      | Bin 8357 -> 8283 bytes
>  29 files changed, 185 insertions(+), 235 deletions(-)
>  create mode 100644 stubs/cmos.c
> 
> -- 
> 2.18.4


