Return-Path: <SRS0=LbB6=TD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EED0C43219
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 16:07:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A64E2075E
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 16:07:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SAWpR6SY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A64E2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43000 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMaiq-0005nN-5i
	for qemu-devel@archiver.kernel.org; Fri, 03 May 2019 12:07:40 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41689)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hMai1-0005UF-SF
	for qemu-devel@nongnu.org; Fri, 03 May 2019 12:06:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hMahz-0001wk-Uf
	for qemu-devel@nongnu.org; Fri, 03 May 2019 12:06:49 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:42118)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hMahz-0001vc-Lh
	for qemu-devel@nongnu.org; Fri, 03 May 2019 12:06:47 -0400
Received: by mail-wr1-x444.google.com with SMTP id l2so8530911wrb.9
	for <qemu-devel@nongnu.org>; Fri, 03 May 2019 09:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=references:user-agent:from:to:cc:subject:in-reply-to:date
	:message-id:mime-version:content-transfer-encoding;
	bh=Fh2yFaW6fF1B6IQwQvMb+9i1sRDjEer1p6eheg/w5Q0=;
	b=SAWpR6SYPT3wXUMW9mguTNgEISLw/qMMgmqFwUR3Iu3IpEHWJq1RH76YIARRNJdIO3
	Le7FW3TdZura146jCzI7SnTKgZ/ifHkgbFL1AVpvm60cigmXB89y08JHLuOlHhq9dsIR
	xR2a9tpchEJt0mpeU/bZtDC1nN4cjTp67jEAE/fRhOJ9M/ef5NbM8D82FzLgpfS78qGG
	7C9MvvmiPJjEB+VNhBdIIJnD5xzozTgFjr6ikk1/oNfbR355HijjjIaT4BItNKaWS7YE
	l147MR7gQZHV0yV0hKaBNG7A8QVXHr5ow79ExjGKlr2hFRY4h6l3+vIyO24RcCPXlIIf
	4Muw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:cc:subject
	:in-reply-to:date:message-id:mime-version:content-transfer-encoding;
	bh=Fh2yFaW6fF1B6IQwQvMb+9i1sRDjEer1p6eheg/w5Q0=;
	b=p+wycnaLaAkw4AvDHW5PsRM7K+aCIj5Nqhr1+kl84o0yoA9kLXRMr+6uWZe2nrSfu+
	f7S6IJKn6pwCPGaHSBW6KfqYhDXir4gLp3NDQPHaR/wjeAFzqW0yks0iB4qdsdnmJvgm
	HSa8bfqtgs5DLfgg+F8L6eUFNbtjDhBGTML1Ag4AwRGwGyFVk1MrRy1GCw+VgxUUult8
	blSVEX4TOJHcwjdc/om5KpNm0gIon9KmpYsPn0ovE/XqvaI45naQZrOymY2HaiPrDDIF
	IsY0hhZRZPNDNft0PUZDwzDLzNlDm9092iaM6sWR5CYIGPhcOToSDroHgn454hxVC3d5
	NskA==
X-Gm-Message-State: APjAAAXRq+DtH7K+cZlq7rPQ7NCs8YCCim9wBqJIZwhG+r3/5nK3TLfT
	0FPd1JTVkEtj9/1M0SCVar+7EnZvZe8=
X-Google-Smtp-Source: APXvYqw5ylqSypuMCpQpR3uAnpSPbP72upirYtjrX9Ln5X4DwbUGI7YJs5DCyYjYsEujL/1h7SnQvQ==
X-Received: by 2002:a5d:530c:: with SMTP id e12mr2095643wrv.290.1556899605337; 
	Fri, 03 May 2019 09:06:45 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	t81sm3167205wmb.47.2019.05.03.09.06.44
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Fri, 03 May 2019 09:06:44 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 52B591FF87;
	Fri,  3 May 2019 17:06:44 +0100 (BST)
References: <20190502143409.59600-1-ysato@users.sourceforge.jp>
	<20190502143409.59600-6-ysato@users.sourceforge.jp>
User-agent: mu4e 1.3.1; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
In-reply-to: <20190502143409.59600-6-ysato@users.sourceforge.jp>
Date: Fri, 03 May 2019 17:06:44 +0100
Message-ID: <87ftpv4j57.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: Re: [Qemu-devel] [PATCH RFC v8 05/12] target/rx: Miscellaneous files
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
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org,
	Yoshinori Sato <ysato@users.sourceforge.jp>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190503160644.5CmCHwFbQyl7Y0TD-0yAOPXw4poxZyBt-X9g0OMXf24@z>


Yoshinori Sato <ysato@users.sourceforge.jp> writes:

> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> ---
>  target/rx/gdbstub.c     | 112 ++++++++++++++++++++++++++++++++++++++++++=
++++++
>  target/rx/monitor.c     |  38 ++++++++++++++++
>  target/rx/Makefile.objs |  11 +++++
>  3 files changed, 161 insertions(+)
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
> + * This program is free software; you can redistribute it and/or modify =
it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2 or later, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License=
 for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License alo=
ng with
> + * this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +#include "qemu/osdep.h"
> +#include "qemu-common.h"
> +#include "cpu.h"
> +#include "exec/gdbstub.h"
> +
> +int rx_cpu_gdb_read_register(CPUState *cs, uint8_t *mem_buf, int n)
> +{
> +    RXCPU *cpu =3D RXCPU(cs);
> +    CPURXState *env =3D &cpu->env;
> +
> +    switch (n) {
> +    case 0 ... 15:
> +        return gdb_get_regl(mem_buf, env->regs[n]);
> +    case 16:
> +        return gdb_get_regl(mem_buf, (env->psw_u) ? env->regs[0] : env->=
usp);
> +    case 17:
> +        return gdb_get_regl(mem_buf, (!env->psw_u) ? env->regs[0] : env-=
>isp);
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
> +    RXCPU *cpu =3D RXCPU(cs);
> +    CPURXState *env =3D &cpu->env;
> +    uint32_t psw;
> +    switch (n) {
> +    case 0 ... 15:
> +        env->regs[n] =3D ldl_p(mem_buf);
> +        if (n =3D=3D 0) {
> +            if (env->psw_u) {
> +                env->usp =3D env->regs[0];
> +            } else {
> +                env->isp =3D env->regs[0];
> +            }
> +        }
> +        break;
> +    case 16:
> +        env->usp =3D ldl_p(mem_buf);
> +        if (env->psw_u) {
> +            env->regs[0] =3D ldl_p(mem_buf);
> +        }
> +        break;
> +    case 17:
> +        env->isp =3D ldl_p(mem_buf);
> +        if (!env->psw_u) {
> +            env->regs[0] =3D ldl_p(mem_buf);
> +        }
> +        break;
> +    case 18:
> +        psw =3D ldl_p(mem_buf);
> +        rx_cpu_unpack_psw(env, psw, 1);
> +        break;
> +    case 19:
> +        env->pc =3D ldl_p(mem_buf);
> +        break;
> +    case 20:
> +        env->intb =3D ldl_p(mem_buf);
> +        break;
> +    case 21:
> +        env->bpsw =3D ldl_p(mem_buf);
> +        break;
> +    case 22:
> +        env->bpc =3D ldl_p(mem_buf);
> +        break;
> +    case 23:
> +        env->fintv =3D ldl_p(mem_buf);
> +        break;
> +    case 24:
> +        env->fpsw =3D ldl_p(mem_buf);
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
> + * Permission is hereby granted, free of charge, to any person obtaining=
 a copy
> + * of this software and associated documentation files (the "Software"),=
 to deal
> + * in the Software without restriction, including without limitation the=
 rights
> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or =
sell
> + * copies of the Software, and to permit persons to whom the Software is
> + * furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be includ=
ed in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHA=
LL
> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR =
OTHER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISI=
NG FROM,
> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S IN
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
> +    CPUArchState *env =3D mon_get_cpu_env();
> +
> +    if (!env) {
> +        monitor_printf(mon, "No CPU available\n");
> +        return;
> +    }
> +}
> diff --git a/target/rx/Makefile.objs b/target/rx/Makefile.objs
> new file mode 100644
> index 0000000000..f63e1ca43f
> --- /dev/null
> +++ b/target/rx/Makefile.objs
> @@ -0,0 +1,11 @@
> +obj-y +=3D translate.o op_helper.o helper.o cpu.o gdbstub.o disas.o
> +obj-$(CONFIG_SOFTMMU) +=3D monitor.o
> +
> +DECODETREE =3D $(SRC_PATH)/scripts/decodetree.py
> +
> +target/rx/decode.inc.c: \
> +  $(SRC_PATH)/target/rx/insns.decode $(DECODETREE)
> +	$(call quiet-command,\
> +	  $(PYTHON) $(DECODETREE) --varinsnwidth 32 -o $@ $<, "GEN",
> $(TARGET_DIR)$@)

This doesn't work for me:

  GEN     rx-softmmu/target/rx/decode.inc.c
error: (GetoptError('option --varinsnwidth not recognized', 'varinsnwidth')=
,)

So are you decode.inc.c stale from some work in progress version of
decodetree?

Also this stanza will be need to be introduced in patch 04 as the
disassembler needs its files.

> +
> +target/rx/translate.o: target/rx/decode.inc.c


--
Alex Benn=C3=A9e

