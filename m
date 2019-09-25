Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB0B3C432C2
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 15:54:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0EA521D7A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 15:54:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0EA521D7A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54048 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iD9cP-0002MU-RH
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 11:54:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33723)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iD9Fw-0003nu-4B
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 11:31:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iD9Fp-0001KR-4A
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 11:31:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43042)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iD9Fm-0001Gd-Ll
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 11:30:56 -0400
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 396C88F4E7
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 15:30:50 +0000 (UTC)
Received: by mail-qk1-f200.google.com with SMTP id g62so6428053qkb.20
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 08:30:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=6Qp707/k+6qLsfCpTzjKfGoXZl57e7+WXHYgVAQOGdU=;
 b=QSfznOQN5UtifFhPYCFOMCgfgTtA98FYc98iHVD1hhwa+NfGIqrrJ2DHEUghKCcSyq
 nx3VnsEufFZACQ8AdF6T4mbN3AqrsAy4llur+zGOkl7UIHezEE6pK9TdJXgosVWypJNA
 AzutXi842TcCz/DsCI4PYEBtrO9U82JlP8wtbKMUlxSZD6pcF7T7AMdywrTUHyWRkdSJ
 xA55/dlBTkwLcEppmpXKZE9YoknF3A+wCgrLnesbCaYccK4v6mqrjx97TSMcxwirc6o/
 qK7P9hvBzWklXsDhH5unXWgId6cAXBrJMINzTCSyxINesGufblWoGgv9lQp4cUTrM8kl
 IvKg==
X-Gm-Message-State: APjAAAUY64bB0Mj41h12pROXn+VU36GC5i+jMyqVORTK4ksJXWniqwZt
 qJgkp38SIVZKuju2ivq9xmYVQMQnvkfgGe9dbMBhAFYOFpRey4eKdjTaPewSLeVK/i3YyNtSKhQ
 exzR5+Ow/cL1STFI=
X-Received: by 2002:a37:8586:: with SMTP id h128mr4262706qkd.253.1569425449474; 
 Wed, 25 Sep 2019 08:30:49 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzCntYB6Bi5qslvl8fye0Db3VBMrOYBiQeV5nQyJRQVSNsqpgnSDbml6j7ydXVf7/TbJxwbbg==
X-Received: by 2002:a37:8586:: with SMTP id h128mr4262669qkd.253.1569425449219; 
 Wed, 25 Sep 2019 08:30:49 -0700 (PDT)
Received: from redhat.com (bzq-79-176-40-226.red.bezeqint.net. [79.176.40.226])
 by smtp.gmail.com with ESMTPSA id n65sm2997976qkb.19.2019.09.25.08.30.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Sep 2019 08:30:48 -0700 (PDT)
Date: Wed, 25 Sep 2019 11:30:42 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH-for-4.2 v11 00/11] ARM virt: ACPI memory hotplug support
Message-ID: <20190925113026-mutt-send-email-mst@kernel.org>
References: <20190918130633.4872-1-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190918130633.4872-1-shameerali.kolothum.thodi@huawei.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: peter.maydell@linaro.org, sameo@linux.intel.com, shannon.zhaosl@gmail.com,
 ard.biesheuvel@linaro.org, qemu-devel@nongnu.org, xuwei5@hisilicon.com,
 linuxarm@huawei.com, eric.auger@redhat.com, qemu-arm@nongnu.org,
 imammedo@redhat.com, sebastien.boeuf@intel.com, lersek@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Sep 18, 2019 at 02:06:22PM +0100, Shameer Kolothum wrote:
> This series is an attempt to provide device memory hotplug support 
> on ARM virt platform. This is based on Eric's recent works here[1]
> and carries some of the pc-dimm related patches dropped from his
> series.
> 
> The kernel support for arm64 memory hot add was added recently by
> Robin and hence the guest kernel should be => 5.0-rc1.
> 
> NVDIM support is not included currently as we still have an unresolved
> issue while hot adding NVDIMM[2]. However NVDIMM cold plug patches
> can be included, but not done for now, for keeping it simple.
> 
> This makes use of GED device to sent hotplug ACPI events to the
> Guest. GED code is based on Nemu. Thanks to the efforts of Samuel and
> Sebastien to add the hardware-reduced support to Nemu using GED
> device[3]. (Please shout if I got the author/signed-off wrong for
> those patches or missed any names).
> 
> This is sanity tested on a HiSilicon ARM64 platform and appreciate
> any further testing.
> 
> Note:
> Attempted adding dimm_pxm test case to bios-tables-test for arm/virt.
> But noticed the issue decribed here[5]. This is under investigation 
> now.
> 
> Thanks,
> Shameer


in case this is going through ARM tree:

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

