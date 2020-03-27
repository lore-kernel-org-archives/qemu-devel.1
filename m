Return-Path: <SRS0=t76e=5M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B9CCC43331
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 18:24:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C44A02083E
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 18:24:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tmrwX74k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C44A02083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45520 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHteJ-0000jH-PN
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 14:24:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42595)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jHtdO-000051-Jb
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 14:23:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jHtdN-00028p-Dq
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 14:23:10 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:41622)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jHtdN-000281-7A
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 14:23:09 -0400
Received: by mail-wr1-x441.google.com with SMTP id h9so12569674wrc.8
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2020 11:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=6aue5MFunMNljM7iQhigLdXXrEOnLaU80oBBssiecrw=;
 b=tmrwX74kHG/BWfdMdGSsmJIQQ2hU8sbiqTN3qIVhbBnyDaICDrsPiKjCoYC98e2vGJ
 J6LKLNqjG0JqTE3JOxqRo/mactIDRF8S1PURE9U71Q/RpcTXHLHVYMEz5qDCwKKfKeO8
 01t5unNOC681n9uQxRR3wg/BR2D2D/RnnjW+jJdPXwrwnbn3bBzLoI2ZYe+59grIHe2m
 8iKE5gfQ9q2pvDFpzY5OyKEShO6Gcqt0NmzA4s5+rklD5vgc8B1F4X6dQbK88VenwoEV
 Hn2qVTq3t/O6drMC3Il0Pf/Ij2ElH5uDbQvNp3jds/cEReXIIwDS2zrrPCJMmCe2u95K
 59Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=6aue5MFunMNljM7iQhigLdXXrEOnLaU80oBBssiecrw=;
 b=HnQEo76UpXyYtMIVQEYCYVL1bSIHlPY7dU0Xub1YIoJxEz4TIYw9D2CIESD0iZUh7Z
 IYJheBoAXLCADdW5sXTW7vKYEL10x3j7irJz6GSTZqEVvRw0iNrKy22iZdih3WMRsJFv
 5K+H70SLolUO/bSqwVbpPipxW0J/DjiUZkxNkBNSZO03qfawZv2SVeQcRjN5eqHSf2uG
 HAV2w4mBx7ek5c4GgsXOikERc6QRcLkincd9QzSS9NnaBayR/d2wbrxtCdEc4MUtNsNE
 oKPll0Q0SoKYMxcpVeZn7K/ohoap30Xk90YQRHuwXZzoRyXUEnESc026QVTY1245g/kM
 Y3lw==
X-Gm-Message-State: ANhLgQ23dsUp2za/L9AtVPWPfIJVWYXC6HXqXXCDaW1EF1+9sAj2PgvH
 Ddh5APV9kKz4XPuHtssN2eS33Q==
X-Google-Smtp-Source: ADFU+vviTe6gKEpcTwppLdxQPUuWmTZ0PAXrPkbMl4PuX21NOOybgbYnzKAXdxZM69YewziPgCjePw==
X-Received: by 2002:a5d:6847:: with SMTP id o7mr735239wrw.274.1585333387746;
 Fri, 27 Mar 2020 11:23:07 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id h132sm9598981wmf.18.2020.03.27.11.23.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2020 11:23:06 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 8C1461FF7E;
 Fri, 27 Mar 2020 18:23:05 +0000 (GMT)
References: <20200326193156.4322-1-robert.foley@linaro.org>
 <20200327051457.GA2815@t420>
User-agent: mu4e 1.3.10; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: "Emilio G. Cota" <cota@braap.org>
Subject: Re: [PATCH v8 00/74] per-CPU locks
In-reply-to: <20200327051457.GA2815@t420>
Date: Fri, 27 Mar 2020 18:23:05 +0000
Message-ID: <87zhc1lks6.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
 Robert Foley <robert.foley@linaro.org>, richard.henderson@linaro.org,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 peter.puhov@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Emilio G. Cota <cota@braap.org> writes:

> (Apologies if I missed some Cc's; I was not Cc'ed in patch 0
>  so I'm blindly crafting a reply.)
>
<snip>
>> Changes for V8:
>> - Fixed issue where in rr mode we could destroy the BQL twice.
>
> I remember doing little to no testing in record-replay mode, so
> there should be more bugs hiding in there :-)

Well we have two (very simple) rr tests in check-tcg now - so there is
that ;-)

> On a related note, I've done some work to get QEMU-system to work
> under thread sanitizer, since tsan now supports our longjmp-based
> coroutines (hurrah!).

When did that go in? Will I need a new toolchain and -ltsan to make it
work?

> My idea was to integrate tsan in QEMU (i.e.
> bring tsan warnings to 0) before (re)trying to merge the
> per-CPU lock patchset; this would minimize the potential for
> regressions, which from my personal viewpoint seems like a reasonable
> thing to do especially now that I have little time to work on QEMU.
>
> If there's interest in doing the tsan work first, then I'd be
> happy to send to the list as soon as this weekend the changes that
> I have so far [1].

Please do - I've been cleaning up some of the other things the sanitizer
has found and it certainly won't hurt to get thread sanitizer working
again.

--=20
Alex Benn=C3=A9e

