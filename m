Return-Path: <SRS0=zTTU=TP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96E3FC04E53
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 21:15:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5706420815
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 21:15:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KdM0oOyl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5706420815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42728 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hR1FQ-0000kD-A0
	for qemu-devel@archiver.kernel.org; Wed, 15 May 2019 17:15:36 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58370)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <adam.loyd.parker@gmail.com>) id 1hR0y7-0003vF-Gx
	for qemu-devel@nongnu.org; Wed, 15 May 2019 16:57:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <adam.loyd.parker@gmail.com>) id 1hR0y6-000773-CC
	for qemu-devel@nongnu.org; Wed, 15 May 2019 16:57:43 -0400
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230]:32857)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <adam.loyd.parker@gmail.com>)
	id 1hR0y6-0006zQ-7S
	for qemu-devel@nongnu.org; Wed, 15 May 2019 16:57:42 -0400
Received: by mail-oi1-x230.google.com with SMTP id m204so902900oib.0
	for <qemu-devel@nongnu.org>; Wed, 15 May 2019 13:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:from:date:message-id:subject:to;
	bh=r2NOzl046FyRmC+loWdRS7ygF5z5SrZUgNHOTdM5jhE=;
	b=KdM0oOylETCXG2f9TvKAGGmlJsgY7Drx9Tg2d2Nn9T/Om5ceQVAR14ohgBfR+dsiJr
	PYqtvgKiLgWEC9dWth62eDoiKHavCk8noyTQfisrS8/pBRdFDL4fShz4bxXaAqu0eiUU
	26vnfoLKWHvI3bPmCtOJO1F2qstXybJNqdAGPvjuu+y0Jm2XY1NY1UY5ySTa7OfcbNoZ
	jo3HtEEVcgILACQ5ZrTeQu2LUcuzyelPoeGhJ/MmbQCu9h690dq4MM2kb4+I+a5Mrvd5
	26nyjh/VL0yYb7rCBLiGYAaCxeSTTqw/MBHo4mTaZTGKdV/YzRbj2hCv3nwuxRZzShAA
	ZnrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
	bh=r2NOzl046FyRmC+loWdRS7ygF5z5SrZUgNHOTdM5jhE=;
	b=iz54ey10cI6mygNiIXuNXsq4zgc5z3WHVcttABII08zJo7vpunJIkFz5o+JphZUIUU
	dBkkXoRUbDNrVFL9WYF/vK1UKqHWUVHQ+D9nGDfhGJUAJAx3hphLgVGrXFZQaEXioq2s
	0B96nnyQDUoa3DuKzlGU47QlMpcRvUGQlOQd6zxhSP5BE6b//PIG+B0hi9FTWkSaKOs4
	T1nRbwzcen7Q3boeskVEqYWwF3nBx+Khcdro+a4FVGe/pkWwnM+1NTYkeY4YCPCYORIT
	G6/Mi3cCyDIpuc1BZIEJ6WNmGiRxN0MlYs56EpM39oZog/RsRBsE7z34lus2pzKaAjVo
	K9og==
X-Gm-Message-State: APjAAAVulQ6SyqCERNLlwNXrj4/lRgN8Lvn0Y2BMO3JwAAYm6qIimDrb
	4VhwSQRIKLNXN3TrYtk/58nWt+Z98xQmhM9dJ013rC1R
X-Google-Smtp-Source: APXvYqzvSxK8eyUeUoF7L1mZHzpJRV3JlXALWKgn3oDimaDWbSXlak72eSf3C6A078g1Shm06aN1zOLsdYvH3AOuSdg=
X-Received: by 2002:aca:54cc:: with SMTP id i195mr1432402oib.37.1557953860139; 
	Wed, 15 May 2019 13:57:40 -0700 (PDT)
MIME-Version: 1.0
From: Adam Parker <adam.loyd.parker@gmail.com>
Date: Wed, 15 May 2019 15:57:29 -0500
Message-ID: <CAP80XEGcxWai-8BF1GyfPo1+FrUxB3Qa=aGieYshu371mt+jFA@mail.gmail.com>
To: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::230
X-Mailman-Approved-At: Wed, 15 May 2019 17:13:10 -0400
Subject: [Qemu-devel] Unhandled Fault when trying to access PCIE
 [AARCH64/VIRT]
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello all,

I am attempting to write PCIe drivers for my OP-TEE project against
the Cortex-A57 using the virt machine.  I am using the default
packaged qemu, 3.0.93v3.1.0-rc3-dirty and v4.0.0-rc4.  I have added
the PCIE device to the page table of the OS and when I try to write to
PIO (0xCF8) I get an unhandled fault.  Tracing this down I found the
memory access was falling into unassigned_mem_write.  Unfortunately I
don't have an example of PCIe working so I don't know what this is
supposed to look like.  Is this normal behavior and the issue lies
elsewhere?  Or is unassigned_mem_write always a problem?  The debug
text for the unassigned_mem_write does say the correct physical
address and value for the operation.

>E/TC:0 0
>E/TC:0 0 Core data-abort at address 0x107f0cf8
>E/TC:0 0 esr 0x96000050 ttbr0 0x0e29f000 ttbr1 0x00000000 cidr 0x0
>E/TC:0 0 cpu #0 cpsr 0x600003c4
>E/TC:0 0 x0 00000000107f0cf8 x1 00000000107f0000
>E/TC:0 0 x2 00000000117fffff x3 000000000e14a6a0
>E/TC:0 0 x4 0000000001200000 x5 000000000000000d
>E/TC:0 0 x6 000000003eff0000 x7 0000000000000020
>E/TC:0 0 x8 000000000e127c48 x9 000000000e146d24
>E/TC:0 0 x10 000000000e142f20 x11 00000000f1906769
>E/TC:0 0 x12 00000000113044e7 x13 000000000e2a693c
>E/TC:0 0 x14 0000000011800000 x15 0000000000000000
>E/TC:0 0 x16 0000000000000000 x17 0000000000000000
>E/TC:0 0 x18 0000000000000000 x19 0000000080000000
>E/TC:0 0 x20 0000000000000000 x21 000000000e1480b4
>E/TC:0 0 x22 000000000e1480a2 x23 0000000000000001
>E/TC:0 0 x24 0000000000000002 x25 000000000000000a
>E/TC:0 0 x26 0000000000000000 x27 0000000000000000
>E/TC:0 0 x28 0000000000000000 x29 000000000e2a6990
>E/TC:0 0 x30 000000000e125af4 elr 000000000e125af4
>E/TC:0 0 sp_el0 000000000e2a6990
>D/TC:0 0 get_fault_type:602 [abort] Unhandled fault!

Thanks,
Adam Parker

