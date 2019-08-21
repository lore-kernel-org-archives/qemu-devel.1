Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12EE4C3A59B
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 10:23:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D880F22DD3
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 10:23:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D880F22DD3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46669 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0NmT-0007bn-Vp
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 06:23:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44802)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1i0Nlr-0007C3-Sd
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 06:23:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1i0Nlq-0000DS-8g
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 06:23:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:9396)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1i0Nlq-0000DC-1C
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 06:23:14 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C5561C056808
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 10:23:12 +0000 (UTC)
Received: by mail-wr1-f72.google.com with SMTP id w11so1006136wru.17
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 03:23:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Hn3+ViBKomI0554PJ3OiEYfP6EDlAXuiCNaobWDJqVc=;
 b=tC2S3dPTf9IHKj/CGfFExtlZfY9Wd6J6NNxgHpLxEE9oDugZV5tKZsyUMtxoYJCSC9
 VSjO7mrmzYo1Eo5lKrEzuevYyPeyHD/Z+C2fGcRknAIwMYGTRjWBtZY6jIKBqTqi2R9q
 FEAdcDYWRTsJl5API2dkonbv6Hc3RRW6t9SQgDDvyyIyLW4KkYtYgmr63sbjTUiQFj2i
 gd48z268h18Grg6f69FChUuq4dU0EZdqaLR6sPWmwCCR6UJycn62gVz5yyw2dZTY8Kxz
 8CELBYBDfY/86+DPnIuMqLnaYfNSZkOkxXoENZXsbyA+sQekS4murcEwNav1Y88Mdu+T
 r9Fw==
X-Gm-Message-State: APjAAAW9iJC7SsQsJ9MfA6aZVby0zeQGapHhHasJQDGU+Hur7WFtBJvQ
 8PTovNd0NQAGfGJHbEgbv2a1r8i2sXPow6PzbU2KJoco0+c/kBB02hv/aY3TiOYu5owaVtyet8I
 YyU8zzqWw2pjbDDE=
X-Received: by 2002:a05:6000:152:: with SMTP id
 r18mr41781007wrx.41.1566382991584; 
 Wed, 21 Aug 2019 03:23:11 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzfhHH9PcDb0IFGLZDNJh8B4zZXtrwciDzzCK+y16MPc4HPV8v5u9E1ewdq6XasJqvRqtPyBg==
X-Received: by 2002:a05:6000:152:: with SMTP id
 r18mr41780980wrx.41.1566382991379; 
 Wed, 21 Aug 2019 03:23:11 -0700 (PDT)
Received: from [192.168.1.39] (251.red-88-10-102.dynamicip.rima-tde.net.
 [88.10.102.251])
 by smtp.gmail.com with ESMTPSA id u186sm5901444wmu.26.2019.08.21.03.23.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Aug 2019 03:23:10 -0700 (PDT)
To: Yoshinori Sato <ysato@users.sourceforge.jp>, qemu-devel@nongnu.org
References: <20190817073628.94473-1-ysato@users.sourceforge.jp>
 <20190817073628.94473-23-ysato@users.sourceforge.jp>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <4ccb8b92-8474-6238-3586-f7c68dc1670f@redhat.com>
Date: Wed, 21 Aug 2019 12:23:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190817073628.94473-23-ysato@users.sourceforge.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v23 22/22] target/rx: remove unused
 functions.
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
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org, imammedo@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/17/19 9:36 AM, Yoshinori Sato wrote:
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> ---
>  target/rx/monitor.c     | 38 --------------------------------------
>  target/rx/Makefile.objs |  1 -
>  2 files changed, 39 deletions(-)
>  delete mode 100644 target/rx/monitor.c
> 
> diff --git a/target/rx/monitor.c b/target/rx/monitor.c
> deleted file mode 100644
> index 5d7a1e58b5..0000000000
> --- a/target/rx/monitor.c
> +++ /dev/null

Why not squash it in your patch #06 "target/rx: CPU definition"?

If you are OK with this suggestion and there is no more comment on this
series, the maintainer willing to take your series can probably do that
for you (no need to repost!).

> @@ -1,38 +0,0 @@
> -/*
> - * QEMU monitor
> - *
> - * Copyright (c) 2003-2004 Fabrice Bellard
> - *
> - * Permission is hereby granted, free of charge, to any person obtaining a copy
> - * of this software and associated documentation files (the "Software"), to deal
> - * in the Software without restriction, including without limitation the rights
> - * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
> - * copies of the Software, and to permit persons to whom the Software is
> - * furnished to do so, subject to the following conditions:
> - *
> - * The above copyright notice and this permission notice shall be included in
> - * all copies or substantial portions of the Software.
> - *
> - * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> - * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> - * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
> - * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> - * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
> - * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
> - * THE SOFTWARE.
> - */
> -#include "qemu/osdep.h"
> -#include "cpu.h"
> -#include "monitor/monitor.h"
> -#include "monitor/hmp-target.h"
> -#include "hmp.h"
> -
> -void hmp_info_tlb(Monitor *mon, const QDict *qdict)
> -{
> -    CPUArchState *env = mon_get_cpu_env();
> -
> -    if (!env) {
> -        monitor_printf(mon, "No CPU available\n");
> -        return;
> -    }
> -}
> diff --git a/target/rx/Makefile.objs b/target/rx/Makefile.objs
> index aa6f2d2d6c..a0018d5bc5 100644
> --- a/target/rx/Makefile.objs
> +++ b/target/rx/Makefile.objs
> @@ -1,5 +1,4 @@
>  obj-y += translate.o op_helper.o helper.o cpu.o gdbstub.o disas.o
> -obj-$(CONFIG_SOFTMMU) += monitor.o
>  
>  DECODETREE = $(SRC_PATH)/scripts/decodetree.py
>  
> 

