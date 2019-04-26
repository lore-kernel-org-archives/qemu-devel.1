Return-Path: <SRS0=QtPl=S4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DA5AC43218
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 12:06:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00BBC206C1
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 12:06:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00BBC206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46120 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJzcK-00023a-4q
	for qemu-devel@archiver.kernel.org; Fri, 26 Apr 2019 08:06:12 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36831)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hJzZj-0008Ku-RW
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 08:03:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hJzQy-0002ym-6i
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 07:54:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46316)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1hJzQx-0002sc-9d
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 07:54:28 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 902193008CC7;
	Fri, 26 Apr 2019 11:54:23 +0000 (UTC)
Received: from Igors-MacBook-Pro.local (ovpn-112-27.ams2.redhat.com
	[10.36.112.27])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 2F66C5DAAF;
	Fri, 26 Apr 2019 11:54:18 +0000 (UTC)
Date: Fri, 26 Apr 2019 13:54:12 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: x00249684 <xuwei5@huawei.com>
Message-ID: <20190426135412.758769f9@Igors-MacBook-Pro.local>
In-Reply-To: <1556211116-172721-1-git-send-email-xuwei5@huawei.com>
References: <1556170489-131927-12-git-send-email-imammedo@redhat.com>
	<1556211116-172721-1-git-send-email-xuwei5@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.48]);
	Fri, 26 Apr 2019 11:54:23 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Andrew Jones <drjones@redhat.com>,
	mst@redhat.com, qemu-devel@nongnu.org,
	shameerali.kolothum.thodi@huawei.com, linuxarm@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190426115412.PCk4UGOoxC9flSq0YVwIvtgLI6aFprvg3reBdTDoons@z>

On Fri, 26 Apr 2019 00:51:56 +0800
x00249684 <xuwei5@huawei.com> wrote:

> Hi Igor,
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
> 
> Replaced the cortex-a57 with host and succesfully tested on the hisilicon arm64 
> D05 board. Otherwise it failed with "kvm_init_vcpu failed: Invalid argument".
> Is it possilbe to set the cpu type like numa-test.c?

I think it works with numa-test because it uses TCG only but in case of bios-tables-test
it uses accel="kvm:tcg" to leverage KVM capabilities whenever possible to speed up test.

Now back to our ARM test case, uefi requirement is to use 64bit CPU (hence it was cortex-a57)
however unlike x86 it obviously breaks since KVM accelerator on ARM host is used
and it doesn't work with anything other than 'host' cpu model.

I think we still want to use KVM whenever possible, but problem lies in that
user (testcase) doesn't have an idea if KVM accelerator is available and host is 64 CPU.

to sum up we need to support 2 modes:
  1. host is 64 ARM, use kvm with -cpu host
  2. all other cases use tcg with -cpu cortex-a57

I can hack to probe if /dev/kvm is accessible and host is 64 bit and use #1
otherwise fallback to #2
or as quick fix do only #2 initially and think about a better solution to #1 

Is there any other suggestions/opinions how to approach issue/proceed.

PS:
we probably would like to reuse this not only for acpi tests but also for other
arm/virt test cases that involve running guest code. 

> Thanks!
> 
> Best Regards,
> Wei


