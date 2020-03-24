Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98433C54EEB
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 09:31:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A1A920786
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 09:31:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dT+SeYyH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A1A920786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGfu2-0002wf-PV
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 05:31:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45322)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jGft2-00020Y-FZ
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 05:30:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jGfsx-0003n1-Jd
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 05:30:16 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:44441)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jGfsx-0003jQ-A7
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 05:30:11 -0400
Received: by mail-ot1-x342.google.com with SMTP id a49so16335447otc.11
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2020 02:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=UzTnB3iS1qilKNurvByNSklxmCSliWtJkL6J5/1oEN0=;
 b=dT+SeYyH1BkKkZWUaBk5uj0MEH4L6HjmlSYG1+nPnGCG3gAENzp0qjsWHAigkjMhtR
 ljAI1uUGzbpci1deREeZbmrQws6bf2gHk+9gusG81aJYoCIN4nyvPaaP6ug29PD+78AD
 pBmUMig88uOYaX5iSgRyVzEwUEzyGAd5Yu8cNqY1KACcX65WNHrT7gMMS3T4RjMXKiRj
 9kQwaauv82/bqrFcDf7AtzgFGJe0b9boON8gM98zVPL6FMxsx9RRo+vJqhikkynkr4WI
 +/oWFfjdmud6SHbfCHGyb5rghdGaq7+cR5SuHhjkz0L5/L+PbiIqnNVLVHCPGSKi0cpY
 kOVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=UzTnB3iS1qilKNurvByNSklxmCSliWtJkL6J5/1oEN0=;
 b=R5FN5Z34opihG9asQFmW1YqzoCeJQgub4ulXgMbXRMJ+9kO5HTzx6JwtzlVQekA2Xb
 yHuJC9oaMvV7RWio5DvPd2Vw/VMDpruJVyZu6+OjVh8CiaxL04bp8hjg3ztOtVXUDq0c
 zomVSGg6eImuT55/MFwI1Ahgdu3AMWnlVOzjYETt9WupYLFpDqMBKoYf0+qpl62UT9Bd
 MbgwMt7Ft99KRC/fnLuFYuElpHBWYv6jPA9LVQo4M8bnj2WmkiaR2p7ISLfflsASuxkZ
 0/9mWl2vhqmpIOtWKZ5mHyQ4FIoSgkCT8vl01NycXfG0oiqfTlf9JDvCeRc/GC4WjDxk
 jK6A==
X-Gm-Message-State: ANhLgQ0wt12IzciwvUoWONmWrgjnFxXLAWrvaJ2DMcf8JeujPIeaxrXr
 NCWVlLHauGYxON6c4O0sMcARZeow63oRMDo0sawgrQ==
X-Google-Smtp-Source: ADFU+vsVpjNMAvc6231UF5jnLInFznAbjT7PjgwTqzNrcYLn3q1rK1MSp0eBo3cutIGiQ6yNzxYDBwJUhUQYQLc0WIo=
X-Received: by 2002:a4a:d1a5:: with SMTP id z5mr1673767oor.63.1585042209973;
 Tue, 24 Mar 2020 02:30:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200317113153.7945-1-linus.walleij@linaro.org>
 <CAFEAcA9mXE+gPnvM6HZ-w0+BhbpeuH=osFH-9NUzCLv=w-c7HQ@mail.gmail.com>
 <CACRpkdZtLNUwiZEMiJEoB0ojOBckyGcZeyFkR6MC69qv-ry9EA@mail.gmail.com>
 <CAFEAcA-gdwi=KSW6LqVdEJWSo9VEL5abYQs9LoHd4mKE_-h=Aw@mail.gmail.com>
 <CACRpkdYuZgZUznVxt1AHCSJa_GAXy8N0SduE5OrjDnE1s_L7Zg@mail.gmail.com>
 <20200324023431.GD53396@mit.edu>
In-Reply-To: <20200324023431.GD53396@mit.edu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Mar 2020 09:29:58 +0000
Message-ID: <CAFEAcA_6RY1XFVNJCo5=tTkv2GQpXZRqh_Zz4dYadq-8MJZgTQ@mail.gmail.com>
Subject: Re: [PATCH] ext4: Give 32bit personalities 32bit hashes
To: "Theodore Y. Ts'o" <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
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
Cc: "Suzuki K. Poulose" <suzuki.poulose@arm.com>,
 Linux API <linux-api@vger.kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, stable <stable@vger.kernel.org>,
 Florian Weimer <fw@deneb.enyo.de>, Andreas Dilger <adilger.kernel@dilger.ca>,
 Andy Lutomirski <luto@kernel.org>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Ext4 Developers List <linux-ext4@vger.kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 24 Mar 2020 at 02:34, Theodore Y. Ts'o <tytso@mit.edu> wrote:
> Another possibility, which would be messier for qemu, would be use a
> flag set via fcntl.  That would require qemu from noticing when the
> guest is calling open, openat, or openat2, and then inserting a fcntl
> system call to set the 32-bit readdir mode.  That's cleaner from the
> kernel interface complexity perspective, but it's messier for qemu.

On the contrary, that would be a much better interface for QEMU.
We always know when we're doing an open-syscall on behalf
of the guest, and it would be trivial to make the fcntl() call then.
That would ensure that we don't accidentally get the
'32-bit semantics' on file descriptors QEMU opens for its own
purposes, and wouldn't leave us open to the risk in future that
setting the PER_LINUX32 flag for all of QEMU causes
unexpected extra behaviour in future kernels that would be correct
for the guest binary but wrong/broken for QEMU's own internals.

thanks
-- PMM

