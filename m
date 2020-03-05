Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A15D3C3F2D2
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 16:53:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70D4420637
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 16:53:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MlMq69bw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70D4420637
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9tkZ-0006fB-Jy
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 11:53:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33326)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j9tbx-0000Vt-MM
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 11:44:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j9tbw-0007cn-Cz
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 11:44:37 -0500
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334]:32888)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j9tbw-0007by-8W
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 11:44:36 -0500
Received: by mail-ot1-x334.google.com with SMTP id a20so6350638otl.0
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2020 08:44:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=8RQgxAytKvFsrqMKrCpxhTLSrB87xnJaR0cBqI+uAPM=;
 b=MlMq69bwI+qfCkLQfhaohorZEArrafzZGqJWVgEMKU3B7tbswQj6zZbpX7DV9qYjnn
 M3NORKzLyQi5YpVMgrKX8ytnekVWx8AtBQmL5g89KSVJJXJOUH9oSRBgTSAqd7MYiUOU
 IXqdQTaIz5x6lYiN68QKUXXSf4fHtJMeZG1sn5YAtmmqtXIzcM+kbaYoZOBVbu1/J1uo
 WCP155qg/DJbI6Bh78CGXuGnv2dIUHFgOGOy9GMUKxvtN3bCQ7Y4+47nU5Ii+qUuGs87
 6o3Wi+cQ2JgMUjQAepu3uPEbgHFrSuNC2/K4OR3O6JBQco///Ah/52yMDBblLwXvk8sK
 A/lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=8RQgxAytKvFsrqMKrCpxhTLSrB87xnJaR0cBqI+uAPM=;
 b=Q0keIy0MfkJGaQ1X9pZFwD9d99Qi0GKcLvl12nUT+ZLbsGNwbpur/8Hc6LqySGpIHb
 /A+6CFNSvdpXoPg0vOv22JhEH9O9fmFKtPyM7Bah1WWwcls7wKwqhqkuj57WN/eXazim
 F5u3XKc+HLkFNAlDdNzxg3TjakGUyT/i5wVmwKCL8mw9Yh/h3TOUnadLy803nO2PJ7Lp
 z10rXcbooDXWAwrHZSzXEbAlnyKJj0SfW3ewaUc6zEAgsGzRHaeOZmi8L2+KkAIdX0gw
 QQoIjx1c9q5DIGnIF+ax8MtAYgIGR+/iE9ub/21CdWyl0RXYkjQrY3Q31CFOYCdX19Qs
 +iLQ==
X-Gm-Message-State: ANhLgQ39gvTs+sYqUBCI7lLrxsT3BQAaHog6SZyFHLlH6+jGE1SntFdL
 k+4H8wqZFdSzHZZ9CsTCgH9VScicJS0FFyajbDvDsg==
X-Google-Smtp-Source: ADFU+vu6RVLX6O6uZ79AIUc2TsahspZghA3XNueFG+MI1/6mmVBtYpGGZke9sjgEbni6iel6vgj5zR+6Xk1blMnqe/Q=
X-Received: by 2002:a05:6830:30ac:: with SMTP id
 g12mr6057165ots.221.1583426675327; 
 Thu, 05 Mar 2020 08:44:35 -0800 (PST)
MIME-Version: 1.0
References: <20200303004848.136788-1-palmerdabbelt@google.com>
 <20200303004848.136788-5-palmerdabbelt@google.com>
In-Reply-To: <20200303004848.136788-5-palmerdabbelt@google.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Mar 2020 16:44:20 +0000
Message-ID: <CAFEAcA9gHNXfGutEZiW-PYJbhdUZEd-dPDp8iwO-Ni_cSD9gZw@mail.gmail.com>
Subject: Re: [PULL 04/38] target/riscv: Add support for the new execption
 numbers
To: Palmer Dabbelt <palmerdabbelt@google.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::334
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
Cc: Alistair Francis <alistair.francis@wdc.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 3 Mar 2020 at 00:49, Palmer Dabbelt <palmerdabbelt@google.com> wrote:
>
> From: Alistair Francis <alistair.francis@wdc.com>
>
> The v0.5 Hypervisor spec add new execption numbers, let's add support
> for those.
>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
> Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>
> ---
>  target/riscv/cpu.c        |  8 ++++++++
>  target/riscv/cpu_bits.h   | 35 +++++++++++++++++++----------------
>  target/riscv/cpu_helper.c |  7 +++++--
>  target/riscv/csr.c        |  7 +++++--
>  4 files changed, 37 insertions(+), 20 deletions(-)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index efbd676edb..2f62f5ea19 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -67,6 +67,14 @@ const char * const riscv_excp_names[] = {
>      "load_page_fault",
>      "reserved",
>      "store_page_fault"
> +    "reserved",

Hi; Coverity (CID 1420223) notice that there's no comma
after "store_page_fault", which means that there's been
a concatenation of that string and the following "reserved".
Could one of you send a patch which adds the missing comma?

> +    "reserved",
> +    "reserved",
> +    "reserved",
> +    "guest_exec_page_fault",
> +    "guest_load_page_fault",
> +    "reserved",
> +    "guest_store_page_fault"

You might also like to add a trailing comma here to avoid
the bug happening again in future.

>  };
>

thanks
-- PMM

