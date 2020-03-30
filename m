Return-Path: <SRS0=g3Vr=5P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDDB0C2D0EB
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 10:44:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B637020578
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 10:44:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B637020578
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47844 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jIruH-0004TB-T1
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 06:44:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50725)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yuzenghui@huawei.com>) id 1jIrte-0003wA-Up
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 06:43:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yuzenghui@huawei.com>) id 1jIrtd-0001SZ-Ml
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 06:43:58 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:41442 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yuzenghui@huawei.com>)
 id 1jIrtZ-0001N7-5E; Mon, 30 Mar 2020 06:43:54 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id C80DCD5780820CED5358;
 Mon, 30 Mar 2020 18:43:46 +0800 (CST)
Received: from [127.0.0.1] (10.173.222.27) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.487.0; Mon, 30 Mar 2020
 18:43:38 +0800
Subject: Re: [kvm-unit-tests PATCH v7 10/13] arm/arm64: ITS: INT functional
 tests
To: Eric Auger <eric.auger@redhat.com>
References: <20200320092428.20880-1-eric.auger@redhat.com>
 <20200320092428.20880-11-eric.auger@redhat.com>
From: Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <f7f1d7c4-2321-9123-2394-528af737bfa7@huawei.com>
Date: Mon, 30 Mar 2020 18:43:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20200320092428.20880-11-eric.auger@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.222.27]
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.32
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
Cc: peter.maydell@linaro.org, drjones@redhat.com, kvm@vger.kernel.org,
 maz@kernel.org, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 andre.przywara@arm.com, thuth@redhat.com, alexandru.elisei@arm.com,
 kvmarm@lists.cs.columbia.edu, eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Eric,

On 2020/3/20 17:24, Eric Auger wrote:
> Triggers LPIs through the INT command.
> 
> the test checks the LPI hits the right CPU and triggers
> the right LPI intid, ie. the translation is correct.
> 
> Updates to the config table also are tested, along with inv
> and invall commands.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>

[...]

So I've tested this series and found that the "INT" test will sometimes
fail.

"not ok 12 - gicv3: its-migration: dev2/eventid=20 triggers LPI 8195 en 
PE #3 after migration
not ok 13 - gicv3: its-migration: dev7/eventid=255 triggers LPI 8196 on 
PE #2 after migration"

 From logs:
"INFO: gicv3: its-migration: Migration complete
INT dev_id=2 event_id=20
INFO: gicv3: its-migration: No LPI received whereas (cpuid=3, 
intid=8195) was expected
FAIL: gicv3: its-migration: dev2/eventid=20 triggers LPI 8195 en PE #3 
after migration
INT dev_id=7 event_id=255
INFO: gicv3: its-migration: No LPI received whereas (cpuid=2, 
intid=8196) was expected
FAIL: gicv3: its-migration: dev7/eventid=255 triggers LPI 8196 on PE #2 
after migration"

> +static void check_lpi_stats(const char *msg)
> +{
> +	bool pass = false;
> +
> +	mdelay(100);

After changing this to 'mdelay(1000)', the above error doesn't show up
anymore. But it sounds strange that 100ms is not enough to deliver a
single LPI. I haven't dig it further but will get back here later.

> +	smp_rmb(); /* pairs with wmb in lpi_handler */
> +	if (lpi_stats.observed.cpu_id != lpi_stats.expected.cpu_id ||
> +	    lpi_stats.observed.lpi_id != lpi_stats.expected.lpi_id) {
> +		if (lpi_stats.observed.cpu_id == -1 &&
> +		    lpi_stats.observed.lpi_id == -1) {
> +			report_info("No LPI received whereas (cpuid=%d, intid=%d) "
> +				    "was expected", lpi_stats.expected.cpu_id,
> +				    lpi_stats.expected.lpi_id);
> +		} else {
> +			report_info("Unexpected LPI (cpuid=%d, intid=%d)",
> +				    lpi_stats.observed.cpu_id,
> +				    lpi_stats.observed.lpi_id);
> +		}
> +	} else {
> +		pass = true;
> +	}
> +	report(pass, "%s", msg);
> +}

This patch itself looks good to me,
Reviewed-by: Zenghui Yu <yuzenghui@huawei.com>


Thanks


