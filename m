Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3354EC10DCE
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 21:18:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED3732070A
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 21:18:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r/73bErW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED3732070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55164 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGqwr-0007yu-4H
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 17:18:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35477)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <linus.walleij@linaro.org>) id 1jGqvy-00078F-7P
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 17:18:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <linus.walleij@linaro.org>) id 1jGqvx-0005eu-5m
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 17:18:02 -0400
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141]:41226)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <linus.walleij@linaro.org>)
 id 1jGqvw-0005dn-Ud
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 17:18:01 -0400
Received: by mail-lf1-x141.google.com with SMTP id z23so19849lfh.8
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2020 14:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=nFWhs7FYWqUzfSLp89dUr9RqAyDvvxrGjpfFY3Xf6t0=;
 b=r/73bErWdHQvuSdWJNWD31sFM6sBzEI3plO5Ph0mnhTsKRC3h1QN3i7Fz3eKj47Yan
 BwWMNi7sdz1VngrNfJgVhs4otMGlVbKrH5Ojtg4qQyZl6c5KNhEt2puHDbfeP7zS1g9z
 9sb9L8shr//a5jX0W9biM5R/XFXVss0aK7nJnFNfhT69yuJ3vEp20yhHEiPfGub2S0l3
 eAM6WE6onEd3buLeks9BWIX5O3wweUSmc37Ts60F6+qNm0gZUEZMEVw0o0nixNUSAlOc
 geZpCA4tpuURui/rTdFdYUk8MNAkScEJxAEUfyVK4GkLj/8d6IGrDaMTou75bMHoukIi
 C9DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=nFWhs7FYWqUzfSLp89dUr9RqAyDvvxrGjpfFY3Xf6t0=;
 b=SKTl6D4zbYWZieKG9NjSEXEEpfNf45gcTTCPBGoY8dGuHu/JLAnZwB86evWfPE3PDQ
 4mOSWMI4jOy3PN65OADWHCkv2FO0yQro/i81PSwMVRPX4859iMZ556PvaQYOo5OIHskr
 5n8U0gQrTrgolv0Hev08PJdrcTNMqfQmxMGA6eAlpVVjP786ZAo/xZ9DprbSMi4H3+7k
 ReK3Ex4+Jj4KWy8tslWTV6oShiwPgKHBpFJjg50/4HkP7WcN6zfMteyDkFQp/ievwQcc
 314L3T4607vkqoM7/ct7/AkCgUcHKxtyJmcrFSKiejliNQUdcsL7IXT6OWVEp0L/Kz0R
 ojww==
X-Gm-Message-State: ANhLgQ3i0tL+U+WssPunkv+GCGMxZA3iJayaaewBVypO2QUYrbCQRa9c
 QR7STEoeXqgD3IIKInzixjowdFxc8spgbnIoaP2WGg==
X-Google-Smtp-Source: ADFU+vu/WFfI8+Ea0qixkispTE8M2IBdFmk3vOeBjdzg2fpI2YVxUN1mkgIfe3Rc2yqBnwLXF8WOfkInLMcS8iGWzNs=
X-Received: by 2002:a19:6502:: with SMTP id z2mr23818lfb.47.1585084677811;
 Tue, 24 Mar 2020 14:17:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200317113153.7945-1-linus.walleij@linaro.org>
 <CAFEAcA9mXE+gPnvM6HZ-w0+BhbpeuH=osFH-9NUzCLv=w-c7HQ@mail.gmail.com>
 <CACRpkdZtLNUwiZEMiJEoB0ojOBckyGcZeyFkR6MC69qv-ry9EA@mail.gmail.com>
 <CAFEAcA-gdwi=KSW6LqVdEJWSo9VEL5abYQs9LoHd4mKE_-h=Aw@mail.gmail.com>
 <CACRpkdYuZgZUznVxt1AHCSJa_GAXy8N0SduE5OrjDnE1s_L7Zg@mail.gmail.com>
 <20200324023431.GD53396@mit.edu>
 <CAFEAcA_6RY1XFVNJCo5=tTkv2GQpXZRqh_Zz4dYadq-8MJZgTQ@mail.gmail.com>
 <20200324184754.GG53396@mit.edu>
In-Reply-To: <20200324184754.GG53396@mit.edu>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 24 Mar 2020 22:17:46 +0100
Message-ID: <CACRpkdapsgkNbNNGz12tBQKh8GKgcUuwgLywM7CMghr94C-Fsg@mail.gmail.com>
Subject: Re: [PATCH] ext4: Give 32bit personalities 32bit hashes
To: "Theodore Y. Ts'o" <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::141
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
 "Suzuki K. Poulose" <suzuki.poulose@arm.com>,
 Linux API <linux-api@vger.kernel.org>, QEMU Developers <qemu-devel@nongnu.org>,
 stable <stable@vger.kernel.org>, Florian Weimer <fw@deneb.enyo.de>,
 Andreas Dilger <adilger.kernel@dilger.ca>, Andy Lutomirski <luto@kernel.org>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Ext4 Developers List <linux-ext4@vger.kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Mar 24, 2020 at 7:48 PM Theodore Y. Ts'o <tytso@mit.edu> wrote:
> On Tue, Mar 24, 2020 at 09:29:58AM +0000, Peter Maydell wrote:
> >
> > On the contrary, that would be a much better interface for QEMU.
> > We always know when we're doing an open-syscall on behalf
> > of the guest, and it would be trivial to make the fcntl() call then.
> > That would ensure that we don't accidentally get the
> > '32-bit semantics' on file descriptors QEMU opens for its own
> > purposes, and wouldn't leave us open to the risk in future that
> > setting the PER_LINUX32 flag for all of QEMU causes
> > unexpected extra behaviour in future kernels that would be correct
> > for the guest binary but wrong/broken for QEMU's own internals.
>
> If using a flag set by fcntl is better for qemu, then by all means
> let's go with that instead of using a personality flag/number.
>
> Linus, do you have what you need to do a respin of the patch?

Absolutely, I'm a bit occupied this week but I will try to get to it
early next week!

Thanks a lot for the directions here, it's highly valuable.

Yours,
Linus Walleij

