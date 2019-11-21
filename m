Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4183C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 11:31:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD04E20714
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 11:31:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="twUKHw0l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD04E20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39028 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXkg2-0000jk-I9
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 06:31:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54878)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iXkeG-0007RK-H5
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 06:29:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iXkeF-00033W-LD
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 06:29:20 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:46897)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iXkeF-00033E-Gv
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 06:29:19 -0500
Received: by mail-ot1-x344.google.com with SMTP id n23so2549631otr.13
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2019 03:29:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=9nL6Pa+RMSOsG6RslpItVGqiLFZKq2og4sVGwt/hizo=;
 b=twUKHw0lwGq+jketh/5bGUC3dkq+AhgglOjdxUp0iaT7rKi4fR0awASCxUcQDCvIu8
 8XtH+/P05Hn/bfHlhbJhpo9t2PypIJAda4I822NnY9OYSGu82PRGnR6+VVL6eaCUsXLE
 u5Y9CT9GgwA6ZIxgTpvxPKsLdM+sPsjC0zwWlQxyNsOyvJ6mkR20t4SMESrrFMtr/dhJ
 c65Sg9Y7X2VEuslhyFdomoa1a+aMVJRhLGhSKCjtTd0Jn28IqMD7SwgcAA56o3lDKcOe
 xUgluBFqERkrH6iGJA+wiihaaKZLyT45JLMRZti/bQD4Lkt2q7P6ladtwR15RLPj1Xcd
 aZDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=9nL6Pa+RMSOsG6RslpItVGqiLFZKq2og4sVGwt/hizo=;
 b=HqxugbivebqFKhXjSokwZqrMXlY64Eqbcq+Fd8Smv1ep2GJ23LtNjQeZSVnW9ldhU9
 OYjpo60Z1aEynpLmIIxciSNSpb2eC/YEJgYZJ4JxXcw8cz0x+tZCs9+dPbeUQRDFYrzy
 1HbNEfEUHSoKj70khEBqsHIJNyYpvN1DgwE+IabDaqI08kX1s6s9gPt39ZvA3CjPzqWg
 3IR9gpuEDZlq+QHOQbXhj3fykOnebIJqDgbuqZ+2+uzllmL+i/NG3ILus14FB+hD60Aq
 BZLxPIFdYSB+QVtbKPTPX45A5U1pVTJS1h93oAn1PINq8o3QIirLvEkE/uGqYJJdm7OK
 k0iA==
X-Gm-Message-State: APjAAAWMzDzBksSKo0If43+OZJgxfTcy8BlwkVAY3wBhdIxiG/FkBxN8
 kM66K/ctmdY9gen4jeYYWqH8z1fwjdmxZvatkZqu9g==
X-Google-Smtp-Source: APXvYqzT9vyoWBS6tkWhyFKtNxwOtklmQzyb4rWoGOu1mxYVOIvPqATUgQ/01rxM3Iuuj5cMJyhrGEZmwptuktJ2QJs=
X-Received: by 2002:a9d:68cc:: with SMTP id i12mr5560756oto.97.1574335758665; 
 Thu, 21 Nov 2019 03:29:18 -0800 (PST)
MIME-Version: 1.0
References: <1574190388-12605-1-git-send-email-tsimpson@quicinc.com>
 <CAFEAcA8AeTgY+3GaN9ZUi-5XtX5jxhqpdOhr3ixYwouWhQOQ5g@mail.gmail.com>
 <e4a52719-fc16-f94a-fb8d-1a4d9e683ce0@vivier.eu>
 <CAFEAcA-tVh9AMucDL4hgQ3ngFZwu4AThcGyhwjVa-LbG8o8-Lg@mail.gmail.com>
 <05b5c1b4-d1dd-7b82-cdf3-a1425edae499@vivier.eu>
 <CAFEAcA-mUps0qe9Ak6VjceZBAe=x9cQ3YPhhT9Qmg-c_XpqcDQ@mail.gmail.com>
 <BYAPR02MB488642577188C95697E72DC3DE4F0@BYAPR02MB4886.namprd02.prod.outlook.com>
In-Reply-To: <BYAPR02MB488642577188C95697E72DC3DE4F0@BYAPR02MB4886.namprd02.prod.outlook.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 21 Nov 2019 11:29:07 +0000
Message-ID: <CAFEAcA_VQZxv3k0CDq1SxgvcnCwbhZAtTumKguQ-xJWwe2tiGA@mail.gmail.com>
Subject: Re: [PATCH] Hexagon: Swap SIGRGMAX-1 and SIGRTMIN+1
To: Taylor Simpson <tsimpson@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
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
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 20 Nov 2019 at 12:54, Taylor Simpson <tsimpson@quicinc.com> wrote:
>
> How was this solved for other targets?

It hasn't been, yet. Other targets only run guest
code that doesn't care about this signal number
being unavailable.

thanks
-- PMM

