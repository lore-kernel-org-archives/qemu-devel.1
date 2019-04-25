Return-Path: <SRS0=VSQP=S3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D5C3C10F03
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 12:42:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF754205F4
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 12:42:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF754205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56566 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJdiA-0004df-9W
	for qemu-devel@archiver.kernel.org; Thu, 25 Apr 2019 08:42:46 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47691)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hJdh7-0003xX-AN
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 08:41:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hJdh3-0004Y4-9e
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 08:41:38 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45029)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hJdh1-0004WC-5x
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 08:41:36 -0400
Received: by mail-wr1-f65.google.com with SMTP id c5so21253110wrs.11
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 05:41:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=5392qh0zKJqtVdZblSioqLExBd6WO6d454pcitZHKpY=;
	b=oPNabGyO1DzoVp2zNXp7Ut3eFLVAzOG8vRoexHXM3n3Nln+m/pLX+wxnFWoAocfWfO
	NzIvJrCd1WjyUsGMJeTHhSAIiqCddoqe+vjIUEbbcIPAG6fCbGepk0NSCbgLoAMGohMd
	ZFSLuWOZVI+hPlrI7/iH913PucGQ9crioGmyx4SLq/EdoJFxv1wXomqyNl33JMji0csS
	8gA8fE5yro+oi1M2Z+gcWA2xb/ntaB6izfzWczFjc1aQFtXhjcNVTartsKBKtAZ0mqG6
	/GwtXgrxZyusf3rqF8j5kxP5acyegMSrD9rIDkfLUMuTwIb3YXTseBIuX1O9IIRYlKpN
	Kobg==
X-Gm-Message-State: APjAAAXm6s0MvZY9pZ14pbz4DBGayOV6PHvVQHZETUzTBIHvpHDu6qGO
	XATW1cWx4VEgHdVYoo+OcwcBbQ==
X-Google-Smtp-Source: APXvYqzBIT/ZZ2KiNMetzcIIALkLco8VbBO1G9CrZvoXimNEuxS5n0S762p/WMfutHs1IsX1KZB+ZQ==
X-Received: by 2002:adf:d851:: with SMTP id k17mr6302856wrl.64.1556196090766; 
	Thu, 25 Apr 2019 05:41:30 -0700 (PDT)
Received: from [192.168.1.25] (abayonne-654-1-209-122.w109-222.abo.wanadoo.fr.
	[109.222.216.122]) by smtp.gmail.com with ESMTPSA id
	o20sm17021064wmh.21.2019.04.25.05.41.29
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Thu, 25 Apr 2019 05:41:30 -0700 (PDT)
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <1556170489-131927-1-git-send-email-imammedo@redhat.com>
	<1556170489-131927-12-git-send-email-imammedo@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <1f64a17a-57e8-448f-ced2-860d137eebaa@redhat.com>
Date: Thu, 25 Apr 2019 14:41:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1556170489-131927-12-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.65
Subject: Re: [Qemu-devel] [PATCH v3 11/13] tests: acpi: add simple arm/virt
 testcase
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Andrew Jones <drjones@redhat.com>, Ben Warren <ben@skyportsystems.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Shannon Zhao <shannon.zhaosl@gmail.com>, Gonglei <arei.gonglei@huawei.com>,
	Wei Yang <richardw.yang@linux.intel.com>, Laszlo Ersek <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190425124128.S2SAVJqxAUzMce0V2bQG_S_IJiFD-E98GF3JfoMrjnI@z>

On 4/25/19 7:34 AM, Igor Mammedov wrote:
> adds simple arm/virt test case that starts guest with
> bios-tables-test.aarch64.iso.qcow2 boot image which
> initializes UefiTestSupport* structure in RAM once
> guest is booted.
> 
>  * see commit: tests: acpi: add acpi_find_rsdp_address_uefi() helper
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> Reviewed-by: Laszlo Ersek <lersek@redhat.com>

> Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Please replace previous R-b by:

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
> v3:
>   * use firmware blobs directly from pc-bios directory
>   * use bios-tables-test.aarch64.iso.qcow2 as test boot image
>   * drop leftover qtest-uefi-images-aarch64 iMakefile rule from
>     previos version (Laszlo)
>   * add Makefile rule to include bios-tables-test into
>     check-qtest-aarch64 target
> v2:
>   * specify in test_data where board's RAM starts and RAM size
> ---
>  tests/Makefile.include   |  1 +
>  tests/bios-tables-test.c | 17 +++++++++++++++++
>  2 files changed, 18 insertions(+)
> 
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index e2432d5..983c8b1 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -267,6 +267,7 @@ check-qtest-arm-y += tests/hexloader-test$(EXESUF)
>  check-qtest-aarch64-y = tests/numa-test$(EXESUF)
>  check-qtest-aarch64-y += tests/boot-serial-test$(EXESUF)
>  check-qtest-aarch64-y += tests/migration-test$(EXESUF)
> +check-qtest-aarch64-y += tests/bios-tables-test$(EXESUF)
>  
>  check-qtest-microblazeel-y += $(check-qtest-microblaze-y)
>  
> diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
> index 1be55a1..f117461 100644
> --- a/tests/bios-tables-test.c
> +++ b/tests/bios-tables-test.c
> @@ -812,6 +812,21 @@ static void test_acpi_piix4_tcg_dimm_pxm(void)
>      test_acpi_tcg_dimm_pxm(MACHINE_PC);
>  }
>  
> +static void test_acpi_virt_tcg(void)
> +{
> +    test_data data = {
> +        .machine = "virt",
> +        .uefi_fl1 = "pc-bios/edk2-aarch64-code.fd",
> +        .uefi_fl2 = "pc-bios/edk2-arm-vars.fd",
> +        .cd = "tests/data/uefi-boot-images/bios-tables-test.aarch64.iso.qcow2",
> +        .ram_start = 0x40000000ULL,
> +        .scan_len = 128ULL * 1024 * 1024,
> +    };
> +
> +    test_acpi_one("-cpu cortex-a57 ", &data);
> +    free_test_data(&data);
> +}
> +
>  int main(int argc, char *argv[])
>  {
>      const char *arch = qtest_get_arch();
> @@ -840,6 +855,8 @@ int main(int argc, char *argv[])
>          qtest_add_func("acpi/q35/numamem", test_acpi_q35_tcg_numamem);
>          qtest_add_func("acpi/piix4/dimmpxm", test_acpi_piix4_tcg_dimm_pxm);
>          qtest_add_func("acpi/q35/dimmpxm", test_acpi_q35_tcg_dimm_pxm);
> +    } else if (strcmp(arch, "aarch64") == 0) {
> +        qtest_add_func("acpi/virt", test_acpi_virt_tcg);
>      }
>      ret = g_test_run();
>      boot_sector_cleanup(disk);
> 

