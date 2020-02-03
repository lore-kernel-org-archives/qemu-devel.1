Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 983E5C3524D
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 08:14:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C7322070A
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 08:14:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C7322070A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyWs8-0005dJ-K0
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 03:14:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59122)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pannengyuan@huawei.com>) id 1iyWrb-00058I-A3
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 03:13:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pannengyuan@huawei.com>) id 1iyWra-0000de-Co
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 03:13:47 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:2748 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pannengyuan@huawei.com>)
 id 1iyWrY-0000U5-4T; Mon, 03 Feb 2020 03:13:44 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 10AE775A812F8BB7ECFE;
 Mon,  3 Feb 2020 16:13:38 +0800 (CST)
Received: from [10.184.39.213] (10.184.39.213) by smtp.huawei.com
 (10.3.19.202) with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 3 Feb 2020
 16:13:29 +0800
Subject: Re: [PATCH] pl031: add finalize function to avoid memleaks
To: Richard Henderson <richard.henderson@linaro.org>,
 <peter.maydell@linaro.org>
References: <20200203074718.37252-1-pannengyuan@huawei.com>
 <c4fdea63-0d7e-1f0a-b0f9-68bce365dc5e@linaro.org>
From: Pan Nengyuan <pannengyuan@huawei.com>
Message-ID: <3ca049ac-a74a-2b73-8236-164cbc2739f5@huawei.com>
Date: Mon, 3 Feb 2020 16:13:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <c4fdea63-0d7e-1f0a-b0f9-68bce365dc5e@linaro.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.184.39.213]
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
Cc: xuding42@huawei.com, Euler Robot <euler.robot@huawei.com>,
 qemu-arm@nongnu.org, zhang.zhanghailiang@huawei.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 2/3/2020 3:59 PM, Richard Henderson wrote:
> On 2/3/20 7:47 AM, pannengyuan@huawei.com wrote:
>> +static void pl031_finalize(Object *obj)
>> +{
>> +    PL031State *s = PL031(obj);
>> +    if (s->timer) {
> 
> As far as I can see, s->timer can never be null.

Yes, it's no instances, just seems safer.

Thanks.
> 
> Otherwise,
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> 
> 
> r~
> 

