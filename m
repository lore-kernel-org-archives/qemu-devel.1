Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D15BC2BA83
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 07:21:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D87E3206DB
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 07:21:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D87E3206DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32900 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1mKc-00029x-Px
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 02:21:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54528)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1j1mJK-00011L-4h
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 02:19:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1j1mJJ-0006k6-7V
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 02:19:50 -0500
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:52011)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1j1mJI-0006iX-ML; Wed, 12 Feb 2020 02:19:49 -0500
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.1399636|-1; CH=green;
 DM=CONTINUE|CONTINUE|true|0.179441-0.00696519-0.813594;
 DS=CONTINUE|ham_alarm|0.654169-0.000124852-0.345706; FP=0|0|0|0|0|-1|-1|-1;
 HT=e01a16384; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS; RN=8; RT=8; SR=0;
 TI=SMTPD_---.GnCHWPR_1581491981; 
Received: from 192.168.3.18(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.GnCHWPR_1581491981)
 by smtp.aliyun-inc.com(10.147.41.137);
 Wed, 12 Feb 2020 15:19:42 +0800
Subject: Re: [PATCH v4 2/4] target/riscv: configure and turn on vector
 extension from command line
To: Richard Henderson <richard.henderson@linaro.org>, alistair23@gmail.com,
 chihmin.chao@sifive.com, palmer@dabbelt.com
References: <20200210081240.11481-1-zhiwei_liu@c-sky.com>
 <20200210081240.11481-3-zhiwei_liu@c-sky.com>
 <4a1182b3-b92a-51b1-1784-4324250fb2dd@linaro.org>
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
Message-ID: <c49aee52-4e42-3686-d487-afaff3e2afd5@c-sky.com>
Date: Wed, 12 Feb 2020 15:19:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <4a1182b3-b92a-51b1-1784-4324250fb2dd@linaro.org>
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
Cc: wenmeng_zhang@c-sky.com, qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 wxy194768@alibaba-inc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 2020/2/11 23:56, Richard Henderson wrote:
> On 2/10/20 8:12 AM, LIU Zhiwei wrote:
>> +            if (cpu->cfg.vlen > RV_VLEN_MAX || cpu->cfg.vlen < 128) {
>> +                error_setg(errp,
>> +                       "Vector extension implementation only supports VLEN "
>> +                       "in the range [128, %d]", RV_VLEN_MAX);
>> +                return;
>> +            }
>> +            if (!is_power_of_2(cpu->cfg.elen)) {
>> +                error_setg(errp,
>> +                       "Vector extension ELEN must be power of 2");
>> +                return;
>> +            }
>> +            if (cpu->cfg.elen > 64) {
>> +                error_setg(errp,
>> +                       "Vector extension ELEN must <= 64");
>> +                return;
>> +            }
> ELEN should use the same "only supports ELEN in the range" language as VLEN.
OK. I will printf "only supports ELEN in the range[8, 64]".
> Otherwise,
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>
>
> r~


