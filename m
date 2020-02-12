Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15844C2BA83
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 07:23:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2D2C206DB
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 07:23:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2D2C206DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32922 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1mNC-0004MJ-6G
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 02:23:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55034)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1j1mMa-0003sm-Qb
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 02:23:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1j1mMZ-0008GV-Tr
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 02:23:12 -0500
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:57283)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1j1mMZ-0008EU-F7; Wed, 12 Feb 2020 02:23:11 -0500
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.07693641|-1; CH=green;
 DM=CONTINUE|CONTINUE|true|0.268712-0.0350433-0.696245;
 DS=CONTINUE|ham_system_inform|0.364233-0.000436892-0.63533;
 FP=0|0|0|0|0|-1|-1|-1; HT=e02c03279; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS;
 RN=8; RT=8; SR=0; TI=SMTPD_---.GnByJJ2_1581492182; 
Received: from 192.168.3.18(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.GnByJJ2_1581492182)
 by smtp.aliyun-inc.com(10.147.41.120);
 Wed, 12 Feb 2020 15:23:02 +0800
Subject: Re: [PATCH v4 3/4] target/riscv: support vector extension csr
To: Richard Henderson <richard.henderson@linaro.org>, alistair23@gmail.com,
 chihmin.chao@sifive.com, palmer@dabbelt.com
References: <20200210081240.11481-1-zhiwei_liu@c-sky.com>
 <20200210081240.11481-4-zhiwei_liu@c-sky.com>
 <23fd0388-7b52-5105-9dc1-cc359b59d881@linaro.org>
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
Message-ID: <93368c51-436d-c8e7-0ce7-8bbe172a1645@c-sky.com>
Date: Wed, 12 Feb 2020 15:23:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <23fd0388-7b52-5105-9dc1-cc359b59d881@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
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



On 2020/2/12 0:11, Richard Henderson wrote:
> On 2/10/20 8:12 AM, LIU Zhiwei wrote:
>> +static int vs(CPURISCVState *env, int csrno)
>> +{
>> +    return 0;
>> +}
> This should at least be testing RVV, a-la smode().
Testing RVV is ok.

  I'm not quite understand "a -1a smode()" here. Could you give more 
details? Thanks.
> You probably want to have all of the other tests vs RVV in this file use this
> function, since this will need to grow the system mode enable test.
>
>> @@ -158,8 +167,10 @@ static int read_fcsr(CPURISCVState *env, int csrno, target_ulong *val)
>>           return -1;
>>       }
>>   #endif
>> -    *val = (riscv_cpu_get_fflags(env) << FSR_AEXC_SHIFT)
>> -        | (env->frm << FSR_RD_SHIFT);
>> +    *val = (env->vext.vxrm << FSR_VXRM_SHIFT)
>> +            | (env->vext.vxsat << FSR_VXSAT_SHIFT)
>> +            | (riscv_cpu_get_fflags(env) << FSR_AEXC_SHIFT)
>> +            | (env->frm << FSR_RD_SHIFT);
>>       return 0;
>>   }
> While we can be perfectly happy shifting 0's into place here, it would probably
> be clearer to conditionalize on vs().
OK.
>> @@ -172,10 +183,60 @@ static int write_fcsr(CPURISCVState *env, int csrno, target_ulong val)
>>       env->mstatus |= MSTATUS_FS;
>>   #endif
>>       env->frm = (val & FSR_RD) >> FSR_RD_SHIFT;
>> +    env->vext.vxrm = (val & FSR_VXRM) >> FSR_VXRM_SHIFT;
>> +    env->vext.vxsat = (val & FSR_VXSAT) >> FSR_VXSAT_SHIFT;
>>       riscv_cpu_set_fflags(env, (val & FSR_AEXC) >> FSR_AEXC_SHIFT);
>>       return 0;
>>   }
> You *must* test vs() here.
OK.
>
>
> r~


