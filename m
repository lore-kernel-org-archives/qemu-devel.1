Return-Path: <SRS0=3Ld+=VU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C88ABC7618B
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 12:58:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C69621670
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 12:58:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C69621670
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42222 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpuNT-0006zf-TB
	for qemu-devel@archiver.kernel.org; Tue, 23 Jul 2019 08:58:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49712)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <imammedo@redhat.com>) id 1hpuNJ-0006XZ-Lg
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 08:58:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1hpuNI-0004pH-2V
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 08:58:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58830)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>)
 id 1hpuNE-0004nM-Pe; Tue, 23 Jul 2019 08:58:33 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A318B8CB48;
 Tue, 23 Jul 2019 12:58:31 +0000 (UTC)
Received: from localhost (unknown [10.43.2.182])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D57285D9C5;
 Tue, 23 Jul 2019 12:58:24 +0000 (UTC)
Date: Tue, 23 Jul 2019 14:58:22 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Message-ID: <20190723145822.5fab37c2@redhat.com>
In-Reply-To: <5FC3163CFD30C246ABAA99954A238FA83F310B0C@lhreml524-mbs.china.huawei.com>
References: <20190716153816.17676-1-shameerali.kolothum.thodi@huawei.com>
 <20190716153816.17676-11-shameerali.kolothum.thodi@huawei.com>
 <20190718151315.2c1d3aff@redhat.com>
 <5FC3163CFD30C246ABAA99954A238FA83F310B0C@lhreml524-mbs.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Tue, 23 Jul 2019 12:58:32 +0000 (UTC)
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
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "sameo@linux.intel.com" <sameo@linux.intel.com>,
 "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Linuxarm <linuxarm@huawei.com>,
 "shannon.zhaosl@gmail.com" <shannon.zhaosl@gmail.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "xuwei \(O\)" <xuwei5@huawei.com>,
 "sebastien.boeuf@intel.com" <sebastien.boeuf@intel.com>,
 "lersek@redhat.com" <lersek@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 22 Jul 2019 14:51:59 +0000
Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com> wrote:

> Hi Igor,
> 
> > -----Original Message-----
> > From: Qemu-devel
> > [mailto:qemu-devel-bounces+shameerali.kolothum.thodi=huawei.com@nongn
> > u.org] On Behalf Of Igor Mammedov
> > Sent: 18 July 2019 14:13
> > To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
> > Cc: peter.maydell@linaro.org; sameo@linux.intel.com;
> > shannon.zhaosl@gmail.com; ard.biesheuvel@linaro.org;
> > qemu-devel@nongnu.org; xuwei (O) <xuwei5@huawei.com>; Linuxarm
> > <linuxarm@huawei.com>; eric.auger@redhat.com; qemu-arm@nongnu.org;
> > sebastien.boeuf@intel.com; lersek@redhat.com
> > Subject: Re: [Qemu-devel] [PATCH-for-4.2 v7 10/10] tests: Update DSDT ACPI
> > table for arm/virt board with PCDIMM related changes
> > 
> > On Tue, 16 Jul 2019 16:38:16 +0100
> > Shameer Kolothum <shameerali.kolothum.thodi@huawei.com> wrote:
> >   
> > > From: Eric Auger <eric.auger@redhat.com>
> > >
> > > PCDIMM hotplug addition updated the DSDT. Update the reference table.  
> > 
> > it's not correct process. series should be merged through Michael's pci branch
> > and see
> > commit ab50f22309a17c772c51931940596e707c200739 (mst/pci)
> > Author: Michael S. Tsirkin <mst@redhat.com>
> > Date:   Tue May 21 17:38:47 2019 -0400
> > 
> >     bios-tables-test: add diff allowed list
> > 
> > how to request table update.  
> 
> Ok. Just to confirm, this means I can probably add the below diff to patch #6 and
> remove this patch(10/10) from the series. 

you can use commit 4a4418369d6 as an example

