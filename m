Return-Path: <SRS0=i8Yf=47=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F38BCC0044D
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 06:33:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF5CD2074D
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 06:33:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF5CD2074D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41386 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jD0Mo-0003IM-W7
	for qemu-devel@archiver.kernel.org; Sat, 14 Mar 2020 02:33:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53652)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1jD0Lm-0002lM-Qm
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 02:32:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1jD0Ll-0003Bn-I9
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 02:32:46 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:41499)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jD0Ll-0001xD-1f; Sat, 14 Mar 2020 02:32:45 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.1550802|-1; CH=green; DM=||false|;
 DS=CONTINUE|ham_social|0.0297961-0.00168917-0.968515; FP=0|0|0|0|0|-1|-1|-1;
 HT=e02c03278; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS; RN=9; RT=9; SR=0;
 TI=SMTPD_---.H.EqM.b_1584167543; 
Received: from 192.168.3.18(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.H.EqM.b_1584167543)
 by smtp.aliyun-inc.com(10.147.42.198);
 Sat, 14 Mar 2020 14:32:23 +0800
Subject: Re: [PATCH v5 11/60] target/riscv: vector integer add-with-carry /
 subtract-with-borrow instructions
To: Richard Henderson <richard.henderson@linaro.org>, alistair23@gmail.com,
 chihmin.chao@sifive.com, palmer@dabbelt.com
References: <20200312145900.2054-1-zhiwei_liu@c-sky.com>
 <20200312145900.2054-12-zhiwei_liu@c-sky.com>
 <77fcc875-ba5e-ea18-1228-6a1e7989491b@linaro.org>
 <6de2ad7d-c83a-a3a0-622c-51aaf28c36a7@linaro.org>
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
Message-ID: <de473cbf-9c9e-7ce7-6314-9c0ebec67e03@c-sky.com>
Date: Sat, 14 Mar 2020 14:32:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <6de2ad7d-c83a-a3a0-622c-51aaf28c36a7@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 121.197.200.217
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
Cc: guoren@linux.alibaba.com, wenmeng_zhang@c-sky.com, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, wxy194768@alibaba-inc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 2020/3/14 14:16, Richard Henderson wrote:
> On 3/13/20 10:58 PM, Richard Henderson wrote:
>>      C ? N + M <= N : N + M < N
> Ho hum.  N + M + 1 <= N.
> I'm sure you saw the typo...
>

You give the corner case and the very precise answer.

Thanks very much.

Zhiwei
> r~


