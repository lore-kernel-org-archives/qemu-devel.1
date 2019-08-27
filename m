Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 198B6C3A5A3
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 15:30:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA8E0217F5
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 15:30:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Ivj+tsW2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA8E0217F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52734 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2dQn-0001tE-AI
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 11:30:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51584)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <chihmin.chao@sifive.com>) id 1i2dMX-00061C-8a
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 11:26:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <chihmin.chao@sifive.com>) id 1i2dMV-0001al-PD
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 11:26:24 -0400
Received: from mail-io1-xd42.google.com ([2607:f8b0:4864:20::d42]:43936)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <chihmin.chao@sifive.com>)
 id 1i2dMV-0001ZT-FC
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 11:26:23 -0400
Received: by mail-io1-xd42.google.com with SMTP id 18so47162685ioe.10
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2019 08:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=zV5inUbU33HGE+HXpm/uIphCXvdIrmc/8bmS9Jcq9yg=;
 b=Ivj+tsW2+DcgSLNglj+8V3nPgfXJH7F1EZNmI/D7uJx/JhHZCXGScye3IGSYzuIkXk
 eOGoND+LRP3CmGsKByO/tf9Ha5FdQpfCBE0VUaPFTaxPbhThs2BcNcDUOVozcDq+icO9
 C7p9uHyKssRfaRGtslJ6NIIpVP3h+YBwz8VvgtwHEigTWYlwYyVtz58EfiDxIhd3oG9s
 pz3WULgsdE+eB1ogSlAp4rnHBMf4SmjrGwdzghtz5ow+r1JpUY91qIl6L/UKF+rUfylA
 fGVntlCIp+G077UkcauCbPGn7Z4DGi+IUE/QNZ308VizohlFZT/47QO7FD5G2/dxg48v
 x19Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=zV5inUbU33HGE+HXpm/uIphCXvdIrmc/8bmS9Jcq9yg=;
 b=ssp9EVT/t3x8awNTtJqpkILQtPgSl5L39IyCLagiM1dYTnlWI6Rli4RgwuY77Z3Z78
 lI7bBAz5vA/UALfBluzVAlp+llNbGT1QCxP6Bd/0+hr5CL1kVgz49Pw+5UqaKqzyRBWS
 tKp0i2KGn0MTuy7s0JcmojogswRU6pLdOJLhi9caTAauPa9Mg54MNLFSeyacBEBvJJtg
 vXLDRSobEwbhEltHaRwfTsF106TkKaKNxba9Nt1iJBxCn/qrTIf1uytcKxJ9Uo7h5l6v
 5p1KLo3yVx/VKZrIFEHCd/kG2rKLkdZPqUfaMvuJKhxtMA2YmZGHSJzvF/fZ2vzVIW4D
 tGiw==
X-Gm-Message-State: APjAAAW3StCzTXYU7GbDk89alJ4ptRaqLt0mNR6W92Wz0PGAvc6nqdVi
 mCyNXFJ9iQkAwVvO4xw1MTFkBi8OLeHQdcS/T5vlog==
X-Google-Smtp-Source: APXvYqwUgWARfrXJuuD5WeBhhqjV7tEoACo0pwyoiyXA+6wMWhcZwWg6nCgEJ3oOiWbqczxYo42f/XDimKCiM7ZfNAI=
X-Received: by 2002:a05:6602:228e:: with SMTP id
 d14mr2207927iod.85.1566919582525; 
 Tue, 27 Aug 2019 08:26:22 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1566603412.git.alistair.francis@wdc.com>
 <008eba3fe3b65cc5d37a1ced51d3631b23bef330.1566603412.git.alistair.francis@wdc.com>
In-Reply-To: <008eba3fe3b65cc5d37a1ced51d3631b23bef330.1566603412.git.alistair.francis@wdc.com>
From: Chih-Min Chao <chihmin.chao@sifive.com>
Date: Tue, 27 Aug 2019 23:26:11 +0800
Message-ID: <CAEiOBXUz6Ng-9scF62XsiU-tcA58sj8P=tNwLpiphm+uGARVmA@mail.gmail.com>
To: Alistair Francis <alistair.francis@wdc.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d42
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH v1 01/28] target/riscv: Add the Hypervisor
 extension
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
Cc: Palmer Dabbelt <palmer@sifive.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>, Anup.Patel@wdc.com,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Atish.Patra@wdc.com, Alistair Francis <alistair23@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Aug 24, 2019 at 7:42 AM Alistair Francis <alistair.francis@wdc.com>
wrote:

> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  target/riscv/cpu.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 124ed33ee4..7f54fb8c87 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -67,6 +67,7 @@
>  #define RVC RV('C')
>  #define RVS RV('S')
>  #define RVU RV('U')
> +#define RVH RV('H')
>
>  /* S extension denotes that Supervisor mode exists, however it is possible
>     to have a core that support S mode but does not have an MMU and there
> --
> 2.22.0
>
>
> Reviewed-by: Chih-Min Chao <chihmin.chao@sifive.com>
