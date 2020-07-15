Return-Path: <SRS0=mmJ2=A2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1,WEIRD_QUOTING autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20E47C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 09:49:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBF1A2067D
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 09:49:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dJUH19E0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBF1A2067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54326 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jve2p-0000X7-5W
	for qemu-devel@archiver.kernel.org; Wed, 15 Jul 2020 05:49:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33938)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1jve0S-0007aZ-Qz
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 05:47:16 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:58491
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1jve0Q-0007RR-Ib
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 05:47:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594806433;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7EJXJW60uwCAuZNAn/a31307eyFSM/Dl3BO3bBsTG+Y=;
 b=dJUH19E0KPnMWHqNkV6v9pO4oT0m0bwMe6qXqTj9TMVsDtoxdGUkUTTNC0ePsy/K+9EFEW
 EOg0lBG1ew6PopmTSTD2WREsG5q0veZaprdUfJ7hAZ+40J3B+Vb6hv2GEehya8Ef/UcXkG
 irkWNVIb9idi1wTmfqIdvhdCEeqg1Sk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-461-h4lzQKJLNEyJEZnIIWqakw-1; Wed, 15 Jul 2020 05:47:11 -0400
X-MC-Unique: h4lzQKJLNEyJEZnIIWqakw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B14A31DE0;
 Wed, 15 Jul 2020 09:47:10 +0000 (UTC)
Received: from [10.36.115.54] (ovpn-115-54.ams2.redhat.com [10.36.115.54])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B4A1C6FDD1;
 Wed, 15 Jul 2020 09:47:09 +0000 (UTC)
Subject: Re: [PATCH for-5.1 4/4] docs/system: Document the arm virt board
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200713175746.5936-1-peter.maydell@linaro.org>
 <20200713175746.5936-5-peter.maydell@linaro.org>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <7b02dddc-abd3-6b65-9e34-5cd167ffb0fe@redhat.com>
Date: Wed, 15 Jul 2020 11:47:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200713175746.5936-5-peter.maydell@linaro.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/15 05:07:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, WEIRD_QUOTING=0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Peter,
On 7/13/20 7:57 PM, Peter Maydell wrote:
> Document the arm 'virt' board, which has been undocumented
> for far too long given that it is the main recommended board
> type for arm guests.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  docs/system/arm/virt.rst   | 157 +++++++++++++++++++++++++++++++++++++
>  docs/system/target-arm.rst |   1 +
>  MAINTAINERS                |   1 +
>  3 files changed, 159 insertions(+)
>  create mode 100644 docs/system/arm/virt.rst
> 
> diff --git a/docs/system/arm/virt.rst b/docs/system/arm/virt.rst
> new file mode 100644
> index 00000000000..6a7823d8bca
> --- /dev/null
> +++ b/docs/system/arm/virt.rst
> @@ -0,0 +1,157 @@
> +'virt' generic virtual platform (``virt``)
> +==========================================
> +
> +The `virt` board is a platform which does not correspond to any
> +real hardware; it is designed for use in virtual machines.
> +It is the recommended board type if you simply want to run
> +a guest such as Linux and do not care about reproducing the
> +idiosyncrasies and limitations of a particular bit of real-world
> +hardware.
> +
> +This is a "versioned" board model, so as well as the ``virt`` machine
> +type itself (which may have improvements, bugfixes and other minor
> +changes between QEMU versions) a version is provided that guarantees
> +to have the same behaviour as that of previous QEMU releases, so
> +that VM migration will work between QEMU versions.

Note: as per the recent discussions, the ACPI description is currently
allowed to changed and this is not really versionned. Normally this
should not really impact the guest but who knows?
 For instance the
