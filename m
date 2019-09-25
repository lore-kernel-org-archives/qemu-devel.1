Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49750C432C2
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 15:49:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2288E21D7A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 15:49:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2288E21D7A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53986 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iD9YD-00069j-EN
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 11:49:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33041)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iD9BK-00081g-TT
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 11:26:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iD9BI-00085v-TL
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 11:26:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33930)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iD9BG-00084Z-RI
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 11:26:16 -0400
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0AF64CD4CD
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 15:26:13 +0000 (UTC)
Received: by mail-qt1-f197.google.com with SMTP id x3so6255158qto.7
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 08:26:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=ecZ8T4qEmI30s+ItSsERtP/R1VJ5HoNF3kNQjMhzU40=;
 b=YEB/Nx89rMlY211rrBsiT02BT+OncSGkfrk7wJYC0xyoZZ2wuT02AYFc14btvPqnzK
 mZ/fIi4boZMub0Mjf+lM0kfpZWh+I8C9N4rhkc3rGLVq0f4A/swAdXGMD9EgWICVvHJM
 oBsrdqsz+yR7TozMWoj1oqHDjzQp1AxyQ++6HEy84tS3f5dh0M3cPcnZLSGfI/Zx+QDX
 Y46Hw3YU7HrEDa19uZyq/hXvwdTTV1y6d9Rc1d/pIH8IlSmNAGz/ZiZGdwVDwmEcaQIQ
 xaF8gU6niVLS/wxZZF2fFi5PKiHrlBomhQHEXZ7YeGQq9pL/4qK5OrZtgJk5im5S3B8N
 XCcw==
X-Gm-Message-State: APjAAAWV11daX67RoOcjWj0nMLyx2UWILzo9Pswq4VaIBisU6GoQOQ8b
 3w6GC3a+qteXMnj4lbVwN2nWExYKJEhzz69HRSG2crV3s4aezzJcv3dDm8uOF5yq4WjrkHm6X+8
 5xzpnBDHb7dB3hCQ=
X-Received: by 2002:a37:4d4a:: with SMTP id a71mr4268554qkb.327.1569425172328; 
 Wed, 25 Sep 2019 08:26:12 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzJaWk3M9hrDkM8F2mwpDUOJUxO5c68qzRJATEwpIUif1AjCKw1dvE+i42hVva++NugcDPuWA==
X-Received: by 2002:a37:4d4a:: with SMTP id a71mr4268511qkb.327.1569425172001; 
 Wed, 25 Sep 2019 08:26:12 -0700 (PDT)
Received: from redhat.com (bzq-79-176-40-226.red.bezeqint.net. [79.176.40.226])
 by smtp.gmail.com with ESMTPSA id e7sm3648758qtb.94.2019.09.25.08.26.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Sep 2019 08:26:10 -0700 (PDT)
Date: Wed, 25 Sep 2019 11:26:04 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH-for-4.2 v11 11/11] tests: Add bios tests to arm/virt
Message-ID: <20190925112521-mutt-send-email-mst@kernel.org>
References: <20190918130633.4872-1-shameerali.kolothum.thodi@huawei.com>
 <20190918130633.4872-12-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190918130633.4872-12-shameerali.kolothum.thodi@huawei.com>
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

On Wed, Sep 18, 2019 at 02:06:33PM +0100, Shameer Kolothum wrote:
> This adds numamem and memhp tests for arm/virt platform.
> 
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> ---
> v10-->v11
> 
> Added Igor's R-by.
> 
> In order to avoid "make check" failure, the files listed in patch #10
> has to be added to tests/data/acpi/virt folder before this patch.

So you can just add empty stubs.

> ---
>  tests/bios-tables-test.c | 49 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 49 insertions(+)
> 
> diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
> index 9b3d8b0d1b..6d9e2e41b0 100644
> --- a/tests/bios-tables-test.c
> +++ b/tests/bios-tables-test.c
> @@ -870,6 +870,53 @@ static void test_acpi_piix4_tcg_dimm_pxm(void)
>      test_acpi_tcg_dimm_pxm(MACHINE_PC);
>  }
>  
> +static void test_acpi_virt_tcg_memhp(void)
> +{
> +    test_data data = {
> +        .machine = "virt",
> +        .accel = "tcg",
> +        .uefi_fl1 = "pc-bios/edk2-aarch64-code.fd",
> +        .uefi_fl2 = "pc-bios/edk2-arm-vars.fd",
> +        .cd = "tests/data/uefi-boot-images/bios-tables-test.aarch64.iso.qcow2",
> +        .ram_start = 0x40000000ULL,
> +        .scan_len = 256ULL * 1024 * 1024,
> +    };
> +
> +    data.variant = ".memhp";
> +    test_acpi_one(" -cpu cortex-a57"
> +                  " -m 256M,slots=3,maxmem=1G"
> +                  " -object memory-backend-ram,id=ram0,size=128M"
> +                  " -object memory-backend-ram,id=ram1,size=128M"
> +                  " -numa node,memdev=ram0 -numa node,memdev=ram1"
> +                  " -numa dist,src=0,dst=1,val=21",
> +                  &data);
> +
> +    free_test_data(&data);
> +
> +}
> +
> +static void test_acpi_virt_tcg_numamem(void)
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
> +    data.variant = ".numamem";
> +    test_acpi_one(" -cpu cortex-a57"
> +                  " -object memory-backend-ram,id=ram0,size=128M"
> +                  " -numa node,memdev=ram0",
> +                  &data);
> +
> +    free_test_data(&data);
> +
> +}
> +
>  static void test_acpi_virt_tcg(void)
>  {
>      test_data data = {
> @@ -916,6 +963,8 @@ int main(int argc, char *argv[])
>          qtest_add_func("acpi/q35/dimmpxm", test_acpi_q35_tcg_dimm_pxm);
>      } else if (strcmp(arch, "aarch64") == 0) {
>          qtest_add_func("acpi/virt", test_acpi_virt_tcg);
> +        qtest_add_func("acpi/virt/numamem", test_acpi_virt_tcg_numamem);
> +        qtest_add_func("acpi/virt/memhp", test_acpi_virt_tcg_memhp);
>      }
>      ret = g_test_run();
>      boot_sector_cleanup(disk);
> -- 
> 2.17.1
> 

