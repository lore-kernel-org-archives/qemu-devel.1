Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3FBEC433E6
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 00:57:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96236206EF
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 00:57:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96236206EF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36230 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDH5E-0004R0-OP
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 20:57:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40464)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pannengyuan@huawei.com>)
 id 1kDH4Z-0003zN-AG
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 20:56:23 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:40556 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pannengyuan@huawei.com>)
 id 1kDH4X-0000Bf-2H
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 20:56:23 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id C0EA6C0884D1F3DBB61E;
 Wed,  2 Sep 2020 08:56:05 +0800 (CST)
Received: from [127.0.0.1] (10.174.187.46) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.487.0; Wed, 2 Sep 2020
 08:55:59 +0800
Subject: Re: [PATCH v2 06/10] target/i386/cpu: Fix memleak in
 x86_cpu_class_check_missing_features
To: Markus Armbruster <armbru@redhat.com>
References: <20200831134315.1221-1-pannengyuan@huawei.com>
 <20200831134315.1221-7-pannengyuan@huawei.com>
 <87ft81ya9x.fsf@dusky.pond.sub.org>
From: Pan Nengyuan <pannengyuan@huawei.com>
Message-ID: <02cab1aa-2f71-69f5-a5cd-f7f4e0602415@huawei.com>
Date: Wed, 2 Sep 2020 08:55:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <87ft81ya9x.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.187.46]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.32;
 envelope-from=pannengyuan@huawei.com; helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/01 20:56:07
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -62
X-Spam_score: -6.3
X-Spam_bar: ------
X-Spam_report: (-6.3 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.13,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, kuhn.chenqun@huawei.com,
 qemu-devel@nongnu.org, euler.robot@huawei.com, Paolo
 Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 zhang.zhanghailiang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 2020/9/1 20:03, Markus Armbruster wrote:
> Pan Nengyuan <pannengyuan@huawei.com> writes:
> 
>> 'err' forgot to free in x86_cpu_class_check_missing_features error path.
>> Fix that.
>>
>> Reported-by: Euler Robot <euler.robot@huawei.com>
>> Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
>> Reviewed-by: Li Qiang <liq3ea@gmail.com>
>> ---
>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>> Cc: Richard Henderson <rth@twiddle.net>
>> Cc: Eduardo Habkost <ehabkost@redhat.com>
>> ---
>> - V2: no changes in v2.
>> ---
>>  target/i386/cpu.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
>> index 588f32e136..4678aac0b4 100644
>> --- a/target/i386/cpu.c
>> +++ b/target/i386/cpu.c
>> @@ -4872,6 +4872,7 @@ static void x86_cpu_class_check_missing_features(X86CPUClass *xcc,
>        x86_cpu_expand_features(xc, &err);
>        if (err) {
>            /* Errors at x86_cpu_expand_features should never happen,
>             * but in case it does, just report the model as not
>             * runnable at all using the "type" property.
>             */
>            strList *new = g_new0(strList, 1);
>>          new->value = g_strdup("type");
>>          *next = new;
>>          next = &new->next;
>> +        error_free(err);
>>      }
>>  
>>      x86_cpu_filter_features(xc, false);
> 
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> 
> Recommended cleanup: change x86_cpu_filter_features() to return true on
> success, false on failure, then pass NULL here and check the return
> value.  Can be done on top.
>
Agree with you, 'err' is not used, we can pass NULL here.
BTW, I think the func you mentioned shoule be x86_cpu_expand_features(), not x86_cpu_filter_features()?

Thanks.

> .
> 