> [1] https://patchwork.kernel.org/cover/10837565/
> [2] https://patchwork.kernel.org/cover/10783589/
> [3] https://github.com/intel/nemu/blob/topic/virt-x86/hw/acpi/ged.c
> [4] http://lists.infradead.org/pipermail/linux-arm-kernel/2019-May/651763.html
> [5] https://www.mail-archive.com/qemu-devel@nongnu.org/msg632651.html
> 
> v10 --> v11
> -Changed patch #10 to update bios-tables-test-allowed-diff.h with a
>  list of expected ACPI tables.
> -GED document changed to rst format (patch #9)
> -Addressed comments from Igor (patch #3 & #5)
> -Igor's R-by to #7, #8 & #11.
> 
> v9 --> v10
>  -Fix for "make check" failure on x86_64(Patch #1).
>  -Minor updates based on Eric's comments.
>  -Dropped patch "hw/arm/virt: Add 4.2 machine type" as this is already
>   in master now.
>  -Added R-by tags by Eric.
> 
> v8 --> v9
>  -Changes related to GED being a TYPE_SYS_BUS_DEVICE now.
>  -Re-arranged patches 8 and 9.
>  -Added GED ABI documentation(patch #10).
>  -Added numamem and memhp tests to arm/virt(#11 and #12)
>  -Dropped few R-by tags as code has changed a bit.
>  -Please see Individual patch history for details.
>  
> v7 --> v8
>  -Addressed comments from Igor.Please see individual patches.
>  -Updated bios-tables-test-allowed-diff.h to avoid "make check"
>   failure (patch #6) and dropped patch #10
>  -Added Igor's R-by to patches 4 & 5.
>  -Dropped Erics's R-by from patch #9 for now.
> 
> v6 --> v7
> - Added 4.2 machine support and restricted GED creation for < 4.2
>   This is to address the migration test fail reported by Eric.
> - Included "tests: Update DSDT ACPI table.." patch(#10) from Eric
>   to fix the "make check" bios-tables-test failure.
>   
> v5 --> v6
> 
> -Addressed comments from Eric.
> -Added R-by from Eric and Igor.
> 
> v4 --> v5
> -Removed gsi/ged-irq routing in virt.
> -Added Migration support.
> -Dropped support for DT coldplug case based on the discussions
>  here[4]
> -Added system_powerdown support through GED.
> 
> v3 --> v4
> Addressed comments from Igor and Eric,
> -Renamed "virt-acpi" to "acpi-ged".
> -Changed ged device parent to TYPE_DEVICE.
> -Introduced DT memory node property "hotpluggable" to resolve device
>  memory being treated as early boot memory issue(patch #7).
> -Combined patches #3 and #9 from v3 into #3.
> 
> v2 --> v3
> 
> Addressed comments from Igor and Eric,
> -Made virt acpi device platform independent and moved
>  to hw/acpi/generic_event_device.c
> -Moved ged specific code into hw/acpi/generic_event_device.c
> -Introduced an opt-in feature "fdt" to resolve device-memory being
>  treated as early boot memory.
> -Dropped patch #1 from v2.
> 
> RFC --> v2
> 
> -Use GED device instead of GPIO for ACPI hotplug events.
> -Removed NVDIMM support for now.
> -Includes dropped patches from Eric's v9 series.
> 
> Eric Auger (1):
>   hw/arm/virt: Add memory hotplug framework
> 
> Samuel Ortiz (2):
>   hw/acpi: Do not create memory hotplug method when handler is not
>     defined
>   hw/acpi: Add ACPI Generic Event Device Support
> 
> Shameer Kolothum (8):
>   hw/acpi: Make ACPI IO address space configurable
>   hw/arm/virt: Enable device memory cold/hot plug with ACPI boot
>   hw/arm/virt-acpi-build: Add PC-DIMM in SRAT
>   hw/arm: Factor out powerdown notifier from GPIO
>   hw/arm: Use GED for system_powerdown event
>   docs/specs: Add ACPI GED documentation
>   tests: Update ACPI tables list for upcoming arm/virt tests
>   tests: Add bios tests to arm/virt
> 
>  docs/specs/acpi_hw_reduced_hotplug.rst |  70 ++++++
>  docs/specs/index.rst                   |   1 +
>  hw/acpi/Kconfig                        |   4 +
>  hw/acpi/Makefile.objs                  |   1 +
>  hw/acpi/generic_event_device.c         | 311 +++++++++++++++++++++++++
>  hw/acpi/memory_hotplug.c               |  43 ++--
>  hw/arm/Kconfig                         |   4 +
>  hw/arm/virt-acpi-build.c               |  35 ++-
>  hw/arm/virt.c                          | 124 +++++++++-
>  hw/i386/acpi-build.c                   |   7 +-
>  hw/i386/pc.c                           |   3 +
>  include/hw/acpi/acpi_dev_interface.h   |   1 +
>  include/hw/acpi/generic_event_device.h | 103 ++++++++
>  include/hw/acpi/memory_hotplug.h       |   9 +-
>  include/hw/arm/virt.h                  |   5 +
>  include/hw/i386/pc.h                   |   3 +
>  tests/bios-tables-test-allowed-diff.h  |  16 ++
>  tests/bios-tables-test.c               |  49 ++++
>  18 files changed, 748 insertions(+), 41 deletions(-)
>  create mode 100644 docs/specs/acpi_hw_reduced_hotplug.rst
>  create mode 100644 hw/acpi/generic_event_device.c
>  create mode 100644 include/hw/acpi/generic_event_device.h
> 
> -- 
> 2.17.1
> 

