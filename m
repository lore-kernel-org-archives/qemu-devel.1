Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B90D1C54FD0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 15:15:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74B732054F
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 15:15:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gbGdtWbM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74B732054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50560 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jT5Tg-00030W-HY
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 11:15:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35304)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1jT5SQ-0000Sz-CR
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 11:14:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1jT5SQ-000418-1D
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 11:14:06 -0400
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43]:45412)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jT5SO-00040i-H3; Mon, 27 Apr 2020 11:14:04 -0400
Received: by mail-io1-xd43.google.com with SMTP id i19so19200394ioh.12;
 Mon, 27 Apr 2020 08:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=vSl9tFxLX/n9X0hlCbc09Op8WwsbwBcotpw6NVs2uME=;
 b=gbGdtWbMLCKQsltGJv0+BIU8wymvD2/hnHRQ/gJeLPvihBGwgyILUMIruXcRDbouSQ
 cIKXsX8fbG9wO/SjIoP36Ap7rkPaHW8SygQc/j1OahRcJkSMLJHuB7lCvdJfMVg3gbyP
 HQPwV4SItgdHlCfxjFOrn4FyanQaOm+RnRbpXgR3LYb2dmiLnbnQxv2E73xQ8f9B01r+
 A2rh6kzpPX6GwD8M/t4g70Ji+ZqQEHppAc8MP7JsMZb7SQ883JsLvbJXvuGh8G6DWGIJ
 wcvMq13CIU9pM5CtAjUtkN6of7yyuNzEvUZDSg5Jjo4aCEpn0TQxDb9UbgtkIAiVssY+
 dUNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=vSl9tFxLX/n9X0hlCbc09Op8WwsbwBcotpw6NVs2uME=;
 b=mGMQXmR8lcr7XTsUYSlnfok2sPZ9PObCpDB6CI2INxs+0k0YoZYRCI4V3UURfPYoCg
 COFyvwHb0oFsKIxkMLS4d6NPDQ6MtceAlRTCmiLX4V/QrHDzlNBw0/jFkF3r8HjwWR75
 201xnQNnrh5ADMQU65e9gd7isd4SPYLvAWVFt4Eh+kCJTKbQahYHrh46p7EJOJLcpZH2
 DKbeRRG0DHKPn+h5dba4axpep/NXJh9mPnDLib/87F22thvxU0sqZ3zZ/OTHp4lS/Hhm
 OPmiVAqh9wmhkL4A2Qg0djzyAJCNQumI10YuAjOaWXqf0TxznzLqSdL8VgkpjT8ASQ8A
 mX0g==
X-Gm-Message-State: AGi0PuY9QpQHsDXrEF4G26otgWz15fYIK5GyUEemPEM/uHwYo7KJJpIj
 sEIlLQGVci0+KQxYLwf2gpmN7KZitUzqAaunppI=
X-Google-Smtp-Source: APiQypI1qfgdKIvtNopqmpO+EAg3QK+XgTz0w7yepJIA01cMWMrz0Y4/o2fVLBWbf+pOuPTsM3r9sHKux9Z7UO+g5G8=
X-Received: by 2002:a5d:984b:: with SMTP id p11mr21296857ios.175.1588000443029; 
 Mon, 27 Apr 2020 08:14:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200427080644.168461-1-anup.patel@wdc.com>
In-Reply-To: <20200427080644.168461-1-anup.patel@wdc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 27 Apr 2020 08:05:24 -0700
Message-ID: <CAKmqyKPb52FQ5NWLVGLBgJqSXXyeReJ-Di--+TwkeQcpJ4H3HQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] RISC-V Spike machine improvements
To: Anup Patel <anup.patel@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d43;
 envelope-from=alistair23@gmail.com; helo=mail-io1-xd43.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::d43
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, Anup Patel <anup@brainfault.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Atish Patra <atish.patra@wdc.com>, Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Apr 27, 2020 at 1:07 AM Anup Patel <anup.patel@wdc.com> wrote:
>
> This series improves QEMU Spike machine to:
> 1. Allow loading OpenBI firmware using -bios option
> 2. Allow more than one CPUs
>
> Changes since v2:
>  - Rebased on QEMU v5.0-rc4
>
> Changes since v1:
>  - Rebased on QEMU master (commit 2ac031d171ccd18c973014d9978b4a63f0ad5fb0)

Applied to the RISC-V tree for 5.1.

Alistair

>
> Anup Patel (3):
>   hw/riscv: Add optional symbol callback ptr to riscv_load_firmware()
>   hw/riscv/spike: Allow loading firmware separately using -bios option
>   hw/riscv/spike: Allow more than one CPUs
>
>  hw/riscv/boot.c         | 13 ++++++++-----
>  hw/riscv/sifive_u.c     |  2 +-
>  hw/riscv/spike.c        | 26 ++++++++++++++++++++++++--
>  hw/riscv/virt.c         |  2 +-
>  include/hw/riscv/boot.h |  6 ++++--
>  5 files changed, 38 insertions(+), 11 deletions(-)
>
> --
> 2.25.1
>
>

