Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A10C6C432C2
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 12:29:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EE7F20640
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 12:29:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="WrttZxqy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EE7F20640
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49336 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iD6Qa-0008Di-G3
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 08:29:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55498)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <guoren@kernel.org>) id 1iD6Pn-0007IX-QH
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 08:29:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <guoren@kernel.org>) id 1iD6Pm-0003iL-Lu
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 08:29:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:52276)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <guoren@kernel.org>)
 id 1iD6Pm-0003hz-Ga; Wed, 25 Sep 2019 08:29:02 -0400
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 33BC720665;
 Wed, 25 Sep 2019 12:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1569414540;
 bh=oXaekWF4ps2BBah8Kc1yQPnkaMiXX/Go11DbBfkvzaM=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=WrttZxqyGQusmjO7ttTITAtFDjOXuJ+J6P32t3Apkg95stwdHsUdsTwFoHNxO4qAa
 d62XSrpd+W6d5Csq8rqDDgGFgJl4I2J9x+Ac+WILyMET0rBLyruJDx5XJsVVMb/+1T
 jiU0BJJI8tbGOGqhhdo4b1Z4+Uee5KNOyXWhtnms=
Received: by mail-wm1-f41.google.com with SMTP id 3so4742740wmi.3;
 Wed, 25 Sep 2019 05:29:00 -0700 (PDT)
X-Gm-Message-State: APjAAAWTRulK6g+Mvnt9NZjlN0SG0i7nW+alZ8TL4ZikcjIzgeKq6MrM
 Ty0iErA2yg9OeELUsxuu/vaCzNtzXOrld2rH1AI=
X-Google-Smtp-Source: APXvYqznwoA3E3rOh7gGSRV9zErUkLmcEic9EWHjLBr1Vm63dx1COo/ejpRRDDcTMh0d4JvzWVV5fkciHX0OGTZK3z4=
X-Received: by 2002:a05:600c:1103:: with SMTP id
 b3mr7757560wma.3.1569414538702; 
 Wed, 25 Sep 2019 05:28:58 -0700 (PDT)
MIME-Version: 1.0
References: <1569386895-8726-1-git-send-email-guoren@kernel.org>
 <CAKmqyKMraotFmqMg7MrJC5C4SogGqSaVtHkVYTEgGWK9UnWb5g@mail.gmail.com>
In-Reply-To: <CAKmqyKMraotFmqMg7MrJC5C4SogGqSaVtHkVYTEgGWK9UnWb5g@mail.gmail.com>
From: Guo Ren <guoren@kernel.org>
Date: Wed, 25 Sep 2019 20:28:47 +0800
X-Gmail-Original-Message-ID: <CAJF2gTR0o0s_p0H669BRZ86phLtpATwWczczWV8HWw1nc+doFA@mail.gmail.com>
Message-ID: <CAJF2gTR0o0s_p0H669BRZ86phLtpATwWczczWV8HWw1nc+doFA@mail.gmail.com>
Subject: Re: [PATCH V3] target/riscv: Bugfix reserved bits in PTE for RV64
To: Alistair Francis <alistair23@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 198.145.29.99
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
 Palmer Dabbelt <palmer@sifive.com>, "open list:RISC-V" <qemu-riscv@nongnu.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Guo Ren <ren_guo@c-sky.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Sep 25, 2019 at 1:19 PM Alistair Francis <alistair23@gmail.com> wrote:
>
> On Tue, Sep 24, 2019 at 9:48 PM <guoren@kernel.org> wrote:
> >
> > From: Guo Ren <ren_guo@c-sky.com>
> >
> > Highest 10 bits of PTE are reserved in riscv-privileged, ref: [1], so we
> > need to ignore them. They can not be a part of ppn.
> >
> > 1: The RISC-V Instruction Set Manual, Volume II: Privileged Architecture
> >    4.4 Sv39: Page-Based 39-bit Virtual-Memory System
> >    4.5 Sv48: Page-Based 48-bit Virtual-Memory System
>
> Hey,
>
> As I mentioned on patch 2 I don't think this is right. It isn't up to
> HW to clear these bits, software should keep them clear.

These bits are not part of ppn in spec, so we still need to ignore them for ppn.

The patch is reasonable.

-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/

