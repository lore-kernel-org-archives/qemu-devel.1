Return-Path: <SRS0=aoXf=X5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC922C47404
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 08:09:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2E962084D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 08:09:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2E962084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42996 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGIen-00012I-MX
	for qemu-devel@archiver.kernel.org; Fri, 04 Oct 2019 04:09:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37580)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1iGIe5-0000S5-VL
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 04:09:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1iGIe4-0007D4-LJ
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 04:09:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41348)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1iGIe4-0007Cg-C1
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 04:09:00 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7A4BB3006BB6;
 Fri,  4 Oct 2019 08:08:59 +0000 (UTC)
Received: from localhost (unknown [10.43.2.182])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B1A7B5D772;
 Fri,  4 Oct 2019 08:08:57 +0000 (UTC)
Date: Fri, 4 Oct 2019 10:08:56 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Tao Xu <tao3.xu@intel.com>
Subject: Re: [PATCH v12 11/11] tests/bios-tables-test: add test cases for
 ACPI HMAT
Message-ID: <20191004100856.58a2ceec@redhat.com>
In-Reply-To: <20190920074349.2616-12-tao3.xu@intel.com>
References: <20190920074349.2616-1-tao3.xu@intel.com>
 <20190920074349.2616-12-tao3.xu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Fri, 04 Oct 2019 08:08:59 +0000 (UTC)
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
Cc: ehabkost@redhat.com, Jingqi Liu <Jingqi.liu@intel.com>, fan.du@intel.com,
 qemu-devel@nongnu.org, Daniel Black <daniel@linux.ibm.com>,
 jonathan.cameron@huawei.com, dan.j.williams@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 20 Sep 2019 15:43:49 +0800
Tao Xu <tao3.xu@intel.com> wrote:

> ACPI table HMAT has been introduced, QEMU now builds HMAT tables for
> Heterogeneous Memory with boot option '-numa node'.
> 
> Add test cases on PC and Q35 machines with 2 numa nodes.
> Because HMAT is generated when system enable numa, the
> following tables need to be added for this test:
>   tests/acpi-test-data/pc/*.acpihmat
>   tests/acpi-test-data/pc/HMAT.*
>   tests/acpi-test-data/q35/*.acpihmat
>   tests/acpi-test-data/q35/HMAT.*
> 
> Reviewed-by: Daniel Black <daniel@linux.ibm.com>
> Reviewed-by: Jingqi Liu <Jingqi.liu@intel.com>
> Suggested-by: Igor Mammedov <imammedo@redhat.com>
> Signed-off-by: Tao Xu <tao3.xu@intel.com>
> ---
> 
> No changes in V11 and v12.
> 
> Changes in v10:
>     - Update test case, add "-machine hmat=on"
> ---
>  tests/bios-tables-test.c | 44 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
> 
> diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
> index 9b3d8b0d1b..976788b6fa 100644
> --- a/tests/bios-tables-test.c
> +++ b/tests/bios-tables-test.c
> @@ -870,6 +870,48 @@ static void test_acpi_piix4_tcg_dimm_pxm(void)
>      test_acpi_tcg_dimm_pxm(MACHINE_PC);
>  }
>  
> +static void test_acpi_tcg_acpi_hmat(const char *machine)
> +{
> +    test_data data;
> +
> +    memset(&data, 0, sizeof(data));
> +    data.machine = machine;
> +    data.variant = ".acpihmat";
> +    test_acpi_one(" -machine hmat=on"
> +                  " -smp 2,sockets=2"
> +                  " -m 128M,slots=2,maxmem=1G"
> +                  " -object memory-backend-ram,size=64M,id=m0"
> +                  " -object memory-backend-ram,size=64M,id=m1"
> +                  " -numa node,nodeid=0,memdev=m0"
> +                  " -numa node,nodeid=1,memdev=m1,initiator=0"
> +                  " -numa cpu,node-id=0,socket-id=0"
> +                  " -numa cpu,node-id=0,socket-id=1"
> +                  " -numa hmat-lb,initiator=0,target=0,hierarchy=memory,"
> +                  "data-type=access-latency,latency=5ns"
> +                  " -numa hmat-lb,initiator=0,target=0,hierarchy=memory,"
> +                  "data-type=access-bandwidth,bandwidth=500M"
> +                  " -numa hmat-lb,initiator=0,target=1,hierarchy=memory,"
> +                  "data-type=access-latency,latency=10ns"
> +                  " -numa hmat-lb,initiator=0,target=1,hierarchy=memory,"
> +                  "data-type=access-bandwidth,bandwidth=100M"
> +                  " -numa hmat-cache,node-id=0,size=0x20000,total=1,level=1"
> +                  ",assoc=direct,policy=write-back,line=8"
> +                  " -numa hmat-cache,node-id=1,size=0x20000,total=1,level=1"

use decimal notation with appropriate suffix for CLI args

other than that looks good to me, so above fixed

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> +                  ",assoc=direct,policy=write-back,line=8",
> +                  &data);
> +    free_test_data(&data);
> +}
> +
> +static void test_acpi_q35_tcg_acpi_hmat(void)
> +{
> +    test_acpi_tcg_acpi_hmat(MACHINE_Q35);
> +}
> +
> +static void test_acpi_piix4_tcg_acpi_hmat(void)
> +{
> +    test_acpi_tcg_acpi_hmat(MACHINE_PC);
> +}
> +
>  static void test_acpi_virt_tcg(void)
>  {
>      test_data data = {
> @@ -914,6 +956,8 @@ int main(int argc, char *argv[])
>          qtest_add_func("acpi/q35/numamem", test_acpi_q35_tcg_numamem);
>          qtest_add_func("acpi/piix4/dimmpxm", test_acpi_piix4_tcg_dimm_pxm);
>          qtest_add_func("acpi/q35/dimmpxm", test_acpi_q35_tcg_dimm_pxm);
> +        qtest_add_func("acpi/piix4/acpihmat", test_acpi_piix4_tcg_acpi_hmat);
> +        qtest_add_func("acpi/q35/acpihmat", test_acpi_q35_tcg_acpi_hmat);
>      } else if (strcmp(arch, "aarch64") == 0) {
>          qtest_add_func("acpi/virt", test_acpi_virt_tcg);
>      }


