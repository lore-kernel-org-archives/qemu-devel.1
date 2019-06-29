Return-Path: <SRS0=rHaa=U4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BB10C5B577
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Jun 2019 19:45:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B999216FD
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Jun 2019 19:45:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CICh/XrW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B999216FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41978 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhJI8-0000R8-0a
	for qemu-devel@archiver.kernel.org; Sat, 29 Jun 2019 15:45:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56975)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <luke.r.nels@gmail.com>) id 1hhJH1-0008Gj-9u
 for qemu-devel@nongnu.org; Sat, 29 Jun 2019 15:44:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <luke.r.nels@gmail.com>) id 1hhJH0-00067n-De
 for qemu-devel@nongnu.org; Sat, 29 Jun 2019 15:44:35 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:40379)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <luke.r.nels@gmail.com>)
 id 1hhJGy-00064v-CE; Sat, 29 Jun 2019 15:44:32 -0400
Received: by mail-wm1-x341.google.com with SMTP id v19so12001980wmj.5;
 Sat, 29 Jun 2019 12:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=XR3CYR+hNAhsKH1MYETD7KsWjiyjIq23cGrTQzYkak8=;
 b=CICh/XrWkdUQBj4vOVfkehnuL3k9qdWBZfFQLsTqpIy7y5NMkaFNiIND0WH0yOvhQC
 loEbaG9RZtum3oKJnxevuzVpzQF86HjS7kU/LRXN3iSmEMK7w619DtZ0r/iQOu89ESno
 sMv71jC5AlWH+d5fyFDjYOA5Tz5nsC5g9VvJTmYhY85G4622V0Ns9E56VYYCQN2srjKj
 2vMI38cS95EwzJjeyBDnYYvuvJ1f2QTQJSCHjzpMqQGIsNQx7vqTfOLve4XFHGz20jd4
 DfgzICLvnZOpmejCpDn+iHIHL6gLLWBrrkiYpYa31M+LEHxmnmvzM1vUZynzgU8OcZ4d
 KOXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=XR3CYR+hNAhsKH1MYETD7KsWjiyjIq23cGrTQzYkak8=;
 b=CDduYWziMFVAGwzF5Ia4K6ZBNbxIjXstVD4BPThEOtm5lDTgR3tuAMn3OLcTcouCNG
 V5m85f/dWNBzfDyz60eoIyO7L5l5s4YPS2Wzxanl6J3mEtO3FGqSR8BH94Lg2gQG3LWo
 20eZwfcuPsDi+bpiY/1vUTYMU0XM6mPJLn9ZERFHg5pdmLY1EWgukjWlHv3qzCdRnG0U
 +eWnRCz3O+SvyYw4le98WC9DAZZ/xekSYE9jjF0hTF1TGokn9buLqcswJc5UCrqHAB6X
 wXM1V/2OZL4i6cAZYDyN+3pDObGosclRU3ht8NHr8vGXB6l42VmIxYA9C566SaZDLNNM
 CWuA==
X-Gm-Message-State: APjAAAUcNMiEbTu/eeRNMBaTakVwQwsNPjMqAXpPFSEPE6I7Ln93bWqQ
 4ZaxEzY7eXIIiSPr2sEdTa/Oi87X31S4h2BQ0tI=
X-Google-Smtp-Source: APXvYqykPFs+X6QrUUw+DJ0M7EvOQUoQSeV/xLPRV+qN/7Aj4skcXcoVAt8AH09E82je219O9Nd4h5YMwHTfOOrdy2w=
X-Received: by 2002:a1c:5453:: with SMTP id p19mr10535238wmi.148.1561837469382; 
 Sat, 29 Jun 2019 12:44:29 -0700 (PDT)
MIME-Version: 1.0
References: <CAKmqyKNPpRKYJunZLQrbNE9LmXLKkMcGUdghe3Ry6kO=R9TQLw@mail.gmail.com>
 <mhng-eb63042f-42db-4a31-96b5-e13a0e1d2363@palmer-si-x1c4>
In-Reply-To: <mhng-eb63042f-42db-4a31-96b5-e13a0e1d2363@palmer-si-x1c4>
From: Luke Nelson <luke.r.nels@gmail.com>
Date: Sat, 29 Jun 2019 12:44:13 -0700
Message-ID: <CAB-e3NRoDmJwr_QEf2djUV6KuESP+kyrhB470vS5t5sUphXPBg@mail.gmail.com>
To: Palmer Dabbelt <palmer@sifive.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: Re: [Qemu-devel] [PATCH] RISC-V: Fix pmpcfg register indexing
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
Cc: qemu-riscv@nongnu.org, Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>, lukenels@pm.me,
 Michael Clark <mjc@sifive.com>, Alistair Francis <Alistair.Francis@wdc.com>,
 alistair23@gmail.com, Xi Wang <xi.wang@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Feb 13, 2019 at 10:12 AM Palmer Dabbelt <palmer@sifive.com> wrote:
>
> On Fri, 08 Feb 2019 10:57:17 PST (-0800), alistair23@gmail.com wrote:
> >
> > Good catch!
> >
> > Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
>
> Ya, thanks -- that's a somewhat embarrassing bug, as someone else just fixed
> one on the line below :).  I'll target this for my next PR.
>

Is there any chance this patch could make it in the next PR?

Thanks,
- Luke

