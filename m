Return-Path: <SRS0=huOX=VG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63646C606B0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 09:50:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3ADFE214AF
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 09:50:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3ADFE214AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48180 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkmlg-0002jV-H7
	for qemu-devel@archiver.kernel.org; Tue, 09 Jul 2019 05:50:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49217)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <palmer@dabbelt.com>) id 1hkmkL-00029D-C9
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 05:49:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1hkmkJ-0002PA-BT
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 05:49:12 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:38669)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1hkmkH-0002Cw-UD
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 05:49:10 -0400
Received: by mail-lf1-f67.google.com with SMTP id h28so8621189lfj.5
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2019 02:48:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
 :mime-version:content-transfer-encoding;
 bh=88dB74LrdlmRR54RcqZMhu/hZ90dwrhWL2qyOHIbZ1Y=;
 b=bV6Tp/dfCqUMZ32/eO3wIUFRpccaL7M4ZQpA5SCHUD63GdSZy1HsvizhbNUFz7fx6V
 SgrjRY8KqumfZzlY4cvyqDPgbPz0QfSUrP7Rf2h2G1J35+07UeG2Zy0qRVTaUxU6dRg1
 uZ/mMGjAw/euQ2aMjiLn6xTRzOZA9wazOTe36DHEsRVswnC+hMMfY8tDng9NQA0cMaG8
 tPZM49YRY6WoZVX152mg9Y8tWXs2OkjwTMOYnXLVCyKzvIzImH8soqcAU/FZ9ZKos4Ke
 VjcW2eVR+iWkmaGU3qU5QXIUXEmyb+YOowlw9tV62kqb9lsllRw/uecTWTgBNbALOFyF
 JisQ==
X-Gm-Message-State: APjAAAXSngOPN2drUXC8BqniZUVZzTBQvUYaP2mQ1MbuM6OcvQa9Hq6/
 EgqF7IR4AUHIYJGzVlH/jryckQ==
X-Google-Smtp-Source: APXvYqxw8E2ikxdIIoACspJd1z1W9Jwn5yT7ytU/1eYuDeYBIR+sdNYlQViXRpZHH5BgQwYFQynvDA==
X-Received: by 2002:a19:f819:: with SMTP id a25mr9055459lff.183.1562665734588; 
 Tue, 09 Jul 2019 02:48:54 -0700 (PDT)
Received: from localhost ([134.17.27.127])
 by smtp.gmail.com with ESMTPSA id v22sm3239669lfe.49.2019.07.09.02.48.52
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 09 Jul 2019 02:48:53 -0700 (PDT)
Date: Tue, 09 Jul 2019 02:48:53 -0700 (PDT)
X-Google-Original-Date: Tue, 09 Jul 2019 02:48:50 PDT (-0700)
In-Reply-To: <1560525351-590-1-git-send-email-bmeng.cn@gmail.com>
From: Palmer Dabbelt <palmer@sifive.com>
To: bmeng.cn@gmail.com
Message-ID: <mhng-4825dce4-e510-41cd-b97c-0e599d6a2369@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.167.67
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

Poking around the hardware side, it looks like we're silently ignoring all
codes aside from 0x3333 and 0x5555.  As a result there's really no way to test
if this added reset is going to work, so this should be a "sifive,test1"
instead of a "sifive,test0".  It's backwards compatible, so the compat string
in the device trees should look something like

    compatible = "sifive,test1", "sifive,test0";

With that it should be fine, pending the change to our hardware to reserve this
as an error code within "sifive,test0" devices.

Do you mind also submitting a device tree binding to Linux that describes this
device?  That way we can all stay on the same page about what the pair of
interfaces do.

Thanks!

