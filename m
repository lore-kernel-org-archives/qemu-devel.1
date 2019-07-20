Return-Path: <SRS0=lwXe=VR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF6C3C7618F
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jul 2019 01:47:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97A5221872
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jul 2019 01:47:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97A5221872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49188 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoeTE-0002cI-0b
	for qemu-devel@archiver.kernel.org; Fri, 19 Jul 2019 21:47:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46260)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <palmer@dabbelt.com>) id 1hoeT1-00029R-R0
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 21:47:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1hoeT0-0006hd-QX
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 21:47:19 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33676)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1hoeT0-0006h6-LD
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 21:47:18 -0400
Received: by mail-pg1-f196.google.com with SMTP id f20so5957020pgj.0
 for <qemu-devel@nongnu.org>; Fri, 19 Jul 2019 18:47:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
 :mime-version:content-transfer-encoding;
 bh=zZtBa+arMTE0TEHA3GMV/hzGd+rV+9tr0IORX7xpj6Y=;
 b=nuVlqEV34y1XKfBe5QHMk/fT/p6+LNbFAaWMmaZvPuBtcQu+Jo1GoswsNbKGI1EGZz
 k8hE99GiacrlJelMJfv84x/VJEgND5+W8IS3fMwJs48mISdsKzLNn2RwFz5H9aAdeR/8
 JHYYp7CpgXjb7vQttcvDzfqwNOgDZk0V2OOxl4ffqWvW1vqTy270JX2Elw2nIfaeaDQx
 exUaMOXR2PsbcbFVXbU/CX9vXLPO03ZV7l++KgsDaCeJKRM8VJt7GB/R648ST6yjr8Rn
 c3T/LO7d++40GwUDejtEfsZPoE0uRtnSWMKPkNIE7RHEfwwCD/SSJLclTwRiYT/EONVS
 p5uQ==
X-Gm-Message-State: APjAAAWy0SwgIkPRrwTFIm8HufqcnI2FbrfuIilXCbllG/BuqeKCnUrJ
 6VYtDOb6/oxK9X5o+HHbpQY=
X-Google-Smtp-Source: APXvYqzAwQmKXdNFMjFYVfg1AthKc9SBqmD2nW+Xv8KxLEeNNQlRnEfxexVNv3GAIpFnzobou/tdFQ==
X-Received: by 2002:a63:360d:: with SMTP id d13mr57223466pga.80.1563587237040; 
 Fri, 19 Jul 2019 18:47:17 -0700 (PDT)
Received: from localhost ([12.206.222.5])
 by smtp.gmail.com with ESMTPSA id j128sm18094726pfg.28.2019.07.19.18.47.16
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 19 Jul 2019 18:47:16 -0700 (PDT)
Date: Fri, 19 Jul 2019 18:47:16 -0700 (PDT)
X-Google-Original-Date: Fri, 19 Jul 2019 18:46:59 PDT (-0700)
In-Reply-To: <1560525351-590-1-git-send-email-bmeng.cn@gmail.com>
From: Palmer Dabbelt <palmer@sifive.com>
To: bmeng.cn@gmail.com
Message-ID: <mhng-7207f9be-4aaa-4b0f-9832-ee6682eb5749@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.215.196
Subject: Re: [Qemu-devel] [PATCH] riscv: sifive_test: Add reset functionality
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
Cc: Alistair Francis <Alistair.Francis@wdc.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 14 Jun 2019 08:15:51 PDT (-0700), bmeng.cn@gmail.com wrote:
> This adds a reset opcode for sifive_test device to trigger a system
> reset for testing purpose.
>
> Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
> ---
>
>  hw/riscv/sifive_test.c         | 4 ++++
>  include/hw/riscv/sifive_test.h | 3 ++-
>  2 files changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/hw/riscv/sifive_test.c b/hw/riscv/sifive_test.c
> index 24a04d7..cd86831 100644
> --- a/hw/riscv/sifive_test.c
> +++ b/hw/riscv/sifive_test.c
> @@ -21,6 +21,7 @@
>  #include "qemu/osdep.h"
>  #include "hw/sysbus.h"
>  #include "qemu/module.h"
> +#include "sysemu/sysemu.h"
>  #include "target/riscv/cpu.h"
>  #include "hw/riscv/sifive_test.h"
>
> @@ -40,6 +41,9 @@ static void sifive_test_write(void *opaque, hwaddr addr,
>              exit(code);
>          case FINISHER_PASS:
>              exit(0);
> +        case FINISHER_RESET:
> +            qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
> +            return;
>          default:
>              break;
>          }
> diff --git a/include/hw/riscv/sifive_test.h b/include/hw/riscv/sifive_test.h
> index 71d4c9f..c186a31 100644
> --- a/include/hw/riscv/sifive_test.h
> +++ b/include/hw/riscv/sifive_test.h
> @@ -34,7 +34,8 @@ typedef struct SiFiveTestState {
>
>  enum {
>      FINISHER_FAIL = 0x3333,
> -    FINISHER_PASS = 0x5555
> +    FINISHER_PASS = 0x5555,
> +    FINISHER_RESET = 0x7777
>  };
>
>  DeviceState *sifive_test_create(hwaddr addr);

Reviewed-by: Palmer Dabbelt <palmer@sifive.com>

Sorry this took a while, but it's in the hardware now.  I'll merge this, but
I'm considering it a new feature so it'll be held off a bit.

Thanks!

