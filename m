Return-Path: <SRS0=nSo8=TI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3434C04A6B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 16:07:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B914A20989
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 16:07:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B914A20989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39881 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOP5w-0007A8-KL
	for qemu-devel@archiver.kernel.org; Wed, 08 May 2019 12:07:00 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49704)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hOP4k-0006Re-8I
	for qemu-devel@nongnu.org; Wed, 08 May 2019 12:05:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hOP4i-0007sm-Nm
	for qemu-devel@nongnu.org; Wed, 08 May 2019 12:05:46 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53086)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hOP4i-0007sS-Gd
	for qemu-devel@nongnu.org; Wed, 08 May 2019 12:05:44 -0400
Received: by mail-wm1-f67.google.com with SMTP id o25so3980464wmf.2
	for <qemu-devel@nongnu.org>; Wed, 08 May 2019 09:05:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=zaZWQXMy/p9Ke4ybFELBTE+FD7sw84ak747pfYq6sMw=;
	b=X8X6qHwuNtrtzO1SZ1ixK0RjYLH0EP0XU2oFXUmfb4Yqnh5mLKVDqAX3napfejahzF
	LlVGWo7DYxzCYg5YbER8FvcR12uccHLO3yMJKNFDhzUNax1owcgBif0LL966REyQAaYy
	+uKuCvsS7VbHffPKTQoFO3Aa6xEPkzhbC/VAdNWs8yQ39D3btqiKkvY2lU+mFyvGQ/+n
	830cKSj+BW26P9Mya5/W5ARMFrlcFHfBxwdQKJRd1k8vd1Hc0kx5AzIyptrce4tDqR+f
	xuPifc/Wd61Cpvo8PCmKFFam0WF0Gx/zhofJ1gov7LNwz9Xi0xRQwP1nyHK6J1HlUXql
	eUvA==
X-Gm-Message-State: APjAAAUKWMePwEvJXzT17Er03hgDeX2j9fZIdWLXKy4PtbwCh/qnATQN
	xq9DpGspNDy6vCJZ2PafzhNnkw==
X-Google-Smtp-Source: APXvYqyIwYdJknauB4sZ3nutBi4zGhsOJaQkKuUBQYCR9BOuI5NSEjbZ0Hwglt3HFKcKzdq8nllh0w==
X-Received: by 2002:a7b:cb4e:: with SMTP id v14mr3526874wmj.52.1557331543516; 
	Wed, 08 May 2019 09:05:43 -0700 (PDT)
Received: from [10.201.33.53] ([195.166.127.210])
	by smtp.gmail.com with ESMTPSA id
	o6sm36592006wrh.55.2019.05.08.09.05.42
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Wed, 08 May 2019 09:05:42 -0700 (PDT)
To: Yoshinori Sato <ysato@users.sourceforge.jp>, qemu-devel@nongnu.org
References: <20190508145611.107133-1-ysato@users.sourceforge.jp>
	<20190508145611.107133-6-ysato@users.sourceforge.jp>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <6bdbe740-e901-057f-8578-42fe909d617d@redhat.com>
