Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A642DC2BA19
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 02:36:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78435206F4
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 02:36:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78435206F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39888 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jR5FN-0004u0-H5
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 22:36:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49432)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1jR5DY-00046K-Bf
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 22:34:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1jR5DV-0002rM-2S
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 22:34:26 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:60283)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jR5DU-00015Y-3G
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 22:34:24 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.07566114|-1; CH=green;
 DM=|CONTINUE|false|;
 DS=CONTINUE|ham_enroll_verification|0.00402059-0.000124981-0.995854;
 FP=0|0|0|0|0|-1|-1|-1; HT=e02c03278; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS;
 RN=9; RT=9; SR=0; TI=SMTPD_---.HLWQgsJ_1587522852; 
Received: from 30.225.208.25(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.HLWQgsJ_1587522852)
 by smtp.aliyun-inc.com(10.147.41.158);
 Wed, 22 Apr 2020 10:34:12 +0800
Subject: Re: [PATCH] linux-user/riscv: fix up struct target_ucontext definition
To: laurent@vivier.eu, riku.voipio@iki.fi
References: <20200412020830.607-1-zhiwei_liu@c-sky.com>
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
Message-ID: <f6dc4fa7-fed5-28a1-5922-68e9a0510de5@c-sky.com>
Date: Wed, 22 Apr 2020 10:34:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200412020830.607-1-zhiwei_liu@c-sky.com>
Content-Type: multipart/alternative;
 boundary="------------DE97C0F91618FBB8E244028B"
Content-Language: en-US
Received-SPF: none client-ip=121.197.200.217;
 envelope-from=zhiwei_liu@c-sky.com; helo=smtp2200-217.mail.aliyun.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/21 22:34:13
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
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
Cc: qemu-riscv@nongnu.org, richard.henderson@linaro.org,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 wxy194768@alibaba-inc.com, wenmeng_zhang@c-sky.com,
 Alistair Francis <Alistair.Francis@wdc.com>, palmer@dabbelt.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is a multi-part message in MIME format.
--------------DE97C0F91618FBB8E244028B
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Ping.

When I port RISU, I find this bug. I can't get the correct registers 
from the
struct ucontext_t parameter in the signal handler.

If you want to reproduce it, just   register a signal handler for SIGILL,
and  output an illegal instruction, such as

#include <stdio.h>
#include <stdlib.h>
#include <inttypes.h>
#include <string.h>
#include <signal.h>
#include <ucontext.h>

void sigill(int sig, siginfo_t *si, void *uc)
{
     printf("Illegal pc: %016" PRIx64 "\n",
            ((ucontext_t *)uc)->uc_mcontext.__gregs[0]);
}

static void set_sigill_handler(void (*fn) (int, siginfo_t *, void *))
{
     struct sigaction sa;
     memset(&sa, 0, sizeof(struct sigaction));

     sa.sa_sigaction = fn;
     sa.sa_flags = SA_SIGINFO;
     sigemptyset(&sa.sa_mask);
     if (sigaction(SIGILL, &sa, 0) != 0) {
         perror("sigaction");
         exit(1);
     }
}

int main()
{
     set_sigill_handler(sigill);
     asm(".dword 0x0000006b");
     return 0;
}
~

Zhiwei

On 2020/4/12 10:08, LIU Zhiwei wrote:
> As struct target_ucontext will be transfered to signal handler, it
> must keep pace with struct ucontext_t defined in Linux kernel.
>
> Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
> ---
>   linux-user/riscv/signal.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/linux-user/riscv/signal.c b/linux-user/riscv/signal.c
> index 83ecc6f799..67a95dbc7b 100644
> --- a/linux-user/riscv/signal.c
> +++ b/linux-user/riscv/signal.c
> @@ -40,8 +40,9 @@ struct target_ucontext {
>       unsigned long uc_flags;
>       struct target_ucontext *uc_link;
>       target_stack_t uc_stack;
> -    struct target_sigcontext uc_mcontext;
>       target_sigset_t uc_sigmask;
> +    uint8_t   __unused[1024 / 8 - sizeof(target_sigset_t)];
> +    struct target_sigcontext uc_mcontext QEMU_ALIGNED(16);
>   };
>   
>   struct target_rt_sigframe {


--------------DE97C0F91618FBB8E244028B
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    Ping.<br>
    <br>
    When I port RISU, I find this bug. I can't get the correct registers
    from the<br>
    struct ucontext_t parameter in the signal handler.<br>
    <br>
    If you want to reproduce it, just   register a signal handler for
    SIGILL,<br>
    and  output an illegal instruction, such as<tt><br>
    </tt>
    <pre>#include &lt;stdio.h&gt;
#include &lt;stdlib.h&gt;
#include &lt;inttypes.h&gt;
#include &lt;string.h&gt;
#include &lt;signal.h&gt;
#include &lt;ucontext.h&gt;

void sigill(int sig, siginfo_t *si, void *uc)
{
    printf("Illegal pc: %016" PRIx64 "\n",
           ((ucontext_t *)uc)-&gt;uc_mcontext.__gregs[0]);
}

static void set_sigill_handler(void (*fn) (int, siginfo_t *, void *))
{
    struct sigaction sa;
    memset(&amp;sa, 0, sizeof(struct sigaction));

    sa.sa_sigaction = fn;
    sa.sa_flags = SA_SIGINFO;
    sigemptyset(&amp;sa.sa_mask);
    if (sigaction(SIGILL, &amp;sa, 0) != 0) {
        perror("sigaction");
        exit(1);
    }
}

int main()
{
    set_sigill_handler(sigill);
    asm(".dword 0x0000006b");
    return 0;
}
~                                                                                                                                                                                                        
</pre>
    Zhiwei<br>
    <br>
    <div class="moz-cite-prefix">On 2020/4/12 10:08, LIU Zhiwei wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:20200412020830.607-1-zhiwei_liu@c-sky.com">
      <pre class="moz-quote-pre" wrap="">As struct target_ucontext will be transfered to signal handler, it
must keep pace with struct ucontext_t defined in Linux kernel.

Signed-off-by: LIU Zhiwei <a class="moz-txt-link-rfc2396E" href="mailto:zhiwei_liu@c-sky.com">&lt;zhiwei_liu@c-sky.com&gt;</a>
---
 linux-user/riscv/signal.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/linux-user/riscv/signal.c b/linux-user/riscv/signal.c
index 83ecc6f799..67a95dbc7b 100644
--- a/linux-user/riscv/signal.c
+++ b/linux-user/riscv/signal.c
@@ -40,8 +40,9 @@ struct target_ucontext {
     unsigned long uc_flags;
     struct target_ucontext *uc_link;
     target_stack_t uc_stack;
-    struct target_sigcontext uc_mcontext;
     target_sigset_t uc_sigmask;
+    uint8_t   __unused[1024 / 8 - sizeof(target_sigset_t)];
+    struct target_sigcontext uc_mcontext QEMU_ALIGNED(16);
 };
 
 struct target_rt_sigframe {
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------DE97C0F91618FBB8E244028B--