> 
> diff --git a/tests/bios-tables-test-allowed-diff.h b/tests/bios-tables-test-allowed-diff.h
> index dfb8523c8b..7b4adbc822 100644
> --- a/tests/bios-tables-test-allowed-diff.h
> +++ b/tests/bios-tables-test-allowed-diff.h
> @@ -1 +1,2 @@
>  /* List of comma-separated changed AML files to ignore */
> +"tests/data/acpi/virt/DSDT",
> 
> > 
> > Another thing:
> > bios-tables-test has test_acpi_tcg_dimm_pxm() test case,
> > pls make use of it to test arm/virt variant  
> 
> I had a go with this, but has found an issue with this.
> 
> This is what I added in order to run the dimm_pxm test.
> 
> - - 8- -
> 
> diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
> index a356ac3489..79af4f4874 100644
> --- a/tests/bios-tables-test.c
> +++ b/tests/bios-tables-test.c
> @@ -871,6 +871,36 @@ static void test_acpi_piix4_tcg_dimm_pxm(void)
>      test_acpi_tcg_dimm_pxm(MACHINE_PC);
>  }
>  
> +static void test_acpi_virt_tcg_dimm_pxm(void)
> +{
> +    test_data data = {
> +        .machine = "virt",
> +        .accel = "tcg",
> +        .uefi_fl1 = "pc-bios/edk2-aarch64-code.fd",
> +        .uefi_fl2 = "pc-bios/edk2-arm-vars.fd",
> +        .cd = "tests/data/uefi-boot-images/bios-tables-test.aarch64.iso.qcow2",
> +        .ram_start = 0x40000000ULL,
> +        .scan_len = 128ULL * 1024 * 1024,
> +    };
> +
> +    data.variant = ".dimmpxm";
> +    test_acpi_one(" -cpu cortex-a57"
> +                  " -smp 4"
> +                  " -m 512M,slots=3,maxmem=2G"
> +                  " -object memory-backend-ram,id=ram0,size=128M"
> +                  " -object memory-backend-ram,id=ram1,size=128M"
> +                  " -object memory-backend-ram,id=ram2,size=128M"
> +                  " -object memory-backend-ram,id=ram3,size=128M"
> +                  " -numa node,memdev=ram0,nodeid=0"
> +                  " -numa node,memdev=ram1,nodeid=1"
> +                  " -numa node,memdev=ram2,nodeid=2"
> +                  " -numa node,memdev=ram3,nodeid=3"
> +                  " -object memory-backend-ram,id=ram4,size=1G"
> +                  " -device pc-dimm,id=dimm0,memdev=ram4,node=0",
> +                  &data);
> +    free_test_data(&data);
> +}
> +
>  static void test_acpi_virt_tcg(void)
>  {
>      test_data data = {
> @@ -917,6 +947,7 @@ int main(int argc, char *argv[])
>          qtest_add_func("acpi/q35/dimmpxm", test_acpi_q35_tcg_dimm_pxm);
>      } else if (strcmp(arch, "aarch64") == 0) {
>          qtest_add_func("acpi/virt", test_acpi_virt_tcg);
> +        qtest_add_func("acpi/virt/dimmpxm", test_acpi_virt_tcg_dimm_pxm);
>      }
>      ret = g_test_run();
>      boot_sector_cleanup(disk);
> 
> - - 8- -
> 
> Then used the script to generate the acpi tables and "make check" runs fine.
> 
> But when I changed the memory configuration to,
> 
> test_acpi_one(" -cpu cortex-a57"
>             " -smp 4"
>             " -m 256M,slots=3,maxmem=2G"
>             " -object memory-backend-ram,id=ram0,size=64M"
>             " -object memory-backend-ram,id=ram1,size=64M"
>             " -object memory-backend-ram,id=ram2,size=64M"
>             " -object memory-backend-ram,id=ram3,size=64M"
>             " -numa node,memdev=ram0,nodeid=0"
>             " -numa node,memdev=ram1,nodeid=1"
>             " -numa node,memdev=ram2,nodeid=2"
>             " -numa node,memdev=ram3,nodeid=3"
>             " -object memory-backend-ram,id=ram4,size=1G"
>             " -device pc-dimm,id=dimm0,memdev=ram4,node=0",
>             &data);
> 
> "make check" gets stuck at,
> 
>   CC      tests/bios-tables-test.o
>   LINK    tests/bios-tables-test
>   TEST    check-qtest-aarch64: tests/numa-test
>   TEST    check-qtest-aarch64: tests/boot-serial-test
>   TEST    check-qtest-aarch64: tests/migration-test
>   TEST    check-qtest-aarch64: tests/bios-tables-test -->stuck here.
> 
> But if I use the same memory configuration and run the qemu guest independently
> it boots fine.
> 
> ./qemu-system-aarch64 -machine virt,accel=tcg \
> -cpu cortex-a57 \
> -nographic -smp 4 \
> -bios QEMU_EFI_Release.fd \
> -kernel Image_5.2rc2 \
> -drive if=none,file=ubuntu-est-5.0,id=fs \
> -device virtio-blk-device,drive=fs \
> -m 256M,slots=3,maxmem=2G \
> -object memory-backend-ram,id=ram0,size=64M \
> -object memory-backend-ram,id=ram1,size=64M \
> -object memory-backend-ram,id=ram2,size=64M \
> -object memory-backend-ram,id=ram3,size=64M \
> -numa node,memdev=ram0,nodeid=0 \
> -numa node,memdev=ram1,nodeid=1 \
> -numa node,memdev=ram2,nodeid=2 \
> -numa node,memdev=ram3,nodeid=3 \
> -object memory-backend-ram,id=ram4,size=1G \
> -device pc-dimm,id=dimm1,memdev=ram4,node=0 \
> -append "console=ttyAMA0 root=/dev/vda rw acpi=force"
>  
> root@ubuntu:~# numactl -H
> available: 4 nodes (0-3)
> node 0 cpus: 0
> node 0 size: 1067 MB
> node 0 free: 1015 MB
> node 1 cpus: 1
> node 1 size: 44 MB
> node 1 free: 5 MB
> node 2 cpus: 2
> node 2 size: 63 MB
> node 2 free: 24 MB
> node 3 cpus: 3
> node 3 size: 63 MB
> node 3 free: 31 MB
> node distances:
> node   0   1   2   3 
>   0:  10  20  20  20 
>   1:  20  10  20  20 
>   2:  20  20  10  20 
>   3:  20  20  20  10 
> root@ubuntu:~#
> 
> I am not sure why "make check" hangs with 64M size!. 
> Please take a look and let me know if I missed anything obvious here.

I'd try to see what tests/bios-tables-test does when it's stuck.
(I'd guess that it can't find ACPI tables)

also pay attention to .scan_len so it would cover all RAM


> 
> Thanks,
> Shameer


