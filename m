Return-Path: <SRS0=VgPO=WQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C57FC3A589
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 15:40:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4505222CE3
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 15:40:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SXdQOeOD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4505222CE3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38818 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i06Fd-0003gd-Gm
	for qemu-devel@archiver.kernel.org; Tue, 20 Aug 2019 11:40:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36982)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i06E6-0001qs-JM
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 11:39:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i06E5-0000VM-Mp
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 11:39:14 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:33139)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i06E5-0000Up-Hk
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 11:39:13 -0400
Received: by mail-oi1-x243.google.com with SMTP id q10so4426561oij.0
 for <qemu-devel@nongnu.org>; Tue, 20 Aug 2019 08:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=5juL1btnjwSUicwKiFx5MZdwnirgkghPx0J2Xk0gzMg=;
 b=SXdQOeODELfohnZDHhN0Gwjq9lhnaXvEH+5UERGG36eK+jrkhdYqukZTnLBTnDoNHW
 6F0IBmraCz3KzGebEKDy8aNsLWeA/xr5s3GchbgFAIAU8FT75pLOrY64xTZmxVg5WDSa
 ZkHAvmGGKiRk/7qlcZR1WMUaBxld6ssAOkLAU1iP7x7Jdidj6pcA62fIboSZSta86IDB
 5UvnCa7uxJnUY7Z8/As8kBtA6C1fzQyVFRldeIzUBYAD7y+L4Og9ZOnh4hwRo6+P7/70
 dTYGCvhK9QO1a6L9JhactH7TQFXPmoOkfkrpoA7TZl2j18pDGiwQtfIS4jVavrgOTJU1
 KwAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5juL1btnjwSUicwKiFx5MZdwnirgkghPx0J2Xk0gzMg=;
 b=srr6CpQFAC9FNYGWDg563kVE0UqgFCFuyQ2631MqeIyWCiI8IXVqxKbLLNSAM8TXMg
 /Fx71sjy7VXVwfR+WosiAKKNefrAjKU6exeIpA7ftuh0Em5p1tPz9N7QoRN+4m7+GOnQ
 0RqnsCstFJ3CJp5BSRjYCcWNU7saXlb+iuut4ZV99npWCdaT8WCqatH9mC8U79IpzkgN
 qQAviNhwQNJOtjgOKWlzvl4s4ZUc2xMWInPqFw3K+toQrBGMeFubXg0VszSk1pBndujd
 hw/RL1a8t8jdaKt21drvJs5guJMeYKgXQXUV+w9yKFH9UtWTX5oJRCs3noQFvH6/a8v7
 1kag==
X-Gm-Message-State: APjAAAU59FyVrXrAMFOPRsfKgG/YEBP6oCS8lK4A6c46unUFyFK8aLGb
 vJPAfbyH8cbh9P+bN1+MLAbxJBtSi4Y36ItRii7qYA==
X-Google-Smtp-Source: APXvYqyGCjjnP9WH0un4PJnQAKBx/FV0T01DvcYa1RfAH13jb055VhHd96TWjk1wB3MDtOFBKsFtqU+s0YPH6yqPHT4=
X-Received: by 2002:a54:4718:: with SMTP id k24mr484991oik.146.1566315552728; 
 Tue, 20 Aug 2019 08:39:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190803210803.5701-1-richard.henderson@linaro.org>
 <20190803210803.5701-5-richard.henderson@linaro.org>
In-Reply-To: <20190803210803.5701-5-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 20 Aug 2019 16:39:01 +0100
Message-ID: <CAFEAcA-_gMkE-0kA=xyUyNKxeqX0n6B-9i_7132xfFXQNRqb6w@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
Subject: Re: [Qemu-devel] [PATCH v7 4/6] include/elf: Add defines related to
 GNU property notes for AArch64
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
Cc: qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Dave P Martin <Dave.Martin@arm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 3 Aug 2019 at 22:08, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> These are all of the defines required to parse
> GNU_PROPERTY_AARCH64_FEATURE_1_AND, copied from binutils.
> Other missing defines related to other GNU program headers
> and notes are elided for now.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

What's the authoritative source for these definitions? I
tried looking in glibc, binutils and the kernel without
any luck.

thanks
-- PMM

