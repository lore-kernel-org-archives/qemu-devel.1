Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4BE9C10F27
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 08:49:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B74220637
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 08:49:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B74220637
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48182 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBx34-0006jQ-Lp
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 04:49:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38325)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yuzenghui@huawei.com>) id 1jBx0r-0005Fc-7N
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 04:46:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yuzenghui@huawei.com>) id 1jBx0o-0006FT-LG
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 04:46:47 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3274 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yuzenghui@huawei.com>)
 id 1jBx0h-0005qg-Cf; Wed, 11 Mar 2020 04:46:41 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id BA91D104182C4D7121A1;
 Wed, 11 Mar 2020 16:46:34 +0800 (CST)
Received: from [127.0.0.1] (10.173.222.27) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.487.0; Wed, 11 Mar 2020
 16:46:25 +0800
Subject: Re: [kvm-unit-tests PATCH v5 07/13] arm/arm64: ITS:
 its_enable_defaults
To: Eric Auger <eric.auger@redhat.com>, <eric.auger.pro@gmail.com>,
 <maz@kernel.org>, <kvmarm@lists.cs.columbia.edu>, <kvm@vger.kernel.org>,
 <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
References: <20200310145410.26308-1-eric.auger@redhat.com>
 <20200310145410.26308-8-eric.auger@redhat.com>
From: Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <59c072ae-c779-8e6e-7c22-427e087b4b64@huawei.com>
Date: Wed, 11 Mar 2020 16:46:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20200310145410.26308-8-eric.auger@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.222.27]
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.191
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
Cc: andre.przywara@arm.com, drjones@redhat.com, alexandru.elisei@arm.com,
 thuth@redhat.com, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2020/3/10 22:54, Eric Auger wrote:
> its_enable_defaults() enable LPIs at distributor level

redistributor level

> and ITS level.
> 
> gicv3_enable_defaults must be called before.
> 
> Signed-off-by: Eric Auger<eric.auger@redhat.com>

Reviewed-by: Zenghui Yu <yuzenghui@huawei.com>


Thanks


