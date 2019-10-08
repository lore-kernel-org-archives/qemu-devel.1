Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43ECBC35280
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 16:43:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E84B21721
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 16:43:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="lOdkhUGM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E84B21721
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58468 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHsaY-0004yK-7H
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 12:43:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44359)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jimw@sifive.com>) id 1iHsZd-0004GT-20
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 12:42:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jimw@sifive.com>) id 1iHsZb-0000q6-Pw
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 12:42:56 -0400
Received: from mail-vs1-xe44.google.com ([2607:f8b0:4864:20::e44]:42035)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jimw@sifive.com>) id 1iHsZb-0000po-KX
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 12:42:55 -0400
Received: by mail-vs1-xe44.google.com with SMTP id m22so11727173vsl.9
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2019 09:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=M5iBE1AnQdiWOZ3mozyE6Xp81Ek6hA8lnryANZaJYw4=;
 b=lOdkhUGMzU/jA3HOmKtZPP3fsEHcs2ZSBJ2WXMCKfx3/SNBQJOcUIs6p2pZT7hkuPh
 7kLZNNE/qW8ea2cuiBm0qDb7UBvhNvk+vD9FPkCW/6Cy5hXyDeMIabenBaZRiK7VZEFn
 ZYuKBL/kEh2365RyicGprptNG8eMQHjvyyyY1lXvligxfyX+v/uXRUdQXEz0LZTpO5Rx
 Dne/JdnoE/aGDR6qfwwQajd6vQYMSFGZ8ddgJe3qFqwlNrNk7o9c6lclqXD+3DOgdGKE
 eHM/7mbPAPIAdOiv5/u+DnkoGb2RyovVm/XC+YegGkJR1Wc/Q+fOqOk2XN5XEPjHTOqK
 +ZOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=M5iBE1AnQdiWOZ3mozyE6Xp81Ek6hA8lnryANZaJYw4=;
 b=IvCrWhrcav6ol7HQeQLlM5kWuV216cZi2nJ45fFkN2GByyx08jsjQg8/mLDOF4jYaL
 92lIVXnrTitjVxngos8ZtNiB1o+w4BB+NcGJeszEW76gPGpt//KqCfNIeIRogw/gwZHM
 f38vuzRitDV/OFzxjSY8eh1nSLQcDXcXHhgekEIx2IwWHr2fD+ld73xRW6UJUNTH8q8q
 cPAmW6jY6l1U1lPWCA085ghgaDLribOBVe5kcKe8BWQo4TrtHCbNw1E6uIliduMdnYmp
 tVRDd90iC+Jtg7K+2ovQLSZtBWlb/mRyferhJ5Irfjj1Q65RR1+GXTPQaJXnI1SdTQsG
 VKpg==
X-Gm-Message-State: APjAAAXKB9vnLU28tP9d8CcANHtblHHe/Kbq1cfmoYETBrsGO6kfRTdf
 X+sGAwt+iiW1+bI/8byDcBO9hj/ZT3/U8oHwRjLONQ==
X-Google-Smtp-Source: APXvYqzb8besrhpICltG3Mr2IHSlYM1Wx5gC5EAu9z2RoiOMAIGR1UScJA03OHyoQDiqfVrbhQoqwnc/avgp9kXW8Kw=
X-Received: by 2002:a05:6102:103:: with SMTP id
 z3mr18894644vsq.72.1570552974852; 
 Tue, 08 Oct 2019 09:42:54 -0700 (PDT)
MIME-Version: 1.0
References: <20191004151614.81516-1-jonathan@fintelia.io>
 <5393a150-71b6-a729-7530-a50df05353bd@sifive.com>
 <CAEUhbmXXwZTu2rJ7Oen4mVSBjp+-7Jd7WBpmds1xm9m-tR+Q-A@mail.gmail.com>
In-Reply-To: <CAEUhbmXXwZTu2rJ7Oen4mVSBjp+-7Jd7WBpmds1xm9m-tR+Q-A@mail.gmail.com>
From: Jim Wilson <jimw@sifive.com>
Date: Tue, 8 Oct 2019 09:42:44 -0700
Message-ID: <CAFyWVaZUhmqQWvEvPpbYV2dKdf-GB1Dp1mFR5C3JYd221q12GA@mail.gmail.com>
Subject: Re: [PATCH v2] target/riscv: Expose "priv" register for GDB
To: Bin Meng <bmeng.cn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::e44
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
 Jonathan Behrens <jonathan@fintelia.io>, Palmer Dabbelt <palmer@sifive.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Oct 8, 2019 at 2:00 AM Bin Meng <bmeng.cn@gmail.com> wrote:
> My gdb does not list "priv" register after applying this patch.

I didn't try the patch, I didn't have time for that.  I would expect
priv to be in the "info registers" output if you are adding it to the
cpu register set.  Shrug.  Anyways, defining priv as a virtual
register is the right way to do this, as it isn't a cpu register, and
gdb already has support for virtual registers like priv.

Jim

