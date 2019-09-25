Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B991C432C2
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 17:39:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FA81207E0
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 17:39:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FA81207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55396 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDBFq-0000Dc-Ij
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 13:39:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52104)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1iDBDc-0006y5-9U
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 13:36:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1iDBDb-0007l3-3g
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 13:36:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40558)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>)
 id 1iDBDY-0007jY-18; Wed, 25 Sep 2019 13:36:44 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id AEBC518C8937;
 Wed, 25 Sep 2019 17:36:42 +0000 (UTC)
Received: from Igors-MacBook-Pro (ovpn-112-17.ams2.redhat.com [10.36.112.17])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0C5E71001B07;
 Wed, 25 Sep 2019 17:36:31 +0000 (UTC)
Date: Wed, 25 Sep 2019 19:36:28 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH-for-4.2 v11 11/11] tests: Add bios tests to arm/virt
Message-ID: <20190925193628.2267cfb5@Igors-MacBook-Pro>
In-Reply-To: <20190925112521-mutt-send-email-mst@kernel.org>
References: <20190918130633.4872-1-shameerali.kolothum.thodi@huawei.com>
 <20190918130633.4872-12-shameerali.kolothum.thodi@huawei.com>
 <20190925112521-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.70]); Wed, 25 Sep 2019 17:36:43 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: peter.maydell@linaro.org, sameo@linux.intel.com, ard.biesheuvel@linaro.org,
 qemu-devel@nongnu.org, Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 linuxarm@huawei.com, shannon.zhaosl@gmail.com, qemu-arm@nongnu.org,
 xuwei5@hisilicon.com, eric.auger@redhat.com, sebastien.boeuf@intel.com,
 lersek@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 25 Sep 2019 11:26:04 -0400
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Wed, Sep 18, 2019 at 02:06:33PM +0100, Shameer Kolothum wrote:
> > This adds numamem and memhp tests for arm/virt platform.
> > 
> > Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> > Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> > ---
> > v10-->v11
> > 
> > Added Igor's R-by.
> > 
> > In order to avoid "make check" failure, the files listed in patch #10
> > has to be added to tests/data/acpi/virt folder before this patch.
> 
> So you can just add empty stubs.

Wouldn't IASL choke on such files?

> 
> > ---
> >  tests/bios-tables-test.c | 49 ++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 49 insertions(+)
> > 
> > diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
> > index 9b3d8b0d1b..6d9e2e41b0 100644
> > --- a/tests/bios-tables-test.c
> > +++ b/tests/bios-tables-test.c
> > @@ -870,6 +870,53 @@ static void test_acpi_piix4_tcg_dimm_pxm(void)
> >      test_acpi_tcg_dimm_pxm(MACHINE_PC);
> >  }
> >  
> > +static void test_acpi_virt_tcg_memhp(void)
> > +{
> > +    test_data data = {
> > +        .machine = "virt",
> > +        .accel = "tcg",
> > +        .uefi_fl1 = "pc-bios/edk2-aarch64-code.fd",
> > +        .uefi_fl2 = "pc-bios/edk2-arm-vars.fd",
> > +        .cd = "tests/data/uefi-boot-images/bios-tables-test.aarch64.iso.qcow2",
> > +        .ram_start = 0x40000000ULL,
> > +        .scan_len = 256ULL * 1024 * 1024,
> > +    };
> > +
> > +    data.variant = ".memhp";
> > +    test_acpi_one(" -cpu cortex-a57"
> > +                  " -m 256M,slots=3,maxmem=1G"
> > +                  " -object memory-backend-ram,id=ram0,size=128M"
> > +                  " -object memory-backend-ram,id=ram1,size=128M"
> > +                  " -numa node,memdev=ram0 -numa node,memdev=ram1"
> > +                  " -numa dist,src=0,dst=1,val=21",
> > +                  &data);
> > +
> > +    free_test_data(&data);
> > +
> > +}
> > +
> > +static void test_acpi_virt_tcg_numamem(void)
> > +{
> > +    test_data data = {
> > +        .machine = "virt",
> > +        .accel = "tcg",
> > +        .uefi_fl1 = "pc-bios/edk2-aarch64-code.fd",
> > +        .uefi_fl2 = "pc-bios/edk2-arm-vars.fd",
> > +        .cd = "tests/data/uefi-boot-images/bios-tables-test.aarch64.iso.qcow2",
> > +        .ram_start = 0x40000000ULL,
> > +        .scan_len = 128ULL * 1024 * 1024,
> > +    };
> > +
> > +    data.variant = ".numamem";
> > +    test_acpi_one(" -cpu cortex-a57"
> > +                  " -object memory-backend-ram,id=ram0,size=128M"
> > +                  " -numa node,memdev=ram0",
> > +                  &data);
> > +
> > +    free_test_data(&data);
> > +
> > +}
> > +
> >  static void test_acpi_virt_tcg(void)
> >  {
> >      test_data data = {
> > @@ -916,6 +963,8 @@ int main(int argc, char *argv[])
> >          qtest_add_func("acpi/q35/dimmpxm", test_acpi_q35_tcg_dimm_pxm);
> >      } else if (strcmp(arch, "aarch64") == 0) {
> >          qtest_add_func("acpi/virt", test_acpi_virt_tcg);
> > +        qtest_add_func("acpi/virt/numamem", test_acpi_virt_tcg_numamem);
> > +        qtest_add_func("acpi/virt/memhp", test_acpi_virt_tcg_memhp);
> >      }
> >      ret = g_test_run();
> >      boot_sector_cleanup(disk);
> > -- 
> > 2.17.1
> > 
> 


