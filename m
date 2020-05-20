Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DE28C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 02:42:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1F812075F
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 02:42:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1F812075F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41574 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbEgn-0006da-4c
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 22:42:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37598)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jbEg8-0006AV-4M; Tue, 19 May 2020 22:41:56 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:42595)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jbEg6-0002si-6N; Tue, 19 May 2020 22:41:55 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.08818989|-1; CH=green;
 DM=|CONTINUE|false|;
 DS=CONTINUE|ham_regular_dialog|0.0330162-0.000783601-0.9662;
 FP=0|0|0|0|0|-1|-1|-1; HT=e02c03278; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS;
 RN=9; RT=9; SR=0; TI=SMTPD_---.HaxZbRD_1589942506; 
Received: from 30.225.208.54(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.HaxZbRD_1589942506)
 by smtp.aliyun-inc.com(10.147.41.231);
 Wed, 20 May 2020 10:41:50 +0800
Subject: Re: [RFC PATCH 1/8] riscv: Add RV64I instructions description
To: Richard Henderson <richard.henderson@linaro.org>, peter.maydell@linaro.org
References: <20200430072139.4602-1-zhiwei_liu@c-sky.com>
 <20200430072139.4602-2-zhiwei_liu@c-sky.com>
 <eb866cde-b8c1-f722-d364-1ae015bb277d@linaro.org>
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
Message-ID: <c776b7f2-ceda-4ab8-b006-698dd41fcc48@c-sky.com>
Date: Wed, 20 May 2020 10:41:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <eb866cde-b8c1-f722-d364-1ae015bb277d@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: none client-ip=121.197.200.217;
 envelope-from=zhiwei_liu@c-sky.com; helo=smtp2200-217.mail.aliyun.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/19 21:46:04
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, UNPARSEABLE_RELAY=0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, wxy194768@alibaba-inc.com,
 wenmeng_zhang@c-sky.com, palmer@dabbelt.com, alistair23@gmail.com,
 alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 2020/5/12 0:39, Richard Henderson wrote:
> On 4/30/20 12:21 AM, LIU Zhiwei wrote:
>> +LUI RISCV imm:20 rd:5 0110111 \
>> +!constraints { $rd != 2 && $rd != 3 && $rd != 4 }
> I think it would be helpful to add a function for this.  e.g. greg($rd) and
> gbase($rs1) (including $0).  It would keep the constraints smaller, and avoid
> mistakes.
>
> These functions would go into risugen_riscv.pm.
Good idea. I will take it next patch set.
>> +ADDI RISCV imm:12 rs1:5 000 rd:5 0010011 \
>> +!constraints { $rd != 2 && $rd != 3 && $rd != 4 && $rs1 != 2 }
> Since all of sp, gp, tp are not in risu's control, why is rs1 only excluding
> sp, and not gp and tp as well?
When I test the patch set, I find gp and tp will be the same in slave 
and master，
so they can be used as source register.

I will check it again in next patch set test.

Zhiwei
>
> r~


