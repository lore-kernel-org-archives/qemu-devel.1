Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6C75C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 13:02:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0152206B5
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 13:02:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0152206B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=digitalsignallabs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38002 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3fXp-0001Kk-TU
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 09:02:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42836)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yates@digitalsignallabs.com>)
 id 1k3fVC-0007n6-PV
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 09:00:14 -0400
Received: from mail.onyx.syn-alias.com ([206.152.134.66]:56302
 helo=smtp.centurylink.net)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yates@digitalsignallabs.com>)
 id 1k3fVB-0006cq-9o
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 09:00:10 -0400
X_CMAE_Category: , ,
X-CNFS-Analysis: v=2.3 cv=QYkYQfTv c=1 sm=1 tr=0
 a=+BvlVZVS74/p9mKwrR4qzg==:117 a=+BvlVZVS74/p9mKwrR4qzg==:17
 a=KGjhK52YXX0A:10 a=IkcTkHD0fZMA:10 a=y4yBn9ojGxQA:10 a=PPsO2EghCewA:10
 a=eQrCS-SpgXYA:10 a=Ixn1CAxRAAAA:8 a=riSzfaxeulHGD2guDgUA:9
 a=gHPTvc8h__eXD_09:21 a=N-NUiAowhh9YROm2:21 a=QEXdDO2ut3YA:10
 a=_0vDLAJOulx5KDpLVjVP:22
X-CM-Score: 0
X-Scanned-by: Cloudmark Authority Engine
Feedback-ID: dfw:ctl:res:onyx
X-Authed-Username: eWF0ZXNmcmVlZGFyYW5keUBjZW50dXJ5bGluay5uZXQ=
Authentication-Results: smtp02.onyx.dfw.sync.lan
 smtp.user=yatesfreedarandy@centurylink.net; auth=pass (LOGIN)
Received: from [64.98.102.7] ([64.98.102.7:54300]
 helo=galois.digitalsignallabs.com)
 by smtp.centurylink.net (envelope-from <yates@digitalsignallabs.com>)
 (ecelerity 3.6.25.56547 r(Core:3.6.25.0)) with ESMTPA
 id 55/21-23904-5DEFB2F5; Thu, 06 Aug 2020 09:00:05 -0400
Received: from localhost.localdomain (fv-nc-f7af8b91e1-234237-1.tingfiber.com
 [64.98.102.7])
 by galois.digitalsignallabs.com (Postfix) with ESMTPSA id 554D02E0ED9;
 Thu,  6 Aug 2020 09:00:04 -0400 (EDT)
Subject: Re: [PATCH] hw/cpu/a9mpcore: Verify the machine use Cortex-A9 cores
To: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
References: <20200709152337.15533-1-f4bug@amsat.org>
 <CAFEAcA_Sbaai_TPMVkGHKGGhfyjc1Mk2Z6pWSVkLcwHLVZVzNg@mail.gmail.com>
From: Randy Yates <yates@digitalsignallabs.com>
Message-ID: <7de5e47e-4347-1e0b-6f4b-922d3adea4fe@digitalsignallabs.com>
Date: Thu, 6 Aug 2020 09:00:04 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_Sbaai_TPMVkGHKGGhfyjc1Mk2Z6pWSVkLcwHLVZVzNg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: none client-ip=206.152.134.66;
 envelope-from=yates@digitalsignallabs.com; helo=smtp.centurylink.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/06 09:00:05
X-ACL-Warn: Detected OS   = Linux 2.6.x [fuzzy]
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 URIBL_BLOCKED=0.001 autolearn=unavailable autolearn_force=no
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
Cc: Rob Herring <robh@kernel.org>, Igor Mitsyanko <i.mitsyanko@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-arm <qemu-arm@nongnu.org>,
 Randy Yates <yates@ieee.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Good! Thank you, Philippe.

--Randy

On 8/6/20 8:54 AM, Peter Maydell wrote:
> On Thu, 9 Jul 2020 at 16:23, Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>> The 'Cortex-A9MPCore internal peripheral' block can only be
>> used with Cortex A5 and A9 cores. As we don't model the A5
>> yet, simply check the machine cpu core is a Cortex A9. If
>> not return an error.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>   hw/cpu/a9mpcore.c | 12 +++++++++++-
>>   1 file changed, 11 insertions(+), 1 deletion(-)
> Applied to target-arm.next (for 5.2), thanks.
>
> -- PMM

