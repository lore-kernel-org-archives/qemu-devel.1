Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98152C54E8D
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 15:08:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1741D20736
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 15:08:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rhTQ7VH+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1741D20736
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51350 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYA2B-0008As-8n
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 11:07:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36598)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jYA1V-0007jE-2K
 for qemu-devel@nongnu.org; Mon, 11 May 2020 11:07:17 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:42307)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jYA1U-0003bP-2L
 for qemu-devel@nongnu.org; Mon, 11 May 2020 11:07:16 -0400
Received: by mail-oi1-x241.google.com with SMTP id i13so15354086oie.9
 for <qemu-devel@nongnu.org>; Mon, 11 May 2020 08:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ixOBZsQKgQqnxVyjfkvtej6hTFYkQfwmVZ4OLjgQepg=;
 b=rhTQ7VH+qAgcNqgbgtBXukOWS4rSZtddXVghMpL41148vLMd6tOrsam26gfjw9zbFx
 3XVm8HCvZpMMaQQviIWshRQR9e/vX4hCi6e3Vb3RzHhDrEA5+tHGsy2WTS8sJN60LCed
 o7ox0MDNKscZ2PDmEbqX7HrgcM69TSHRTeCDvA/OGOPkkqtDx+aaH4g/Id1Pqgnip/g4
 6UwDeloajGsmqJwdC3KjYKB6so7hHaOQ+wlzeOAPBH+R6Q0HVkp1U0lJEQsP3M0G3bJ7
 iWBJrFUXM1+kYIX8i2gDnXS9bdO9G2/I4QWW22VqJaX73BMkskuyV0RKHFhT4s+rEqfY
 Bu8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ixOBZsQKgQqnxVyjfkvtej6hTFYkQfwmVZ4OLjgQepg=;
 b=KkJIxAm1roR+zCJmZjQ4O3v4g/SGL9gyg8DMPm24AEJAc1dZv+u29xrpnTNnxOKshL
 V9HQxnEOKUG5k0PC1AI3dfoxPAlY9Z18QkNW1QEyWhiGTF68J7Pm7PRg2Q95+5HnH4Dc
 3Vx+JYAOdudWDAIjSzWw+0o04P53S7JB33gu0eqMxDD+fRNxbJSvkBl44N3I7rghZgi1
 VEZFJlmNTw3ygcQfWyxv6j9RnDH3g4Am2jmZ6cCneVqDzx0WdSV9Sl7Jn2jM83KTxztp
 C0Te8NnnGeQNY1TEcexTQ+f+Ci+ZbnGtdNhtJ+L1XLC5/khbNq4yyVMLR3EXdSLxCWXu
 XAig==
X-Gm-Message-State: AGi0PuYHTVnGlREBDLyV3a1ZKAi3HU3N4YdUd1HpgYEBjZ5LGrvqWw+o
 OjrYOH0QNreXpwG+7xkQD8S+fc6SWnhsQmdr2oktgA==
X-Google-Smtp-Source: APiQypLXk96oDZwRNvuYnwxWUqpeZPWNhJMPHyOrDUKNyekmgnuN/62t8RVNH/QaJjxhcooBKisexmpIQ8JnybIg17A=
X-Received: by 2002:a54:400c:: with SMTP id x12mr19302651oie.146.1589209634481; 
 Mon, 11 May 2020 08:07:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200506173035.2154053-1-patrick@stwcx.xyz>
 <20200506183219.2166987-1-patrick@stwcx.xyz>
 <CAFEAcA8RMhq3aZcqzqFkaWCkwkzfptxAyAogEEg+BcqNU1BquA@mail.gmail.com>
 <20200511131328.GF10214@heinlein>
In-Reply-To: <20200511131328.GF10214@heinlein>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 11 May 2020 16:07:03 +0100
Message-ID: <CAFEAcA8q7xdsyz+=c2iCqcLxDFSMq5f1tvP1OPuQxV4qLfJncg@mail.gmail.com>
Subject: Re: [PATCH v3] aspeed: Add support for the sonorapass-bmc board
To: Patrick Williams <patrick@stwcx.xyz>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::241;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x241.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Andrew Jeffery <andrew@aj.id.au>, Amithash Prasad <amithash@fb.com>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Vijay Khemka <vijaykhemka@fb.com>, Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 11 May 2020 at 14:13, Patrick Williams <patrick@stwcx.xyz> wrote:
>
> On Mon, May 11, 2020 at 11:54:42AM +0100, Peter Maydell wrote:
> > On Wed, 6 May 2020 at 19:32, Patrick Williams <patrick@stwcx.xyz> wrote:
>
> > Looking up through the thread I can't find the email where
> > Amithash gave his reviewed-by tag -- did I miss it?
>
> I probably shouldn't have done this.  I asked Amithash off-list for his
> approval to add his Reviewed-by.  I'll ask him to reply to this with
> confirmation.

Thanks; no big deal. I figured I'd check because the details
of how we handle reviewed-by tags are a bit non-obvious if you
haven't worked with projects like QEMU or the kernel that use
this email-based workflow before.

> > PS: for the future, v2/v3 etc patches should be sent as
> > fresh emails, not as followups/replies to the v1.
>
> Thanks.  I missed this detail when I read [1] before but I see it now.
> It seems like LKML tends to do the opposite?

I don't do kernel development but AIUI they have the same
general approach we do. Their process doc:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst#n771
says:
  "for a multi-patch series, it is generally
   best to avoid using In-Reply-To: to link to older versions of the
   series.  This way multiple versions of the patch don't become an
   unmanageable forest of references in email clients."

thanks
-- PMM

