Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7AACC00A89
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 05:13:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C983521D91
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 05:13:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C983521D91
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZSAA-0002NS-FE
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 00:13:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46124)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.chen@huawei.com>)
 id 1kZS9O-0001v9-SX; Mon, 02 Nov 2020 00:13:02 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:2492)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.chen@huawei.com>)
 id 1kZS9L-0007TK-OD; Mon, 02 Nov 2020 00:13:02 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CPgz40JtBzhfcq;
 Mon,  2 Nov 2020 13:12:48 +0800 (CST)
Received: from [10.174.187.138] (10.174.187.138) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.487.0; Mon, 2 Nov 2020 13:12:26 +0800
Message-ID: <5F9F953A.4060603@huawei.com>
Date: Mon, 2 Nov 2020 13:12:26 +0800
From: AlexChen <alex.chen@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.2; WOW64;
 rv:17.0) Gecko/20130509 Thunderbird/17.0.6
MIME-Version: 1.0
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH] util: Remove redundant checks in the openpty()
References: <5F9D449A.900@huawei.com>
 <CAFEAcA9w_JZ5m2Cj9Cuc4GMka8vp-AabtmqNLwe0q7ObN7QKyA@mail.gmail.com>
In-Reply-To: <CAFEAcA9w_JZ5m2Cj9Cuc4GMka8vp-AabtmqNLwe0q7ObN7QKyA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.187.138]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.191; envelope-from=alex.chen@huawei.com;
 helo=szxga05-in.huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/02 00:12:49
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, Michael Tokarev <mjt@tls.msk.ru>,
 QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2020/10/31 23:21, Peter Maydell wrote:
> On Sat, 31 Oct 2020 at 11:04, AlexChen <alex.chen@huawei.com> wrote:
>>
>> As we can see from the following function call stack, the amaster and the aslave
>> cannot be NULL: char_pty_open() -> qemu_openpty_raw() -> openpty().
>> In addition, the amaster and the aslave has been dereferenced at the beginning
>> of the openpty(). So the checks on amaster and aslave in the openpty() are redundant.
>>
>> Reported-by: Euler Robot <euler.robot@huawei.com>
>> Signed-off-by: Alex Chen <alex.chen@huawei.com>
> 
> This function is trying to match the BSD/glibc openpty()
> function, so the thing to check here is not QEMU's specific
> current usage but the API specification for openpty():
> https://www.gnu.org/software/libc/manual/html_node/Pseudo_002dTerminal-Pairs.html
> https://www.freebsd.org/cgi/man.cgi?query=openpty
> 
> The spec says that name, termp and winp can all be
> NULL, but it doesn't say this for amaster and aslave,
> so indeed the change in this patch is the correct one.
> 
>> ---
>>  util/qemu-openpty.c | 7 +++----
>>  1 file changed, 3 insertions(+), 4 deletions(-)
>>
>> diff --git a/util/qemu-openpty.c b/util/qemu-openpty.c
>> index eb17f5b0bc..427f43a769 100644
>> --- a/util/qemu-openpty.c
>> +++ b/util/qemu-openpty.c
>> @@ -80,10 +80,9 @@ static int openpty(int *amaster, int *aslave, char *name,
>>              (termp != NULL && tcgetattr(sfd, termp) < 0))
>>                  goto err;
>>
>> -        if (amaster)
>> -                *amaster = mfd;
>> -        if (aslave)
>> -                *aslave = sfd;
>> +        *amaster = mfd;
>> +        *aslave = sfd;
>> +
>>          if (winp)
>>                  ioctl(sfd, TIOCSWINSZ, winp);
> 
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> 
> though you might like to mention in the commit message that
> the openpty() API doesn't allow NULL amaster or aslave
> arguments.
>

Thanks for your review, I will add this description to my commit message in my patch V2.
In addition, since the amaster and the aslave are not allow to be NULL,
do we need to check that the amaster and the aslave are NULL in the beginning of the openpty()?
such as this modification:

diff --git a/util/qemu-openpty.c b/util/qemu-openpty.c
index eb17f5b0bc..1aadd39395 100644
--- a/util/qemu-openpty.c
+++ b/util/qemu-openpty.c
@@ -61,6 +61,9 @@ static int openpty(int *amaster, int *aslave, char *name,
         const char *slave;
         int mfd = -1, sfd = -1;

+        if (!amaster || !aslave)
+                goto err;
+
         *amaster = *aslave = -1;

         mfd = open("/dev/ptmx", O_RDWR | O_NOCTTY);
@@ -80,10 +83,9 @@ static int openpty(int *amaster, int *aslave, char *name,
             (termp != NULL && tcgetattr(sfd, termp) < 0))
                 goto err;

-        if (amaster)
-                *amaster = mfd;
-        if (aslave)
-                *aslave = sfd;
+        *amaster = mfd;
+        *aslave = sfd;
+
         if (winp)
                 ioctl(sfd, TIOCSWINSZ, winp);

@@ -92,7 +94,8 @@ static int openpty(int *amaster, int *aslave, char *name,
 err:
         if (sfd != -1)
                 close(sfd);
-        close(mfd);
+        if (mfd != -1)
+                close(mfd);
         return -1;
 }
 #endif
-- 
2.19.1

Thanks,
Alex