Date: Wed, 8 May 2019 18:05:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190508145611.107133-6-ysato@users.sourceforge.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.67
Subject: Re: [Qemu-devel] [PATCH v10 05/13] target/rx: Miscellaneous files
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/8/19 4:56 PM, Yoshinori Sato wrote:
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> ---
>  target/rx/gdbstub.c     | 112 ++++++++++++++++++++++++++++++++++++++++++++++++
>  target/rx/monitor.c     |  38 ++++++++++++++++
>  target/rx/Makefile.objs |  12 ++++++
>  3 files changed, 162 insertions(+)
>  create mode 100644 target/rx/gdbstub.c
>  create mode 100644 target/rx/monitor.c
>  create mode 100644 target/rx/Makefile.objs
> 
> diff --git a/target/rx/gdbstub.c b/target/rx/gdbstub.c
> new file mode 100644
> index 0000000000..d76ca52e82
> --- /dev/null
> +++ b/target/rx/gdbstub.c
> @@ -0,0 +1,112 @@
> +/*
> + * RX gdb server stub
> + *
> + * Copyright (c) 2019 Yoshinori Sato
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2 or later, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License along with
> + * this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +#include "qemu/osdep.h"
> +#include "qemu-common.h"
> +#include "cpu.h"
> +#include "exec/gdbstub.h"
> +
> +int rx_cpu_gdb_read_register(CPUState *cs, uint8_t *mem_buf, int n)
> +{
> +    RXCPU *cpu = RXCPU(cs);
> +    CPURXState *env = &cpu->env;
> +
> +    switch (n) {
> +    case 0 ... 15:
> +        return gdb_get_regl(mem_buf, env->regs[n]);
> +    case 16:
> +        return gdb_get_regl(mem_buf, (env->psw_u) ? env->regs[0] : env->usp);
> +    case 17:
> +        return gdb_get_regl(mem_buf, (!env->psw_u) ? env->regs[0] : env->isp);
> +    case 18:
> +        return gdb_get_regl(mem_buf, rx_cpu_pack_psw(env));
> +    case 19:
> +        return gdb_get_regl(mem_buf, env->pc);
> +    case 20:
> +        return gdb_get_regl(mem_buf, env->intb);
> +    case 21:
> +        return gdb_get_regl(mem_buf, env->bpsw);
> +    case 22:
> +        return gdb_get_regl(mem_buf, env->bpc);
> +    case 23:
> +        return gdb_get_regl(mem_buf, env->fintv);
> +    case 24:
> +        return gdb_get_regl(mem_buf, env->fpsw);
> +    case 25:
> +        return 0;
> +    }
> +    return 0;
> +}
> +
> +int rx_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
> +{
> +    RXCPU *cpu = RXCPU(cs);
> +    CPURXState *env = &cpu->env;
> +    uint32_t psw;
> +    switch (n) {
> +    case 0 ... 15:
> +        env->regs[n] = ldl_p(mem_buf);
> +        if (n == 0) {
> +            if (env->psw_u) {
> +                env->usp = env->regs[0];
> +            } else {
> +                env->isp = env->regs[0];
> +            }
> +        }
> +        break;
> +    case 16:
> +        env->usp = ldl_p(mem_buf);
> +        if (env->psw_u) {
> +            env->regs[0] = ldl_p(mem_buf);
> +        }
> +        break;
> +    case 17:
> +        env->isp = ldl_p(mem_buf);
> +        if (!env->psw_u) {
> +            env->regs[0] = ldl_p(mem_buf);
> +        }
> +        break;
> +    case 18:
> +        psw = ldl_p(mem_buf);
> +        rx_cpu_unpack_psw(env, psw, 1);
> +        break;
> +    case 19:
> +        env->pc = ldl_p(mem_buf);
> +        break;
> +    case 20:
> +        env->intb = ldl_p(mem_buf);
> +        break;
> +    case 21:
> +        env->bpsw = ldl_p(mem_buf);
> +        break;
> +    case 22:
> +        env->bpc = ldl_p(mem_buf);
> +        break;
> +    case 23:
> +        env->fintv = ldl_p(mem_buf);
> +        break;
> +    case 24:
> +        env->fpsw = ldl_p(mem_buf);
> +        break;
> +    case 25:
> +        return 8;
> +    default:
> +        return 0;
> +    }
> +
> +    return 4;
> +}
> diff --git a/target/rx/monitor.c b/target/rx/monitor.c
> new file mode 100644
> index 0000000000..5d7a1e58b5
> --- /dev/null
> +++ b/target/rx/monitor.c
> @@ -0,0 +1,38 @@
> +/*
> + * QEMU monitor
> + *
> + * Copyright (c) 2003-2004 Fabrice Bellard
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a copy
> + * of this software and associated documentation files (the "Software"), to deal
> + * in the Software without restriction, including without limitation the rights
> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
> + * copies of the Software, and to permit persons to whom the Software is
> + * furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
> + * THE SOFTWARE.
> + */
> +#include "qemu/osdep.h"
> +#include "cpu.h"
> +#include "monitor/monitor.h"
> +#include "monitor/hmp-target.h"
> +#include "hmp.h"
> +
> +void hmp_info_tlb(Monitor *mon, const QDict *qdict)
> +{
> +    CPUArchState *env = mon_get_cpu_env();
> +
> +    if (!env) {
> +        monitor_printf(mon, "No CPU available\n");
> +        return;
> +    }
> +}


^ I'd add those 3 files in patch #3 "CPU definitions"

> diff --git a/target/rx/Makefile.objs b/target/rx/Makefile.objs
> new file mode 100644
> index 0000000000..aa6f2d2d6c
> --- /dev/null
> +++ b/target/rx/Makefile.objs
> @@ -0,0 +1,12 @@
> +obj-y += translate.o op_helper.o helper.o cpu.o gdbstub.o disas.o
> +obj-$(CONFIG_SOFTMMU) += monitor.o
> +
> +DECODETREE = $(SRC_PATH)/scripts/decodetree.py
> +
> +target/rx/decode.inc.c: \
> +  $(SRC_PATH)/target/rx/insns.decode $(DECODETREE)
> +	$(call quiet-command,\
> +	  $(PYTHON) $(DECODETREE) --varinsnwidth 32 -o $@ $<, "GEN", $(TARGET_DIR)$@)
> +
> +target/rx/translate.o: target/rx/decode.inc.c
> +target/rx/disas.o: target/rx/decode.inc.c
> 

^ this one belongs to patch #1 "TCG translation"

