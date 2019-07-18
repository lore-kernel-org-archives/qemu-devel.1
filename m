Return-Path: <SRS0=9jkQ=VP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7916FC76191
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 13:13:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51FED20880
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 13:13:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51FED20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37900 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ho6E3-00073L-Gm
	for qemu-devel@archiver.kernel.org; Thu, 18 Jul 2019 09:13:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57547)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <imammedo@redhat.com>) id 1ho6Ds-0006Xn-Gv
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 09:13:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1ho6Dr-0006p5-G8
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 09:13:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59188)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>)
 id 1ho6Dp-0006jW-3j; Thu, 18 Jul 2019 09:13:21 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9CC783DDBE;
 Thu, 18 Jul 2019 13:13:19 +0000 (UTC)
Received: from localhost (unknown [10.43.2.182])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2114D1001B0C;
 Thu, 18 Jul 2019 13:13:16 +0000 (UTC)
Date: Thu, 18 Jul 2019 15:13:15 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Message-ID: <20190718151315.2c1d3aff@redhat.com>
In-Reply-To: <20190716153816.17676-11-shameerali.kolothum.thodi@huawei.com>
References: <20190716153816.17676-1-shameerali.kolothum.thodi@huawei.com>
 <20190716153816.17676-11-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Thu, 18 Jul 2019 13:13:19 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH-for-4.2 v7 10/10] tests: Update DSDT ACPI
 table for arm/virt board with PCDIMM related changes
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
 sebastien.boeuf@intel.com, lersek@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 16 Jul 2019 16:38:16 +0100
Shameer Kolothum <shameerali.kolothum.thodi@huawei.com> wrote:

> From: Eric Auger <eric.auger@redhat.com>
> 
> PCDIMM hotplug addition updated the DSDT. Update the reference table.

it's not correct process. series should be merged through Michael's pci branch
and see
commit ab50f22309a17c772c51931940596e707c200739 (mst/pci)
Author: Michael S. Tsirkin <mst@redhat.com>
Date:   Tue May 21 17:38:47 2019 -0400

    bios-tables-test: add diff allowed list

how to request table update.


Another thing:
bios-tables-test has test_acpi_tcg_dimm_pxm() test case,
pls make use of it to test arm/virt variant

> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  tests/data/acpi/virt/DSDT | Bin 18476 -> 18493 bytes
>  1 file changed, 0 insertions(+), 0 deletions(-)
> 
> diff --git a/tests/data/acpi/virt/DSDT b/tests/data/acpi/virt/DSDT
> index 20e85c7f89f645c69935c615c07084e221419960..1a5c3e5243c78eb25345fdf7ffa442afec3c5c28 100644
> GIT binary patch
> delta 172
> zcmZ28fpPByMlP3Nmk?VI1_q{Y6S<_BIvO{s=eSSi^^mWRZt~=a(Tfjuig$N)iRXy-
> z@O0sIbPn(|FfcS`;D`?ea)A;+mUB?BARiZZCmRDZqb36bLnT9WgKLnhI|B~`0|zG;
> zOLQYQi0kYc?CPT+ViNBf7Q$Ho;v_5(n_Qj1$iNt*&kVB1*CW8$H`v*4fdEjLhl`1U
> Ni>WOjJjjWw0RY`tDw+TQ  
> 
> delta 134
> zcmdlxfpN_QMlP3Nmk=Ef1_q{ziCof5?F}2%bKIpo*xdvC4LIUGJY9GlgM2*<49pA}
> zIN}{$f+og`c`$P_2rw{ovN13+sxvS!RDxt&Jq4Ay6ndl?7@-g-A<n=c$sh-0Ff)LR
> Z11c2ZjdwLLW@rlt4|3vam^{&45den68LI#Q
> 


