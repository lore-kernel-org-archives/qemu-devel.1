Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38B57C433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 09:46:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A722422200
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 09:46:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A722422200
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36384 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kURjy-0004ve-99
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 05:46:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50190)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yubihong@huawei.com>)
 id 1kURhv-0003dz-Vu; Mon, 19 Oct 2020 05:44:01 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5253 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yubihong@huawei.com>)
 id 1kURhn-0001jy-61; Mon, 19 Oct 2020 05:43:59 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 900E4D994F388299A0DE;
 Mon, 19 Oct 2020 17:43:45 +0800 (CST)
Received: from [10.174.186.14] (10.174.186.14) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.487.0; Mon, 19 Oct 2020 17:43:36 +0800
Subject: Re: [PATCH v2 3/8] migration: Add spaces around operator
To: Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert"
 <dgilbert@redhat.com>
References: <1602508140-11372-1-git-send-email-yubihong@huawei.com>
 <1602508140-11372-4-git-send-email-yubihong@huawei.com>
 <20201013101003.GC2920@work-vm> <87a6wi1v4b.fsf@dusky.pond.sub.org>
From: Bihong Yu <yubihong@huawei.com>
Message-ID: <90d55347-0f39-1ac7-f1a1-3982684b2213@huawei.com>
Date: Mon, 19 Oct 2020 17:43:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <87a6wi1v4b.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.186.14]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.191; envelope-from=yubihong@huawei.com;
 helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/19 05:17:55
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: alex.chen@huawei.com, quintela@redhat.com, qemu-trivial@nongnu.org,
 qemu-devel@nongnu.org, zhengchuan@huawei.com, wanghao232@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Yes, I used to think "const VMStateDescription *[]" was right, but when I search
similar expressions, most of all are "xxx * []". Such as:
fsdev/qemu-fsdev.c:54:        .opts = (const char * [])
hw/intc/s390_flic_kvm.c:567:    .subsections = (const VMStateDescription * [])
...

So, I keep the same style. Should I change it to "const VMStateDescription *[]"?

On 2020/10/19 16:24, Markus Armbruster wrote:
> "Dr. David Alan Gilbert" <dgilbert@redhat.com> writes:
> 
>> * Bihong Yu (yubihong@huawei.com) wrote:
>>> Signed-off-by: Bihong Yu <yubihong@huawei.com>
>>> Reviewed-by: Chuan Zheng <zhengchuan@huawei.com>
>>
>> Yes that's OK, I'm a bit sturprised we need the space afte rthe * in the
>> VMStateDescription case, I wouldn't necessarily go and change them all.
> 
> We don't: it's not the binary multiplication operator *, where we want a
> space on both sides, it's a pointer declarator, where we want a space on
> the left only.
> 
> Example:
> 
>     int *pa, *pb, *pc;
>     *pa = *pb * *pc;
> 
> Note the space on both side of binary operator * (multiplication), but
> only on the left side of the pointer declarator's * and the unary
> operator * (indirection).
> 
>> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> [...]
>>> diff --git a/migration/savevm.c b/migration/savevm.c
>>> index d2e141f..9e95df1 100644
>>> --- a/migration/savevm.c
>>> +++ b/migration/savevm.c
>>> @@ -521,7 +521,7 @@ static const VMStateDescription vmstate_configuration = {
>>>          VMSTATE_VBUFFER_ALLOC_UINT32(name, SaveState, 0, NULL, len),
>>>          VMSTATE_END_OF_LIST()
>>>      },
>>> -    .subsections = (const VMStateDescription*[]) {
>>> +    .subsections = (const VMStateDescription * []) {
>>>          &vmstate_target_page_bits,
>>>          &vmstate_capabilites,
>>>          &vmstate_uuid,
> 
> Should be
> 
>    .subsections = (const VMStateDescription *[]) {
> 
> [...]
> 
> .
> 

