Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1A1FC4360C
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 15:43:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B3D421D79
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 15:43:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B3D421D79
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53856 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iD9Rx-0000PI-04
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 11:43:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59171)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1iD8xC-0002RV-SE
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 11:11:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1iD8xB-0007bi-Qw
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 11:11:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38496)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>)
 id 1iD8x7-0007ao-Bk; Wed, 25 Sep 2019 11:11:37 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 830A0C059B6F;
 Wed, 25 Sep 2019 15:11:36 +0000 (UTC)
Received: from Igors-MacBook-Pro (ovpn-112-17.ams2.redhat.com [10.36.112.17])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7A4961001956;
 Wed, 25 Sep 2019 15:11:28 +0000 (UTC)
Date: Wed, 25 Sep 2019 17:11:26 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH-for-4.2 v11 10/11] tests: Update ACPI tables list for
 upcoming arm/virt tests
Message-ID: <20190925171126.6cd6b7e5@Igors-MacBook-Pro>
In-Reply-To: <20190918130633.4872-11-shameerali.kolothum.thodi@huawei.com>
References: <20190918130633.4872-1-shameerali.kolothum.thodi@huawei.com>
 <20190918130633.4872-11-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Wed, 25 Sep 2019 15:11:36 +0000 (UTC)
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
 mst@redhat.com, sebastien.boeuf@intel.com, lersek@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 18 Sep 2019 14:06:32 +0100
Shameer Kolothum <shameerali.kolothum.thodi@huawei.com> wrote:

> This is in preparation to add numamem and memhp tests to
> arm/virt platform. The bios-tables-test-allowed-diff.h
> is updated with a list of expected ACPI tables that needs to be
> present in tests/data/acpi/virt folder.
> 
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
> v10 --> v11
> 
> As per Michael's suggestion updated bios-tables-test-allowed-diff.h
> instead of adding expected files directly.
> ---
>  tests/bios-tables-test-allowed-diff.h | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/tests/bios-tables-test-allowed-diff.h b/tests/bios-tables-test-allowed-diff.h
> index 7b4adbc822..3776dd2f3d 100644
> --- a/tests/bios-tables-test-allowed-diff.h
> +++ b/tests/bios-tables-test-allowed-diff.h
> @@ -1,2 +1,17 @@
>  /* List of comma-separated changed AML files to ignore */
>  "tests/data/acpi/virt/DSDT",
> +"tests/data/acpi/virt/APIC.memhp",
> +"tests/data/acpi/virt/APIC.numamem",
> +"tests/data/acpi/virt/DSDT.memhp",
> +"tests/data/acpi/virt/DSDT.numamem",
> +"tests/data/acpi/virt/FACP.memhp",
> +"tests/data/acpi/virt/FACP.numamem",
> +"tests/data/acpi/virt/GTDT.memhp",
> +"tests/data/acpi/virt/GTDT.numamem",
> +"tests/data/acpi/virt/MCFG.memhp",
> +"tests/data/acpi/virt/MCFG.numamem",
> +"tests/data/acpi/virt/SLIT.memhp",
> +"tests/data/acpi/virt/SPCR.memhp",
> +"tests/data/acpi/virt/SPCR.numamem",
> +"tests/data/acpi/virt/SRAT.memhp",
> +"tests/data/acpi/virt/SRAT.numamem",


