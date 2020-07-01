Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18AD5C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 23:51:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B643A206B7
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 23:51:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B643A206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52112 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqmVM-0001QP-Rw
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 19:51:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49330)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jqmP1-0000X3-DD; Wed, 01 Jul 2020 19:44:31 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:36938)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jqmOt-0002aV-GG; Wed, 01 Jul 2020 19:44:30 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.4209036|-1; CH=blue; DM=|OVERLOAD|false|;
 DS=CONTINUE|ham_enroll_verification|0.00714789-0.000805358-0.992047;
 FP=0|0|0|0|0|-1|-1|-1; HT=e02c03278; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS;
 RN=7; RT=7; SR=0; TI=SMTPD_---.Hw4dnAW_1593647049; 
Received: from 192.168.3.18(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.Hw4dnAW_1593647049)
 by smtp.aliyun-inc.com(10.147.41.121);
 Thu, 02 Jul 2020 07:44:09 +0800
Subject: Re: [PATCH 1/1] tcg/tcg-op: nonatomic_op should work with smaller
 memop
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
References: <20200701152156.1147-1-zhiwei_liu@c-sky.com>
 <e828263f-e592-d787-b4cd-44c41a41e7f3@linaro.org>
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
Message-ID: <fcfd644f-fcec-72ca-ebbe-d2eaa60bdeac@c-sky.com>
Date: Thu, 2 Jul 2020 07:44:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <e828263f-e592-d787-b4cd-44c41a41e7f3@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: none client-ip=121.197.200.217;
 envelope-from=zhiwei_liu@c-sky.com; helo=smtp2200-217.mail.aliyun.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/01 19:44:11
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, UNPARSEABLE_RELAY=0.001 autolearn=_AUTOLEARN
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
Cc: palmer@dabbelt.com, wenmeng_zhang@c-sky.com, Alistair.Francis@wdc.com,
 wxy194768@alibaba-inc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 2020/7/2 0:25, Richard Henderson wrote:
> On 7/1/20 8:21 AM, LIU Zhiwei wrote:
>> -    tcg_gen_qemu_ld_i32(t1, addr, idx, memop & ~MO_SIGN);
>> +    tcg_gen_qemu_ld_i32(t1, addr, idx, memop);
>> +    tcg_gen_ext_i32(val, val, memop);
>>       gen(t2, t1, val);
> I was just about to post a simiar patch.
> The difference with mine is that I do not modify val:
>
> -    gen(t2, t1, val);
> +    tcg_gen_ext_i32(t2, val, memop);
> +    gen(t2, t1, t2);
I see. So just ignore this patch.:-)

Zhiwei
>
> r~


