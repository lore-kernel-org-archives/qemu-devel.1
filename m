Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A2CDC43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 07:35:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 709F62467F
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 07:35:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 709F62467F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51642 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiCos-0002ou-HO
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 02:35:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54185)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yuzenghui@huawei.com>) id 1iiCo2-0001zw-0N
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 02:34:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yuzenghui@huawei.com>) id 1iiCo1-0000J1-1L
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 02:34:37 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:2226 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yuzenghui@huawei.com>)
 id 1iiCny-0008IH-Ay; Fri, 20 Dec 2019 02:34:34 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 3DF20FFEDCEF0B4DF2E7;
 Fri, 20 Dec 2019 15:34:29 +0800 (CST)
Received: from [127.0.0.1] (10.173.222.27) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.439.0; Fri, 20 Dec 2019
 15:34:22 +0800
Subject: Re: [kvm-unit-tests PATCH 05/16] arm/arm64: ITS: Introspection tests
To: Auger Eric <eric.auger@redhat.com>, <eric.auger.pro@gmail.com>,
 <maz@kernel.org>, <kvmarm@lists.cs.columbia.edu>, <kvm@vger.kernel.org>,
 <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
References: <20191216140235.10751-1-eric.auger@redhat.com>
 <20191216140235.10751-6-eric.auger@redhat.com>
 <c133ebe6-10f4-2ff7-f75f-75b755397785@huawei.com>
 <6542297b-74d2-f3c2-63d8-04bb284414df@redhat.com>
From: Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <c164db0f-2e18-093f-8886-4746cb197fe2@huawei.com>
Date: Fri, 20 Dec 2019 15:34:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <6542297b-74d2-f3c2-63d8-04bb284414df@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.222.27]
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.190
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

On 2019/12/18 16:34, Auger Eric wrote:
> Hi Zenghui,
> 
> On 12/18/19 4:46 AM, Zenghui Yu wrote:
>> Hi Eric,
>>
>> I have to admit that this is the first time I've looked into
>> the kvm-unit-tests code, so only some minor comments inline :)
> 
> no problem. Thank you for looking at this.
> 
> By the way, with patch 16 I was able to test yout fix: "KVM: arm/arm64:
> vgic: Don't rely on the wrong pending table". Reverting it produced an
> error.

which is great! Thanks for your work!


Zenghui


