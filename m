Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 560BCC4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 17:37:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FD14205F4
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 17:37:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FD14205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34886 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hguo1-00032k-EP
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 13:37:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46665)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <eric.auger@redhat.com>) id 1hguB2-0007hv-Md
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 12:56:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1hguB0-0003eu-0J
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 12:56:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55372)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1hguAu-0003bc-6s; Fri, 28 Jun 2019 12:56:36 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0D6CA30832D3;
 Fri, 28 Jun 2019 16:56:35 +0000 (UTC)
Received: from [10.36.116.89] (ovpn-116-89.ams2.redhat.com [10.36.116.89])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9C7955C888;
 Fri, 28 Jun 2019 16:56:28 +0000 (UTC)
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, imammedo@redhat.com
References: <20190625121421.22280-1-shameerali.kolothum.thodi@huawei.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <86a13b18-f339-0436-6301-72afb000ed45@redhat.com>
Date: Fri, 28 Jun 2019 18:56:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190625121421.22280-1-shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Fri, 28 Jun 2019 16:56:35 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v6 0/8] ARM virt: ACPI memory hotplug
 support
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
Cc: peter.maydell@linaro.org, sameo@linux.intel.com, ard.biesheuvel@linaro.org,
 linuxarm@huawei.com, xuwei5@hisilicon.com, shannon.zhaosl@gmail.com,
 sebastien.boeuf@intel.com, lersek@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Shameer,

On 6/25/19 2:14 PM, Shameer Kolothum wrote:
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

Tested-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric
> 
> Thanks,
> Shameer
> 
> [1] https://patchwork.kernel.org/cover/10837565/
> [2] https://patchwork.kernel.org/cover/10783589/
> [3] https://github.com/intel/nemu/blob/topic/virt-x86/hw/acpi/ged.c
> [4] http://lists.infradead.org/pipermail/linux-arm-kernel/2019-May/651763.html
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
> Shameer Kolothum (5):
>   hw/acpi: Make ACPI IO address space configurable
>   hw/arm/virt: Enable device memory cold/hot plug with ACPI boot
>   hw/arm/virt-acpi-build: Add PC-DIMM in SRAT
>   hw/acpi: Add system power down support to GED
>   hw/arm: Use GED for system_powerdown event
> 
>  hw/acpi/Kconfig                        |   4 +
>  hw/acpi/Makefile.objs                  |   1 +
>  hw/acpi/generic_event_device.c         | 352 +++++++++++++++++++++++++
>  hw/acpi/memory_hotplug.c               |  35 +--
>  hw/arm/Kconfig                         |   4 +
>  hw/arm/virt-acpi-build.c               |  58 ++--
>  hw/arm/virt.c                          |  88 ++++++-
>  hw/i386/acpi-build.c                   |   3 +-
>  include/hw/acpi/generic_event_device.h | 106 ++++++++
>  include/hw/acpi/memory_hotplug.h       |   9 +-
>  include/hw/arm/virt.h                  |   3 +
>  11 files changed, 607 insertions(+), 56 deletions(-)
>  create mode 100644 hw/acpi/generic_event_device.c
>  create mode 100644 include/hw/acpi/generic_event_device.h
> 

