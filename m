Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22E60C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 15:35:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCAE2206A5
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 15:35:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gPBof4It"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCAE2206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36542 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZFt2-0004p8-07
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 11:35:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52506)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jZFs5-0004BK-4w; Thu, 14 May 2020 11:34:05 -0400
Received: from mail-yb1-xb41.google.com ([2607:f8b0:4864:20::b41]:35762)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jZFs4-00039a-9w; Thu, 14 May 2020 11:34:04 -0400
Received: by mail-yb1-xb41.google.com with SMTP id o134so1765727ybg.2;
 Thu, 14 May 2020 08:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=TEDrXDf+KI3VG7KocfZ6F0NF5hM/HBsEz+ZxvfQYBoE=;
 b=gPBof4Itgj6H2zc6/5e0I4l2ZEeI0GrLRQPOYhcMLGbGBJYze3GUG2DMmsidnLToTA
 ONdqPV6rWHUdB8aemVEmpDpFcy01Gsq2LQbLov7VX4sX+M9W2aXcwlQ/a5flxe9YQ+eB
 65CUeD3txQu3kbITQB2qJPxICG5pO7+dan95MgHmsw3DvJF41gnRnFPrmvu8sO5wUKLs
 1Pjwpm5sLhIR0b9XsqfmlhMtyZWSsHClMzS06KYAy8Q/x270CswlM4GVkE+0PlSiu9zW
 rEgTXZnIWoFrGWOJsMmQZaBLZyVBnDrO/oEghJZHoce8eyQRNqy0baKGh5wlbA4XHi1b
 7y7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=TEDrXDf+KI3VG7KocfZ6F0NF5hM/HBsEz+ZxvfQYBoE=;
 b=ktFw1xXUZDsgPPa4D1g1X1sFDvIk9DXuiphT5+OOP8TNmNsPw+vBQkP+Y2Zoe0Pxp9
 x95Y7X+3ARRAwHS1adgQbUUMLVfciA0i54R+82WPr7IqxQBrPeJEufv4JuHYD9j86P1B
 9WE/FM+FJOM0HVQa+H38sMwZ+OGxkunSwD1Op4qQ5E5lX6c61szZ/BBzFX5Ze82PW9nV
 CzWtsmdwPVylAcRRW/TxMbrLFj9YN1CzfG/Cm8R0t9oTaz5GbOS8txxt3/8gUdGd2mSq
 xKJn2y6Ay9vkhCC0aYr+u6tqNbY72IgJ6pb3qL3rqG6G5gri+HVSABxs7UaHEnHmlwX5
 wYNg==
X-Gm-Message-State: AOAM530W/H42x0oO56P0wjV0NBPgbTEo4FziT/qV5T4hoGN6kAXdN9Aj
 azQMdS0iiQabRjGco1TkWUkT+Ft24sxQ6+ndFNk=
X-Google-Smtp-Source: ABdhPJx65JV9LlwBajQK50ZV9ZvYTClo5+TCL9FQNfBx53dHtV7GBU2mc4GXPEPJH20acibFo97yWeC5HOajiQPBgJY=
X-Received: by 2002:a25:d2d8:: with SMTP id j207mr7569586ybg.517.1589470442665; 
 Thu, 14 May 2020 08:34:02 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1588878756.git.alistair.francis@wdc.com>
 <dc10c6b220154fd448630ef7a790e5d7e59ab45a.1588878756.git.alistair.francis@wdc.com>
In-Reply-To: <dc10c6b220154fd448630ef7a790e5d7e59ab45a.1588878756.git.alistair.francis@wdc.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Thu, 14 May 2020 23:33:51 +0800
Message-ID: <CAEUhbmVMu4hov1WxafL9+8kET_Q_Q2hMi8JTnbKE78EhU4kaHQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/9] riscv/boot: Add a missing header include
To: Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b41;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yb1-xb41.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <alistair23@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, May 8, 2020 at 3:24 AM Alistair Francis
<alistair.francis@wdc.com> wrote:
>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  include/hw/riscv/boot.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/include/hw/riscv/boot.h b/include/hw/riscv/boot.h
> index 474a940ad5..9daa98da08 100644
> --- a/include/hw/riscv/boot.h
> +++ b/include/hw/riscv/boot.h
> @@ -21,6 +21,7 @@
>  #define RISCV_BOOT_H
>
>  #include "exec/cpu-defs.h"
> +#include "hw/loader.h"

Why is this needed? Currently this does not break build.

>
>  void riscv_find_and_load_firmware(MachineState *machine,
>                                    const char *default_machine_firmware,

Regards,
Bin

