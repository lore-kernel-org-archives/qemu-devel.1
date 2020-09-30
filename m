Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0FC2C2D0A8
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 05:09:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66F6A206F7
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 05:09:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66F6A206F7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNUNE-00067g-8V
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 01:09:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43662)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gengdongjiu@huawei.com>)
 id 1kNUMO-000581-3H; Wed, 30 Sep 2020 01:09:00 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:2981 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gengdongjiu@huawei.com>)
 id 1kNUML-00034Y-Nv; Wed, 30 Sep 2020 01:08:59 -0400
Received: from dggeme755-chm.china.huawei.com (unknown [172.30.72.56])
 by Forcepoint Email with ESMTP id D678CD8DFBE8D194DE50;
 Wed, 30 Sep 2020 13:08:44 +0800 (CST)
Received: from [10.140.157.78] (10.140.157.78) by
 dggeme755-chm.china.huawei.com (10.3.19.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Wed, 30 Sep 2020 13:08:44 +0800
Subject: Re: [PATCH] hw/arm: Restrict APEI tables generation to the 'virt'
 machine
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 <qemu-devel@nongnu.org>
References: <20200929125609.1088330-1-philmd@redhat.com>
From: Dongjiu Geng <gengdongjiu@huawei.com>
Message-ID: <12be4400-c37f-2b7f-2f15-f8700dad6003@huawei.com>
Date: Wed, 30 Sep 2020 13:08:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20200929125609.1088330-1-philmd@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.140.157.78]
X-ClientProxiedBy: dggeme703-chm.china.huawei.com (10.1.199.99) To
 dggeme755-chm.china.huawei.com (10.3.19.101)
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.188;
 envelope-from=gengdongjiu@huawei.com; helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/30 01:08:45
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>, Xiang Zheng <zhengxiang9@huawei.com>,
 qemu-arm@nongnu.org, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Igor Mammedov <imammedo@redhat.com>, Laszlo Ersek <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2020/9/29 20:56, Philippe Mathieu-Daudé wrote:
> As only the Virt machine uses the RAS Virtualization feature (see
> commit 2afa8c8519: "hw/arm/virt: Introduce a RAS machine option"),
> restrict the APEI tables generation code to the virt machine.

APEI is a generic feature for X86 and arm64.  X86 platform also can use it, although currently it was mainly
used by ARM64. what is reason that we restrict APEI tables generation to the 'virt' machine?

> 
> Fixes: aa16508f1d ("ACPI: Build related register address fields via hardware error fw_cfg blob")
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
> Cc: Laszlo Ersek <lersek@redhat.com>
> Cc: Xiang Zheng <zhengxiang9@huawei.com>
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Igor Mammedov <imammedo@redhat.com>
> Cc: Dongjiu Geng <gengdongjiu@huawei.com>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> ---
>  default-configs/arm-softmmu.mak | 1 -
>  hw/arm/Kconfig                  | 1 +
>  2 files changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
> index 9a94ebd0be..08a32123b4 100644
> --- a/default-configs/arm-softmmu.mak
> +++ b/default-configs/arm-softmmu.mak
> @@ -43,4 +43,3 @@ CONFIG_FSL_IMX7=y
>  CONFIG_FSL_IMX6UL=y
>  CONFIG_SEMIHOSTING=y
>  CONFIG_ALLWINNER_H3=y
> -CONFIG_ACPI_APEI=y
> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index f303c6bead..7d040827af 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -26,6 +26,7 @@ config ARM_VIRT
>      select ACPI_MEMORY_HOTPLUG
>      select ACPI_HW_REDUCED
>      select ACPI_NVDIMM
> +    select ACPI_APEI
>  
>  config CHEETAH
>      bool
> 

