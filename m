Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26BCBC3815B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 19:32:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA78820782
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 19:32:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mrd9u2NG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA78820782
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41288 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQc9E-0000dZ-2r
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 15:32:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54734)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1jQc8D-0008NW-7X
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 15:31:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1jQc7y-00058E-QJ
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 15:31:01 -0400
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41]:38421)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jQc7x-000535-SI; Mon, 20 Apr 2020 15:30:46 -0400
Received: by mail-io1-xd41.google.com with SMTP id f19so12400126iog.5;
 Mon, 20 Apr 2020 12:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=8reeFoMDhrBHkyh2+PUxpeJZje9eT2v6qsPaitY5no8=;
 b=mrd9u2NGaev9/qQBvl/IAHONu2CfgR9IjrvXvKwbv0eNkJqqm27Y9v7X0x1sWewQ5Z
 7HfZJnOgjeVj2TwLvGhi7+z/7VE4hlfk61+CslmRJFlB8/QZaIIfDSBvI5To4Wu3cpnj
 4PU0rTckejiVN1PTT8xyFzluWdJdHnpBSVlSuGWwiRxIqzBTk0UkaFyEnPxW+MaDdrbR
 DnOu/KlWsytpltxqD/mpcb57f8GPRWt74fpE8SMf6CDH97P/fmN50yRgivC/edpeMrsC
 F8z0kxuM3ojKhOCHWlT5xv06jNzz7eo7fdgkOUHnzIwjAsdsw2KXATptLkMW7QLje8K0
 XeEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=8reeFoMDhrBHkyh2+PUxpeJZje9eT2v6qsPaitY5no8=;
 b=sI29osU8Ys/rZ51+vagTHqW3DrZU6uO2OB8x53gNZPA985FQdbZz3WhwqcgLV7UHYa
 zK6x4BjFjxmMLvmikNwjaV1j4gJdUta4VbeK9SPlO3GNm+d31CD8zunBVE/dy800D1mB
 iIgBFKXwfDluPOUF20s79yRi0iRR1ZHnGNn/nug7DsPhyOD1lYFQbDQJJ+nwpNdYGTPH
 LOPUpMexx2SshIPfcVDSD2wSO7QrOmPxppiipMQZXWHHz0cytJjgfBbmrZCpv55T2o3u
 4SVFj8s/t80yAENIpoDQBOI/j3qWDMEL5O6v+hfxXSELUPjJ+76jSwizZIKCoyA5efsa
 4tCg==
X-Gm-Message-State: AGi0PuaDrJbNCbJAUdHObKoCk3yMu3iqPi97fo2slVWdRSXWxWR3Ld47
 sa5HP7cFbTVpJ1YKEhMO6J083jQ94ZBpFeLWucA=
X-Google-Smtp-Source: APiQypJzflNPwn7XVKT4A4s9VquVZPoV5123ejfcBBH0LhqeXLVH53ETk/el77p03Dd4s1Xq8UuaAP7G54NJFXAvf28=
X-Received: by 2002:a05:6602:d:: with SMTP id
 b13mr17318369ioa.176.1587411044585; 
 Mon, 20 Apr 2020 12:30:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200313193429.8035-1-coreyw7@fb.com>
In-Reply-To: <20200313193429.8035-1-coreyw7@fb.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 20 Apr 2020 12:22:16 -0700
Message-ID: <CAKmqyKNVKMc8o3b3xNnv9g8T_2ihmvHhAHrVzsm6KpE4FEsHsA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Support different CPU types for the sifive_e
 machine
To: Corey Wharton <coreyw7@fb.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d41;
 envelope-from=alistair23@gmail.com; helo=mail-io1-xd41.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::d41
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
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Bin Meng <bmeng.cn@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Mar 13, 2020 at 12:36 PM Corey Wharton <coreyw7@fb.com> wrote:
>
> The purpose of this patch set is to allow the sifive_e machine to run
> with different CPU targets to enable different ISA entensions. To that
> end it also introduces a new sifive-e34 CPU type which provides the
> same ISA as sifive-e31, with the addition of the single precision
> floating-point extension (f). The default CPU for the sifive_e machine
> is unchanged.
>
> v2: Added missing RVU flag

Applied to the RISC-V tree for 5.1

Alistair

>
> Corey Wharton (2):
>   riscv: sifive_e: Support changing CPU type
>   target/riscv: Add a sifive-e34 cpu type
>
>  hw/riscv/sifive_e.c |  3 ++-
>  target/riscv/cpu.c  | 10 ++++++++++
>  target/riscv/cpu.h  |  1 +
>  3 files changed, 13 insertions(+), 1 deletion(-)
>
> --
> 2.21.1
>
>

