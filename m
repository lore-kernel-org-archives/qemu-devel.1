Return-Path: <SRS0=ZEKs=WJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AA6BC433FF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 13:06:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CC2D206C2
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 13:06:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CC2D206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52276 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxWVV-0008WI-H0
	for qemu-devel@archiver.kernel.org; Tue, 13 Aug 2019 09:06:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56650)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hxWV1-00086L-IE
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 09:06:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hxWV0-0003tm-I1
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 09:06:03 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50205)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hxWV0-0003tO-C3
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 09:06:02 -0400
Received: by mail-wm1-f68.google.com with SMTP id v15so1455345wml.0
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2019 06:06:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=er5CioLV9Yb8Z57pbegotoK7UGycsPbrWboLu8pnWhM=;
 b=F5XYcCs7hXcQzN5CSUkI+lxXB60Y6y6Qq1+5yZXlYujf6bjSZMm6tabfyTRMSHnoLU
 nhlNkjo4QW5ospB0C63F0uzSVxL7GxGoACTP9iVUinzmBJMgcQMDa563Z7wAu4vuVHfC
 9mGxIPfXQ7Jl1ps4yfb0RHcjxLrwqCZQjLivOqDV4yhmLHY1LVJMHTA1CP54IKDsMf2H
 YeQ1khVOr2A1JTzrQ9GpVfU7CW+Ph4GOgyiIigvwROVQ5L9uU0Or6TyY9/AKhXs5f12J
 i2+aOH0umeQ9wwm6IrAL8hhUT0+7szDlnwaAl0y4Tpdf+T36HIqfUpLFQOko8yvV0Iwr
 rmbA==
X-Gm-Message-State: APjAAAVL4hjIGzUaiSRomnZJh9zR50DlAhwsvDaEXoNJGfseeuUEmJsj
 vrVxfhMDxOcwZFipu80LkS+1iA==
X-Google-Smtp-Source: APXvYqxn2GluI0c3s2caziqTikBNQrjY9hggMlf/XivWjoD0Pn4dOTQHXhc/HpCsrr2pI7rdFMbZAQ==
X-Received: by 2002:a1c:f914:: with SMTP id x20mr3209934wmh.142.1565701561172; 
 Tue, 13 Aug 2019 06:06:01 -0700 (PDT)
Received: from [192.168.1.35] (251.red-88-10-102.dynamicip.rima-tde.net.
 [88.10.102.251])
 by smtp.gmail.com with ESMTPSA id i66sm2325328wmi.11.2019.08.13.06.05.59
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Tue, 13 Aug 2019 06:06:00 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20190813124946.25322-1-alex.bennee@linaro.org>
 <20190813124946.25322-13-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <f60d8934-f6b1-7619-dc2a-062cc769fbfc@redhat.com>
Date: Tue, 13 Aug 2019 15:05:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190813124946.25322-13-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.68
Subject: Re: [Qemu-devel] [PATCH v3 12/13] target/riscv: rationalise
 softfloat includes
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
Cc: "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmer@sifive.com>,
 Richard Henderson <richard.henderson@linaro.org>, armbru@redhat.com,
 Alistair Francis <Alistair.Francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/13/19 2:49 PM, Alex Bennée wrote:
> We should avoid including the whole of softfloat headers in cpu.h and
> explicitly include it only where we will be calling softfloat
> functions. We can use the -types.h and -helpers.h in cpu.h for the few
> bits that are global.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  target/riscv/cpu.c        | 1 +
>  target/riscv/cpu.h        | 2 +-
>  target/riscv/fpu_helper.c | 1 +
>  3 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index f8d07bd20ad..6d52f97d7c3 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -27,6 +27,7 @@
>  #include "qemu/error-report.h"
>  #include "hw/qdev-properties.h"
>  #include "migration/vmstate.h"
> +#include "fpu/softfloat-helpers.h"
>  
>  /* RISC-V CPU definitions */
>  
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 0adb307f329..240b31e2ebb 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -22,7 +22,7 @@
>  
>  #include "qom/cpu.h"
>  #include "exec/cpu-defs.h"
> -#include "fpu/softfloat.h"
> +#include "fpu/softfloat-types.h"
>  
>  #define TCG_GUEST_DEFAULT_MO 0
>  
> diff --git a/target/riscv/fpu_helper.c b/target/riscv/fpu_helper.c
> index b4f818a6465..0b79562a690 100644
> --- a/target/riscv/fpu_helper.c
> +++ b/target/riscv/fpu_helper.c
> @@ -21,6 +21,7 @@
>  #include "qemu/host-utils.h"
>  #include "exec/exec-all.h"
>  #include "exec/helper-proto.h"
> +#include "fpu/softfloat.h"
>  
>  target_ulong riscv_cpu_get_fflags(CPURISCVState *env)
>  {
> 

