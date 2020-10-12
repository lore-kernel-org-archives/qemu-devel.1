Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91247C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 12:52:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA82221BE5
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 12:52:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA82221BE5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38020 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRxJH-00046F-N6
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 08:52:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33690)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yubihong@huawei.com>)
 id 1kRxDR-0006DL-Kf; Mon, 12 Oct 2020 08:46:13 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5232 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yubihong@huawei.com>)
 id 1kRxDO-0000Ky-Os; Mon, 12 Oct 2020 08:46:13 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id EF885F46E000FDB4DF67;
 Mon, 12 Oct 2020 20:46:04 +0800 (CST)
Received: from [10.174.186.14] (10.174.186.14) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.487.0; Mon, 12 Oct 2020 20:45:58 +0800
Subject: Re: [PATCH v1 2/8] migration: Don't use '#' flag of printf format
To: Peter Maydell <peter.maydell@linaro.org>
References: <1602413863-19513-1-git-send-email-yubihong@huawei.com>
 <1602413863-19513-3-git-send-email-yubihong@huawei.com>
 <CAFEAcA_VGzPsteNKjYkm7PGUn5As5Z+XWLMZq60ph055LqqfrA@mail.gmail.com>
From: Bihong Yu <yubihong@huawei.com>
Message-ID: <9d9a11cd-ff11-4192-f72d-0495dda97351@huawei.com>
Date: Mon, 12 Oct 2020 20:45:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_VGzPsteNKjYkm7PGUn5As5Z+XWLMZq60ph055LqqfrA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.186.14]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.191; envelope-from=yubihong@huawei.com;
 helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/12 07:12:20
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.001,
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
Cc: alex.chen@huawei.com, Juan Quintela <quintela@redhat.com>,
 QEMU Trivial <qemu-trivial@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, zhengchuan@huawei.com,
 wanghao232@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Thank you for your review. OK,I have fixed the problem in v2.

On 2020/10/12 2:19, Peter Maydell wrote:
> On Sun, 11 Oct 2020 at 14:52, Bihong Yu <yubihong@huawei.com> wrote:
>> @@ -998,7 +998,7 @@ static int block_load(QEMUFile *f, void *opaque, int version_id)
>>                     (addr == 100) ? '\n' : '\r');
>>              fflush(stdout);
>>          } else if (!(flags & BLK_MIG_FLAG_EOS)) {
>> -            fprintf(stderr, "Unknown block migration flags: %#x\n", flags);
>> +            fprintf(stderr, "Unknown block migration flags: %0x\n", flags);
> 
> This doesn't look right. "%#x" will print a number in hex with a leading '0x'.
> To get the same effect without using "#" you need "0x%x" (that is,
> the format string provides the 0x characters literally).
> What you've written is '%0x", which is a format string where the '0' is
> a request to print with zero padding (which is ignored since there's no
> field width given), so the result is the same as if you'd just said '%x',
> and there is no '0x' in the output.
> 
> $ cat /tmp/zz9.c
> #include <stdio.h>
> int main(void) {
>   printf("%#x\n", 42);
>   printf("%0x\n", 42);
>   printf("0x%x\n", 42);
>   return 0;
> }
> $ gcc -g -Wall -o /tmp/zz9 /tmp/zz9.c
> $ /tmp/zz9
> 0x2a
> 2a
> 0x2a
> 
>>          default:
>> -            error_report("Unknown combination of migration flags: %#x"
>> +            error_report("Unknown combination of migration flags: %0x"
>>                           " (postcopy mode)", flags);
>>              ret = -EINVAL;
>>              break;
>> @@ -3576,7 +3576,7 @@ static int ram_load_precopy(QEMUFile *f)
>>              if (flags & RAM_SAVE_FLAG_HOOK) {
>>                  ram_control_load_hook(f, RAM_CONTROL_HOOK, NULL);
>>              } else {
>> -                error_report("Unknown combination of migration flags: %#x",
>> +                error_report("Unknown combination of migration flags: %0x",
>>                               flags);
>>                  ret = -EINVAL;
>>              }
> 
> These two similarly should be "0x%x".
> 
> thanks
> -- PMM
> .
> 

