Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EA8AC54FC9
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 19:29:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39EE2206D5
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 19:29:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hlNBCi3I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39EE2206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35172 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQyZo-0002KP-M4
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 15:29:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53790)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jQyYu-0001rF-LR
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 15:28:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jQyYu-0007ly-0k
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 15:28:04 -0400
Received: from mail-oi1-x229.google.com ([2607:f8b0:4864:20::229]:43054)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jQyYt-0007lK-Cw
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 15:28:03 -0400
Received: by mail-oi1-x229.google.com with SMTP id j16so12987076oih.10
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2020 12:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=UJOOxmMinqSKKEku91FQG3H/5a98axsYeH+hGvR5NGo=;
 b=hlNBCi3IlYyNBYQ/nI0+8yOP8nNGUVkb9RCoGzdQ9L4SKghcDE48hz4PsJpQNyDQvw
 fFbzP4WEzMGOPBoqSGWb7h0uRxPtLfNU0Beie7Q4nhTyv2ONmmKubtQJ8s+pTLdAU9ly
 3VOvCUzI4eDfGZ4kcqx1OzZ+TJM6wPNS1hzvrSeLGmGJlnjLqGzejBgcQaWK9ZKWDT7F
 M2ksu/4WmYW2haz5wYlhA0DV0eMBsyRtBjrxj29DcrWZzwktsTkqSfAwg3lDbprKgsdT
 2W0+nSwI9B27N7CGsuCjewVP5dtX5ErwR4PwXV2aws6Q6H0OvC0RGi8AZNyOLTMOagMO
 D8ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=UJOOxmMinqSKKEku91FQG3H/5a98axsYeH+hGvR5NGo=;
 b=OU0orOk+/01fX1bjY4DWGzUlAC18SG8hMWYYcDKiEjFODkTo8FV3peSFfNxCFV7w5R
 FnYR04gHk+j18svRUrhiwL/yYuIs+wOUlrkr6ETycgfw1Xb0fSShO61GiGg9AAJukdHI
 KJgPHwo4hSjzEv6UpCNPz18FAfJYqN0gjSfS9DWJ72wOxVTyGMVFjUpS1nQ4TqbvC/p2
 zRdmtpJsgxRI08jtFX5pUHD075eomJD0QpFRA5kRw/qUUCpvLvUXmDP+Mjj3OdexPGwe
 wiQW6rEKwn7ORf3BI0fZzookaW9EMZoIJ1hAaOS8EDKHlfVTS/zdQUERT02h1uqXLDxU
 we3Q==
X-Gm-Message-State: AGi0PuZBg0G6e2ziifYHDeCx7hlf6bxXMSWJT0L+xpa+m+RB02ZF14hm
 yF8PBDSKYPQ5dWUg3gc0ktTQJkJGuR0+FerypWXUIA==
X-Google-Smtp-Source: APiQypLfG330WBSuCDCtJMZ0fJBsu2WCRznwAWnWvfkEg5PrfpiCeWRxLOi9NVae/yYDSxWbue2FY/XEZBiyYppOwS8=
X-Received: by 2002:aca:3a8a:: with SMTP id h132mr4153815oia.146.1587497281614; 
 Tue, 21 Apr 2020 12:28:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200421191001.92644-1-palmerdabbelt@google.com>
In-Reply-To: <20200421191001.92644-1-palmerdabbelt@google.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 21 Apr 2020 20:27:50 +0100
Message-ID: <CAFEAcA9ZrLDnU1KLmoPBqhS1fYVG05TzN3bojEGherL7PRhwFg@mail.gmail.com>
Subject: Re: [PULL] RISC-V Patches for 5.0-rc4
To: Palmer Dabbelt <palmerdabbelt@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::229;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x229.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::229
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
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 21 Apr 2020 at 20:19, Palmer Dabbelt <palmerdabbelt@google.com> wrote:
> ----------------------------------------------------------------
> RISC-V Patches for 5.0-rc4
>
> This contains handful of patches that I'd like to target for 5.0.  I know it's
> a bit late, I thought I'd already sent these out but must have managed to miss
> doing so.  The patches include:
>
> * A handful of fixes to PTE lookups related to H-mode support.
> * The addition of a serial number fo the SiFive U implementetaion, which allows
>   bootloaders to generate a sane MAC address.
>
> These pass "make check" and boot Linux for me.
>
> ----------------------------------------------------------------
> Peter: Sorry I dropped the ball here.  I can understand if it's too late for
> 5.0, but if there's still going to be an rc4 then I'd love to have these
> included.
> ----------------------------------------------------------------

Nope, sorry. rc4 has technically not been tagged yet, but especially
the serial-property stuff is too big a code change at this point
(it includes one "let's just refactor and rearrange some code"
patch which is really not rc4 material.)
Also these patches have been on the list for over a month -- if
they were 5.0-worthy there's been plenty of time for them to be
put in.

Plus the last email from Alistair on the "target/riscv: Don't set
write permissions on dirty PTEs" patch thread is a note saying
it shouldn't be applied, unless I've got confused.

thanks
-- PMM

