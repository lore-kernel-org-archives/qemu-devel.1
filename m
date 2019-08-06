Return-Path: <SRS0=MhU4=WC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D207C0650F
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 00:22:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05D1D2070D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 00:22:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PTV8vZ42"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05D1D2070D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57702 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hunEs-0007fB-C3
	for qemu-devel@archiver.kernel.org; Mon, 05 Aug 2019 20:22:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35657)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alistair23@gmail.com>) id 1hunEW-0007Dp-6O
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 20:21:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1hunEV-0004pV-8i
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 20:21:44 -0400
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142]:40826)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1hunEV-0004pN-2M; Mon, 05 Aug 2019 20:21:43 -0400
Received: by mail-lf1-x142.google.com with SMTP id b17so59480608lff.7;
 Mon, 05 Aug 2019 17:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=R7Pe5GNZNalCGi3LS2y94Cy/0WFzM1IroXaWKj73m60=;
 b=PTV8vZ425GQdAhVdr3lZx+0Subw2aQkrYPafJPy53oyn31tqUDqFResyVOwUh5mRUw
 VtP0qyrUdv7B/9lEWL0kc8WB43L9CFI4A/PY37qGuZlNXNiJJM6hgTHeh6IqQa80cv7q
 7Scjw/tL970UFl3VhO2bBcV+zxNINHPWWHVaFt20ZOvw+xM4xgfLkFhLB66OwlLcTs+0
 m/MH3B1xuZvzcKU9pyeatoW+Iko1X+p7i6xhF93wlhYLiJwuo6OoCQ8HMfAuFUGs2de/
 0bbdVWShHCxUqiY91piG7misqeWuXr552OmFC6WQNVtrSBC8Rjfyl2vZecz4hARIxLwf
 cquA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=R7Pe5GNZNalCGi3LS2y94Cy/0WFzM1IroXaWKj73m60=;
 b=C9FbuxQVtz64OaVgQuzY1TM026n4hDvgMttPe819xESkhgBHKivWf9xfc3RDmmxNoG
 Wtezum7uIFIqMcC1GYQ2S/hup2YKYuy5v516VA1QZwmsnSjCs+uJQIbN9VIUVxVXPFX5
 dCeTK8lIEiozLGuWb2wHvp9gqI3c5MWgzLGiZukmxg3n5SWelLerxlj4iISXPefOGxtb
 Qn8dHnvwNcRoQ5N2jhq6/8jZeOQjDzMc6We2WxvPGQTwGjstruGWpA5edMNcDoVi4wBw
 FMPTC4wu+v16uB+yp/BNUiLcVHn3IcQlzkzQWxwBtuRgXXN89or3n8ZLJuXWWFufH0rb
 5LWw==
X-Gm-Message-State: APjAAAVlz1VsuLVXKYP10QKUuiPSX2NbxyjCntbK62D0D0TXdVsjnCFX
 1yDA5RzLODjF1LVq46KKpy1+dpIVbvWErw41GDs=
X-Google-Smtp-Source: APXvYqywftj7ItmzOZeYdViZoQ9NIH0CEvFw8kWKDKVhWGZt+7VY5hphmTx3LU19VtUZHERS58efLpSSlN8Iqmz7RBg=
X-Received: by 2002:a19:c6d4:: with SMTP id w203mr235068lff.135.1565050901766; 
 Mon, 05 Aug 2019 17:21:41 -0700 (PDT)
MIME-Version: 1.0
References: <1565020823-24223-1-git-send-email-bmeng.cn@gmail.com>
 <1565020823-24223-11-git-send-email-bmeng.cn@gmail.com>
In-Reply-To: <1565020823-24223-11-git-send-email-bmeng.cn@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 5 Aug 2019 17:18:03 -0700
Message-ID: <CAKmqyKP7+2+cnOUW3a_0NojgTn+d78TGDBHY0grF7A7+F8CYXA@mail.gmail.com>
To: Bin Meng <bmeng.cn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::142
Subject: Re: [Qemu-devel] [PATCH 10/28] riscv: sifive_u: Remove the
 unnecessary include of prci header
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

On Mon, Aug 5, 2019 at 9:10 AM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> sifive_u machine does not use PRCI as of today. Remove the prci
> header inclusion.
>
> Signed-off-by: Bin Meng <bmeng.cn@gmail.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>
>  hw/riscv/sifive_u.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
> index 9f05e09..dfcb525 100644
> --- a/hw/riscv/sifive_u.c
> +++ b/hw/riscv/sifive_u.c
> @@ -40,7 +40,6 @@
>  #include "hw/riscv/sifive_plic.h"
>  #include "hw/riscv/sifive_clint.h"
>  #include "hw/riscv/sifive_uart.h"
> -#include "hw/riscv/sifive_prci.h"
>  #include "hw/riscv/sifive_u.h"
>  #include "hw/riscv/boot.h"
>  #include "chardev/char.h"
> --
> 2.7.4
>
>

