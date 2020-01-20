Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA7F7C32771
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 23:10:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D4EA20882
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 23:10:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j2zi2pkQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D4EA20882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45490 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itgBV-0000f4-Oe
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 18:10:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59548)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1itgAl-00007S-QP
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 18:09:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1itgAj-00076C-Bp
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 18:09:31 -0500
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:38154)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1itgAj-00075l-5K
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 18:09:29 -0500
Received: by mail-lj1-x244.google.com with SMTP id w1so762745ljh.5
 for <qemu-devel@nongnu.org>; Mon, 20 Jan 2020 15:09:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=xsiWq724NbXBbZvO6ohPWYihUSX18H/ygCm6WbpAe70=;
 b=j2zi2pkQVeMqQj9atNGPDtJRdifBwyBgumwJzg1KemxN5YR7mARPKyQsAyNbv9zmuK
 xS61joJP3QRzu3Ce4QkYCqcIpIBDBwolZy4CXQkvXpJTJRqTWVIV1f7LzVuX+fOJO9pM
 Hy7OZ/OrONblq8LXpxfnNwwqgJtCMuo79xjezRxdPOD+RMpb/sb8VtyNknLAEx/DWe2e
 4TMAHyNTP2Wez2Ai6S2ay6zCOYjWzJAIZPR5lZX7hM0NWANn5659gXn4LBzaP1ZlBYrg
 G6nGewM6Q38sLQzZlBXRL1oxJ08SR0zHCp/jKURv2wXWtqJsqfRwM7E/NBDjfeE2lFk0
 llZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=xsiWq724NbXBbZvO6ohPWYihUSX18H/ygCm6WbpAe70=;
 b=lv+mc6pPDuNIrj2O02dTizvY2gZ8Hc5vkqtTk3k7r0HAhm4t/3Bwyb9LB/K9wVP6CT
 PUH3cDN32ue6a8/svWLvBhp+bMWx4ohsOLNfMbPDWbfWgzkxrmVIt4xetQWDoAo877+o
 Pwuawh9AydgwRAm9E0CQP//Rh9yeSNMgSCKpiCpPJ3UGYIu3WPF8jzTtKOmwMKuR3/SD
 liKlYhjh6SzhSoWKzG49Kp6KD+Uw7yHCDWLryOX5W9LrZQHxnY2L92pRYMG4pmBexTh9
 DgZPKrjvOTJmW7gqQHk6PhKIusnxLaj4SoHojuHdwkMcYetF9+/0CwPdr9iJwq00CU4a
 Qlnw==
X-Gm-Message-State: APjAAAWg7u3GnWhexvztEs9rzRzKye4ecaDeDK5c9kiJLHI4ti6xujpR
 G/6BYE6gL5tLhDOCy/iiC/8/LZE4+QOYfLJiBeU=
X-Google-Smtp-Source: APXvYqxccfNfZE61Ms9yEM3ily8RdDPk7bW9U0aYzktzOw+gahnE5SwTaCQWD709pdecEJUk+joSD0bBTJovZHjbaX0=
X-Received: by 2002:a2e:461a:: with SMTP id t26mr14490566lja.204.1579561767700; 
 Mon, 20 Jan 2020 15:09:27 -0800 (PST)
MIME-Version: 1.0
References: <20200119105245.5860-1-jiangzhiying@ict.ac.cn>
In-Reply-To: <20200119105245.5860-1-jiangzhiying@ict.ac.cn>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 21 Jan 2020 09:08:58 +1000
Message-ID: <CAKmqyKMJYHSPmZCe9yUzoU8nKkN5ypb9dd3ZYo2p5y+r0iOdaw@mail.gmail.com>
Subject: Re: [PATCH] riscv: Fix defination of csr operations
To: jiangzhiying@ict.ac.cn
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::244
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
Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Ian Jiang <ianjiang.ict@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Jan 19, 2020 at 11:55 PM <jiangzhiying@ict.ac.cn> wrote:
>
> From: Ian Jiang <ianjiang.ict@gmail.com>
>
> There is a mistake in defining CSR operations for pmpcfg registers.
> This patch fixes the bug.
>
> Signed-off-by: Ian Jiang <ianjiang.ict@gmail.com>

Looks good! Thanks for the patch.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/csr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index da02f9f0b1..e07b5267be 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -948,7 +948,7 @@ static riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
>      [CSR_SATP] =                { smode, read_satp,        write_satp        },
>
>      /* Physical Memory Protection */
> -    [CSR_PMPCFG0  ... CSR_PMPADDR9] =  { pmp,   read_pmpcfg,  write_pmpcfg   },
> +    [CSR_PMPCFG0  ... CSR_PMPCFG3] =  { pmp,   read_pmpcfg,  write_pmpcfg   },
>      [CSR_PMPADDR0 ... CSR_PMPADDR15] = { pmp,   read_pmpaddr, write_pmpaddr  },
>
>      /* Performance Counters */
> --
> 2.17.1
>
>

