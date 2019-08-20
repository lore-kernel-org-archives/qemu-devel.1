Return-Path: <SRS0=VgPO=WQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E14CC3A589
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 18:46:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EA7022DA7
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 18:46:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tuuBvr4A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EA7022DA7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40468 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i099b-0004y9-JD
	for qemu-devel@archiver.kernel.org; Tue, 20 Aug 2019 14:46:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33804)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1i097O-0004Qp-PF
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 14:44:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1i097N-0006wJ-My
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 14:44:30 -0400
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:41823)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1i097N-0006w3-DQ; Tue, 20 Aug 2019 14:44:29 -0400
Received: by mail-lj1-x244.google.com with SMTP id m24so6088190ljg.8;
 Tue, 20 Aug 2019 11:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=b7NnqSJ+WmmmeF092H0RreZ/saSRTH8UMqRQVH6Kx9g=;
 b=tuuBvr4AkC4AjrqS9MkOu12IAyHssXMfTPuYc+kZHzJelEAp1QI6pXzNk9yQNCbqJ/
 WtferDU2VrVaFk39oK52LNkKsdCjP8tpGvNkDume/67mTjdQD99SxwCzbSPXmBruXMGO
 IzS4QFdqwHp9LPKe6GcUXtDNmb2tOrzWb8cj2HKgRh80mkisyDsTRbJJ9Ak3ClWWWWEc
 vlJWpUI8pJdeJbkgzjr+LtR5xwWIArOz2x5bx5QOBQWdJRJfhNgV+y6oh8dESboW/yUo
 JZS6Lg+7t2xN4jh3AVYR7GOFHdA9QCfICqVxschqj5yY4cQzQ9TcD1/GI4ryXzUWoRzw
 6Ixg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=b7NnqSJ+WmmmeF092H0RreZ/saSRTH8UMqRQVH6Kx9g=;
 b=PNapilOScUCRuVAGtgXhDSiY23AiSL5EDblGU7llDNCFQ9BpRTG74ziX/wGMn7YoU+
 AYRBcCzu9ONoIHmU9//EBUoVkYqUGjSa/nggZHT3x7I3kQxkbraBQa73GX8y9yC0WuFG
 GkwB5DmYwndywoIA3gGdf/FM+eNBL+RPTP2nvh6qctYZR7DgTgSnVQgVdknrIb2eOF6s
 1G5IZYTTC4tyze/8fieSLvf6CTEYIachMykdOFE1YPYzEtiOwfbE7TKI4HiiOZMH8Fiw
 clJteQL5pCGUnghH76d6WVdfuFZDkXB6zZb61BhSFu2nVhtbbrth5ECp9J797sWpiCPQ
 wJOQ==
X-Gm-Message-State: APjAAAWAGBI8/KrYDeodJxpbUZaspIIUB3jLRdZc5mfsccZ0PYNpSTT4
 Zwj0UufYL9o+MyQwM1dPviPh/VegOhE4V+Jx1Uo=
X-Google-Smtp-Source: APXvYqyeE01UJCyCBkhEDtV+8XUhR3HTp0u8UUKUw1pJegu1MJ0VW5fAI4LvSF48+xmtTwF7b1mUlIpUbRJqFb32ABs=
X-Received: by 2002:a2e:7c0b:: with SMTP id x11mr16449046ljc.85.1566326667658; 
 Tue, 20 Aug 2019 11:44:27 -0700 (PDT)
MIME-Version: 1.0
References: <1565960976-6693-1-git-send-email-bmeng.cn@gmail.com>
 <1565960976-6693-3-git-send-email-bmeng.cn@gmail.com>
In-Reply-To: <1565960976-6693-3-git-send-email-bmeng.cn@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 20 Aug 2019 11:40:26 -0700
Message-ID: <CAKmqyKMBLdPrcvFvR5x=1d=tkDYmhV7uLeXq18F7jPrQHXOUYg@mail.gmail.com>
To: Bin Meng <bmeng.cn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::244
Subject: Re: [Qemu-devel] [PATCH 2/2] riscv: Resolve full path of the given
 bios image
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmer@sifive.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Aug 16, 2019 at 6:11 AM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> At present when "-bios image" is supplied, we just use the straight
> path without searching for the configured data directories. Like
> "-bios default", we add the same logic so that "-L" actually works.
>
> Signed-off-by: Bin Meng <bmeng.cn@gmail.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

>
> ---
>
>  hw/riscv/boot.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
> index a122846..15002d3 100644
> --- a/hw/riscv/boot.c
> +++ b/hw/riscv/boot.c
> @@ -72,14 +72,14 @@ void riscv_find_and_load_firmware(MachineState *machine,
>          firmware_filename = riscv_find_firmware(default_machine_firmware);
>      } else {
>          firmware_filename = machine->firmware;
> +        if (strcmp(firmware_filename, "none")) {
> +            firmware_filename = riscv_find_firmware(firmware_filename);
> +        }
>      }
>
>      if (strcmp(firmware_filename, "none")) {
>          /* If not "none" load the firmware */
>          riscv_load_firmware(firmware_filename, firmware_load_addr);
> -    }
> -
> -    if (!strcmp(machine->firmware, "default")) {
>          g_free(firmware_filename);
>      }
>  }
> --
> 2.7.4
>
>

