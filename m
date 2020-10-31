Return-Path: <SRS0=iivN=EG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22DE4C00A89
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Oct 2020 02:59:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B2F02071A
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Oct 2020 02:59:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B2F02071A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35072 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYh76-0001an-DW
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 22:59:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56406)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.chen@huawei.com>)
 id 1kYh5s-0000vc-QT; Fri, 30 Oct 2020 22:58:16 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:2064)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.chen@huawei.com>)
 id 1kYh5q-00087T-8P; Fri, 30 Oct 2020 22:58:16 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
 by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4CNP4J2QDNzhcfy;
 Sat, 31 Oct 2020 10:57:52 +0800 (CST)
Received: from [10.174.187.138] (10.174.187.138) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.487.0; Sat, 31 Oct 2020 10:57:47 +0800
Message-ID: <5F9CD2AB.1060601@huawei.com>
Date: Sat, 31 Oct 2020 10:57:47 +0800
From: AlexChen <alex.chen@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.2; WOW64;
 rv:17.0) Gecko/20130509 Thunderbird/17.0.6
MIME-Version: 1.0
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH] hw/display/exynos4210_fimd: Fix potential NULL pointer
 dereference
References: <5F9BE974.3040806@huawei.com>
 <CAFEAcA_7xMjOTAWkk+k34oneB_KGCGk_hoBVMX-oDRMLZzR8Wg@mail.gmail.com>
In-Reply-To: <CAFEAcA_7xMjOTAWkk+k34oneB_KGCGk_hoBVMX-oDRMLZzR8Wg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.187.138]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.32; envelope-from=alex.chen@huawei.com;
 helo=szxga06-in.huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/30 22:57:53
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.253,
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
Cc: Igor Mitsyanko <i.mitsyanko@gmail.com>,
 QEMU Trivial <qemu-trivial@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2020/10/30 22:28, Peter Maydell wrote:
> On Fri, 30 Oct 2020 at 10:23, AlexChen <alex.chen@huawei.com> wrote:
>>
>> In exynos4210_fimd_update(), the pointer s is dereferenced before
>> being check if it is valid, which may lead to NULL pointer dereference.
>> So move the assignment to global_width after checking that the s is valid
>>
>> Reported-by: Euler Robot <euler.robot@huawei.com>
>> Signed-off-by: Alex Chen <alex.chen@huawei.com>
>> ---
>>  hw/display/exynos4210_fimd.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/hw/display/exynos4210_fimd.c b/hw/display/exynos4210_fimd.c
>> index 4c16e1f5a0..a1179d2f89 100644
>> --- a/hw/display/exynos4210_fimd.c
>> +++ b/hw/display/exynos4210_fimd.c
>> @@ -1275,12 +1275,12 @@ static void exynos4210_fimd_update(void *opaque)
>>      bool blend = false;
>>      uint8_t *host_fb_addr;
>>      bool is_dirty = false;
>> -    const int global_width = (s->vidtcon[2] & FIMD_VIDTCON2_SIZE_MASK) + 1;
>>
>>      if (!s || !s->console || !s->enabled ||
>>          surface_bits_per_pixel(qemu_console_surface(s->console)) == 0) {
>>          return;
>>      }
>> +    const int global_width = (s->vidtcon[2] & FIMD_VIDTCON2_SIZE_MASK) + 1;
>>      exynos4210_update_resolution(s);
>>      surface = qemu_console_surface(s->console);
> 
> Yep, this is a bug, but QEMU's coding style doesn't permit
> variable declarations in the middle of functions. You need
> to split the declaration (which stays where it is) and the
> initialization (which can moved down below the !s test.
> 
Thans for your review. I have also considered this modification to be incompatible with
the QEMU's coding style. But the type of global_width is const int which cannot be
assigned once they are defined.
Could we define the global_width as int, such as this modification:

diff --git a/hw/display/exynos4210_fimd.c b/hw/display/exynos4210_fimd.c
index 4c16e1f5a0..34a960a976 100644
--- a/hw/display/exynos4210_fimd.c
+++ b/hw/display/exynos4210_fimd.c
@@ -1275,12 +1275,14 @@ static void exynos4210_fimd_update(void *opaque)
     bool blend = false;
     uint8_t *host_fb_addr;
     bool is_dirty = false;
-    const int global_width = (s->vidtcon[2] & FIMD_VIDTCON2_SIZE_MASK) + 1;
+    int global_width;

     if (!s || !s->console || !s->enabled ||
         surface_bits_per_pixel(qemu_console_surface(s->console)) == 0) {
         return;
     }
+
+    global_width = (s->vidtcon[2] & FIMD_VIDTCON2_SIZE_MASK) + 1;
     exynos4210_update_resolution(s);
     surface = qemu_console_surface(s->console);


