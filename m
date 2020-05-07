Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59E74C38A2A
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 10:32:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 316EC207DD
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 10:32:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 316EC207DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56550 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWdpG-0006i9-DO
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 06:32:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45736)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhukeqian1@huawei.com>)
 id 1jWdoY-0006B6-1c; Thu, 07 May 2020 06:31:38 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:56814 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhukeqian1@huawei.com>)
 id 1jWdoW-0008IR-MA; Thu, 07 May 2020 06:31:37 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id E8E56452AD0204D732F5;
 Thu,  7 May 2020 18:31:24 +0800 (CST)
Received: from [127.0.0.1] (10.173.221.230) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.487.0;
 Thu, 7 May 2020 18:31:15 +0800
Subject: Re: [PATCH v3] migration/throttle: Add cpu-throttle-tailslow
 migration parameter
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
References: <20200413101508.54793-1-zhukeqian1@huawei.com>
 <20200430141239.GH2874@work-vm>
From: zhukeqian <zhukeqian1@huawei.com>
Message-ID: <bc72b9c0-3592-df1f-c101-1a08c6982e72@huawei.com>
Date: Thu, 7 May 2020 18:31:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20200430141239.GH2874@work-vm>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.221.230]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.32; envelope-from=zhukeqian1@huawei.com;
 helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/07 06:31:25
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, qemu-arm@nongnu.org,
 wanghaibin.wang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Dr.David,

Sorry for the reply delay, just come back from holiday.

On 2020/4/30 22:12, Dr. David Alan Gilbert wrote:
> * Keqian Zhu (zhukeqian1@huawei.com) wrote:
>> At the tail stage of throttling, the Guest is very sensitive to
>> CPU percentage while the @cpu-throttle-increment is excessive
>> usually at tail stage.
[...]
>> -static void mig_throttle_guest_down(void)
>> +static void mig_throttle_guest_down(uint64_t bytes_dirty_period,
>> +                                    uint64_t bytes_dirty_threshold)
>>  {
>>      MigrationState *s = migrate_get_current();
>>      uint64_t pct_initial = s->parameters.cpu_throttle_initial;
>> -    uint64_t pct_icrement = s->parameters.cpu_throttle_increment;
>> +    uint64_t pct_increment = s->parameters.cpu_throttle_increment;
>> +    bool pct_tailslow = s->parameters.cpu_throttle_tailslow;
>>      int pct_max = s->parameters.max_cpu_throttle;
>>  
>> +    uint64_t throttle_now = cpu_throttle_get_percentage();
>> +    uint64_t cpu_now, cpu_ideal, throttle_inc;
>> +
>>      /* We have not started throttling yet. Let's start it. */
>>      if (!cpu_throttle_active()) {
>>          cpu_throttle_set(pct_initial);
>>      } else {
>>          /* Throttling already on, just increase the rate */
>> -        cpu_throttle_set(MIN(cpu_throttle_get_percentage() + pct_icrement,
>> -                         pct_max));
>> +        if (!pct_tailslow) {
>> +            throttle_inc = pct_increment;
>> +        } else {
>> +            /* Compute the ideal CPU percentage used by Guest, which may
>> +             * make the dirty rate match the dirty rate threshold. */
>> +            cpu_now = 100 - throttle_now;
>> +            cpu_ideal = cpu_now * (bytes_dirty_threshold * 1.0 /
>> +                        bytes_dirty_period);
> 
> I worry if we need a divide-by-0 check; but that seems unlikely.
mig_throttle_guest_down is called when bytes_dirty_period is bigger than
bytes_dirty_threshold, and bytes_dirty_threshold is of unsigned type, so
bytes_dirty_period will not be zero here. I will add an assert check here
to make it clear.

> Now if that worked out as huge, then I think the MIN's guard it even
> with overflow below, so I think we're OK.
Yes, it will not exceed legacy increment.

> 
>> +            throttle_inc = MIN(cpu_now - cpu_ideal, pct_increment);
>> +        }
>> +        cpu_throttle_set(MIN(throttle_now + throttle_inc, pct_max));
>>      }
>>  }
>>  
[...]
>> -- 
>> 2.19.1
>>
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> 
Thanks,
Keqian
> 
> .
> 


