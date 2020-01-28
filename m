Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23FBFC33CB3
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 15:31:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7329207FD
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 15:31:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GI0v3MNG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7329207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60566 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwSpd-0003EH-1i
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 10:31:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35711)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1iwSoF-0002AP-Qu
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 10:29:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1iwSoD-0001X5-Um
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 10:29:47 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:47156
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1iwSoD-0001Vs-Rz
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 10:29:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580225384;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qszdijBA+Sr3knp3xlx4nc7EJz5wv7Zo8TLSCoWED58=;
 b=GI0v3MNGncKnAsgh97uP8KpjBMTsVVqik+DdYjnrfMJ3PhLLchL8vvnl3NajxF+jYFxqKY
 vTYSfroEcRBLpe//JIvOqJTnODt1ICkIBB7V1olQp0XxmnSjKfA+hX8WyErulhOXWT7R6U
 aB367JrTWs9BE4gAKegx12FMT2sotIQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-65-qcGKa7nlNnOn7sbjlDgKwA-1; Tue, 28 Jan 2020 10:29:27 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2D41613EB;
 Tue, 28 Jan 2020 15:29:25 +0000 (UTC)
Received: from [10.36.116.37] (ovpn-116-37.ams2.redhat.com [10.36.116.37])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0FB2719E9C;
 Tue, 28 Jan 2020 15:29:16 +0000 (UTC)
Subject: Re: [PATCH v2 0/7] ARM virt: Add NVDIMM support
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, imammedo@redhat.com
References: <20200117174522.22044-1-shameerali.kolothum.thodi@huawei.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <7b338b7c-fd47-930b-53d5-894711c69941@redhat.com>
Date: Tue, 28 Jan 2020 16:29:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20200117174522.22044-1-shameerali.kolothum.thodi@huawei.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: qcGKa7nlNnOn7sbjlDgKwA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 207.211.31.81
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
Cc: peter.maydell@linaro.org, xiaoguangrong.eric@gmail.com, mst@redhat.com,
 linuxarm@huawei.com, xuwei5@hisilicon.com, shannon.zhaosl@gmail.com,
 lersek@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Shameer,

On 1/17/20 6:45 PM, Shameer Kolothum wrote:
> This series adds NVDIMM support to arm/virt platform.
> The series reuses some of the patches posted by Eric
> in his earlier attempt here[1].
> 
> Patch #1 is a fix to the Guest reboot issue on NVDIMM
> hot add case described here[2] and patch #2 is another
> fix to the nvdimm aml issue discussed here[3].
> 
> I have done a basic sanity testing of NVDIMM deviecs
> with Guest booting with both ACPI and DT. Further testing
> is always welcome.
> 
> Please let me know your feedback.


With this version, I do not get the former spurious warning reported on v1.

I can see the nvdimm device topology using ndctl. So it looks fine to me.

Unfortunately we cannot test with DAX as kernel dependencies are not yet
resolved yet but this is an independent problem.

Thanks

Eric
> 
> Thanks,
> Shameer
> 
> [1] https://patchwork.kernel.org/cover/10830777/
> [2] https://patchwork.kernel.org/patch/11154757/
> [3] https://patchwork.kernel.org/cover/11174959/
> 
> v1 --> v2
>  -Reworked patch #1 and now fix is inside qemu_ram_resize().
>  -Added patch #2 to fix the nvdim aml issue.
>  -Dropped support to DT cold plug.
>  -Updated test_acpi_virt_tcg_memhp() with pc-dimm and nvdimms(patch #7)
> 
> Kwangwoo Lee (2):
>   nvdimm: Use configurable ACPI IO base and size
>   hw/arm/virt: Add nvdimm hot-plug infrastructure
> 
> Shameer Kolothum (5):
>   exec: Fix for qemu_ram_resize() callback
>   hw/acpi/nvdimm: Fix for NVDIMM incorrect DSM output  buffer  length
>   hw/arm/virt: Add nvdimm hotplug support
>   tests: Update ACPI tables list for upcoming arm/virt test changes
>   tests/bios-tables-test: Update arm/virt memhp test
> 
>  docs/specs/acpi_hw_reduced_hotplug.rst      |  1 +
>  exec.c                                      | 36 +++++++----
>  hw/acpi/generic_event_device.c              | 13 ++++
>  hw/acpi/nvdimm.c                            | 68 +++++++++++++++++----
>  hw/arm/Kconfig                              |  1 +
>  hw/arm/virt-acpi-build.c                    |  6 ++
>  hw/arm/virt.c                               | 35 +++++++++--
>  hw/i386/acpi-build.c                        |  6 ++
>  hw/i386/acpi-build.h                        |  3 +
>  hw/i386/pc_piix.c                           |  2 +
>  hw/i386/pc_q35.c                            |  2 +
>  hw/mem/Kconfig                              |  2 +-
>  include/exec/ram_addr.h                     |  5 +-
>  include/hw/acpi/generic_event_device.h      |  1 +
>  include/hw/arm/virt.h                       |  1 +
>  include/hw/mem/nvdimm.h                     |  3 +
>  tests/data/acpi/virt/NFIT.memhp             |  0
>  tests/data/acpi/virt/SSDT.memhp             |  0
>  tests/qtest/bios-tables-test-allowed-diff.h |  5 ++
>  tests/qtest/bios-tables-test.c              |  9 ++-
>  20 files changed, 163 insertions(+), 36 deletions(-)
>  create mode 100644 tests/data/acpi/virt/NFIT.memhp
>  create mode 100644 tests/data/acpi/virt/SSDT.memhp
> 