> +``virt-5.0`` machine type will behave like the ``virt`` machine from
> +the QEMU 5.0 release, and migration should work between ``virt-5.0``
> +of the 5.0 release and ``virt-5.0`` of the 5.1 release. Migration
> +is not guaranteed to work between different QEMU releases for
> +the non-versioned ``virt`` machine type.
> +
> +Supported devices
> +"""""""""""""""""
> +
> +The virt board supports:
> +
> +- Flash memory
> +- One PL011 UART
> +- An RTC
> +- The fw_cfg device that allows a guest to obtain data from QEMU
> +- A PL061 GPIO controller
> +- An optional SMMUv3 IOMMU
> +- hotpluggable DIMMs
> +- hotpluggable NVDIMs
NVDIMMs
- an MSI controller (GICv2M or ITS). GICv2M is selected by default along
with GICv2. ITS is selected by default with GICv3 (>= virt-2.7). Note
ITS is not modeled in TCG mode.
> +- 32 virtio-mmio transport devices
> +- running guests using the KVM accelerator on aarch64 hardware
> +- large amounts of RAM (at least 255GB, and more if using highmem)
> +- many CPUs (up to 512 if using a GICv3 and highmem)
> +- Secure-World-only devices if the CPU has TrustZone:
> +
> +  - A second PL011 UART
> +  - A secure flash memory
> +  - 16MB of secure RAM
> +
> +Supported guest CPU types:
> +
> +- ``cortex-a7`` (32-bit)
> +- ``cortex-a15`` (32-bit; the default)
> +- ``cortex-a53`` (64-bit)
> +- ``cortex-a57`` (64-bit)
> +- ``cortex-a72`` (64-bit)
> +- ``host`` (with KVM only)
> +- ``max`` (same as ``host`` for KVM; best possible emulation with TCG)
> +
> +Note that the default is ``cortex-a15``, so for an AArch64 guest you must
> +specify a CPU type.
> +
> +Graphics output is available, but unlike the x86 PC machine types
> +there is no default display device enabled: you should select one from
> +the Display devices section of "-device help". The recommended option
> +is ``virtio-gpu-pci``; this is the only one which will work correctly
> +with KVM. You may also need to ensure your guest kernel is configured
> +with support for this; see below.
> +
> +Machine-specific options
> +""""""""""""""""""""""""
> +
> +The following machine-specific options are supported:
> +
> +secure
> +  Set ``on``/``off`` to enable/disable emulating a guest CPU which implements the
> +  Arm Security Extensions (TrustZone). The default is ``off``.
> +
> +virtualization
> +  Set ``on``/``off`` to enable/disable emulating a guest CPU which implements the
> +  Arm Virtualization Extensions. The default is ``off``.
> +
> +highmem
> +  Set ``on``/``off`` to enable/disable placing devices and RAM in physical
> +  address space above 32 bits. The default is ``on`` for machine types
> +  later than ``virt-2.12``.
> +
> +gic-version
> +  Specify the version of the Generic Interrupt Controller (GIC) to provide.
> +  Valid values are:
> +
> +  ``2``
> +    GICv2
> +  ``3``
> +    GICv3
> +  ``host``
> +    Use the same GIC version the host provides, when using KVM
> +  ``max``
> +    Use the best GIC version possible (same as host when using KVM;
> +    currently same as ``3``` for TCG, but this may change in future)
> +
> +its
> +  Set ``on``/``off`` to enable/disable ITS instantiation. The default is ``on``
> +  for machine types later than ``virt-2.7``.
> +
> +iommu
> +  Set the IOMMU type to create for the guest. Valid values are:
> +
> +  ``none``
> +    Don't create an IOMMU (the default)
> +  ``smmuv3``
> +    Create an SMMUv3
> +
> +ras
> +  Set ``on``/``off`` to enable/disable reporting host memory errors to a guest
> +  using ACPI and guest external abort exceptions. The default is off.> +
> +Linux guest kernel configuration
> +""""""""""""""""""""""""""""""""
> +
> +The 'defconfig' for Linux arm and arm64 kernels should include the
> +right device drivers for virtio and the PCI controller; however some older
> +kernel versions, especially for 32-bit Arm, did not have everything
> +enabled by default. If you're not seeing PCI devices that you expect,
> +then check that your guest config has::
> +
> +  CONFIG_PCI=y
> +  CONFIG_VIRTIO_PCI=y
> +  CONFIG_PCI_HOST_GENERIC=y
> +
> +If you want to use the ``virtio-gpu-pci`` graphics device you will also
> +need::
> +
> +  CONFIG_DRM=y
> +  CONFIG_DRM_VIRTIO_GPU=y
> +
> +Hardware configuration information for bare-metal programming
> +"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
> +
> +The ``virt`` board automatically generates a device tree blob ("dtb")
> +which it passes to the guest. This provides information about the
> +addresses, interrupt lines and other configuration of the various devices
> +in the system. Guest code can rely on and hard-code the following
> +addresses:
> +
> +- Flash memory starts at address 0x0000_0000
> +
> +- RAM starts at 0x4000_0000
> +
> +All other information about device locations may change between
> +QEMU versions, so guest code must look in the DTB.
> +
> +QEMU supports two types of guest image boot for ``virt``, and
> +the way for the guest code to locate the dtb binary differs:
> +
> +- For guests using the Linux kernel boot protocol (this means any
> +  non-ELF file passed to the QEMU ``-kernel`` option) the address
> +  of the DTB is passed in a register (``r2`` for 32-bit guests,
> +  or ``x0`` for 64-bit guests)
> +
> +- For guests booting as "bare-metal" (any other kind of boot),
> +  the DTB is at the start of RAM (0x4000_0000)
> diff --git a/docs/system/target-arm.rst b/docs/system/target-arm.rst
> index 163ab915592..4c5b0e4aab8 100644
> --- a/docs/system/target-arm.rst
> +++ b/docs/system/target-arm.rst
> @@ -92,6 +92,7 @@ undocumented; you can get a complete list by running
>     arm/collie
>     arm/sx1
>     arm/stellaris
> +   arm/virt
>  
>  Arm CPU features
>  ================
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 286b076da89..553760e5442 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -878,6 +878,7 @@ L: qemu-arm@nongnu.org
>  S: Maintained
>  F: hw/arm/virt*
>  F: include/hw/arm/virt.h
> +F: docs/system/arm/virt.rst
>  
>  Xilinx Zynq
>  M: Edgar E. Iglesias <edgar.iglesias@gmail.com>
> 
Thanks

Eric



