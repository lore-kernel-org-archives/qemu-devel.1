Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20635C00A89
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 05:16:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34FE020936
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 05:16:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34FE020936
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43038 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaXct-0000Ln-68
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 00:15:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50728)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.chen@huawei.com>)
 id 1kaXbm-0008AZ-LY; Thu, 05 Nov 2020 00:14:50 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:2131)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.chen@huawei.com>)
 id 1kaXbh-00013L-3U; Thu, 05 Nov 2020 00:14:50 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
 by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4CRWsc6R7Nz6whT;
 Thu,  5 Nov 2020 13:14:28 +0800 (CST)
Received: from [10.174.187.138] (10.174.187.138) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.487.0; Thu, 5 Nov 2020 13:14:26 +0800
Message-ID: <5FA38A32.2020008@huawei.com>
Date: Thu, 5 Nov 2020 13:14:26 +0800
From: AlexChen <alex.chen@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.2; WOW64;
 rv:17.0) Gecko/20130509 Thunderbird/17.0.6
MIME-Version: 1.0
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH] qtest: Fix bad printf format specifiers
References: <5FA28117.3020802@huawei.com>
 <67eca43e-99ea-f2ce-5d9e-a9cb5c7a3a83@redhat.com>
In-Reply-To: <67eca43e-99ea-f2ce-5d9e-a9cb5c7a3a83@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.187.138]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.35; envelope-from=alex.chen@huawei.com;
 helo=szxga07-in.huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/05 00:14:33
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: lvivier@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 QEMU Trivial <qemu-trivial@nongnu.org>, QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2020/11/4 18:44, Thomas Huth wrote:
> On 04/11/2020 11.23, AlexChen wrote:
>> We should use printf format specifier "%u" instead of "%d" for
>> argument of type "unsigned int".
>>
>> Reported-by: Euler Robot <euler.robot@huawei.com>
>> Signed-off-by: Alex Chen <alex.chen@huawei.com>
>> ---
>>  tests/qtest/arm-cpu-features.c | 8 ++++----
>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/tests/qtest/arm-cpu-features.c b/tests/qtest/arm-cpu-features.c
>> index d20094d5a7..bc681a95d5 100644
>> --- a/tests/qtest/arm-cpu-features.c
>> +++ b/tests/qtest/arm-cpu-features.c
>> @@ -536,7 +536,7 @@ static void test_query_cpu_model_expansion_kvm(const void *data)
>>          if (kvm_supports_sve) {
>>              g_assert(vls != 0);
>>              max_vq = 64 - __builtin_clzll(vls);
>> -            sprintf(max_name, "sve%d", max_vq * 128);
>> +            sprintf(max_name, "sve%u", max_vq * 128);
>>
>>              /* Enabling a supported length is of course fine. */
>>              assert_sve_vls(qts, "host", vls, "{ %s: true }", max_name);
>> @@ -556,7 +556,7 @@ static void test_query_cpu_model_expansion_kvm(const void *data)
>>                   * unless all larger, supported vector lengths are also
>>                   * disabled.
>>                   */
>> -                sprintf(name, "sve%d", vq * 128);
>> +                sprintf(name, "sve%u", vq * 128);
>>                  error = g_strdup_printf("cannot disable %s", name);
>>                  assert_error(qts, "host", error,
>>                               "{ %s: true, %s: false }",
>> @@ -569,7 +569,7 @@ static void test_query_cpu_model_expansion_kvm(const void *data)
>>               * we need at least one vector length enabled.
>>               */
>>              vq = __builtin_ffsll(vls);
>> -            sprintf(name, "sve%d", vq * 128);
>> +            sprintf(name, "sve%u", vq * 128);
>>              error = g_strdup_printf("cannot disable %s", name);
>>              assert_error(qts, "host", error, "{ %s: false }", name);
>>              g_free(error);
>> @@ -581,7 +581,7 @@ static void test_query_cpu_model_expansion_kvm(const void *data)
>>                  }
>>              }
>>              if (vq <= SVE_MAX_VQ) {
>> -                sprintf(name, "sve%d", vq * 128);
>> +                sprintf(name, "sve%u", vq * 128);
>>                  error = g_strdup_printf("cannot enable %s", name);
>>                  assert_error(qts, "host", error, "{ %s: true }", name);
>>                  g_free(error);
>>
> 
> max_vq and vq are both "uint32_t" and not "unsigned int" ... so if you want
> to fix this really really correctly, please use PRIu32 from inttypes.h instead.
> 

Hi Thomas,
Thanks for your review.
According to the definition of the macro PRIu32(# define PRIu32         "u"),
using PRIu32 works the same as using %u to print, and using PRIu32 to print
is relatively rare in QEMU(%u 720, PRIu32 only 120). Can we continue to use %u to
print max_vq and vq in this patch.
Of course, this is just my small small suggestion. If you think it is better to use
PRIu32 for printing, I will send patch V2.
Looking forward to your reply.

Thanks,
Alex




