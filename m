Return-Path: <SRS0=PhvJ=UY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D7C7C48BD5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 09:23:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A55D20883
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 09:23:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FYmW731h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A55D20883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57846 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfhfy-0005kT-86
	for qemu-devel@archiver.kernel.org; Tue, 25 Jun 2019 05:23:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40977)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bmeng.cn@gmail.com>) id 1hfhcy-0002iP-Aq
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 05:20:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1hfhcx-0000f1-C1
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 05:20:36 -0400
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542]:37812)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1hfhcx-0000ee-4t; Tue, 25 Jun 2019 05:20:35 -0400
Received: by mail-ed1-x542.google.com with SMTP id w13so26140065eds.4;
 Tue, 25 Jun 2019 02:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=8LfG13CjcL0lU97Rgqablf4y73o84jNFLM13k4SKWA4=;
 b=FYmW731h3EhkSXa+iApUwevPeZbuRXd3qa3QhJ22TUummbgZrVJx/bokxCw+RN5bMp
 zrr5u3BBRE8Bq8fO79r1thf98rh5ZBS1Aw/Y4yxoC/FFLEk+cITdoNxTJAVnwsQlAnTs
 vToyrVaYgCKmwCMLuslc+G0KkzCC77DRtgnkgKLqQoe1UyiQUK5YEugbIruWCaYq4TzO
 ltQKOTH4NowXRElqGmKOG8C6Jq2+ziXHrpHVliswWmqHnBcpAx5e8JFbC2Wl0x36JSTT
 Xi/nyU/FL4AWCxZpJg54RQ030PZqh/8L+61TIbLDiblA7bylSDpayPtoZ+WQLQernQdR
 wRLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=8LfG13CjcL0lU97Rgqablf4y73o84jNFLM13k4SKWA4=;
 b=Gt8rc3NwWJEwhE+rlokDiDLgKRjebH9JUADtaJTgt1eIMoZ6iqRGl8FvDNNo1jKOkC
 jgYhvZ6jsQMKFu0MxVCxPeeklA2KfIzOmjhNFBeRgXk16RBPZPvmtZBeYZYH1sjJU8IQ
 1fxYKcX6QeOG/dlZAS8l71dx/eBKaSUdLb+Ru7obBiYdPC9Os7cezvWkm2Zs3n53oxmE
 JU6mWVKdUhNl6V4AGWp/iIaqGY4EAI5mE7lrf7oDHF5ydGg0+yuLucm+O+I1lp/c3As1
 2l0Oo9EehceCvNdsYfMdfTkePJSvWAIQF7JCtuvGdaDdZ28FoTNbsnciIhSmYvpMK7ah
 /tXw==
X-Gm-Message-State: APjAAAUAWAEUED6oUoGkzNIuMC3L3IPtQZIHu3LfyIXWa/Fs1U7oxU0m
 htnJYav1Tkcq1ho+dDFA0p8BPpzf4klYF2cNIxE=
X-Google-Smtp-Source: APXvYqxqdzv86o5kcWLsNDV8aj5iylrqM221VOlHpVxvufzJEWI5tDwf4pzseXZSDOmh2a+HwCtykQeD1FlEhS4yBC0=
X-Received: by 2002:a50:ad01:: with SMTP id y1mr146118334edc.180.1561454434346; 
 Tue, 25 Jun 2019 02:20:34 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1561414240.git.alistair.francis@wdc.com>
 <7f51ed96a93bf46f76dbdfac61e4d14002d40e08.1561414240.git.alistair.francis@wdc.com>
In-Reply-To: <7f51ed96a93bf46f76dbdfac61e4d14002d40e08.1561414240.git.alistair.francis@wdc.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Tue, 25 Jun 2019 17:20:23 +0800
Message-ID: <CAEUhbmXk8YdxOpy+sZDYtOCYyo4d1G_mpm6N3fhxpAMXO7YqBg@mail.gmail.com>
To: Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::542
Subject: Re: [Qemu-devel] [PATCH v1 5/5] hw/riscv: Load OpenSBI as the
 default firmware
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
Cc: Alistair Francis <alistair23@gmail.com>, Palmer Dabbelt <palmer@sifive.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jun 25, 2019 at 6:23 AM Alistair Francis
<alistair.francis@wdc.com> wrote:
>
> If the user hasn't specified a firmware to load (with -bios) or
> specified no bios (with -bios none) then load OpenSBI by default. This
> allows users to boot a RISC-V kernel with just -kernel.
>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  hw/riscv/boot.c         | 49 +++++++++++++++++++++++++++++++++++++++++
>  hw/riscv/sifive_u.c     |  7 +++---
>  hw/riscv/virt.c         | 11 ++++++---
>  include/hw/riscv/boot.h |  3 +++
>  qemu-deprecated.texi    | 20 +++++++++++++++++
>  5 files changed, 84 insertions(+), 6 deletions(-)
>

Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
Tested-by: Bin Meng <bmeng.cn@gmail.com>

