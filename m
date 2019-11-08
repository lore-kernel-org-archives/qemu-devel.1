Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13203C5DF60
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 08:12:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D67E221D7B
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 08:12:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D67E221D7B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50516 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSzNO-00058m-V0
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 03:12:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48760)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gengdongjiu@huawei.com>) id 1iSzMl-0004Uw-6I
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 03:11:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <gengdongjiu@huawei.com>) id 1iSzMk-0002iI-8q
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 03:11:35 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:2264 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <gengdongjiu@huawei.com>)
 id 1iSzMh-0002aO-OK; Fri, 08 Nov 2019 03:11:32 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 0B11D5CF9E69D6D25DA8;
 Fri,  8 Nov 2019 16:11:24 +0800 (CST)
Received: from [127.0.0.1] (10.142.68.147) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.439.0; Fri, 8 Nov 2019
 16:11:14 +0800
Subject: Re: [PATCH v21 3/6] ACPI: Add APEI GHES table generation support
To: Xiang Zheng <zhengxiang9@huawei.com>, <pbonzini@redhat.com>,
 <mst@redhat.com>, <imammedo@redhat.com>, <shannon.zhaosl@gmail.com>,
 <peter.maydell@linaro.org>, <lersek@redhat.com>, <james.morse@arm.com>,
 <mtosatti@redhat.com>, <rth@twiddle.net>, <ehabkost@redhat.com>,
 <jonathan.cameron@huawei.com>, <xuwei5@huawei.com>, <kvm@vger.kernel.org>,
 <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>, <linuxarm@huawei.com>
References: <20191104121458.29208-1-zhengxiang9@huawei.com>
 <20191104121458.29208-4-zhengxiang9@huawei.com>
From: gengdongjiu <gengdongjiu@huawei.com>
Message-ID: <3068b1f2-7175-485a-a9a1-dcba0bf82dea@huawei.com>
Date: Fri, 8 Nov 2019 16:11:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20191104121458.29208-4-zhengxiang9@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.142.68.147]
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
Cc: wanghaibin.wang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2019/11/4 20:14, Xiang Zheng wrote:
> From: Dongjiu Geng <gengdongjiu@huawei.com>
> 
> This patch implements APEI GHES Table generation via fw_cfg blobs. Now
> it only supports ARMv8 SEA, a type of GHESv2 error source. Afterwards,
> we can extend the supported types if needed. For the CPER section,
> currently it is memory section because kernel mainly wants userspace to
> handle the memory errors.
> 
> This patch follows the spec ACPI 6.2 to build the Hardware Error Source
> table. For more detailed information, please refer to document:
> docs/specs/acpi_hest_ghes.rst
> 
> Suggested-by: Laszlo Ersek <lersek@redhat.com>
> Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
> Signed-off-by: Xiang Zheng <zhengxiang9@huawei.com>

Hi Xiang,
   please add "Reviewed-by: Michael S. Tsirkin <mst@redhat.com> " which from Michael, thanks.


