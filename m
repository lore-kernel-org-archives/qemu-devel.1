Return-Path: <SRS0=HB7V=X6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BF8AC3E8AB
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2019 13:34:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27706222CA
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2019 13:34:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Srf1fxA8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27706222CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56782 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGkCa-0005ND-9j
	for qemu-devel@archiver.kernel.org; Sat, 05 Oct 2019 09:34:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59505)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iGkBw-0004vq-SJ
 for qemu-devel@nongnu.org; Sat, 05 Oct 2019 09:33:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iGkBv-0002mx-Pv
 for qemu-devel@nongnu.org; Sat, 05 Oct 2019 09:33:48 -0400
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b]:44142)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iGkBv-0002mZ-Kv
 for qemu-devel@nongnu.org; Sat, 05 Oct 2019 09:33:47 -0400
Received: by mail-ot1-x32b.google.com with SMTP id 21so7521384otj.11
 for <qemu-devel@nongnu.org>; Sat, 05 Oct 2019 06:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=PLCMuKinwuOXUAFPzEQ8Cqtq6rK45qg7YObjyiRLIPQ=;
 b=Srf1fxA89PrKE5vcMaUhs+/HDRww1d8dM+XnhWpAMzT1q4MEeJ/2fiITvpMhwo0G4e
 eF1n/6GmiIRrqrGt0WnWbfFwd93JfyZr1CD7Pjqsay90rIWlJYWjydf+tG9w8wEFHd4t
 nfCiCDzW1pv+ma8rVMRNVTn0zMkjdgRXQePlVCwiYPZsbNaYTBTpj1akx7wdWMsRIAZt
 fet+m9tZcFgpppQc/td5n3HXfi+7WoFKb+RcI7++XZQIdyII/HxOA1acKI+AC8EJiP5E
 c9EXX4JBf6r1uAGiUI+uwRRUUYNJT270jdAfHIK2/f3c00L4Qc8qHI+WokCv7pxLxPJf
 ok+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=PLCMuKinwuOXUAFPzEQ8Cqtq6rK45qg7YObjyiRLIPQ=;
 b=Jd3lmxHKe7PzYrLBi7GP3J3i95wUVXtClQsyyZFfLYXWQyiOuL6Dnje4KvXjYGAS3q
 KJE+cEFeoSHqFRyoJCd2PnMnnmupKprkmJm5KebzJb+P9s4eDvSSZTyrHycrX+BiVt/U
 4pzOcwMw43RsmxNOsqrpxsIWTxNJ4BcLcOmo3k4RvkWy8XRCAN7o54wZjPXKpwizJZ8k
 nVsi+2e62mZ3oJWH+AUmFJAVoDxf//U9YpQMAw6qOBjGlNejcHrfQ5BAEEf4ei99JMQb
 n+o1WvfAxsMxCdFYcAQMLhKdcA7cH9AP4KO83zQBNvM5nn8+mAJyAh6IQw2wfg3mirvW
 C8Bw==
X-Gm-Message-State: APjAAAW2JpJLNksN1kT4acT5aTwupKgrQ0aohQcX1I7nieTny8JGU+4z
 0FMurodzpdXMe5GYn0g0wWYPt2EYyw9Kxg5mal2irg==
X-Google-Smtp-Source: APXvYqwSyLVQqpoyfGc0esDDF9qqPs4Zu09OU9+7/oUEZeuuuodt2tr7WQ4a3U2qI5HKaNCMi3ZZbM4JiYzoWTBP7H8=
X-Received: by 2002:a9d:4615:: with SMTP id y21mr13607867ote.97.1570282426117; 
 Sat, 05 Oct 2019 06:33:46 -0700 (PDT)
MIME-Version: 1.0
References: <CALvKS=E-t1c+BVDn=0RbM8nBry8GcYOXh-PrziQO7XhS7W2NUw@mail.gmail.com>
 <CALvKS=GB1-zDnkKxei6Dn5MNyr5kwj+vEtD_3MZyVNfzqQuRZg@mail.gmail.com>
In-Reply-To: <CALvKS=GB1-zDnkKxei6Dn5MNyr5kwj+vEtD_3MZyVNfzqQuRZg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 5 Oct 2019 14:33:34 +0100
Message-ID: <CAFEAcA-gLHm0D6vR0Rvpbi_bbVWpKspvm8YLSVPHpCVP6HmDUg@mail.gmail.com>
Subject: Re: RFC: Why dont we move to newer capstone?
To: Lucien Murray-Pitts <lucienmp.qemu@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::32b
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 5 Oct 2019 at 11:21, Lucien Murray-Pitts
<lucienmp.qemu@gmail.com> wrote:
> Whilst working on a m68k patch I noticed that the capstone in use
> today (3.0) doesnt support the M68K and thus a hand turned disasm
> function is used.
>
> The newer capstone (5.0) appears to support a few more CPU, inc. m68k.
>
> Why we move to this newer capstone?

Moving to a newer capstone sounds like a good idea. The only
reason we haven't moved forward as far as I'm aware is that
nobody has done the work to send a patch to do that move
forward to the newer version. Richard Henderson would
probably know if there was any other blocker.

> Furthermore, if making a move why not move to something with wider cpu
> support like libopcodes  ?

Unfortunately as far as I know libopcodes is GPLv3, which is not
compatible with the GPLv2-only code in QEMU. Otherwise it
would be an obvious choice.

thanks
-- PMM

